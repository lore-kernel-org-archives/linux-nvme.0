From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Mon, 9 Feb 2015 16:59:46 +0000
Subject: linux-nvme user space tooling update
In-Reply-To: <alpine.LNX.2.00.1502091601360.15481@localhost.lm.intel.com>
References: <alpine.LNX.2.00.1502091601360.15481@localhost.lm.intel.com>
Message-ID: <36F6EBABA23FEF4391AF72944D2289019EA90447@BBYEXM01.pmc-sierra.internal>

Hi All

To echo Keith's point, if there is something you would like to see added please let us know. Note we are planning to move to a more friendly command line options interface. That will be quite a bit change so you might want to wait for that before working on patches.

Also beware right now, the regress script randomly writes to a target drive, that could lead to bad things happening ;-). We plan to update that script very soon to correct this and add a more completion set of regression tests...

Cheers

Stephen

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Monday, February 9, 2015 9:46 AM
To: linux-nvme at lists.infradead.org
Subject: linux-nvme user space tooling update

I've gotten really good feedback and contributions on the linux nvme command line interface I started up. Since it's getting some traction, I thought it best to further open this, so moved to a github project:

   https://github.com/linux-nvme/nvme-cli

Please feel free to join in if you're interested.

Anyone more familiar with writing command line utilities may spot some questionable tactics, like hard-coded install paths. It's a work in progress. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
