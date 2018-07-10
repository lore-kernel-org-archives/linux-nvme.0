From: andrew.maier@eideticom.com (Andrew Maier)
Date: Tue, 10 Jul 2018 23:55:50 +0000
Subject: NVMe SGL Data Length Error
In-Reply-To: <20180710200805.GD11548@localhost.localdomain>
References: <MWHPR19MB11032909762BAF8174A26422935B0@MWHPR19MB1103.namprd19.prod.outlook.com>
 <20180710200805.GD11548@localhost.localdomain>
Message-ID: <MWHPR19MB11037AF1418BAB8AC67BC318935B0@MWHPR19MB1103.namprd19.prod.outlook.com>

Hey Keith,

Thanks for the commit. I hadn't been testing on 4.18-rc4 which it looks like has this commit as well.  

That does appear to fix the bug, however with large IOCTL commands I now get the "submit-io: Invalid argument" in place of the 2 segment transfer issue which I believe is expected.

Andrew

-----Original Message-----
From: Keith Busch <keith.busch@linux.intel.com> 
Sent: Tuesday, July 10, 2018 2:08 PM
To: Andrew Maier <andrew.maier at eideticom.com>
Cc: linux-nvme at lists.infradead.org; Stephen Bates <stephen at eideticom.com>
Subject: Re: NVMe SGL Data Length Error

On Tue, Jul 10, 2018@05:28:25PM +0000, Andrew Maier wrote:
> Hi all,
> 
> I've run into an issue with NVMe SGLs lately with our controller when given multiple SGL segments in a single command from the driver (i.e., more than 256 SGL entries in a single nvme read/write command); where there are not enough SGL Data Block descriptors for the transfer.  The first segment properly links to, in my case, a Last Segment Descriptor, however at the end of the second segment there are not enough Data Block descriptors for the full transfer (it is usually missing space for 4096 or 8192 bytes) which I've verified manually using a PCIe analyzer.  This forces our NVMe Controller to fail and return the SGL Data Length Invalid (0xF) status code.
> 
> Repro Steps:
> 1. Set the sgl_threshold to 4096
> 2. Run a 4MB nvme read transfer (i.e., nvme read <sgl_nvme_dev> -s 0 
> -c 8191 -z 4194304 -t) 3. Repeat step 2 until the memory is split into multiple SGL segments or try a larger transfer.
> 
> Does anyone know of a patch for this issue?

Probably not the fix you were hoping for, but the following commit will limit the number of SGL entries to 127 for PCI devices, so it'd always only have 1 segment descriptor.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=943e942e6266f22babee5efeb00f8f672fbff5bd
