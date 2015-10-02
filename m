From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 03 Oct 2015 07:35:09 +1000
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151002210435.GM8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
 <20151002210435.GM8040@linux.vnet.ibm.com>
Message-ID: <1443821709.27295.20.camel@kernel.crashing.org>

On Fri, 2015-10-02@14:04 -0700, Nishanth Aravamudan wrote:
> Right, I did start with your advice and tried that approach, but it
> turned out I was wrong about the actual issue at the time. The problem
> for NVMe isn't actually the starting address alignment (which it can
> handle not being aligned to the device's page size). It doesn't handle
> (addr + len % dev_page_size != 0). That is, it's really a length
> alignment issue.
> 
> It seems incredibly device specific to have a an API into the DMA code
> to request an end alignment -- no other device seems to have this
> issue/design. If you think that's better, I can fiddle with that
> instead.
> 
> Sorry, I should have called this out better as an alternative
> consideration.

Nah it's fine. Ok. Also adding the alignment requirement to the API
would have been a much more complex patch since it would have had to
be implemented for all archs.

I think your current solution is fine.

Cheers,
Ben.
