From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 Aug 2018 00:18:20 -0700
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
Message-ID: <20180803071820.GA22003@infradead.org>

On Thu, Aug 02, 2018@10:09:50PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Hi,
> 
> Recently some confusion came up about how the /dev/nvme numbers are 
> allocated, and how much one can expect the to be consistent across 
> reboots. I was fairly convinced that it was about as random as a coin 
> flip, but some people have pointed out that these numbers were very 
> deterministic in older kernels, dating back to the 3.10 era.

They are allocated using an ida allocator and are not stable at all.
For any stable enumeration you have to rely on the EUI64/NGUID/UUID.

> Also, separate but related question. Samsung M1725a drives don't 
> generate entries under /dev/disk/by-path. Any idea why that might be?

Please send a dump of the nvme-cli id-ctrl subcommand.
