From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 28 May 2018 21:19:43 -0400
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180525145056.GD9591@redhat.com> (Mike Snitzer's message of
 "Fri, 25 May 2018 10:50:56 -0400")
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
Message-ID: <yq1muwj45sg.fsf@oracle.com>


Mike,

I understand and appreciate your position but I still don't think the
arguments for enabling DM multipath are sufficiently compelling. The
whole point of ANA is for things to be plug and play without any admin
intervention whatsoever.

I also think we're getting ahead of ourselves a bit. The assumption
seems to be that NVMe ANA devices are going to be broken--or that they
will require the same amount of tweaking as SCSI devices--and therefore
DM multipath support is inevitable. However, I'm not sure that will be
the case.

> Thing is you really don't get to dictate that to the industry.  Sorry.

We are in the fortunate position of being able to influence how the spec
is written. It's a great opportunity to fix the mistakes of the past in
SCSI. And to encourage the industry to ship products that don't need the
current level of manual configuration and complex management.

So I am in favor of Johannes' patches *if* we get to the point where a
Plan B is needed. But I am not entirely convinced that's the case just
yet. Let's see some more ANA devices first. And once we do, we are also
in a position where we can put some pressure on the vendors to either
amend the specification or fix their implementations to work with ANA.

-- 
Martin K. Petersen	Oracle Linux Engineering
