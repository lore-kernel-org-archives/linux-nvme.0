From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 May 2019 14:59:09 +0200
Subject: [PATCH v2 06/10] nvme/core: add mdev interfaces
In-Reply-To: <1cc7efd1852f298b01f09955f2c4bf3b20cead13.camel@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-7-mlevitsk@redhat.com>
 <20190503122902.GA5081@infradead.org>
 <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
 <20190504064938.GA30814@lst.de>
 <1cc7efd1852f298b01f09955f2c4bf3b20cead13.camel@redhat.com>
Message-ID: <20190506125909.GB5288@lst.de>

On Mon, May 06, 2019@11:31:27AM +0300, Maxim Levitsky wrote:
> Why are you saying that? I actualy prefer to use a sepearate queue per software
> nvme controller, tat because of lower overhead (about half than going through
> the block layer) and it better at QoS as the separate queue (or even few queues
> if needed) will give the guest a mostly guaranteed slice of the bandwidth of the
> device.

The downside is that your create tons of crap code in the core nvme driver
for your specific use case that no one cares about.  Which is why it is
completely unacceptable.  If you want things to go fast make the block
layer go fast, don't add your very special bypass.
