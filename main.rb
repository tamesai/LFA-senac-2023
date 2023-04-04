class Tarefa
  def obter_tarefa
    puts 'Entre com a tarefa:'
    gets.chomp
  end

  def obter_datas(tarefa)
    data = %r{((\d{1,2}\s+de\s+[a-zA-Z]+\s+de\s+\d{4})|(\d{1,2}/\d{1,2}(/\d{2,4})?)|hoje|amanhã|depois\ de\ amanhã|(\d{1,2}\s(de\s)?[a-zA-Z]+\s(de\s)?\d{4}))}
    regexs = [data]

    for regex in regexs
      tags = tarefa.scan(regex)
      if tags.length > 0
        puts 'Data: ' + tags[0][0]
        break
      end
    end
  end

  def obter_horarios(tarefa)
    horario = /(\b((1?\d)|(2[0-3]))[:h]?\s?(\d{1,2})?\s?(hora|horas)?\b|\bàs\s(1?\d))/
    regexs = [horario]

    for regex in regexs
      tags = tarefa.scan(regex)
      if tags.length > 0
        puts 'Horário: ' + tags[0][0]
        break
      end
    end
  end

  def obter_tags(tarefa)
    tags = tarefa.scan(/#[[:word:]]+/)
    puts 'Tags: ' + tags.inspect if tags.length > 0
  end

  def obter_acoes(tarefa)
    tags = tarefa.scan(/(((R|r)eunião)|((A|a)gendar)|((M|m)arcar))|((L|l)igar)/)
    if tags.length > 0
      tags[0].delete(nil)
      puts 'Ações: ' + tags[0][0]
    end
  end

  def obter_pessoas(tarefa)
    pessoas = /((com|para) ([A-Z][[:word:]]+)((( ?, )|( e ))([A-Z][[:word:]]+))*)/
    regexs = [pessoas]

    for regex in regexs
      tags = tarefa.scan(regex)
      if tags.length > 0
        pessoas = tags[0][0]
        pessoas.slice! ","
        pessoas.slice! "e"
        puts "Pessoas: " + pessoas.split(' ')[1..].inspect
        break
      end
    end
  end

  def iniciar
    tarefa = obter_tarefa

    puts "\n"
    obter_datas(tarefa)
    obter_horarios(tarefa)
    obter_tags(tarefa)
    obter_acoes(tarefa)
    obter_pessoas(tarefa)
  end
end

t = Tarefa.new
t.iniciar

# Reunião amanhã com Maria e João às 10 #trabalho
# Ligar para Maria, João e Marie 12:00 13/04 #entrevista #trabalho
