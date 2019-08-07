From: jeff.johnson@aeoncomputing.com (Jeff Johnson)
Date: Wed, 7 Aug 2019 14:36:48 -0700
Subject: inverting order of NVMe pci enable/disable device during
 boot/shutdown? Failing release.
In-Reply-To: <20190807213039.GA26026@localhost.localdomain>
References: <CAFCYAsfsCH+swCmpubto9od6dmJFsw0i+VDri9U+GVyZkOqcWg@mail.gmail.com>
 <20190807213039.GA26026@localhost.localdomain>
Message-ID: <CAFCYAsd6ra346vBuNfd8fGcL_5ntRTNneXa3_TTk_YoAUy0ZFw@mail.gmail.com>

On Wed, Aug 7, 2019@2:33 PM Keith Busch <kbusch@kernel.org> wrote:
> Do you require all 24 slots be populated to observe the failure, or can
> you repro with fewer?

I have not tried with partially depopulating the JBOD but I'll attempt
it now and report back. It always occurs on the final one or two
endpoint devices (SSDs) to disable/release during the shutdown
process.

--Jeff
