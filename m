From: sbates@raithlin.com (Stephen Bates)
Date: Fri, 16 Dec 2016 13:37:46 -0600
Subject: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
In-Reply-To: <365e0b2b-06b1-dc0b-a9ae-dc901ca98d6a@fb.com>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <365e0b2b-06b1-dc0b-a9ae-dc901ca98d6a@fb.com>
Message-ID: <b2755703b7823eb26f282218ef29362b.squirrel@webmail.raithlin.com>

>> Jens I based this off v4.9 because for some reason your for-4.10/block
>> is missing my original CMB commit (202021c1a63c6)?
>
> for-4.10/block was forked off v4.9-rc1, and that patch didn't make it in
> until v4.9-rc2. Since for-4.10/block has been merged, any patches for this
> series or next should be based on my for-linus, or just master.
>
> Assuming these two apply directly to master as well?
>
>

Ah thanks for clearing up my confusion ;-). Yes, this series applies
cleanly to both your master and for-linus branches.


Stephen
