From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 24 Jan 2018 14:03:15 +0100
Subject: [PATCH 0/2] nvme-cli: add support for an abort command with
 documentation
In-Reply-To: <98552e25-112b-da7a-6ee8-b046c6a54c18@gmail.com>
References: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180124123141.t4gtx6fvzgei2rei@linux-x5ow.site>
 <98552e25-112b-da7a-6ee8-b046c6a54c18@gmail.com>
Message-ID: <20180124130315.g7i3yk73avo7wh66@linux-x5ow.site>

On Wed, Jan 24, 2018@09:55:20PM +0900, Minwoo Im wrote:
> Hello Johannes,
> 
> On 01/24/2018 09:31 PM, Johannes Thumshirn wrote:
> > On Wed, Jan 24, 2018@09:24:42PM +0900, Minwoo Im wrote:
> > > It would be convenient to use abort command by a subcommand.
> > > This command will strongly used by device developers to test device.
> > 
> > Ahm... please no.
> > 
> > If you need it for development just hack a small tool to create the
> > passthrough ioctl() call but don't hand out loaded guns to children^Wusers.
> > 
> 
> Thanks for your kindly comment.
> 
> I thought nvme-cli tool would be used mostly by developers, not children
> users. Also thought that it will not need any helps from kernel to abort a
> specified command not just like delete I/O SQ/CQ so that nvme-cli could
> handle this kind of thing.

nvme-cli will also be used by administrators intending to setup nvme over
fabrics connections or debug nvme multipathing as well. It is certainly not a
developer only tool.

> But, actually there is no limit for anybody to use this interface tool.

Yes, actually thinking more of it, the whole passthrough interface is
dangerous. What happens if a user sends a delete CQ/SQ command via this
interface and the kernel still tries to do I/O to it?

I think I'll need to come up with a testcase for this.

	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
