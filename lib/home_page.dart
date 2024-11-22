import 'package:flutter/material.dart';
import 'package:focus_app/login/tela_login.dart';

void main() {
  runApp(AppTarefas());
}

class AppTarefas extends StatelessWidget {
  const AppTarefas({super.key});
  static const String tag = 'home-page';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: TelaPrincipal(), // Define TelaPrincipal como a tela inicial.
    );
  }
}

class Tarefa {
  String titulo;
  String descricao;
  DateTime data;
  bool concluida;

  Tarefa({
    required this.titulo,
    required this.descricao,
    required this.data,
    this.concluida = false,
  });
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _dataSelecionada;
  String _erroMensagem = '';  // Variável para armazenar a mensagem de erro

  // Função para adicionar tarefas
  void _adicionarTarefa(String titulo, String descricao, DateTime? data) {
    if (titulo.isEmpty || data == null) {
      // Se o título ou a data não forem preenchidos, exibe a mensagem de erro
      setState(() {
        _erroMensagem = 'Por favor, preencha o título e a data da tarefa.';
      });
      return;  // Não adiciona a tarefa e mantém o diálogo aberto
    }

    setState(() {
      _tarefas.add(Tarefa(
        titulo: titulo,
        descricao: descricao,
        data: data,
      ));
    });
    _tituloController.clear();
    _descricaoController.clear();
    _dataSelecionada = null;
    setState(() {
      _erroMensagem = '';  // Limpa a mensagem de erro
    });
  }

  // Função para remover tarefa com confirmação
  void _removerTarefaComConfirmacao(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar remoção'),
          content: Text('Você tem certeza que deseja remover a tarefa "${_tarefas[index].titulo}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _removerTarefa(index);
                Navigator.of(context).pop(); // Fecha o diálogo após remover
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  // Função para remover tarefa
  void _removerTarefa(int index) {
    setState(() {
      final tarefa = _tarefas.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa "${tarefa.titulo}" removida')),
      );
    });
  }

  // Função para alternar a conclusão de uma tarefa
  void _alternarConclusao(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });

    // Exibe uma mensagem de confirmação quando a tarefa for concluída
    final mensagem = _tarefas[index].concluida
        ? 'Tarefa "${_tarefas[index].titulo}" marcada como concluída.'
        : 'Tarefa "${_tarefas[index].titulo}" marcada como pendente.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  // Função para exibir o dialogo de nova tarefa
  Future<void> _exibirDialogoNovaTarefa() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    hintText: 'Digite o título da tarefa',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    hintText: 'Digite uma observação ou descrição',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      _dataSelecionada == null
                          ? 'Nenhuma data selecionada'
                          : 'Data: ${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}',
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final data = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        setState(() {
                          _dataSelecionada = data;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Exibe a mensagem de erro, se houver
                if (_erroMensagem.isNotEmpty)
                  Text(
                    _erroMensagem,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _adicionarTarefa(
                  _tituloController.text,
                  _descricaoController.text,
                  _dataSelecionada,
                );
                if (_erroMensagem.isEmpty) {
                  Navigator.of(context).pop(); // Só fecha o diálogo se a tarefa for válida
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginApp()),
            );
          },
        ),
        title: const Text(
          'Minhas Tarefas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: <Widget>[
          // Barra de Atalhos (Carrossel)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150.0, // Tamanho da barra de atalhos
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefas[index];
                  return Card(
                    color: Colors.orange[100],
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tarefa.titulo,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87),
                            ),
                            Text(
                              'Data: ${tarefa.data.day}/${tarefa.data.month}/${tarefa.data.year}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Lista de Tarefas
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () => _alternarConclusao(index), // Marca como concluída
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: tarefa.concluida
                                ? Colors.green
                                : Colors.grey,
                            child: Icon(
                              tarefa.concluida
                                  ? Icons.check
                                  : Icons.pending,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tarefa.titulo,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: tarefa.concluida
                                        ? Colors.grey
                                        : Colors.black87,
                                    decoration: tarefa.concluida
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  'Data: ${tarefa.data.day}/${tarefa.data.month}/${tarefa.data.year}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _removerTarefaComConfirmacao(index), // Chama a função de remoção com confirmação
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: _exibirDialogoNovaTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}
