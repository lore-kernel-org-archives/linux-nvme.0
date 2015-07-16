From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 16 Jul 2015 15:47:31 -0400
Subject: [PATCH 1/3] block: copy multi iovec user mappings if
 QUEUE_FLAG_SG_GAPS is set
In-Reply-To: <55A7E0B2.900@kernel.dk>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-2-git-send-email-sagig@mellanox.com>
 <alpine.LNX.2.00.1507161633270.15930@localhost.lm.intel.com>
 <55A7E0B2.900@kernel.dk>
Message-ID: <20150716194731.GN13681@linux.intel.com>

On Thu, Jul 16, 2015@10:49:54AM -0600, Jens Axboe wrote:
> SG_GAPS is a bit of a misnomer, but it's not easy to explain exactly what
> that logic is in a few short words! SG gaps was the closest I could come up
> with.

The sense is wrong -- surely it should be 'NOGAPS'?
