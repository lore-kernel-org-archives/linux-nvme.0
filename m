From: jsmart2021@gmail.com (James Smart)
Date: Wed, 15 Feb 2017 08:04:54 -0800
Subject: [PATCH v3 00/16] lpfc: Add NVME Fabrics support
In-Reply-To: <3440afa9-9449-3378-6e8f-7cbe8dbb52cf@grimberg.me>
References: <58a0d918.RXFImMqrhYsCnA/U%jsmart2021@gmail.com>
 <3440afa9-9449-3378-6e8f-7cbe8dbb52cf@grimberg.me>
Message-ID: <bf3afee6-cd38-86fc-2e12-53df9c731987@gmail.com>



On 2/15/2017 2:12 AM, Sagi Grimberg wrote:
>
>>
>> The patches were cut against 1/30 scsi.git tree, misc branch.
>> ** THEY ARE INTENDED FOR THE SCSI.GIT TREE, MISC BRANCH **
>>
>> The lpfc version in the linux-block.git tree is rather old. I have a
>> recipe for how to get it to a version that syncs with the
>> scsi.git/misc tree so that these patches can apply there as well.
>> Contact me if you would like it.
>
> This set does not seem to apply cleanly on nvme-4.11 tree, looks
> like patch 6 is failing.

As I stated - the patches were cut vs the scsi.git tree - where the most 
recent lpfc is. So I expected merge via the scsi.git tree.

Given how old the scsi/lpfc part was on linux-block as of a little while 
ago, it doesn't surprise me they aren't clean.  I'll cut a version vs 
git.infradead.orig/nvme.git nvme-4.11 and send them privately.


>
> Also, can you send your patchset threaded? It usually does so
> when generating the patches with git format-patch, not sure
> how this is not the case with your set... It would make my
> life a bit easier.

Well, I am using git format-patch to create them. But have to revert to 
a manual mailing request as I haven't been able to get git-send-email 
working past our firewalls.  Sorry.

-- james
