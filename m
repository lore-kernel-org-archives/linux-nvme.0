From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 4 May 2018 09:34:53 +0200
Subject: [PATCH blktests 3/3] nvme: add test for resetting the loopback
 controller
In-Reply-To: <CAK0tqikbAzX79tPuoTmB-n=3+8=9ExN43k1jTsqY0E-47TN2UA@mail.gmail.com>
References: <20180503150054.14022-1-jthumshirn@suse.de>
 <20180503150054.14022-3-jthumshirn@suse.de>
 <CAK0tqikbAzX79tPuoTmB-n=3+8=9ExN43k1jTsqY0E-47TN2UA@mail.gmail.com>
Message-ID: <20180504073453.ebpnkpvkydmbkso6@linux-x5ow.site>

On Thu, May 03, 2018@12:03:15PM -0700, chaitany kulkarni wrote:
> Hi Johannes,
> 
> Thanks for submitting the test.
> 
> I was wondering if we can move the generic setup and clean up
> functionality to the helpers for reference:-
> 
> +pre()
> +{
> +      # Clean up all stale modules
> +       modprobe -r nvme-loop
> +       modprobe -r nvme-core
> +       modprobe -r nvmet
> +
> }
> 
> +post()
> +{
> +       modprobe -r nvme-loop
> +       modprobe -r nvme-core
> +       modprobe -r nvmet
> +
> +}

I was thinking of the same as well but then I'd rather love "generic"
pre()/post() callbacks which the framework calles and not the actual
test case (just like requires() et al).

You can't really make the content's of pre()/post() generically enough
for all tests of a category unfortunately so I think placing them into
common/ won't work (i.e. for the next test I have in the pipeline I
need nvme-fcloop not nvme-loop, and so on).

Let me think a bit more about it.

    Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
