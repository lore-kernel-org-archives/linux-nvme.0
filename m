From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Feb 2017 10:27:16 -0500
Subject: OPAL fixups
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
References: <20170217125941.14319-1-hch@lst.de>
Message-ID: <20170217152716.GB18275@localhost.localdomain>

On Fri, Feb 17, 2017@01:59:37PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this contains a few more OPAL-related fixups.  It tones down warnings a bit,
> allocates the OPAL-?pecific data structure in a separate dynamic allocation,
> checks for support of Security Send/Receive in NVMe before using them,
> and makes sure we re-discovery the security capabilities after each reset.

Patches 1-3 look good to me.
