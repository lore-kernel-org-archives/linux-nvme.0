From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 07 Jun 2019 11:21:16 -0400
Subject: [PATCH 0/2] NVMe 1.4 Identify Namespace Support
In-Reply-To: <CAOSXXT5vsi4Fp20dj9TrouwNAYfOAMxAsbFZADZQ9pZE8uo3VA@mail.gmail.com>
 (Keith Busch's message of "Fri, 7 Jun 2019 07:56:21 -0600")
References: <20190606212854.122478-1-bvanassche@acm.org>
 <CAOSXXT5vsi4Fp20dj9TrouwNAYfOAMxAsbFZADZQ9pZE8uo3VA@mail.gmail.com>
Message-ID: <yq1a7etjuab.fsf@oracle.com>


Keith,

> Series looks good. There doesn't seem to be much in-kernel use for
> these preferred access attributes unfortunately, but this is a good
> start.

Userland makes use of them to ensure partition/MD/DM alignment, pick
sane values for filesystem layout, etc.

-- 
Martin K. Petersen	Oracle Linux Engineering
