From: sbates@raithlin.com (Stephen  Bates)
Date: Fri, 7 Apr 2017 12:11:06 +0000
Subject: [PATCH v2 2/2] blk-mq: Add a polling specific stats function
In-Reply-To: <370c8854-1735-b0e7-089f-4b04068ca4f1@kernel.dk>
References: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
 <1491413957-30885-3-git-send-email-sbates@raithlin.com>
 <370c8854-1735-b0e7-089f-4b04068ca4f1@kernel.dk>
Message-ID: <2AD7D1E1-3906-4ABA-A301-E15DABAF443C@raithlin.com>

On 2017-04-05, 7:14 PM, "Jens Axboe" <axboe@kernel.dk> wrote:

> Why not just have 8 buckets, and make it:
>
>	bucket = ddir + ilog2(bytes) - 9;
>
> and cap it at MAX_BUCKET (8) and put all those above into the top
> bucket.

Thanks. However, that equation does not differentiate between direction and size. Instead we can use

bucket = ddir + 2*(ilog2(bytes) - 9);

and then bin any IO over 64K in the largest of the two buckets based on direction. I?ll implement this in a v3?.

Cheers

Stephen
