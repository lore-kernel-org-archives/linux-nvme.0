From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Feb 2016 15:52:22 +0000
Subject: [PATCH 0/4] NVMe: Surprise removal fixes
In-Reply-To: <BJXPR01MB1997AE807A93FA2EBB32076E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <BJXPR01MB1997AE807A93FA2EBB32076E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160204155221.GC28747@localhost.localdomain>

On Thu, Feb 04, 2016@03:25:50AM +0000, Wenbo Wang wrote:
> Isn't the dd behavior correct? For non-direct dd, even if a surprise remove happened, it simply keeps dirtying the page cache and is not aware of any errors below.

Try it with a usb drive. It ends with ENOSPC error.
