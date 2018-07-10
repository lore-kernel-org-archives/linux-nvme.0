From: andrew.maier@eideticom.com (Andrew Maier)
Date: Tue, 10 Jul 2018 17:28:25 +0000
Subject: NVMe SGL Data Length Error
Message-ID: <MWHPR19MB11032909762BAF8174A26422935B0@MWHPR19MB1103.namprd19.prod.outlook.com>

Hi all,

I've run into an issue with NVMe SGLs lately with our controller when given multiple SGL segments in a single command from the driver (i.e., more than 256 SGL entries in a single nvme read/write command); where there are not enough SGL Data Block descriptors for the transfer.  The first segment properly links to, in my case, a Last Segment Descriptor, however at the end of the second segment there are not enough Data Block descriptors for the full transfer (it is usually missing space for 4096 or 8192 bytes) which I've verified manually using a PCIe analyzer.  This forces our NVMe Controller to fail and return the SGL Data Length Invalid (0xF) status code.

Repro Steps:
1. Set the sgl_threshold to 4096
2. Run a 4MB nvme read transfer (i.e., nvme read <sgl_nvme_dev> -s 0 -c 8191 -z 4194304 -t)
3. Repeat step 2 until the memory is split into multiple SGL segments or try a larger transfer.

Does anyone know of a patch for this issue?

Cheers,
Andrew Maier
Software Engineer
Eideticom.com
