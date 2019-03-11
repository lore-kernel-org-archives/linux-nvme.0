From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 11 Mar 2019 15:59:47 -0700
Subject: [PATCH v2] nvme: test out-of-range I/O access (file backend)
In-Reply-To: <763669e2-7a87-6876-feae-49e82c5d4c8f@grimberg.me>
References: <20190311221855.27375-1-sagi@grimberg.me>
 <20190311224904.GE1315@vader>
 <763669e2-7a87-6876-feae-49e82c5d4c8f@grimberg.me>
Message-ID: <20190311225947.GF1315@vader>

On Mon, Mar 11, 2019@03:58:02PM -0700, Sagi Grimberg wrote:
> 
> > Ah, so this fails for me because I have nvme-cli 1.7 which is missing
> > your 9c891c139894 ("nvmet: check fileio lba range access boundaries").
> > How about we just look at the exit code of nvme read instead of relying
> > on that output?
> 
> Fine by me, you can fold it in..

Done and pushed.
