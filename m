From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Feb 2019 18:11:00 +0100
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190213120358.GA3559@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain> <20190205161347.GA847@lst.de>
 <20190213120358.GA3559@esprimo>
Message-ID: <20190214171100.GA473@lst.de>

On Wed, Feb 13, 2019@09:03:58PM +0900, Takao Indoh wrote:
> Ok, let me think about how I should change this patch.

Just drop it.

> I'm thinking that the problem of this patch is adding processor specific
> code into NVMe common driver, is this correct? Or another problem? It
> would be great if you could give me a hint to improve this patch.

For one it is processor / root port specific.  But even more importantly
it is incorrect.  If the device wants to issue a relaxed order
transaction it should do so all by itself, not by hacking around it
from the kernel.
