From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 10 Jul 2019 00:47:43 +0900
Subject: [PATCH] nvmet: print a hint while rejecting NSID 0 or 0xffffffff
In-Reply-To: <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
References: <c3a8458b54fcd189f7a441eb959274937faf8568.1562586068.git.mskorzhinskiy@solarflare.com>
 <8bfa9035-ad7c-bdd2-a480-b8d26c597767@acm.org>
Message-ID: <20190709154743.GA16207@minwoo-desktop>

On 19-07-08 08:09:38, Bart Van Assche wrote:
> If Linux users want to figure out which code reported an error message they
> sometimes run grep over the Linux kernel source code. Seeing the above
> message makes me wonder whether enough context information is provided to
> allow users to figure out unambiguously which code reported the error
> message? Have you considered to include the function name in the error
> message?

Bart,

I can see some pr_err() with __func__ being printed out in other drivers,
but I just wonder if error messages with the function name itself have
been a tradition for the linux kernel project.

Is there somewhere to find out these kind of standard or something?  Or
If you don't mind, can I ask your advices based on your experience on
kernel?

Thanks,
