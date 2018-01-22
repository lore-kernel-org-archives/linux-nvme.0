From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 22 Jan 2018 17:04:37 +0100
Subject: [PATCH v4 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180122155956.GA6635@lst.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-2-jthumshirn@suse.de>
 <20180122152301.GA5818@lst.de>
 <20180122155356.4doy32sfgzwegmq4@linux-x5ow.site>
 <20180122155956.GA6635@lst.de>
Message-ID: <20180122160437.4kct2cz2ihwymvct@linux-x5ow.site>

On Mon, Jan 22, 2018@04:59:56PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2018@04:53:56PM +0100, Johannes Thumshirn wrote:
> > Yes and no. I personally like to have the big hammer when tracing customer
> > problems and filter out maunally later. I initially had a tracepoint for each
> > of nvme_setup_flush(), nvme_setup_discard(), nvme_setup_rw() but decided it
> > was too fine grained.
> > 
> > nvme_setup_cmd() has the nice side effect that all commands, including
> > userspace passtrough commands must pass it. This was extremely helpful in the
> > customer bug which inspired me to implement this tracepoint.
> 
> Not arguing against placing the tracepoint(s) in nvme_setup_cmd, but
> it seems like we should have one for admin and one for I/O commands.
> Especially as we have to special case them just about everywhere,
> and the overlap of the opcode space is pretty annoying.

You mean like:
	if (ns)
		trace_nvme_setup_cmd(cmd);
	else
		trace_nvme_setup_admin_cmd(cmd);

?



-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
