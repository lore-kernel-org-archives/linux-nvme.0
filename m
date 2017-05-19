From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 18 May 2017 18:18:13 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <e3790097493247b5b483e0196ae2c973@ausx13mpc120.AMER.DELL.COM>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <CALCETrXLhbiGTmeMDFjYAAwMi2PSK38cy1Z8UEPKxOWJz55wyQ@mail.gmail.com>
 <e3790097493247b5b483e0196ae2c973@ausx13mpc120.AMER.DELL.COM>
Message-ID: <CALCETrXsMG45yBdzytgrLSimXnVUnC1ku0Tph+gxpM=_mY4wxA@mail.gmail.com>

On Mon, May 15, 2017@9:11 AM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto at kernel.org]
>> Sent: Saturday, May 13, 2017 7:28 AM
>> To: Andy Lutomirski <luto at kernel.org>
>> Cc: Jens Axboe <axboe at kernel.dk>; linux-kernel at vger.kernel.org; Kai-Heng Feng
>> <kai.heng.feng at canonical.com>; linux-nvme <linux-nvme at lists.infradead.org>;
>> Christoph Hellwig <hch at lst.de>; Sagi Grimberg <sagi at grimberg.me>; Keith Busch
>> <keith.busch at intel.com>; Limonciello, Mario <Mario_Limonciello at Dell.com>
>> Subject: Re: [PATCH] nvme: Change our APST table to be no more aggressive than
>> Intel RSTe
>>
>> On Thu, May 11, 2017@9:06 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> > It seems like RSTe is much more conservative with transition timing
>> > that we are.  According to Mario, RSTe programs APST to transition from
>> > active states to the first idle state after 60ms and, thereafter, to
>> > 1000 * the exit latency of the target state.
>>
>> Bad news, folks: this appears to be merely more stable, not all the way stable:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184/comments/65
>>
>> I maintain my hypothesis that no one ever validated these disks and
>> that the very conservative parameters set by RSTe merely make it rare
>> to trigger the bug.  But maybe something else is going on.
>
> This is really unfortunate to hear.  I think the conservative parameters set
> by Intel are still best though.
>
> I've been talking to folks about this.  There has been mentions to a possible
> signal integrity issue specifically on the quirked Dell systems and how it
> relates to this.  The current (working) theory is that when the drive is in PS4
> and is supposed to transition back that crosstalk causes problems with the
> link negotiation and thus fails.
> So there's two possible ways I see to approach solving this (from Linux side):
>
> 1) Keep quirking those systems from going into PS4.
> This isn't ideal as the jump to PS4 gets you the most power savings, but of course
> stable system > power savings
>
> 2) Quirk those systems to redo link negotiation a few times if it fails
> I don't know if this is actually possible.  Where is link negotiation invoked?

Hi Bjorn-

As I understand it, we have a situation where some NVMe drives are
occasionally (due to signal quality issues or whatever) failing
"recovery".  I think this means that the disk is in an internal
low-power state and the PCIe link is in some L1 state and, when the
host and/or drive tries to wake up, the PCIe link fails to return to
L0.  Maybe I'm misunderstanding.

Is there some way to program the link to try harder?  Any other ideas?
 Are there better people to ask?

--Andy

>
> If our partners come up with a way to solve this from drive firmware though
> I'll let this group know.
>
> Thanks,
