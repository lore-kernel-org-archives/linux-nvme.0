From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Nov 2016 09:28:19 +0100
Subject: [PATCH] usb: gadget: uvc: fix returnvar.cocci warnings
In-Reply-To: <3504c280-fe7f-9ec2-0f92-2b6aea290080@samsung.com>
References: <201509170828.xv0cYNA5%fengguang.wu@intel.com>
 <alpine.DEB.2.10.1509171056470.2399@hadrien> <55FAA16C.5070601@samsung.com>
 <CGME20161122172658epcas4p43c58fc9861747068b50cc7af9337f692@epcas4p4.samsung.com>
 <2122146.rzc0RNY0pB@avalon>
 <3504c280-fe7f-9ec2-0f92-2b6aea290080@samsung.com>
Message-ID: <20161128082819.GA31105@lst.de>

On Wed, Nov 23, 2016@09:35:36AM +0100, Andrzej Pietrasiewicz wrote:
> The ->drop_item() is indeed a void function, the ->drop_link() is
> actually not. This, together with the fact that the value of ->drop_link()
> is silently ignored suggests, that it is the ->drop_link() return
> type that should be corrected and changed to void.

Please send a patch to change it.
