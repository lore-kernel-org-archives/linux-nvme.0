Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE99D3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjKqDDxnDeleMY1oyM3fDMAYl44GJFBsP5Du7IzAyrI=; b=ARc8aQfK0xWzyxiwWR7VF9nboZ
	5L3whXYAilclLCn97hNVe3VnK6rQCXlvDYD2hfCaFDKcNfX5DKrIaF/a9jj1SWbCXmMFhU1nJ3zEE
	08EV2h7fYijBnjoO/IrGH1588UwAsydvBlHcUa0KS6Ru1kvWbNzbDbzGgzDaMLKKdp4ImAfA+2aiP
	4vF5pGRjqWPIKBibnDWsemx5uvUGstdGVQB3yoPZbBWl6KzI9+dj3qUdFVr6c+Xk+WHzDNJJcxDsG
	G4DUsXUez9dijSFSEtdG75lXZGPJw/hSrG0QKlTFWu2ASNYP4zGlB5Hzk5eCuzTvG5kFjF4a4yIRh
	YG49Q/Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSa5r-0000000D3GG-3QDc;
	Mon, 08 Dec 2025 12:11:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSa5l-0000000D3FS-42xG
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 12:11:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B88en3g001548;
	Mon, 8 Dec 2025 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pjKqDD
	xnDeleMY1oyM3fDMAYl44GJFBsP5Du7IzAyrI=; b=bbiAvoEj5H3Yy0/Hf4JBiy
	M9uEE4n+Dbs6JijNa6eq39Mjn99FYbZwG83aepBRE5TDsd3/jqrTj1zd6ylXuuvi
	aX1z+JrIW9vG/bV1fpIjSFtRTg82XNbth4NaDgEbXekNDLutxXUuiMu79vNEn+hc
	+/FHBdWx8FeGqU3I+wQLyetew2in6arqx3NiMB/RyrxxE4alk0SCGLYetQaK6TCG
	pQQl+mcbXtTusc/xkAJW+U6aYtE7orD1fzQSJfFnJR88obCxDwaLMVRcxiRB07bJ
	CDl630zr4hGryrgYniopRwISmBAQQSNabM6WrZRfyf9j6N7FExfIBqFNxDgTXKcQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7bqk42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 12:11:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8B18d2028102;
	Mon, 8 Dec 2025 12:11:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xnjw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 12:11:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8CBh4526477194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 12:11:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0705805D;
	Mon,  8 Dec 2025 12:11:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB3F5805A;
	Mon,  8 Dec 2025 12:11:39 +0000 (GMT)
Received: from [9.111.12.154] (unknown [9.111.12.154])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 12:11:38 +0000 (GMT)
Message-ID: <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
Date: Mon, 8 Dec 2025 17:41:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
From: Nilay Shroff <nilay@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
 <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
 <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DMh7LYmT1GwxwF_XzWcu9lWjm40KjSN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX/CDFhho64bTQ
 vbJ8cCJ/XzQyzynsm22hdI2oGvA1bJdXTXp0ySPLiSZFgLbH7T4ylneWN9mlfMfCmXX82cPjH9c
 Cxh1ovhBCpR550ju8mwNYrSK2V3I14V1TuR+dCu4yBWpYVYGW9BWOGBT+7VxwEdcnKlN3O17D2O
 LIp+iNF3r2lyGjxtGyALTBXSLZsXLj/Fg1okYOhhod1j7Ws5aEoXyO6PDsvlSOIVOP9h13cGClf
 ZAuw8RektRUuk7LclWNXlTaqdprIglVflvGojeteRwItYZFmoByC3N2B2sHQcLK37ccDGBTiA1s
 VKXW60d1qNRuPlytPV6VB7lVUgg8hbHB+rfDoEue+g6vgVF7gHaXWw9WbM8LAUkRrXh63IH05yW
 QEZV4PcM8OOzFjeDjB1yTgXAzUdrGw==
X-Proofpoint-GUID: DMh7LYmT1GwxwF_XzWcu9lWjm40KjSN5
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=6936c081 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2LPsYEdpw_cF1ukiLYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_041150_014757_758B2D4B 
X-CRM114-Status: GOOD (  18.38  )
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



On 10/22/25 8:54 PM, Nilay Shroff wrote:
> 
> 
> On 10/22/25 2:20 PM, John Garry wrote:
>> On 21/10/2025 16:02, Nilay Shroff wrote:
>>
>> -
>>
>>>> Does the drive which you are using report NAWUPF as zero (as hinted)?
>>>>
>>>> If so, have you tried the followinghttps://lore.kernel.org/linux-nvme/20250820150220.1923826-1- john.g.garry@oracle.com/
>>>>
>>>> We were considering changing the NVMe driver to not use AWUPF at all...
>>> Yes, I just tested your patch with the latest upstream kernel on my drive,
>>> which reports a non-zero AWUPF but a zero NAWUPF.
>>
>> Do you think that you could check with the OEM for updated firmware (that reports NAWUPF)?
> Yes, certainly — we can check with the disk vendor for updated firmware that correctly reports
> NAWUPF. I’ve already discussed this with my manager, and he’ll arrange a call with the vendor
> so that I can directly explain the issue and what we want from the kernel perspective.
> I’ll follow up with you once I’ve spoken to the vendor.
> 
Just an update...

We met with the vendor team and explained the current situation regarding atomic
writes and the NVMe Linux kernel driver. I’m happy to report that they acknowledged
the issue and agreed to provide updated firmware that advertises atomic write support
using NAWUPF instead of AWUPF.

We shall first receive a test firmware build with this change. Once our test team
verifies that it behaves as expected, the vendor will proceed with a formal firmware
release. I’ll keep you posted once we receive the updated firmware.

Thanks,
--Nilay

