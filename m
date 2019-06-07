From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jun 2019 18:44:19 +0200
Subject: [PATCH 0/2] NVMe 1.4 Identify Namespace Support
In-Reply-To: <CAOSXXT55eF5hUqoyyrY1OV1iPs3bKwU6FbmTN6m_-sr2JXQ5dg@mail.gmail.com>
References: <20190606212854.122478-1-bvanassche@acm.org>
 <CAOSXXT5vsi4Fp20dj9TrouwNAYfOAMxAsbFZADZQ9pZE8uo3VA@mail.gmail.com>
 <yq1a7etjuab.fsf@oracle.com>
 <CAOSXXT55eF5hUqoyyrY1OV1iPs3bKwU6FbmTN6m_-sr2JXQ5dg@mail.gmail.com>
Message-ID: <20190607164419.GC7307@lst.de>

On Fri, Jun 07, 2019@10:26:47AM -0600, Keith Busch wrote:
> The intention for this feature is to communicate potentially larger
> physical blocks than page sizes, so I was just hoping for enforcing
> that access from filesystems. Something like this from xfs
> 
>   https://lwn.net/Articles/770975/
> 
> would be a nice feature.

No need for new NVMe features for that, you just need a controller
that exposes a LBA format with a data size larger than 4k, which has
been perfectly doable since NVMe 1.0.
