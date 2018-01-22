From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jan 2018 17:10:27 +0100
Subject: [PATCH v4 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180122160437.4kct2cz2ihwymvct@linux-x5ow.site>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-2-jthumshirn@suse.de> <20180122152301.GA5818@lst.de>
 <20180122155356.4doy32sfgzwegmq4@linux-x5ow.site>
 <20180122155956.GA6635@lst.de>
 <20180122160437.4kct2cz2ihwymvct@linux-x5ow.site>
Message-ID: <20180122161027.GA7097@lst.de>

On Mon, Jan 22, 2018@05:04:37PM +0100, Johannes Thumshirn wrote:
> You mean like:
> 	if (ns)
> 		trace_nvme_setup_cmd(cmd);
> 	else
> 		trace_nvme_setup_admin_cmd(cmd);
> 
> ?

Yes.  Although I'd rename trace_nvme_setup_cmd to trace_nvme_setup_nvm_cmd
to prepare for new I/O command sets.
