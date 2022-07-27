import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // usado para salvar as informações. Funciona junto com _submitForm(), key: _formKey, onSaved: () {}
  final _formData = Map<String, Object>();
  // as informações serão salvas inicialmente no map _formData e depois, em _submitForm(), faremos uma nova instância de Product com essas informações

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final product = argument as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    // validando as respostas do formulário
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    // Por estarmos fora do método build precisamos passar listen: false
    Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData)
        .catchError((error) {
      return showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Algo de errado não está certo'),
          content: Text('Ocorreu um erro para salvar o produto!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        ),
      );
    }).then(
      (value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      },
    );
    // Apenas retornará para a tela quando estiver finalizado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      // quando apertamos 'ok' no teclado do celular, irá automaticamente para o próximo campo. Caso isso não ocorra automaticamente (pode funcionar em um dispositivo e não em outro) ou se queremos personalizar o focus, podemos controlar o foco com FocusNode e FocusScope
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      // ?? é 'caso não exista'
                      validator: (_name) {
                        // se o validator retornar nulo, significa que o campo foi validado com sucesso
                        // colocaremos uma string e, caso haja algum erro, ela será retornada e aparecerá para o usuário
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          // trim tira os espaços em branco
                          return 'Nome é obrigatório';
                        }

                        if (name.trim().length < 3) {
                          return 'Nome precisa no mínimo de 3 caracteres';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;
                        if (price <= 0) {
                          return 'Informe um preço válido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: InputDecoration(labelText: 'Descrição'),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        // se o validator retornar nulo, significa que o campo foi validado com sucesso
                        // colocaremos uma string e, caso haja algum erro, ela será retornada e aparecerá para o usuário
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          // trim tira os espaços em branco
                          return 'Descrição é obrigatória';
                        }

                        if (description.trim().length < 10) {
                          return 'Descrição precisa no mínimo de 10 caracteres';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'URL da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction
                                .done, // para submete a imagem quando selecionar 'ok' no teclado
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isValidImageUrl(imageUrl)) {
                                return 'Insira uma URL válida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text('Informe a Url')
                              : Image.network(_imageUrlController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
