Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59A0CCD1BB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lu+SRBMoeksmXcA7YPHWXb0VULobYlejHJ6C3xKZYzE=; b=4lLUnkibwVpXDk7aNsd9aIVCeV
	bRUiicVB76GiVqhgnY9sQ6k6nKC9lq2Ez5BU7YJt7OkkHqYa8DepAquW2S5V2XYzA7BJ+EjTu7udM
	PetTKCMsLP4o8Z7BPWnbFKMXhLxAL8VD3bAuGO8fkv2YrT0NoL9PgkYJvqs/obpHrOq05JOxk9jNg
	IFQsCWlHuL7XfqLAOi0jo9RsH4hA+DnmzaH6teALtcE6130ypPpxuAiSN1Mp7H0nqdMXQgfXjwvSC
	4N4fIG/xcllBX+nLq4C5f5hoNAqgkrKc4HsaXP8AOeNleBd4Hw/SmaYkqL1MbzQs2LbsFZkointq0
	MkOTJQug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBahR-00000003NsT-11ql;
	Wed, 22 Oct 2025 15:24:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBahH-00000003NpZ-440H
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 15:24:23 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7lJNg014602;
	Wed, 22 Oct 2025 15:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lu+SRB
	MoeksmXcA7YPHWXb0VULobYlejHJ6C3xKZYzE=; b=QzcHI20XaBe1JEn2TB2AAU
	LWU+uo19WgKHITWRrWfNiQ2UGQjhbrKxgN7xujuNKyCZGzKMS2P6AcnqnUtMwFPE
	+FErUc2XvYcohlp2LvlxyvTCzzZQnmLc79Gn1SKygYvw6vsSgiSZi+grr4looxM/
	gb2VnIooCMOs+FXI2wwaXzETHeWv2sJ3ClNgPDRpPF4QGkWVTiUXRxvbqDSw5L5C
	/Rdjl79C96u6qjfIhJiycQeD8KYz1fJssomPRvzsg9d287lL613HbVX6tZcQ9sia
	u4SUHBS/4pzyTYJQywQyE7v7cB2VAe0Ez+LfK7jVLV27ivorRLXF4elSD+WlHngg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s5hxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:24:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MF1j2l002488;
	Wed, 22 Oct 2025 15:24:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejgvu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:24:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MFODHi27525650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:24:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1799558064;
	Wed, 22 Oct 2025 15:24:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8DE158054;
	Wed, 22 Oct 2025 15:24:10 +0000 (GMT)
Received: from [9.61.143.219] (unknown [9.61.143.219])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 15:24:10 +0000 (GMT)
Message-ID: <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
Date: Wed, 22 Oct 2025 20:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7VEGHUwGyux2mKhwrOvJXM8UnfTx4GN8
X-Proofpoint-GUID: 7VEGHUwGyux2mKhwrOvJXM8UnfTx4GN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3yeOqzDX+D4l
 GtoUlTWltDvj07HNEUod6rznJnhZUk87pC+ziHTcgq5j+BoNMxcUZNFaVgWRzXO3eZiDxU+mYiy
 sdKfQQgwguyDn7izq2266K3x2klAc70LaABuHa5nlX+13JcQqPEL5UfzaW/45vUPFg4Ew7fhsCT
 xp2uhakGg/5AcT1dwU89kbaHfj4wG1Z6PR59ftkybeU48/SLVaCaIXczLJTLrlYfj4444weYwYt
 f6G9Bt5O2vvqF1hTMlxLrnUGXr0D/cdeqF2eAMpLO9pWsX8pNJJA+YfufqkeHvBsWwF5msQi324
 y+Y92a915j2gSC7IU2XRHM9WZ51agl53I/J8Q3qPc7Swd7c5K2tXWSZg4wA6M1PA7izPhlFuJn6
 URCv3ov3Dxv1Zguov9TQe4thEi0ikA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8f71e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=P1pzS-bjeOVViHUOnBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_082420_017608_2CB28CA3 
X-CRM114-Status: GOOD (  16.30  )
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



On 10/22/25 2:20 PM, John Garry wrote:
> On 21/10/2025 16:02, Nilay Shroff wrote:
> 
> -
> 
>>> Does the drive which you are using report NAWUPF as zero (as hinted)?
>>>
>>> If so, have you tried the followinghttps://lore.kernel.org/linux-nvme/20250820150220.1923826-1- john.g.garry@oracle.com/
>>>
>>> We were considering changing the NVMe driver to not use AWUPF at all...
>> Yes, I just tested your patch with the latest upstream kernel on my drive,
>> which reports a non-zero AWUPF but a zero NAWUPF.
> 
> Do you think that you could check with the OEM for updated firmware (that reports NAWUPF)?
Yes, certainly — we can check with the disk vendor for updated firmware that correctly reports
NAWUPF. I’ve already discussed this with my manager, and he’ll arrange a call with the vendor
so that I can directly explain the issue and what we want from the kernel perspective.
I’ll follow up with you once I’ve spoken to the vendor.

Thanks,
--Nilay

