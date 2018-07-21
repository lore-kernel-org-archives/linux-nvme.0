From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 21 Jul 2018 21:23:32 +0000
Subject: [PATCH 0/2] blktests: test ANA base support
In-Reply-To: <20180717133118.39026-1-hare@suse.de>
References: <20180717133118.39026-1-hare@suse.de>
Message-ID: <BYAPR04MB4502201C7DCD5AC4514AC6BC86500@BYAPR04MB4502.namprd04.prod.outlook.com>

Hi Hannes,

Thanks for the test, this is really helpful, please see my inline comments to individual patches.

Also, the test number should be I guess 18, 14-17 testcases are still in the queue.

Omar, can you please let us know when can you merge the remaining testcases for NVMeOF
from the first round that I've posted? so we can set the right number for this.

From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org> on behalf of Hannes Reinecke <hare@suse.de>
Sent: Tuesday, July 17, 2018 6:31 AM
To: Omar Sandoval
Cc: Christoph Hellwig; Sagi Grimberg; Keith Busch; linux-nvme at lists.infradead.org; linux-block at vger.kernel.org; Hannes Reinecke
Subject: [PATCH 0/2] blktests: test ANA base support
? 
 
Hi all,

here's a small patchset for testing ANA base support.
The test itself requires the ANA patchset from Christoph, plus
the fixes I've sent to the mailing list earlier.

Hannes Reinecke (2):
? blktests: enable ANA support
? blktests: add test for ANA state transition

?tests/nvme/014???? | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
?tests/nvme/014.out |? 17 ++++++
?tests/nvme/rc????? |? 49 ++++++++++++++++-
?3 files changed, 221 insertions(+), 3 deletions(-)
?create mode 100755 tests/nvme/014
?create mode 100644 tests/nvme/014.out

-- 
2.12.3

    
