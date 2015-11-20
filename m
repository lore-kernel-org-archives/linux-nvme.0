From: mlin@kernel.org (Ming Lin)
Date: Thu, 19 Nov 2015 21:33:44 -0800
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
 target
In-Reply-To: <20151120051645.GB19405@lst.de>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
 <20151120051645.GB19405@lst.de>
Message-ID: <1447997624.3473.6.camel@hasee>

On Fri, 2015-11-20@06:16 +0100, Christoph Hellwig wrote:
> Thanks Ming,
> 
> from a first quick view this looks great.  I'll look over it in a bit
> more detail once I get a bit more time.

Thanks to CC Nic :-)

But funny, I double-checked bash history. I actually CCed Nic.
Don't know why it's lost.

mlin at ssi:~$ history |grep "nab"
 1861  git send-email --from "Ming Lin <mlin at kernel.org>" --to
"linux-nvme at lists.infradead.org"  --cc "qemu-devel at nongnu.org" --cc
"virtualization at lists.linux-foundation.org" --cc "Christoph Hellwig
<hch at lst.de>" --cc "Nicholas A. Bellinger <nab at linux-iscsi.org>"
--compose ~/patches/*.patch
