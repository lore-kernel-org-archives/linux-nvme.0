From: osandov@osandov.com (Omar Sandoval)
Date: Thu, 26 Jul 2018 14:31:32 -0700
Subject: [PATCH 0/2] blktests: test ANA base support
In-Reply-To: <9661913b-cb11-39ba-7c3f-7dbd7490736a@broadcom.com>
References: <20180717133118.39026-1-hare@suse.de>
 <BYAPR04MB4502201C7DCD5AC4514AC6BC86500@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20180725191712.GA16847@vader>
 <BYAPR04MB4502890F18B77778B8EF6E5686540@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20180725210001.GB16847@vader>
 <BYAPR04MB4502FE260EA90730B4522657862B0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <9661913b-cb11-39ba-7c3f-7dbd7490736a@broadcom.com>
Message-ID: <20180726213132.GG16847@vader>

On Thu, Jul 26, 2018@09:35:53AM -0700, James Smart wrote:
> make sure this fix has been picked up in your kernel:
> http://git.infradead.org/nvme.git/commit/6cdefc6e2ad52170f89a8d0e8b1a1339f91834dc
> 
> deletes were broken otherwise and have the exact trace below.
> 
> -- james

Thanks, James, that indeed fixes the problem. I'll go ahead and merge
these tests since there's a fix in flight.
