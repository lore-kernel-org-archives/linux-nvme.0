From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Sep 2016 10:33:02 -0400
Subject: [PATCH v3 1/3] nvme/scsi: Remove power management support
In-Reply-To: <20160916083333.GB2415@lst.de>
References: <cover.1474002926.git.luto@kernel.org>
 <714df91022b06c6799afb315962769f22b8ab9f4.1474002926.git.luto@kernel.org>
 <20160916083333.GB2415@lst.de>
Message-ID: <20160916143301.GB1852@localhost.localdomain>

On Fri, Sep 16, 2016@10:33:33AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 15, 2016@10:24:19PM -0700, Andy Lutomirski wrote:
> > Since this code appears to be useless, just delete it.
> 
> Yes, please!

For a future patch, any objection to deleting the whole file? :)
