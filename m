From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 30 Oct 2017 08:23:34 -0600
Subject: [PATCH urgent-4.14] nvme: Fix setting logical block format when
 revalidating
In-Reply-To: <20171027195122.1810-1-keith.busch@intel.com>
References: <20171027195122.1810-1-keith.busch@intel.com>
Message-ID: <fb7b1486-ab1c-05f8-3c3b-7dbaef6d75c3@kernel.dk>

On 10/27/2017 01:51 PM, Keith Busch wrote:
> Revalidating the disk needs to set the logical block format and capacity,
> otherwise it can't figure out if the users modified anything about
> the namespace.

Applied, thanks Keith.

-- 
Jens Axboe
