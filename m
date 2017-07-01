From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Sat, 01 Jul 2017 17:31:17 -0400
Subject: [PATCH] nvme: Quirks for PM1725 controllers
In-Reply-To: <20170628022757.32309-1-martin.petersen@oracle.com> (Martin
 K. Petersen's message of "Tue, 27 Jun 2017 22:27:57 -0400")
References: <20170628022757.32309-1-martin.petersen@oracle.com>
Message-ID: <yq17ezrvo7u.fsf@oracle.com>


> PM1725 controllers have a couple of quirks that need to be handled in
> the driver:
>
>  - I/O queue depth must be limited to 64 entries on controllers that do
>    not report MQES.
>
>  - The host interface registers go offline briefly while resetting the
>    chip. Thus a delay is needed before checking whether the controller
>    is ready.
>
> Note that the admin queue depth is also limited to 64 on older versions
> of this board. Since our NVME_AQ_DEPTH is now 32 that is no longer an
> issue.

Discussed this with Keith privately and he prefers the current
non-quirks approach to limiting the queue depth.

Thus no changes needed, please review/apply.

-- 
Martin K. Petersen	Oracle Linux Engineering
