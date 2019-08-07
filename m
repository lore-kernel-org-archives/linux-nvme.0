From: jeff.johnson@aeoncomputing.com (Jeff Johnson)
Date: Wed, 7 Aug 2019 14:54:13 -0700
Subject: inverting order of NVMe pci enable/disable device during
 boot/shutdown? Failing release.
In-Reply-To: <CAFCYAsd6ra346vBuNfd8fGcL_5ntRTNneXa3_TTk_YoAUy0ZFw@mail.gmail.com>
References: <CAFCYAsfsCH+swCmpubto9od6dmJFsw0i+VDri9U+GVyZkOqcWg@mail.gmail.com>
 <20190807213039.GA26026@localhost.localdomain>
 <CAFCYAsd6ra346vBuNfd8fGcL_5ntRTNneXa3_TTk_YoAUy0ZFw@mail.gmail.com>
Message-ID: <CAFCYAseCyHqpn-6NEhbu3EpyGfs-eMmsmkdKhg9QCiNP_tuE-w@mail.gmail.com>

On Wed, Aug 7, 2019 at 2:36 PM Jeff Johnson
<jeff.johnson@aeoncomputing.com> wrote:
>
> On Wed, Aug 7, 2019@2:33 PM Keith Busch <kbusch@kernel.org> wrote:
> > Do you require all 24 slots be populated to observe the failure, or can
> > you repro with fewer?
>
> I have not tried with partially depopulating the JBOD but I'll attempt
> it now and report back. It always occurs on the final one or two
> endpoint devices (SSDs) to disable/release during the shutdown
> process.

Depopulated chassis down to 18 NVMe SSDs from 24. All 18 were
functional with good status, negotiated speed and width. All SSDs
visible to kernel.

After shutdown `sync ; poweroff` the next to last drive in the
shutdown disable/release order was left in a polling state
(G1/0width).

Host: Intel Xeon (Sky Lake SP), UEFI, VMD enabled, CentOS 7.6,
3.10.0-957.21.3.el7 (with DPC enabled)
