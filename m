From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 4 Aug 2018 01:16:36 -0700
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <20180803165411.GA4551@localhost.localdomain>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
 <20180803165411.GA4551@localhost.localdomain>
Message-ID: <20180804081636.GA4421@infradead.org>

On Fri, Aug 03, 2018@10:54:11AM -0600, Keith Busch wrote:
> The sammy drives do not have compliant serial number. Spec requires
> strings are left justified, padding spaces to the right.

It doesn't look like Samsung fucked it up but Dell..

On the plus side that should give us more of a chance to fix it :)
