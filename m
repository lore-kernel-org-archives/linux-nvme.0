From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 14 May 2019 00:01:51 +0900
Subject: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
In-Reply-To: <20190513140246.GB24840@lst.de>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
 <20190513140246.GB24840@lst.de>
Message-ID: <CAC5umygobKcQ4NacG7cGkuqXR1qLUFCRBovWu5n=EOs=mu=esg@mail.gmail.com>

2019?5?13?(?) 23:03 Christoph Hellwig <hch at lst.de>:
>
> Usage of a scatterlist here is rather bogus as we never use
> it for dma mapping.  Why can't you store the various pages in a
> large bio_vec and then just issue that to the device in one
> get log page command?  (or at least a few if MDTS kicks in?)

OK.  I'll try to use bio_vec and see how it goes.
