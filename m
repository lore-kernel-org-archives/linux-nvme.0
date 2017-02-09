From: wzhang@fb.com (Wei Zhang)
Date: Thu, 9 Feb 2017 23:46:03 +0000
Subject: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <B0BD08E8-442E-4FBF-AF52-7AC0A7CA092C@fb.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <B0BD08E8-442E-4FBF-AF52-7AC0A7CA092C@fb.com>
Message-ID: <D01CA43B-A973-4407-AFE1-4729F8F8C13F@fb.com>

Corrections to the email below.  It should be

    Tested-by: Krishna Dhulipala krishnad at fb.com
    Reviewed-by: Wei Zhang wzhang at fb.com  

Thanks,
-Wei

--
wei zhang | software engineer | facebook
wzhang at fb.com | (408) 460-4803

On 2/9/17, 3:16 PM, "Wei Zhang" <wzhang@fb.com> wrote:

    Hi,
    
    The switchtec driver patches [PATCH v2 (0-4)/4] in conjunction with the switchtec userland tool is used to communicate with the Microsemi 8536 PCIe Switch used on Facebook?s Lightning platform. The following essential driver and tool functions were successfully tested with it:
    ?         Retrieval of firmware and configuration information along with CRCs
    ?         Switch firmware and configuration upgrades
    ?         Switch PHY/Link error counter collection and the ability to reset them
    ?         Switch upstream and downstream ports? link status reporting
    ?         Switch interface functioning
    ?         Retrieval of switch ASIC temperature
    ?         Exporting switch firmware log dump
    ?         Read the information of firmware and configuration binaries
    ?         Extract the firmware and configuration images stored in the switch EEPROM
    
    Tested-by: Krishna Dhulipala krishnad at fb.com
    Reviewed-by: Wei Zhang wzhang at fb.com  
    
    Thanks,
    -Wei
    
    --
    wei zhang | software engineer | facebook
    wzhang at fb.com | (408) 460-4803
    
    On 2/2/17, 10:05 AM, "Logan Gunthorpe" <logang@deltatee.com> wrote:
    
        Changes since v1:
        
        * Rebased onto 4.10-rc6 (cleanly)
        * Split the patch into a few more easily digestible patches (as
          suggested by Greg Kroah-Hartman)
        * Folded switchtec.c into switchtec.h (per Greg)
        * Fixed a bunch of 32bit build warnings caught by the kbuild test robot
        * Fixed some issues in the documentation so it has a proper
          reStructredText format (as noted by Jonathan Corbet)
        * Fixed padding and sizes in the IOCTL structures as noticed by Emil
          Velikov and used pahole to verify their consistency across 32 and 64
          bit builds
        * Reworked one of the IOCTL interfaces to be more future proof (per
          Emil).
        
        Changes since RFC:
        
        * Fixed incorrect use of the drive model as pointed out by Greg
          Kroah-Hartman
        * Used devm functions as suggested by Keith Busch
        * Added a handful of sysfs attributes to the switchtec class
        * Added a handful of IOCTLs to the switchtec device
        * A number of miscellaneous bug fixes
        
        --
        
        Hi,
        
        This is a continuation of the RFC we posted lasted month [1] which
        proposes a management driver for Microsemi's Switchtec line of PCI
        switches. This hardware is still looking to be used in the Open
        Compute Platform
        
        To make this entirely clear: the Switchtec products are compliant
        with the PCI specifications and are supported today with the standard
        in-kernel driver. However, these devices also expose a management endpoint
        on a separate PCI function address which can be used to perform some
        advanced operations. This is a driver for that function. See the patch
        for more information.
        
        Since the RFC, we've made the changes requested by Greg Kroah-Hartman
        and Keith Busch, and we've also fleshed out a number of features. We've
        added a couple of IOCTLs and sysfs attributes which are documented in
        the patch. Significant work has also been done on the userspace tool
        which is available under a GPL license at [2]. We've also had testing
        done by some of the interested parties.
        
        We hope to see this work included in either 4.11 or 4.12 assuming a
        smooth review process.
        
        The patch is based off of the v4.10-rc6 release.
        
        Thanks for your review,
        
        Logan
        
        [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_lists_linux-2Dpci_msg56897.html&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=LRFoLl92zWj5mkgkc_hRcg&m=VLDBJqzotzGkTj8-xjlfT-J0k2uFq6FcWg2nA_oKYJo&s=OkigHoSqH1Z3dnmLqN76lIQ_WxRJDj1uqIDl35SI58A&e= 
        [2] https://github.com/sbates130272/switchtec-user
        
        --
        
        Logan Gunthorpe (4):
          MicroSemi Switchtec management interface driver
          switchtec: Add user interface documentation
          switchtec: Add sysfs attributes to the Switchtec driver
          switchtec: Add IOCTLs to the Switchtec driver
        
         Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
         Documentation/ioctl/ioctl-number.txt            |    1 +
         Documentation/switchtec.txt                     |   80 ++
         MAINTAINERS                                     |   11 +
         drivers/pci/Kconfig                             |    1 +
         drivers/pci/Makefile                            |    1 +
         drivers/pci/switch/Kconfig                      |   13 +
         drivers/pci/switch/Makefile                     |    1 +
         drivers/pci/switch/switchtec.c                  | 1608 +++++++++++++++++++++++
         include/uapi/linux/switchtec_ioctl.h            |  132 ++
         10 files changed, 1944 insertions(+)
         create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
         create mode 100644 Documentation/switchtec.txt
         create mode 100644 drivers/pci/switch/Kconfig
         create mode 100644 drivers/pci/switch/Makefile
         create mode 100644 drivers/pci/switch/switchtec.c
         create mode 100644 include/uapi/linux/switchtec_ioctl.h
        
        --
        2.1.4
        
    
    
