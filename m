From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Feb 2018 09:16:57 -0700
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <38ae419b-1c41-37e7-46a5-3156802f6744@grimberg.me>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
 <20180115084240.GA32313@lst.de>
 <20180208155943.GB4906@localhost.localdomain>
 <38ae419b-1c41-37e7-46a5-3156802f6744@grimberg.me>
Message-ID: <20180208161657.GA5039@localhost.localdomain>

On Thu, Feb 08, 2018@06:02:04PM +0200, Sagi Grimberg wrote:
> > Allocating the full 64-byte NVMe command for each request seems a bit
> > excessive.
> 
> Why?

That's 64B per request that would rarely ever get used. If you've enough
drives with high queue counts, this can add up to quite a lot of memory.
