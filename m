From: david@craven.ch (David Craven)
Date: Sat, 1 Aug 2015 18:31:37 -0700
Subject: Linux-nvme Digest, Vol 41, Issue 1
In-Reply-To: <mailman.3.1438455602.9283.linux-nvme@lists.infradead.org>
References: <mailman.3.1438455602.9283.linux-nvme@lists.infradead.org>
Message-ID: <CAL1_imk1re5pRqMUzOW5Tv7W3s+rFFPX1ABVwZ8NYYqpaysOVw@mail.gmail.com>

I thought I'd share the reply I got from the puredarwin mailinglist.
If Linux is a requirement for any of you guy's I suggest dumping the
macbook, I don't see any other options.

hello david,

thanks for joining the puredarwin mailinglist,
but i think we dont have any positive message to you about the source
code for your storage controller
the problem is that apple doesnt want that there will be more drivers
for darwin in the future more and more
all will be only available on osx only.
But does puredarwin work on the latest macbook model i dont know we
dont have any source to the latest macbook
model you would be welcome to try our latest puredarwin image
https://puredarwin.googlecode.com/files/puredarwinxmas.tar.xz
and try it out on your macbook.
If i found out any more infos for your controller i will mail it to
you, but for now i dont have any more infos.

cheers
ferdinand


On Sat, Aug 1, 2015 at 12:00 PM,
<linux-nvme-request@lists.infradead.org> wrote:
> Send Linux-nvme mailing list submissions to
>         linux-nvme at lists.infradead.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         http://lists.infradead.org/mailman/listinfo/linux-nvme
> or, via email, send a message with subject or body 'help' to
>         linux-nvme-request at lists.infradead.org
>
> You can reach the person managing the list at
>         linux-nvme-owner at lists.infradead.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-nvme digest..."
>
>
> Today's Topics:
>
>    1. Re: [PATCH] NVMe: Add device id to vendor specific chunk size
>       (Christoph Hellwig)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 31 Jul 2015 20:26:57 -0700
> From: Christoph Hellwig <hch at infradead.org>
> To: Keith Busch <keith.busch at intel.com>
> Cc: linux-nvme at lists.infradead.org, Matthew Wilcox
>         <willy at linux.intel.com>
> Subject: Re: [PATCH] NVMe: Add device id to vendor specific chunk size
> Message-ID: <20150801032657.GA8488 at infradead.org>
> Content-Type: text/plain; charset=us-ascii
>
> On Fri, Jul 31, 2015@04:03:59PM -0600, Keith Busch wrote:
>> A controller with a new device id supports the same striping feature
>> currently used with DID 0953h, so appending the new device identifier
>> to the check that enables this feature.
>
> Eww.   Why do we need these workarounds for new hardware?  If this is
> something Intel want to be stuck with it should be pushed as something
> reported in IDENTIFY data.
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
> ------------------------------
>
> End of Linux-nvme Digest, Vol 41, Issue 1
> *****************************************
