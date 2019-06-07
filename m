From: keith.busch@gmail.com (Keith Busch)
Date: Fri, 7 Jun 2019 10:26:47 -0600
Subject: [PATCH 0/2] NVMe 1.4 Identify Namespace Support
In-Reply-To: <yq1a7etjuab.fsf@oracle.com>
References: <20190606212854.122478-1-bvanassche@acm.org>
 <CAOSXXT5vsi4Fp20dj9TrouwNAYfOAMxAsbFZADZQ9pZE8uo3VA@mail.gmail.com>
 <yq1a7etjuab.fsf@oracle.com>
Message-ID: <CAOSXXT55eF5hUqoyyrY1OV1iPs3bKwU6FbmTN6m_-sr2JXQ5dg@mail.gmail.com>

On Fri, Jun 7, 2019 at 9:21 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> > Series looks good. There doesn't seem to be much in-kernel use for
> > these preferred access attributes unfortunately, but this is a good
> > start.
>
> Userland makes use of them to ensure partition/MD/DM alignment, pick
> sane values for filesystem layout, etc.

Okay, that makes sense.

The intention for this feature is to communicate potentially larger
physical blocks than page sizes, so I was just hoping for enforcing
that access from filesystems. Something like this from xfs

  https://lwn.net/Articles/770975/

would be a nice feature.
