From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 27 Jun 2018 13:01:38 -0600
Subject: [PATCH 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180627191241.GE9361@localhost.localdomain>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180622195914.18575-2-scott.bauer@intel.com>
 <20180627191241.GE9361@localhost.localdomain>
Message-ID: <20180627190137.GA9697@sbauer-Z170X-UD5>

On Wed, Jun 27, 2018@01:12:42PM -0600, Keith Busch wrote:
> How about changing the reaction based on success?

I don't think this will work. The other scenario is the original admin command
was fine. We enter nvme_update_formats, grab the semaphore as write, issue the
nvme admin identify, that fails, we enter timeout, and attempt to down_read in
diasble_dev -> stop queues and get stuck there.

We need a way where we are not holding a down_write on the semaphore while issuing
I/O.
