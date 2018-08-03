From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 3 Aug 2018 08:40:25 -0600
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <20180803071820.GA22003@infradead.org>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
Message-ID: <20180803144025.GA4381@localhost.localdomain>

On Fri, Aug 03, 2018@12:18:20AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018@10:09:50PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > Hi,
> > 
> > Recently some confusion came up about how the /dev/nvme numbers are 
> > allocated, and how much one can expect the to be consistent across 
> > reboots. I was fairly convinced that it was about as random as a coin 
> > flip, but some people have pointed out that these numbers were very 
> > deterministic in older kernels, dating back to the 3.10 era.
> 
> They are allocated using an ida allocator and are not stable at all.
> For any stable enumeration you have to rely on the EUI64/NGUID/UUID.

Yeah, the were always allocated through an ida and were never stable in
any kernel version.
 
> > Also, separate but related question. Samsung M1725a drives don't 
> > generate entries under /dev/disk/by-path. Any idea why that might be?
> 
> Please send a dump of the nvme-cli id-ctrl subcommand.

The 'by-path' should actually only depend on the PCI BDf and the 'nsid'
attribute. The bdf is not necessarilly stable.

If using systemd, you'd need thsi commit to get the by-path links:

  https://github.com/systemd/systemd/commit/b4c6f71b827d41a4af8007b735edf21ef7609f99
