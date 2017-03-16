alias Dbuniverse.Repo
alias Dbuniverse.Character
alias Dbuniverse.Category

Repo.drop_database

case Repo.create_database do

    {:error, body} -> 
        IO.puts "Database could not be created. An error occured:"
        IO.puts body
    {:ok, _} ->
        yamcha = Character.create_new_character(%Character{}, %{
            :name => "Yamcha",
            :category => "db",
            :image_url_header => "http://static1.squarespace.com/static/51b3dc8ee4b051b96ceb10de/51ce6099e4b0d911b4489b79/58502dd16a4963e77eaaa543/1481650773075/shonen-jump-releases-dragon-ball-manga-where-yamcha-is-the-hero-social.jpg?format=1000w",
            :image_url_tiny => "http://dball.free.fr/dball/perso/perso_db/perso_yamcha3.gif",
            :image_url => "http://vignette1.wikia.nocookie.net/joke-battles/images/f/f2/Yamcha_render_by_anthonyjmo-d9tmtfh.png/revision/latest?cb=20160909123653",
            :description => "Yamcha est un redoutable guerrier capable de terrasser les adversaires les plus terribles grâce à sa technique dévastatrice : la botte secrète du loup. Accompagné de son acolyte Pual, il parcourt le désert à la recherche de voyageurs à détrousser.\nCe jeune homme particulièrement séduisant souffre cependant d'une timidité maladive qui lui fait perdre tous ses moyens dès qu'il se trouve en face d'une fille.\nIl abandonnera sa vie de bandit du désert pour accompagner Goku et vaincre sa peur de la gent féminine.\nIl décidera ensuite d'aller en ville parfaire ses techniques de combat et il participera même au Championnat du Monde des arts martiaux.",
            :type => "character"
        })

        Repo.insert(Poison.encode! yamcha.changes)
        
        songoku = Character.create_new_character(%Character{}, %{
            :name => "Songoku",
            :category => "db",
            :image_url_header => "http://orig08.deviantart.net/6d7a/f/2013/252/5/8/dragon_ball___kid_goku_27_by_superjmanplay2-d6lni55.png",
            :image_url_tiny => "http://dball.free.fr/dball/perso/perso_principaux/sangoku/gokou5.gif",
            :image_url => "http://vignette1.wikia.nocookie.net/3__/images/8/8d/Goku2.jpg.png/revision/latest?cb=20140917091017&path-prefix=300-heroes",
            :description => "Goku est un jeune garçon au cœur pur doté d’une queue de singe et d’une force extraordinaire.\nSeule petite ombre au tableau : il a tendance à se transformer en gorille géant lorsqu’il regarde la pleine lune.\nGoku ne se sépare jamais du bâton que lui a laissé son grand-père adoptif, Gohan, et qui a le pouvoir de changer de taille sur commande. Sa panoplie va s’étoffer par la suite avec le nuage magique offert par Tortue Géniale, qui lui permettra de parcourir des distances formidables en un rien de temps.\nAu fil de ses aventures, Goku va gagner en expérience pour devenir le plus puissant guerrier de la terre.\nIl apprendra notamment à maîtriser à la perfection la technique du Kamehameha, qui permet de concentrer sa force intérieure pour propulser des boules d’énergie destructrices.",
            :type => "character"
        })

        Repo.insert(Poison.encode! songoku.changes)
        
        vegeta = Character.create_new_character(%Character{}, %{
            :name => "Vegeta",
            :category => "dbz",
            :image_url_header => "http://orig08.deviantart.net/6d7a/f/2013/252/5/8/dragon_ball___kid_goku_27_by_superjmanplay2-d6lni55.png",
            :image_url_tiny => "http://dball.free.fr/dball/perso/perso_principaux/sangoku/gokou5.gif",
            :image_url => "http://vignette1.wikia.nocookie.net/3__/images/8/8d/Goku2.jpg.png/revision/latest?cb=20140917091017&path-prefix=300-heroes",
            :description => "Vegeta blabla",
            :type => "character"
        })

        Repo.insert(Poison.encode! vegeta.changes)

        db_category = Poison.encode! %Category{
            name: "db",
            type: "category"
        }

        Repo.insert db_category

        dbz_category = Poison.encode! %Category{
            name: "dbz",
            type: "category"
        }

        Repo.insert dbz_category

        fetch_all_categories_code = File.read! "priv/repo/views/category_fetch_all.json"
        Repo.create_view "category", fetch_all_categories_code

        by_category_code = File.read! "priv/repo/views/character_by_category.json"
        Repo.create_view "character", by_category_code

        IO.puts "Database has been seeded successfully"

end