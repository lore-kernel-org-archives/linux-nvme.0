From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 8 Mar 2016 10:58:11 -0700
Subject: [PATCH 1/2] Block: Disable polling stats when iostats are disabled
In-Reply-To: <56DF0E21.4000907@dev.mellanox.co.il>
References: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>
 <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
 <56DF0E21.4000907@dev.mellanox.co.il>
Message-ID: <20160308175811.GA8867@localhost.localdomain>

> 
> I fail to see how replacing incrementation with a branch statement helps
> performance or even not making it worse...

It may have been coincidental in my setup - I had assumed the test on the local io_stat was cheaper than the cost of following hctx to then increment (or not) poll_invoked.
