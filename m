Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35EC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ra8kajpAg5iez5n90ZH/pe3ipDq2+MZrEKZ6vBxE88c=; b=YZKJhvZfLdfR//O5ghyYXAYTnz
	FhOyCm0Gssw+4wnPEr4bmS0qd51adjaGsasaDlxrjrq57KN20CCvBtIHgUk57kRO1J+DxrGn7F/sD
	xX9d/TFiWSGNzpqiZP8w4/8Tw9hUn3NdPHnebQvMMtoqi8paXYE5ngS9mAxFKmDIVLBaw/S7fqU+l
	Z7Fh4Ck+2J0ajhQUqc9OcBQWTeS6oPrqD7zyGBuw6duv4jFwPHHoXd0g9TAC9K1pZHho2Va5NalRI
	khD2WvJmN10sfK+c4uMxMUyxO7Lr92P4RvbiDVt3W2hPgsVvyS1OnPvI6FXIRFZoZypLmZwNYe1II
	2vR7U+FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lez-0000000EttC-1Ick;
	Wed, 02 Sep 2026 14:09:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lew-0000000EtsD-0cGU
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:09:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CWBiT2312958;
	Wed, 2 Sep 2026 14:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ra8kaj
	pAg5iez5n90ZH/pe3ipDq2+MZrEKZ6vBxE88c=; b=h6D9byVqWVUjn+VZLZd+uy
	irEvr4wuTCpMEDoOhs4Lfb039H3GbboijHSv1NnW42OpiK0euddeli2XOcq+fQGl
	BoTpi2mgY5K32T7SYlT5dneevjBNsGtVy00Ej+91W8pgK5bpsaKCSA8g/LmT3bZf
	X4Dq4ScOY5UGXch9Qxox++2dX+HbAfl5H4sRaOZ19AiLBDmCDFG8pp8YIYsNRgfw
	ky04e/kPGfejFFETfBSR1HYOr0/5krbsiMuVwbxUKMTzHxVOP+SP3R5E4GaGRiR3
	k3UFRs1wUN2TV/k5WObWscLVpwsJtyfKrItNFtOVK7YyYQglJH+ZUw8GrT5dDQhA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rf1r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:09:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682DuFlI020829;
	Wed, 2 Sep 2026 14:09:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqjc5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:09:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682E9aoT1704486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:09:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258B75805D;
	Wed,  2 Sep 2026 14:09:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E8958058;
	Wed,  2 Sep 2026 14:09:33 +0000 (GMT)
Received: from [9.61.83.86] (unknown [9.61.83.86])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 14:09:33 +0000 (GMT)
Message-ID: <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
Date: Wed, 2 Sep 2026 19:39:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, john.g.garry@oracle.com, wenxiong@linux.ibm.com,
        gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260902133104.GA20945@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a982e23 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=O_PADi6Tx5M44VIUG9oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX1R2BCI6zL4P2
 EAKWDRDFoVXn8SC3eM+U5o/8weMZVmyBkD/VnHectGC6OnoTS3eO1sDUJnXs7/ELBRSGYZgc8+4
 isMtC285QowYfjQRDp/D+g4XfNUUAb2239Ja1fFlNd1lRlzBfJi4lbaeVIeA8yuKKGsXCkEMUyK
 sSsFMT1Uex0iVDDDlrPcTWDwoja9Y6ZipGI/T/vjkpbbK6/MiIi5qjgRr060zanCDxyZfSnGJlJ
 QrHWEFCtQSduVwJG3UL5zv4/U70sQUQQAI635bY2V3G7HnDJnUyw5Uc+vmZN4r2i1OIRAob43PY
 ZjjaoOOshlb9Y7Q2XTiBWUuXKYXfEKKzaP7Hfh2f1SIorvFKOdOgJ/a5U/vL7ZFz90r6RX5pket
 EddLhRxvnSHmiwGoAkmR2WAQOSc9LkSHm333NQPfJn3jUPNwwWFYLwyM1oSdtojgQPoCwXwu/MA
 NJginMTkySEUu82sMxg==
X-Proofpoint-GUID: QqZnMWiU6c1XortuIF1S_D0jNEqENXx1
X-Proofpoint-ORIG-GUID: QqZnMWiU6c1XortuIF1S_D0jNEqENXx1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX7U+vfMgIQSqc
 swVk9PM7+UsS9RHZiVNVPUkHqSThbbiGaJ3YWW9X9tgV3EHB1/ODGjC85Gu9nYxsa+TEy052a+2
 FXYeKRxnI6VZsXnMYN1QRmodXOp9UJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_070950_227153_8E32D8F4 
X-CRM114-Status: GOOD (  24.89  )
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

On 9/2/26 7:01 PM, Christoph Hellwig wrote:
> On Mon, Aug 31, 2026 at 08:49:54PM +0530, Nilay Shroff wrote:
>> When a user opens an NVMe multipath head node, we take a reference to
>> the head node, but this does not prevent the transport module backing
>> its paths from being unloaded. This can result in the multipath head
>> remaining open while its underlying transport module is unloaded.
> 
> Which makes sense.  Different paths can use different transports, but
> even when all paths go away, the head can stick around.
> 
>> Fix this by taking a reference to the transport module for each active
>> path when the multipath head node is opened. Keep track of the number
>> of active head node openers so that dynamically added paths acquire the
>> same number of transport module references.
> 
> I'm not sure this is correct.  Unloading the layer below should be
> just fine.
> 
> What practical problem do you want to solve with this?
> 

The problem we are trying to solve is that the multipath head node can
remain open and be used by a filesystem even though the transport module
backing its paths can be unloaded.

For example, we have a shared namespace exposed through two PCIe paths:

nvme-subsys0
     nvme0 -> nvme0n1
     nvme1 -> nvme0n1

The namespace is formatted with ext4 and mounted:

# mount -t ext4 /dev/nvme0n1 /mnt/disk

At this point, the multipath head has a reference to nvme_core, but the
nvme transport module itself has a refcount of zero:

# lsmod | grep nvme
nvme                  262144  0
nvme_core             458752  2
nvme_keyring          262144  1
nvme_auth             262144  1

Consequently, the transport module can be unloaded:

# rmmod nvme

After this, the filesystem remains mounted, but I/O starts failing:

     EXT4-fs (...): shut down requested (2)
     Aborting journal on device nvme0n1-8.
     block nvme0n1: no available path - failing I/O
     Buffer I/O error on dev nvme0n1, logical block ..., lost sync page write
     JBD2: I/O error when updating journal superblock for nvme0n1-8.

This becomes particularly problematic if the multipath NVMe device is
used as the root filesystem. Once the transport module is unloaded, I/O
fails and we can no longer run commands to reload the NVMe module. In
our testing, the only recovery option in that situation has been to
power-cycle the system.

So the practical problem is that an open multipath head can continue to
be used after its underlying transport module has been unloaded. The
proposed change keeps the transport module referenced while the head
node is open, preventing the module from being unloaded in this
scenario.

Thanks,
--Nilay


