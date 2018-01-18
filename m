From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Jan 2018 16:32:05 +0100
Subject: [PATCH v3 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180118152134.GB24168@lst.de>
References: <20180117105336.8666-1-jthumshirn@suse.de>
 <20180117105336.8666-2-jthumshirn@suse.de>
 <20180118152134.GB24168@lst.de>
Message-ID: <20180118153205.ipl6yzdfqqoohzbs@linux-x5ow.site>

On Thu, Jan 18, 2018@04:21:34PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 17, 2018@11:53:35AM +0100, Johannes Thumshirn wrote:
> > +nvme-core-y				:= trace.o core.o
> 
> trace.o should be conditional on CONFIG_TRACEPOINTS.
 
Doesn't do too much of a difference for me if CONFIG_TRACEPOINTS=n but if you
insist I can do it of cause.

> > +TRACE_EVENT(nvme_setup_cmd,
> > +	    TP_PROTO(struct nvme_command *cmd),
> > +	    TP_ARGS(cmd),
> > +	    TP_STRUCT__entry(
> > +		    __field(__u8, opcode)
> > +		    __field(__u8, flags)
> > +		    __field(__u16, cid)
> > +		    __field(__le32, nsid)
> > +		    __field(__le64, metadata)
> > +		    __field_struct( struct nvme_command, cmnd )
> 
> This still copies the whole SQE.  I think that is way to much to
> copy, especially given that you also copy many of the fields separately
> as well.

it's not that much, but ok.

Will be sending out a v4 tomorrow.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
