create database naodigital_reto1_tweets;

use naodigital_reto1_tweets;

create table tweets_table (
	id integer,
	texto varchar(280),
  usuario char(50),
  hashtags json,
  fecha datetime,
  retweets integer,
  favoritos integer
  );

create table jsonTable (jsondata json);

insert into jsonTable (jsondata)
values
	('{
      "id": 1,
      "texto": "La tecnología de la realidad virtual está revolucionando la forma en que experimentamos los videojuegos. #tecnología #videojuegos",
      "usuario": "gamers_unidos",
      "hashtags": ["tecnología", "videojuegos"],
      "fecha": "2023-03-13 16:45:00",
      "retweets": 23,
      "favoritos": 87
  }'),
  ('{
      "id": 2,
      "texto": "Apple anuncia el lanzamiento de su nuevo iPhone 15 con cámara mejorada y pantalla OLED de 6,7 pulgadas. #Apple #iPhone15",
      "usuario": "tech_news",
      "hashtags": ["Apple", "iPhone15"],
      "fecha": "2023-03-12 10:30:00",
      "retweets": 234,
      "favoritos": 1876
  }');

INSERT INTO tweets_table (id, texto, usuario, hashtags, fecha, retweets, favoritos)
SELECT
    jsondata->'$.id' AS id,
    jsondata->'$.texto' AS texto,
    jsondata->'$.usuario' AS usuario,
    JSON_ARRAY(jsondata->'$.hashtags[0]', jsondata->'$.hashtags[1]') AS hashtags,
    CAST(jsondata->'$.fecha' AS DATETIME) AS fecha,
    jsondata->'$.retweets' AS retweets,
    jsondata->'$.favoritos' AS favoritos
FROM jsonTable;