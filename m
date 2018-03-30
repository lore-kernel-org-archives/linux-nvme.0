From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Mar 2018 15:24:39 -0600
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
Message-ID: <20180330212439.GA28945@localhost.localdomain>

On Fri, Mar 30, 2018@06:18:50PM -0300, Rodrigo R. Galvao wrote:
> When trying to issue write_zeroes command against TARGET the nr_sector is
> being incremented by 1, which ends up hitting the following condition at
> __blkdev_issue_zeroout:
> 
>      if ((sector | nr_sects) & bs_mask)
>                 return -EINVAL;
> 
> Causing the command to always fail. Removing the increment makes the
> command to work properly.

Doesn't that mean your host is using this command wrong? The NLB is a
0's based value, we're supposed to +1 to get the correct block count.
