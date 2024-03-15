Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68076C54E58
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Mar 2024 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MRVQlCXViPyrX4Q0CMrvYnoBhqqbGH6iOcEOvhPSl38=; b=KVxfwe+A0lIqyPlnMvvObQf4zS
	WctdJZyPgLvplgSjr9dM8wsp2K8QPf9bIbzJWgxVYEntkJDchKjWsgneolZMnOdXKJB1EKlOvJXCB
	5d6mZX+ogz9htBGLP4tKrj2AQE5rxQWOUNj0Rwr5+hqjH7xyb7cui6fS5qvef2EUMV6BcLy/S84xC
	I+FnQosuYRqR2QPyV9N++cxzxGWQrDGXcAm45byuT2sb4AfpsszzbBCq+oV4pDdtYOyCX+hXeKRsf
	LSyB1mb7zEkSviAip0233CjNCLZvgPSpMnUIzKSN6r4afsspEd80wWT9Z55UE0tdeZ+SGsTq0nJOd
	QlTEs6GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl8fH-00000000Vvc-2aNQ;
	Fri, 15 Mar 2024 14:36:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl8fE-00000000Vrj-3B7w
	for linux-nvme@lists.infradead.org;
	Fri, 15 Mar 2024 14:36:06 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FE6lJL014114;
	Fri, 15 Mar 2024 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : content-type :
 content-transfer-encoding; s=pp1;
 bh=MRVQlCXViPyrX4Q0CMrvYnoBhqqbGH6iOcEOvhPSl38=;
 b=Kr0EeGjwnBfuMSWNK9FdJQxNtnekY/4/jjZBO/Cf79CLM7LboOxybggDc82v34jwvUXZ
 WqGJR1ryVFOs2+lHaOHnv5yuNBiScsJ2wu7corjc+sJAHUjJZHRkTDdAvBZd7idCA5e6
 EMVCh0IRQFNYjeNWnU1D0CBjVGPHcqiZaqpS4FA/vOSnkNIsXRF9iN4HKUGVLXeK06r0
 o4z+LCTLYawdklro53STw9GaqipsgL4NqjLaMr04Ntdi2zyksyEjRXgwSD183JLlopZg
 iJy08K14CJRtxxMRIntiiEcj3EHIK3InDXs74BArfW5FYRrO8u4IGdRel97wNRK4xJnh BA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvqnargmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:35:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FCvZLt018134;
	Fri, 15 Mar 2024 14:31:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tvjdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:31:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FEVbvA11338358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:31:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63FF058054;
	Fri, 15 Mar 2024 14:31:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44B8058062;
	Fri, 15 Mar 2024 14:31:35 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 14:31:34 +0000 (GMT)
