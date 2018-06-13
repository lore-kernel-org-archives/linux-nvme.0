From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 13 Jun 2018 07:31:19 -0600
Subject: please revert a nvme-cli commit
In-Reply-To: <20180613075557.GA22940@lst.de>
References: <20180613075557.GA22940@lst.de>
Message-ID: <20180613133118.GB5331@localhost.localdomain>

On Wed, Jun 13, 2018@09:55:57AM +0200, Christoph Hellwig wrote:
> d8f949c21e9d832149518f26c71dfd8de16cd628 does bogus blind retries
> on failure, and the kernel part of it was rejected.  Let's sort this
> out properly.
> 
> Similarly at least for now bb2d87d7f386882005bb87fe9412af23c646c876 is
> bogus as well.  We require fabrics connect to be synchronous, and changing
> that will require a longer discussion first.

Okay, will do.
