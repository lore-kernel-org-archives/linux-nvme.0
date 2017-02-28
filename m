From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 28 Feb 2017 09:09:20 -0600
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <1488091997-12843-1-git-send-email-logang@deltatee.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
Message-ID: <20170228150920.GB12481@bhelgaas-glaptop.roam.corp.google.com>

Hi Logan,

On Sat, Feb 25, 2017@11:53:13PM -0700, Logan Gunthorpe wrote:
> ...
> This is a continuation of the RFC we posted lasted month [1] which
> proposes a management driver for Microsemi's Switchtec line of PCI
> switches. This hardware is still looking to be used in the Open
> Compute Platform
> 
> To make this entirely clear: the Switchtec products are compliant
> with the PCI specifications and are supported today with the standard
> in-kernel driver. However, these devices also expose a management endpoint
> on a separate PCI function address which can be used to perform some
> advanced operations. This is a driver for that function. See the patch
> for more information.
> 
> Since the RFC, we've made the changes requested by Greg Kroah-Hartman
> and Keith Busch, and we've also fleshed out a number of features. We've
> added a couple of IOCTLs and sysfs attributes which are documented in
> the patch. Significant work has also been done on the userspace tool
> which is available under a GPL license at [2]. We've also had testing
> done by some of the interested parties.
> 
> We hope to see this work included in either 4.11 or 4.12 assuming a
> smooth review process.
> 
> The patch is based off of the v4.10-rc6 release.
> 
> Thanks for your review,
> 
> Logan
> 
> [1] https://www.spinics.net/lists/linux-pci/msg56897.html
> [2] https://github.com/sbates130272/switchtec-user
> 
> Logan Gunthorpe (4):
>   MicroSemi Switchtec management interface driver
>   switchtec: Add user interface documentation
>   switchtec: Add sysfs attributes to the Switchtec driver
>   switchtec: Add IOCTLs to the Switchtec driver
> 
>  Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
>  Documentation/ioctl/ioctl-number.txt            |    1 +
>  Documentation/switchtec.txt                     |   80 ++
>  MAINTAINERS                                     |   11 +
>  drivers/pci/Kconfig                             |    1 +
>  drivers/pci/Makefile                            |    1 +
>  drivers/pci/switch/Kconfig                      |   13 +
>  drivers/pci/switch/Makefile                     |    1 +
>  drivers/pci/switch/switchtec.c                  | 1535 +++++++++++++++++++++++
>  include/uapi/linux/switchtec_ioctl.h            |  132 ++
>  10 files changed, 1871 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
>  create mode 100644 Documentation/switchtec.txt
>  create mode 100644 drivers/pci/switch/Kconfig
>  create mode 100644 drivers/pci/switch/Makefile
>  create mode 100644 drivers/pci/switch/switchtec.c
>  create mode 100644 include/uapi/linux/switchtec_ioctl.h

This driver doesn't have anything to do with the PCI core, other than
using the pci_register_driver() interface (just like all other drivers
for PCI-connected devices), so drivers/pci doesn't really feel like
the right place for it.  Putting it in drivers/pci leads to the sort
of confusion you mentioned above ("To make this entirely clear ...").

Would drivers/perf or drivers/misc/switchtec/ be possible places for
it?

Bjorn
