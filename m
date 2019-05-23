From: hch@lst.de (hch@lst.de)
Date: Thu, 23 May 2019 16:07:56 +0200
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <20190523133946.GE14049@localhost.localdomain>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
 <1558543193-24752-10-git-send-email-maxg@mellanox.com>
 <20190522224955.GC5857@localhost.localdomain>
 <0c677aa1-aa60-dddd-4a3f-a339545fee63@mellanox.com>
 <20190523133946.GE14049@localhost.localdomain>
Message-ID: <20190523140756.GB19598@lst.de>

On Thu, May 23, 2019@07:39:46AM -0600, Keith Busch wrote:
> > if this if fine I'll send a V2 with a small fix.
> 
> I think we'd actually prefer not seeing the hidden block devices, but
> instead use the device name from the "head": nvme4n1, nvme4n2, etc...

Agreed.  The hidden devices are an artefact we should expose to the
user as little as possible.
