From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 21 Nov 2015 00:19:09 -0800
Subject: nvme lightnvm comments
In-Reply-To: <564F9003.5080109@bjorling.me>
References: <20151120105022.GA22131@infradead.org>
 <564EFEBC.3040603@bjorling.me>
 <20151120164709.GA9931@infradead.org>
 <564F9003.5080109@bjorling.me>
Message-ID: <20151121081909.GB16229@infradead.org>

On Fri, Nov 20, 2015@10:26:27PM +0100, Matias Bj?rling wrote:
> Do you have any plans for exposing the completion_entry on req_completion in
> the driver? I'm interested in the fields ->result and ->rsvd in struct
> nvme_completion. They contain the completion bits for each of the PPA
> entries. Which I'll need higher up in the stack to perform correct retries
> and so forth.

->result is available already for passthrough commands.  But for Fabrics
I actually need the full CQE as well, and I'm working on that at the
moment.  Stay tuned!
