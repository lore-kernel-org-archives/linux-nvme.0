From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 24 Jan 2018 13:31:41 +0100
Subject: [PATCH 0/2] nvme-cli: add support for an abort command with
 documentation
In-Reply-To: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20180124123141.t4gtx6fvzgei2rei@linux-x5ow.site>

On Wed, Jan 24, 2018@09:24:42PM +0900, Minwoo Im wrote:
> It would be convenient to use abort command by a subcommand.
> This command will strongly used by device developers to test device.

Ahm... please no.

If you need it for development just hack a small tool to create the
passthrough ioctl() call but don't hand out loaded guns to children^Wusers.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
