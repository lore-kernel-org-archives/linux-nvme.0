From: roland@kernel.org (Roland Dreier)
Date: Sun, 31 Jul 2016 08:33:16 -0700
Subject: [PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets
In-Reply-To: <33dfc646-1804-363e-4d83-1ba618303dbb@grimberg.me>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
 <1469950060-18098-2-git-send-email-roland@kernel.org>
 <4acdd466-b8f6-8208-7287-e97dfd45bbf1@grimberg.me>
 <33dfc646-1804-363e-4d83-1ba618303dbb@grimberg.me>
Message-ID: <CAL1RGDUHrvQWXxHgxsK78WWT+Mr1uB2LFAVGi8-bHf1n5vCJDA@mail.gmail.com>

On Sun, Jul 31, 2016@3:58 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> How did you test it btw?

I have a userspace target :).  Which is also how I caught the
uninitialized private data.

> Currently the target driver doesn't support ipv6 addresses.
>
> These complementary patches [1,2] makes the it work e2e!

That's cool!  Thanks.
