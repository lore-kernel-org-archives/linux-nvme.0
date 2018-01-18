From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Jan 2018 16:21:34 +0100
Subject: [PATCH v3 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180117105336.8666-2-jthumshirn@suse.de>
References: <20180117105336.8666-1-jthumshirn@suse.de>
 <20180117105336.8666-2-jthumshirn@suse.de>
Message-ID: <20180118152134.GB24168@lst.de>

On Wed, Jan 17, 2018@11:53:35AM +0100, Johannes Thumshirn wrote:
> +nvme-core-y				:= trace.o core.o

trace.o should be conditional on CONFIG_TRACEPOINTS.

> +TRACE_EVENT(nvme_setup_cmd,
> +	    TP_PROTO(struct nvme_command *cmd),
> +	    TP_ARGS(cmd),
> +	    TP_STRUCT__entry(
> +		    __field(__u8, opcode)
> +		    __field(__u8, flags)
> +		    __field(__u16, cid)
> +		    __field(__le32, nsid)
> +		    __field(__le64, metadata)
> +		    __field_struct( struct nvme_command, cmnd )

This still copies the whole SQE.  I think that is way to much to
copy, especially given that you also copy many of the fields separately
as well.
