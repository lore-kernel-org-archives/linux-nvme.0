From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 Feb 2016 20:09:56 -0800
Subject: [PATCH-4.5-v3 2/5] NVMe: Fix namespace removal deadlock
In-Reply-To: <BJXPR01MB1997CEFCF124760350CFEEDE0AF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-3-git-send-email-keith.busch@intel.com>
 <BJXPR01MB1997CEFCF124760350CFEEDE0AF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160218040956.GB12379@infradead.org>

On Thu, Feb 18, 2016@02:00:47AM +0000, Wenbo Wang wrote:
> Without this mutex, is it safe to run concurrently with nvme_free_ns which manipulates the list?

see the first patch for an explanation on why this should be safe.
