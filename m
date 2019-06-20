From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Jun 2019 08:25:17 +0200
Subject: [PATCH 2/3] nvme-pci: remove queue_count_ops for write,poll_queues
In-Reply-To: <20190616045137.GA5373@minwooim-desktop>
References: <CACVXFVPm4v1-9Sta3C0oN3YdTQhGQL1EVDwPBmA4i28SMHJAaQ@mail.gmail.com>
 <20190610015155.GD26551@ming.t460p>
 <20190608180219.17523-1-minwoo.im.dev@gmail.com>
 <20190608180219.17523-3-minwoo.im.dev@gmail.com>
 <20190610022522epcms2p26bc1b339680476ac6d81050045545f44@epcms2p2>
 <20190610024127.GE26551@ming.t460p>
 <20190610034136epcms2p1981531bd319a5210167e26251c5a6a4b@epcms2p1>
 <CGME20190610015241epcas3p2a021735345864364cb7f8c6aded4685d@epcms2p1>
 <20190610035219epcms2p152ffea1ffdda63bba9a901dd42979a11@epcms2p1>
 <20190616045137.GA5373@minwooim-desktop>
Message-ID: <20190620062517.GB20765@lst.de>

On Sun, Jun 16, 2019@01:51:37PM +0900, Minwoo Im wrote:
> Hi Christoph,
> 
> Could you please take a look at this patch ?

I much prefer this simpler series.  I'll queue it up for 5.3 after
a little testing.
