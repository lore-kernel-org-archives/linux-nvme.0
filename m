From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 24 Apr 2017 22:04:02 -0600
Subject: [PATCH 0/3] nvme: APST improvements (for 4.12, perhaps)
In-Reply-To: <cover.1492816561.git.luto@kernel.org>
References: <cover.1492816561.git.luto@kernel.org>
Message-ID: <20170425040400.GB23572@kernel.dk>

On Fri, Apr 21 2017, Andy Lutomirski wrote:
> Hi all-
> 
> These are APST improvements for 4.12 or so.  The first one fixes a
> buggy comment.  The second makes debugging easier.  The third makes
> it possible to force APST on despite quirks.
> 
> Andy Lutomirski (3):
>   nvme: Fix APST comment
>   nvme: Display raw APST configuration via DYNAMIC_DEBUG
>   nvme: Add nvme_core.force_apst to ignore the NO_APST quirk
> 
>  drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)

I have added these for 4.12, thanks Andy.

-- 
Jens Axboe
