From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 28 Jun 2016 01:45:47 -0700
Subject: NVMe over Fabrics: NQN UUID byte order
In-Reply-To: <1466792528.3234.9.camel@intel.com>
References: <1466792528.3234.9.camel@intel.com>
Message-ID: <20160628084547.GA31465@infradead.org>

On Fri, Jun 24, 2016@06:22:11PM +0000, Verkamp, Daniel wrote:
> The NVMe 1.2.1 specification, section 7.9 (NVMe Qualified Names), says
> that the UUID format of NQN is based on RFC 4122, which explicitly
> requires all fields to be in big-endian/network byte order (section
> 4.1.2, Layout and Byte Order).
> 
> However, the current NVMe over Fabrics host code generates and formats
> the Host Identifier UUID in little-endian byte order:
> 
> >static struct nvmf_host *nvmf_host_default(void)
> >{
> [...]
> >	uuid_le_gen(&host->id);
> >	snprintf(host->nqn, NVMF_NQN_SIZE,
> >		"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUl", &host-
> >id);
> 
> Is this intentional or an oversight?

This isn't intentional.  Can you send a patch to use uuid_be and
uuid_be_gen instead?
