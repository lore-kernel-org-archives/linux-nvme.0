From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 Mar 2015 18:48:29 +0000 (UTC)
Subject: infradead NVMe repositories
In-Reply-To: <BN3PR0401MB144466279974D2A943C0171BFD190@BN3PR0401MB1444.namprd04.prod.outlook.com>
References: <BN3PR0401MB144466279974D2A943C0171BFD190@BN3PR0401MB1444.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1503111840320.32385@localhost.lm.intel.com>

Hi David,

On Wed, 11 Mar 2015, David Darrington wrote:
> Hi Keith,
> 
> Can help me understand the purpose of the infradead repos and how they are related?
> 
> http://git.infradead.org/users/willy/linux-nvme.git - My understanding is that this is the NVMe maintainers git repo. However, it seems to be inactive. I believe that this because the current
> work is happening with the 3.19 blk-mq work, here? git://git.kernel/org/pub/scm/linux/kernel/git/axboe/linux-block.git.

That's a really good question ... I'll have to get back to you on that.

> http://git.infradead.org/users/kbusch/linux-nvme.git
> 
> I?m not sure what this is for?

That's so I can control my own upstream destiny. :)
  ?
> http://git.infradead.org/users/kbusch/nvme-compatibility.git
> 
> Is this a backport to a pre-3.3 kernel?

Originally compatibility for 2.6.30 - present. Hasn't been updated
publicly in a while due to percieved lack of interest.

> http://git.infradead.org/users/kbusch/nvme-legacy.git
> 
> My understanding is that this the repo for the pre-mq version of NVMe.

This repo is the latest version of the driver prior to the blk-mq
conversion since a lot of popular vendor distros have not moved to blk-mq
just yet.

> Also, I?d like to understand how change/fixes make it into the distro?s. Perhaps this is not the correct place to ask this, but I figure that you would know.

You'd have to check with your distro vendor. Most would have you file
a bugzilla or launchpad or something like that.

> Thanks,
> Dave
