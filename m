From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Tue, 27 Jun 2017 12:24:08 +0800
Subject: [PATCH v2] nvme: explicitly disable APST on quirked devices
In-Reply-To: <CALCETrVRNR4RLS53pqvXfGYZwc7QMNvdO46JVn6fCeeRAUvJuA@mail.gmail.com>
References: <20170626070129.14744-1-kai.heng.feng@canonical.com>
 <CALCETrVRNR4RLS53pqvXfGYZwc7QMNvdO46JVn6fCeeRAUvJuA@mail.gmail.com>
Message-ID: <CAAd53p6k52fPGq1EnJzGwPamGSc+CgoaRvSdFR0GHu=JDD6Bpg@mail.gmail.com>

On Tue, Jun 27, 2017@2:05 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Jun 26, 2017 at 12:01 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> A user reports APST is enabled, even when the NVMe is quirked or with
>> option "default_ps_max_latency_us=0".
>>
>> The current logic will not set APST if the device is quirked. But the
>> NVMe in question will enable APST automatically.
>>
>> Separate the logic "apst is supported" and "to enable apst", so we can
>> use the latter one to explicitly disable APST at initialiaztion.
>
> Reviewed-by: Andy Lutomirski <luto at kernel.org>
>
> That being said, I smell a giant WTF here.  The affected hardware
> seems to have APST on by default, and APST is buggy so the disk stops
> working when APST is on.  So here's the $1M question: how does the
> system *boot*?  After all, it's running for a while before the kernel
> gets around to turning off APST, and I really doubt that BIOS does
> this.

>From my experience, systems never failed to boot on those faulty
NVMes. Probably because the constantly disk read required by boot
never let the NVMe transited to PS4. The problem always occurs after
some usage after boot.

Seems like the user has a tricky system. At first, APST wasn't
enabled. It's enabled after boot with a new kernel, and it's enabled
forever. Even if it's disabled explicitly, the APST is still enabled
by default on the system. The user didn't upgrade BIOS in the interim.

>
> Here's a wild theory: what if the problem on all these disks is
> actually our CSTS polling?  Could it be that some of the disks
> implement CSTS reads in firmware and malfunction if CSTS is read while
> in PS4?  This would be a blatant spec violation, but that's never
> stopped anyone before...
>
> --Andy
