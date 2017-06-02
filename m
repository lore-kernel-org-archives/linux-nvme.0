From: sielicki@yandex.com (Nicholas Sielicki)
Date: Fri, 2 Jun 2017 02:23:15 -0500
Subject: [PATCH 2/2] nvme: Quirk APST on Intel 600P/P3100 devices
In-Reply-To: <CALCETrVa4xvAKyw=-dwRpOExwFrKuVdmMDixaCjaWV0HYtuO5A@mail.gmail.com>
Message-ID: <20170602072315.GA24551@doghouse.gt.sielicki.com>

On Wed, May 31 06:54:51 PDT 2017, Andy Lutomirski wrote:
>On Tue, May 30, 2017@8:35 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Wed, May 24, 2017@03:06:31PM -0700, Andy Lutomirski wrote:
>>> They have known firmware bugs.  A fix is apparently in the works --
>>> once fixed firmware is available, someone from Intel (Hi, Keith!)
>>> can adjust the quirk accordingly.
>>
>> Here's the latest firmware with all the known fixes:
>>
>>   https://downloadcenter.intel.com/download/26491?v=t
>>
>> I am not 100% sure if this fixes the issue you're quirking, but I
>> think it falls under the issues the link initialization and ASPM
>> comments in the release notes.
>
>Can you or someone at Intel supply a reliable way to distinguish a
>fixed firmware from an unfixed firmware?  We have access to the "fr"
>string, but I don't know what to do with it.

FWIW, on a system with a 600P on the old firmware (109C) running 4.11.3,
I went out to lunch and returned to find my system came down with a
message something like

> controller is down; will reset: CSTS=<???>, PCI_STATUS=0xffff

I updated to the new firmware (121C) and saw it again a few hours later
on the same 4.11.3 kernel. So I think it's prudent to quirk regardless
of firmware revision.
