From: israelr@mellanox.com (Israel Rukshin)
Date: Sun, 8 Apr 2018 17:07:49 +0300
Subject: [PATCH 1/2] nvme-rdma: Fix race between queue timeout and error
 recovery
In-Reply-To: <58e5c294-a716-26bf-9099-c9e9d5cf204c@grimberg.me>
References: <1522595994-21092-1-git-send-email-israelr@mellanox.com>
 <20180405085527.GD2286@lst.de>
 <58e5c294-a716-26bf-9099-c9e9d5cf204c@grimberg.me>
Message-ID: <343bdf4f-a1b2-9b59-4652-ce917da2b4dd@mellanox.com>

On 4/8/2018 2:04 PM, Sagi Grimberg wrote:
>
>> Please send an introduction cover letter explaining what issue you've
>> triggered and your overall design.
>
> The commit log is actually wrong... We don't complete the request in two
> places, the issue is that we need to make sure to unmap user buffer

We have two bugs here that those paths fix.
What you said is one of them.
The second one is what I said here.
I will show the call traces I have got in my V2.

> before completing the request in case of a timeout. I sent this patch
> to a bug report on the list and this is what it is designed to do.
>
> Given that we already simply schedule error recovery, we will fail it
> there, after we drain the queue pair, so the choice is to reset the
> timer for it in the timeout callout.
>
> We could alternatively invalidate the rkey in the timeout callout, but
> that won't work with the unsafe rkey mode.
