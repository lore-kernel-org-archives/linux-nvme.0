From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Fri, 24 Jun 2016 18:22:11 +0000
Subject: NVMe over Fabrics: NQN UUID byte order
Message-ID: <1466792528.3234.9.camel@intel.com>

The NVMe 1.2.1 specification, section 7.9 (NVMe Qualified Names), says
that the UUID format of NQN is based on RFC 4122, which explicitly
requires all fields to be in big-endian/network byte order (section
4.1.2, Layout and Byte Order).

However, the current NVMe over Fabrics host code generates and formats
the Host Identifier UUID in little-endian byte order:

>static struct nvmf_host *nvmf_host_default(void)
>{
[...]
>	uuid_le_gen(&host->id);
>	snprintf(host->nqn, NVMF_NQN_SIZE,
>		"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUl", &host-
>id);

Is this intentional or an oversight?

This could probably use some clarification on the NVMe specification
side either way.

Thanks,
-- Daniel Verkamp
