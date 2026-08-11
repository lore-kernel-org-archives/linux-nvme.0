Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D37C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YL0ah+RnrWnjQVv7gvazYGFyfa4WMCnZV9rFuXBt5UI=; b=4MDYupr1zzC/3X+5g9GphDbQ1W
	Xwi/MMTHITVJ9Xp3htIorsJzsHV3vn8CZGhL9S/RoqNgj7nvaow4xOlXLJhXZTt+9Wbue5+efnNBv
	FSC6eHVmFj/7ddoVHH52aoCCMHqhgmr9xw0kE9DSOF8MPr3yKltaVi1Y2KJbdHa7Y0CEwHh/fUjob
	HJmBQ6amvVwx1i5MpZdVd+Uenyo4g9dRkgzoxpp187BFIlNs3gHPi8RD6FhXD2srtrDNt/x6V1y0L
	m0W4+6lw+V7IA7iHitd4qoln2AWfEuokst/zekQPHs3KpHnIes0eTRn2mHjojZTZf2jD+hz3Yic0J
	H4++bAEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttA8-0000000Evx5-0Sp0;
	Tue, 11 Aug 2026 20:33:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wttA5-0000000Evwk-3pDg
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 20:33:27 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BJVa0S3653747;
	Tue, 11 Aug 2026 20:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YL0ah+
	RnrWnjQVv7gvazYGFyfa4WMCnZV9rFuXBt5UI=; b=Aso9SyUpp0dLWgo4T1S8lG
	VsbV+Y6/aQb6lIzchaWY43Uh8DFg3uIEfYxITDMhqKe3tRn5lI1cjdzzSbyM6A0j
	ayvazHnwb/moLcG/ezTvUlZHxnnEIgcgU5Wvj+SRBvwoUzCuQJ2LTKIStC6Yoo5P
	dFt+/0G5VV9onBbMkb3lu/Qju73OB9GXKSF6Q0gvgzEMvwhHMe6vgYY4TZ/n0xMW
	FyAXXoiaqvkQHftTR8sz8TQIs2a/NXgXWLOXmXxF+2NRUruAZUW6wy08M5vLW3mP
	sGq3ziErSnHXBCaYbqH71RSF6BUsIXl+mzLAgNpckezmtQi/tCTLt37rsYj9X/tw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyy2e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:33:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BKQQGl021671;
	Tue, 11 Aug 2026 20:33:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gap0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:33:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BKXKvN197590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 20:33:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1570058051;
	Tue, 11 Aug 2026 20:33:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BD45805A;
	Tue, 11 Aug 2026 20:33:19 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 20:33:19 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 15:33:19 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com, wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
In-Reply-To: <ant0I66BcAugTyGX@kbusch-mbp>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <ant0I66BcAugTyGX@kbusch-mbp>
Message-ID: <07ba01ec9c9f54da7cf7b3b4096f1e7e@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfX3/0aiyW13+Ci
 I6fRC5ePDmzfmQ/MSq0N19FyPkbJAJbEMSCShfPBNz9VcO0nJlYP5Lo+duL+kKp7lmLpjAl5Nsm
 Jt1gHTf0u2BlPzQ4UgwLf8wdmHGeMKuvqkdsBgNxH7L3R7CZ7u6uvoEGWICdPl8ZhmUdjjtDHba
 8YRlXccaXGDWUt2txfDvTOa15RE5FcYkcIrRQ7yezNB5VCy04Q+OrxKSTK4/5hh+3WIRDgsQB2Z
 KEW1sFMo2Wu/5xMuBSZoBZRwU9D7rZOyfXx2hBRBUoZCJ4nWikDTPOJYpGqQjC6+//LqXOOxwSQ
 z2PG9AHoFwwC5FPBPaM8ks2sHttCojuppMimdtK4VW6d+bPUKj/jducxAzv2NFFAWvLkcLwOlu6
 hElicLvv0PMcM+lOQFwBnhPqY+PZxwK+OZQOoM8jVl9eZws6abTLr2FZWC0oBv//oZvURfaDkH0
 26cMXngQ90KkYuKHbOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfX/aUOZiNnBecr
 JxlTZxGQElbLN97y9y31XXbs1n584Phu7v+rJL3PEzTg8ojxSny641z/q7pDxnKih8jqQDGCT3l
 U+0woHjLbgizKyrTh3m5S54W/DKNckY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b8714 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=BP976wIk3yFgEuwxU8QA:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: VKk7X3QNDq-RO4Wv2SbjI48_-q8MF1qS
X-Proofpoint-ORIG-GUID: VKk7X3QNDq-RO4Wv2SbjI48_-q8MF1qS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_133325_982330_6C6BEC71 
X-CRM114-Status: GOOD (  13.49  )
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

On 2026-08-11 14:12, Keith Busch wrote:


> The result of nvme_find_path() is just the current path at the moment,
> so I don't think this is right.
> 
I thought:
- if policy is NUMA, returns current caches path if optimized.
- Otherwise scans other paths to find a new optimal path.

> I think you need the head to hold a module reference on every path the
> head has, so the module_get/put should be in nvme_mpath_add_disk and
> nvme_mpath_remove_disk.
I will check this.

Thanks for your reviewing!
Wendy

