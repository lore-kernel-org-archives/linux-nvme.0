From: luto@kernel.org (Andy Lutomirski)
Date: Mon, 26 Jun 2017 11:05:32 -0700
Subject: [PATCH v2] nvme: explicitly disable APST on quirked devices
In-Reply-To: <20170626070129.14744-1-kai.heng.feng@canonical.com>
References: <20170626070129.14744-1-kai.heng.feng@canonical.com>
Message-ID: <CALCETrVRNR4RLS53pqvXfGYZwc7QMNvdO46JVn6fCeeRAUvJuA@mail.gmail.com>

On Mon, Jun 26, 2017 at 12:01 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> A user reports APST is enabled, even when the NVMe is quirked or with
> option "default_ps_max_latency_us=0".
>
> The current logic will not set APST if the device is quirked. But the
> NVMe in question will enable APST automatically.
>
> Separate the logic "apst is supported" and "to enable apst", so we can
> use the latter one to explicitly disable APST at initialiaztion.

Reviewed-by: Andy Lutomirski <luto at kernel.org>

That being said, I smell a giant WTF here.  The affected hardware
seems to have APST on by default, and APST is buggy so the disk stops
working when APST is on.  So here's the $1M question: how does the
system *boot*?  After all, it's running for a while before the kernel
gets around to turning off APST, and I really doubt that BIOS does
this.

Here's a wild theory: what if the problem on all these disks is
actually our CSTS polling?  Could it be that some of the disks
implement CSTS reads in firmware and malfunction if CSTS is read while
in PS4?  This would be a blatant spec violation, but that's never
stopped anyone before...

--Andy
