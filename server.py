class Server(object):
    def run1(self, message):
        print("Hello {} from run1".format(message))
    
    def run2(message):
        print("Hello {} from run2".format(message))

    def run(hoge):
        print("Hello from hoge")

    def run3(hoge):
        print("Hello from hoge")

    def run4(hoge):
        print("Hello from hoge")

if __name__== "__main__":
    server = Server()
    server.run1()
    server.run2()
