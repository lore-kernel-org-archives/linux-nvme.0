From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 10:48:14 -0700
Subject: [PATCH] nvme: set physical block size to value discovered in
 Identify Namespace
In-Reply-To: <20170920174842.GB1379@localhost.localdomain>
References: <20170920170605.42161-1-andrzej.jakowski@intel.com>
 <20170920174842.GB1379@localhost.localdomain>
Message-ID: <20170920174814.GA2556@infradead.org>

On Wed, Sep 20, 2017@01:48:42PM -0400, Keith Busch wrote:
> I think what you're wanting to say is:
> 
>   The physical block size will default to the logical block size unless
>   otherwise specified. While NVMe doesn't provide a way to discover the
>   physical block size, the format with best relative performance is a
>   good indicator as to the underlying block size.

I don't like this at all.  It's a really nasty guesswork.  If you need
this to get reasonable performance out of a specific device please
quirk it.

NVMe doesn't have the legacy issues that require 4k physical sectors
and 512 logical like ATA, so if a device really prefers 4k sectors
it should skip with 4k format by default instead of doing the logical /
physical dance.  Especially that a "physical" blocksize that Linux
could actually deal with (<= 4k) is a complete lie for flash anyway.
