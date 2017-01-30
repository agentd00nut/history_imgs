import imgkit

def save_urls_as_imgs(f_handle):
    
    i=0;
    while True:
       
        url=f.readline().rstrip()

        if not url:
            break

        print "{0} {1}".format(i, url)

        try:
            imgkit.from_url(url, "imgs/ff"+str(i))

        except IOError as e:
            print e;

            continue;
        
        
        i+=1;


f=open('ff_default_history.data', 'r');

save_urls_as_imgs(f);

f.close();