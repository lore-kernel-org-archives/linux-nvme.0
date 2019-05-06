From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Mon, 06 May 2019 11:34:26 +0300
Subject: [PATCH v2 06/10] nvme/core: add mdev interfaces
In-Reply-To: <1cc7efd1852f298b01f09955f2c4bf3b20cead13.camel@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-7-mlevitsk@redhat.com>
 <20190503122902.GA5081@infradead.org>
 <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
 <20190504064938.GA30814@lst.de>
 <1cc7efd1852f298b01f09955f2c4bf3b20cead13.camel@redhat.com>
Message-ID: <8ed3a93804ca136690749edcb464a60d4149a4e8.camel@redhat.com>

On Mon, 2019-05-06@11:31 +0300, Maxim Levitsky wrote:
> On Sat, 2019-05-04@08:49 +0200, Christoph Hellwig wrote:
> > On Fri, May 03, 2019@10:00:54PM +0300, Max Gurtovoy wrote:
> > > Don't see a big difference of taking NVMe queue and namespace/partition
> > > to 
> > > guest OS or to P2P since IO is issued by external entity and pooled
> > > outside 
> > > the pci driver.
> > 
> > We are not going to the queue aside either way..  That is where the
> > last patch in this series is already working to, and which would be
> > the sensible vhost model to start with.
> 
> Why are you saying that? I actualy prefer to use a sepearate queue per
> software
> nvme controller, tat because of lower overhead (about half than going through
> the block layer) and it better at QoS as the separate queue (or even few
> queues
> if needed) will give the guest a mostly guaranteed slice of the bandwidth of
> the
> device.

Sorry for typos - I need more coffee :-)

Best regards,
	Maxim Levitsky
