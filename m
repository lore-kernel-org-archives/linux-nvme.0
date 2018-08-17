From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 17 Aug 2018 15:58:59 -0600
Subject: [PATCH 0/6] nvme-cli fixes and ANA updates
In-Reply-To: <20180817072908.56784-1-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
Message-ID: <20180817215859.GC9931@localhost.localdomain>

On Fri, Aug 17, 2018@09:29:02AM +0200, Hannes Reinecke wrote:
> Hi Keith,
> 
> here's a small set of fixes and an update to have nvme list-subsys printing
> out the ANA state for all paths.
> This brings nvme-cli output on par with that from multipath-tools.
> 
> As usual, comments and reviews welcome.

These all look fine to me. I'll apply 1-3 immediately as those look
pretty trivial. I'll give a test on 4-6 early next week when I should
have more time for nvme again.
