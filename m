From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 25 Jun 2019 05:25:57 +0900
Subject: [PATCH nvme-cli 2/3] nvme-cli: Restore RHEL 7 compatibility
In-Reply-To: <20190624200521.28191-3-bvanassche@acm.org>
References: <20190624200521.28191-1-bvanassche@acm.org>
 <20190624200521.28191-3-bvanassche@acm.org>
Message-ID: <20190624202557.GF6526@minwooim-desktop>

On 19-06-24 13:05:20, Bart Van Assche wrote:
> With glibc version 2.24 and before the endianness conversion macros
> return a value with an incorrect type. Avoid that this causes the
> nvme-cli build to fail on e.g. RHEL 7. A side effect of this patch
> is that it allows sparse to verify the type of the endianness
> conversion functions.
> 
> See also https://sourceware.org/bugzilla/show_bug.cgi?id=16458
> 
> Cc: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Reported-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
> Fixes: e68409e447b2 ("Remove superfluous casts")
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>

Not only for REHL 7, Ubuntu 16.04 which is my VM has had same issue :)

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Also for the build:

Tested-by: Minwoo Im <minwoo.im.dev at gmail.com>
