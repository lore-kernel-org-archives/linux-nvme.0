From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 May 2019 08:53:46 +0200
Subject: [PATCH] nvme: target: use struct_size() in kmalloc()
In-Reply-To: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
References: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
Message-ID: <20190521065346.GG30402@lst.de>

Looks ok to me, although for a fixed size argument the whole overflow
detection thing in struct_size() is rather pointless..
