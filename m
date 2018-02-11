From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 10:48:42 +0200
Subject: [PATCH 0/2] nvme-fc: io termination cleanup
In-Reply-To: <20180206144830.968-1-jsmart2021@gmail.com>
References: <20180206144830.968-1-jsmart2021@gmail.com>
Message-ID: <a09e98ff-04d4-1cd9-3c6d-2a7c32e9f1b6@grimberg.me>


> The patches address io termination issues in nvme-fc:
> 
> The first patch addresses a race condition on io termination vs
> reset/delete abort paths that allowed an io to complete yet the
> association termination counted it and is waiting for the completion.
> 
> The second patch addresses cleanup of the code that was synchronizing
> io termination between the lldd done path and the blk-mq completion
> path. the completion path existed because, at the time, the eh_handler
> could return a successful return status, allowing the complete routine
> to be called, although the io was still active in the lldd. Since then
> the eh_handler has been corrected to reschedule the io timer after
> initiating the abort and this condition is no longer true.

Hi James,

Picked up for 4.16-rc, had a slight conflict due to Max's ctrl state
change. Please verify its ok.
