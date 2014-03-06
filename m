From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 06 Mar 2014 10:56:55 +0100
Subject: [PATCH v2] NVMe: silence GCC warning on 32 bit
In-Reply-To: <alpine.LRH.2.03.1403050803090.2885@AMR>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
 <1392934261.15264.22.camel@x220> <alpine.LRH.2.03.1402210921010.4656@AMR>
 <1393925767.3038.23.camel@x220> <alpine.LRH.2.03.1403050803090.2885@AMR>
Message-ID: <1394099815.4592.8.camel@x220>

On Wed, 2014-03-05@08:09 -0700, Keith Busch wrote:
> Looks good to me.

Thanks.

> This won't apply in linux-nvme yet and it may be a
> little while before it does, so this might be considered to go upstream
> through a different tree if you want this in sooner.

These warnings popped up in v3.14-rc1. (In v3.13 bvprv was a pointer
initialized to NULL.) This patch is not urgent, but it would still be
nice if the warnings were silenced in v3.14, since they are so noisy. Is
there any tree that queues NVMe fixes to be applied during this release
cycle?

> On Tue, 4 Mar 2014, Paul Bolle wrote:
> > bvprv? Would that mean bio_vec private? But it looks like some temporary
> > variable, so something like tmp may make more sense. Anyhow, still
> > compile tested only (on 32 and 64 bit x86).
> 
> bvprv == bio_vec previous

Thanks. So perhaps that variable could be renamed to previous (or its
more common alias prev),


Paul Bolle
