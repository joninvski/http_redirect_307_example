# cat config.ru
require "roda"

class App < Roda
    use Rack::Session::Cookie, :secret => ENV['SECRET']

    route do |r|
        # GET / request
        r.root do
            r.redirect "/a"
        end

        r.on 'a' do
            r.is do
                r.post do
                    puts "It hit A!"
                    r.redirect("/b", 307)
                end
            end
        end

        r.on 'b' do
            r.is do
                r.post do
                    puts "It hit B!"
                    """
        <Response>
            <Say>This is b post response</Say>
        </Response>
                    """
                end
            end
        end

        r.on 'c' do
            r.is do
                r.post do
                    puts "It hit c!"
                    r.redirect("/d", 307)
                end
            end
        end


        r.on 'd' do
            r.is do
                r.post do
                    puts "It hit D!"
                    """
                    <Response>
                        <Say>This is d post response</Say>
                    </Response>
                    """
                end
            end
        end

    end
end

run App.freeze.app
