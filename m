From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 25 Jul 2017 16:04:22 +0200
Subject: [PATCH] nvme: wwid_show: show uuid first if existed
In-Reply-To: <1500989306-18460-1-git-send-email-guanjunxiong@huawei.com>
References: <1500989306-18460-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170725140422.GL3750@linux-x5ow.site>

On Tue, Jul 25, 2017@09:28:26PM +0800, Guan Junxiong wrote:
> The NGUID/EUI64 is not universal unique because a controller may reuse a non-zero NGUID
> or EUI64 value for a new namespace after the original namespace using the value has been
> deleted. Therefore, UUID of a namescpace prevails over NGUID/EUI64 for showing wwid.

I've already sent a patch for this:
http://lists.infradead.org/pipermail/linux-nvme/2017-July/011905.html

@Christoph, did this miss the last pull to Jens?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
