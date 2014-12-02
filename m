From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Dec 2014 19:32:56 +0000 (UTC)
Subject: [PATCH v2] nvme-user: Minor enhancement and fixes
In-Reply-To: <547E0E91.60706@hp.com>
References: <1417182636-2990-1-git-send-email-s.chawdhary@samsung.com>
 <alpine.LNX.2.00.1412011529540.4225@localhost.lm.intel.com>
 <547E0E91.60706@hp.com>
Message-ID: <alpine.LNX.2.00.1412021926410.4225@localhost.lm.intel.com>

On Tue, 2 Dec 2014, Linda Knippers wrote:
> On 12/01/2014 10:45 AM, Keith Busch wrote:
>> On Fri, 28 Nov 2014, Swati C wrote:
>>> Addressing comments from -
>>> [PATCH] nvme-user: Minor enhancement and fixes
>>> (http://lists.infradead.org/pipermail/linux-nvme/2014-November/001214.html)
>>>
>>>
>>> Minor enhancements to nvme_format_ns.c
>>>     - Make Metadata Settings a user settable value.
>>>     - Support for Secure Erase Settings.
>>>
>>> Signed-off-by: Swati C <s.chawdhary at samsung.com>
>>
>> Thanks, applied.
>>
>> On a side note, some people asked if I could take the example programs
>> here and turn it into something more useful with just one program to
>> run all nvme instead of a bunch of stand-alone programs. I took a stab
>> at it:
>>
>> http://git.infradead.org/users/kbusch/linux-nvme-cli.git
>>
>> It's still a work in progress, but just linking here in case others
>> have ideas or find it useful too.
>
> Thanks, I think something like this will be very helpful.
>
> I noticed that FreeBSD already has an nvmecontrol command.
> https://www.freebsd.org/cgi/man.cgi?query=nvmecontrol&sektion=8&apropos=0&manpath=FreeBSD+10.1-RELEASE
>
> I haven't tried it or looked to see what the functional differences
> are between nvmecontrol and your nvme, if any.  Have you?

Thanks for the link! I had no idea that existed, though it looks like mine
implements more of the command set. I'll ask Jim if he's still working
on that. I'd like to see more unified NVMe tooling, so collaboration
is better.

> Thanks,
>
> -- ljk
