From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Dec 2018 17:58:14 +0100
Subject: [PATCH v4 1/2] export trace.c helper functions to other modules
In-Reply-To: <20181218165706.GA13271@lst.de>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218165706.GA13271@lst.de>
Message-ID: <20181218165814.GA13449@lst.de>

On Tue, Dec 18, 2018@05:57:06PM +0100, Christoph Hellwig wrote:
> 
> 
> On Mon, Dec 17, 2018@08:51:37PM -0800, yupeng wrote:
> > Export bellow three functions:
> > nvme_trace_parse_admin_cmd
> > nvme_trace_parse_nvm_cmd
> > nvme_trace_disk_name
> > Thus any other modules which depends on nvme-core could use the trace
> > events in trace.h
> 
> But we don't actually use these trace events anywhere outside of core.c,
> even with your second patch, do we?

Except for nvme_trace_disk_name, which is used via __print_disk_name.
