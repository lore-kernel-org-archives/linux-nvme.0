From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Feb 2018 09:26:05 -0700
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <38ae419b-1c41-37e7-46a5-3156802f6744@grimberg.me>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
 <20180115084240.GA32313@lst.de>
 <20180208155943.GB4906@localhost.localdomain>
 <38ae419b-1c41-37e7-46a5-3156802f6744@grimberg.me>
Message-ID: <20180208162605.GB5039@localhost.localdomain>

On Thu, Feb 08, 2018@06:02:04PM +0200, Sagi Grimberg wrote:
> I'm fine with fixing this locally, btw isn't this exact same stale sqe
> happen in pci's nvme_delete_queue?

Yeah, this is the other case. Fortunately that never gets called on a
quiesced admin queue, so we should be 'ok', but moving the command from
the stack into struct nvme_queue would be the right thing to do.
