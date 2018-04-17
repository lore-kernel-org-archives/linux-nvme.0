From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 17 Apr 2018 16:52:55 -0400
Subject: Disable Native NVMe Multipath Support
In-Reply-To: <DE927C68B458BE418D582EC97927A9287FEB6848@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9287FEB6848@ORSMSX113.amr.corp.intel.com>
Message-ID: <20180417205255.GB29501@redhat.com>

On Mon, Apr 16 2018 at  4:52pm -0400,
Gruher, Joseph R <joseph.r.gruher@intel.com> wrote:

> Hi everyone-
> 
> I'm doing some testing with the native NVMe multipath support in an
> NVMeoF environment.  In Ubuntu with kernel 4.15.15 it seems to be
> enabled by default and "just works" without taking any steps to set it
> up.  If I connect the same namespace from my target to my initiator
> using two different network paths it results in a single namespace on
> the initiator.  Then I can fail either network path and still run IO
> to the namespace.
> 
> I'd like to now set up dm-multipath for comparison.  It looks like
> I'll need to disable the native NVMe multipath support to do this,
> otherwise I can't connect the same namespace via two paths and have it
> show up on the initiator as two separate namespaces for dm-multipath
> to use.  Is there an quick and easy way to do disable the native NVMe
> multipath support, or is rebuilding the kernel with
> CONFIG_NVME_MULTIPATH=N the only option?

Current upstream kernel needs to be rebuilt with CONFIG_NVME_MULTIPATH=N

AFAIK Keith Busch is working on a patch to fix crashes when multiple
namespaces are created with an nvme_core that is compiled for multipath
but disabled at module load, e.g.: modprobe nvme_core multipath=N (or
nvme_core.multipath=N on kernel commandline)

See:
http://lists.infradead.org/pipermail/linux-nvme/2018-April/016765.html

FYI, when testing DM multipath ontop of NVMe you should use
dm-multipath's table argument: queue_mode=bio
