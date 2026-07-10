Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6528FC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Co+MBVxnbPOLb66s1VxJ6IqsBCfel7NrZlPPyoEsFbs=; b=hos3ItPPmHsVP9be+uQZaLPO6C
	mEh9sJaamY9ToqWZR12K70UOny+N3lUZP9YxR8h0qgWcPwRXbirsbgf12tUcQlG7y9ME/baaJTwRL
	d70Svk+OoLVDsSEK2awPlOTebxt0nxVvBOIZM5yJpBXL0XjZrcW/0YxMf3mHgdBh1w78rrT/BxDJk
	GQgAOr3KBN30ZIHDPxihdvcXcSeru8MG27odGGrAnvTZJhTWeLcTZuVVuTNOu6NbNjWzfr8yD94sH
	+DabQFhHqpFt2oP9Tm5AuylwhrcHTROSh8j8J2b5nubAFu5J0wy5AhXMIEB2oU3TIecCGtqsWuTin
	Ic2Rariw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6RK-00000004Rfn-1StO;
	Fri, 10 Jul 2026 08:18:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6RI-00000004Req-3PMf
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 08:18:29 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mKqE223095;
	Fri, 10 Jul 2026 08:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Co+MBV
	xnbPOLb66s1VxJ6IqsBCfel7NrZlPPyoEsFbs=; b=J00NnuPQyI8hx/nJ69m5V0
	5pGuE/iCkc+oRi2yEDf7e7g5B7yYGxbkDjnP/bkmI4jSrjyYZ74TCpkh4eQKUE/a
	8TJ1JVCeGTTqaGQn69PzqJTMDd2oVbMnhpCHvY/XvvfkqwddJnUFwv8BuUC0uxql
	U3aN7dkbshkT2Ellp2/IyZ4STx61LIazea/Xu5/QHZRkgstiwVN3jyio5G72daCC
	j4FPD9Ra/lMf0INPxqTJftUY4TeRQ2Vm+lqKLUZCs6Eq2d7YOqgTgD9qo+oFgyPd
	jsJLTHJiXGQ1z/7Kl91E6Y0d0zPMNK7FIVkhqd+1o3qfGtdygpVPhuoAcfMG7X2A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw55rjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:18:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A84jxu016391;
	Fri, 10 Jul 2026 08:18:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkh3g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:18:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A8I5ah22938324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:18:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F675805E;
	Fri, 10 Jul 2026 08:18:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F695805C;
	Fri, 10 Jul 2026 08:18:02 +0000 (GMT)
Received: from [9.43.90.92] (unknown [9.43.90.92])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 08:18:01 +0000 (GMT)
Message-ID: <32ffcd98-1d9e-4f12-b7f9-4960942f8650@linux.ibm.com>
Date: Fri, 10 Jul 2026 13:48:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/18] nvme: add context annotations for
 nvme_subsystem::lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        elver@google.com, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
 <20260706141452.3008233-8-nilay@linux.ibm.com>
 <20260709062845.GA18056@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709062845.GA18056@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jNopTae3gpEzoJJVHFEg7enKlEjkpcfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfX60lPonr9b/DQ
 3LZ9BZjZOasvBM4S3IscMVpX647wp+u5jynYub3JguAJf5UbiZ1fjfZGasQpZC1sse0vf7q/ssY
 Y1YYleDkZfD9zZqZ0i+5+jpR7tFpcclEyWnVTmmcUL2aHdlLokm+oyfEze8Oq3emX++eyPnnX1a
 ejGixibQh77lUSFCbZuqUd0xdEXV1fNkN11o47ZETWBS/WMKFcSILkx/F+4kr313GetY3pY691O
 zH1S0LbMVc48pL8uUD0hPCVt2AgHoMafoFU1FQqITRTqMVFK+YLPbaEMcYP1Fp1b9vy9IjjYD1v
 T1QlFUHB/7pjHqJq8jsavjKIugnXx+rFNMHoo7zNT8w/ZCrcGwBBa3O4P8r248GGwS4gvXKVaRe
 p1l3/x1PBYclApKvAEqTc/zU/+JnUQf2WRdRLr0d2rHuwaYhpwKniD91e4LmlcxwZINgotx0vs3
 Mo5fnZPCdtA5thckePQ==
X-Proofpoint-ORIG-GUID: zn1IEVjIvGTJ01g064ufCQdW38KjN_3X
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a50aabf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FlTBnMmiTBUqsbusg5kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MCBTYWx0ZWRfX36cL0oy/0qWo
 9JYgDJeJooFV9dMQUhVLruUVcPiiqgCNc6G1qyHw2+mjdfrrsVX0W1rLjloeUPJKq/CqsA6q57g
 EbFv6oo0S2SMxox3nBMkM8am6B/8Df8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_011828_857993_34D97D73 
X-CRM114-Status: GOOD (  13.66  )
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

On 7/9/26 11:58 AM, Christoph Hellwig wrote:
> On Mon, Jul 06, 2026 at 07:44:09PM +0530, Nilay Shroff wrote:
>> Wrap the initialization of nvme_subsystem::nsheads with
>> context_unsafe(...) to suppress the context analysis warning emitted
>> for INIT_LIST_HEAD() during object initialization.
> 
> Still not a fan of that vs adding a proper helper.
> 
Okay so I think lets instead annotate nvme_init_subsystem() with
__context_unsafe.

>> nvme_ns_head is allocated with kzalloc(), so explicitly initializing
>> nvme_ns_head::delayed_removal_secs to 0 in nvme_mpath_alloc_disk() is
>> redundant. Remove the redundant initialization, which also avoids a
>> false positive from Clang's context analysis.
> 
> Please split that into a prep patch.
> 
Sure, I'll split that into a separate preparatory patch in the next
revision.

Thanks,
--Nilay