Message-ID: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
Date: Fri, 15 Mar 2024 20:01:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: [Bug Report] nvme-cli fails re-formatting NVMe namespace
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IvRHsfAaputHNMRkgiJf2wN2ihAG3Z8b
X-Proofpoint-ORIG-GUID: IvRHsfAaputHNMRkgiJf2wN2ihAG3Z8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_01,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403150116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_073604_946819_F2778FAF 
X-CRM114-Status: GOOD (  26.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

We found that "nvme format ..." command fails to format nvme disk with block-size set to 512.

Notes and observations:
====================== 
This is observed on the latest linus kernel tree. This was working well on kernel v6.8.

Test details:
=============
At system boot or when nvme is hot plugin, the nvme block size is 4096 and later if we try format
it with the block-size of 512 (lbaf=2) then it fails. Interestingly, if we start with the nvme block
size of 512 and later if we try format it with block-size of 4096 (lbaf=0) then it doesn't fail. 
Please note that CONFIG_NVME_MULTIPATH is enabled.
 
Please find below further details:

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# nvme list 
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            S6EUNA0R500358       1.6TB NVMe Gen4 U.2 SSD                  0x1          1.60  TB /   1.60  TB    512   B +  0 B   REV.SN49

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0

<snip>
<snip>

nlbaf   : 4
flbas   : 0
  [6:5] : 0	Most significant 2 bits of Current LBA Format Selected
  [4:4] : 0	Metadata Transferred in Separate Contiguous Buffer
  [3:0] : 0	Least significant 4 bits of Current LBA Format Selected
  
<snip>
<snip>  

LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best (in use)
LBA Format  1 : Metadata Size: 8   bytes - Data Size: 4096 bytes - Relative Performance: 0x2 Good 
LBA Format  2 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x1 Better 
LBA Format  3 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0x3 Degraded 
LBA Format  4 : Metadata Size: 64  bytes - Data Size: 4096 bytes - Relative Performance: 0x3 Degraded 

# lsblk -t /dev/nvme0n1 
NAME    ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
nvme0n1         0   4096      0    4096    4096    0               128    0B
                                   ^^^     ^^^ 	

!!!! FAILING TO FORMAT with 512 bytes of block size !!!!

# nvme format /dev/nvme0n1 --lbaf=2 --pil=0 --ms=0 --pi=0 -f 
Success formatting namespace:1
failed to set block size to 512
^^^

# lsblk -t /dev/nvme0n1 
NAME    ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
nvme0n1         0   4096      0    4096    4096    0               128    0B
                                   ^^^     ^^^
# cat /sys/block/nvme0n1/queue/logical_block_size:4096
# cat /sys/block/nvme0n1/queue/physical_block_size:4096

# cat /sys/block/nvme0c0n1/queue/logical_block_size:512
# cat /sys/block/nvme0c0n1/queue/physical_block_size:512


# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0
<snip>
<snip>
nlbaf   : 4
flbas   : 0x2
  [6:5] : 0	Most significant 2 bits of Current LBA Format Selected
  [4:4] : 0	Metadata Transferred in Separate Contiguous Buffer
  [3:0] : 0x2	Least significant 4 bits of Current LBA Format Selected
<snip>
<snip>

LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best 
LBA Format  1 : Metadata Size: 8   bytes - Data Size: 4096 bytes - Relative Performance: 0x2 Good 
LBA Format  2 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x1 Better (in use)
LBA Format  3 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0x3 Degraded 
LBA Format  4 : Metadata Size: 64  bytes - Data Size: 4096 bytes - Relative Performance: 0x3 Degraded 


Note : We could see above that the NVMe is indeed formatted with lbaf 2(block size 512). However,
the block queue limits are not correctly updated.

Git bisect:
==========
Git bisect reveals the following commit as bad commit:

8f03cfa117e06bd2d3ba7ed8bba70a3dda310cae is the first bad commit
commit 8f03cfa117e06bd2d3ba7ed8bba70a3dda310cae
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 4 07:04:51 2024 -0700

    nvme: don't use nvme_update_disk_info for the multipath disk
    
    Currently nvme_update_ns_info_block calls nvme_update_disk_info both for
    the namespace attached disk, and the multipath one (if it exists).  This
    is very different from how other stacking drivers work, and leads to
    a lot of complexity.
    
    Switch to setting the disk capacity and initializing the integrity
    profile, and let blk_stack_limits which already is called just below
    deal with updating the other limits.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Keith Busch <kbusch@kernel.org>

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


The above commit is part of the new atomic queue limit updates patch series. For 
NVMe device if multipath config is enabled then we rely on blk_stack_limits to 
update the queue limits for the stacked device. For updating the logical/physical
queue limit of the top (nvme%dn%d) device, the blk_stack_limits() uses the max of 
top and bottom limit:

	t->logical_block_size = max(t->logical_block_size,
				    b->logical_block_size);

	t->physical_block_size = max(t->physical_block_size,
				     b->physical_block_size);

When we try formatting the nvme disk with block-size of 512, the value of 
t->logical_block_size would be 4096 (as this is the initial block-size) however the
value of b->logical_block_size would be 512 (the block size of the bottom device is first 
updated in nvme_update_ns_info_block()).

I think we may want to update the queue limits of both top and bottom devices in the
nvme_update_ns_info_block(). Or if there's some other way?

Let me know if you need any further information.

Thanks,
--Nilay







