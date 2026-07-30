Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93817C55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLFI1DH5Dxr/Yiy/SDTZRNjsS12F4yyfeN6Y3hj9j9s=; b=kvQcK1aPPVakzueNqcJGSIvGLg
	3/3tVzkJlklWP59g6PVx7EE+hPU9nEnHjQohXGlodgn/YxgLB5e4YFVaKXf3r8e+F4sppETDmHF9O
	l4KWqrTxFHwJxHwHc3S9Oil0e9H2xVeYwBz2oXaSSEQZlEmFJj8jnWSATUsixktXFIBk8Zx44Eu7r
	a7oV/CuCRqpAHx7rgg8NB6x03C1zg2vx//SRjPMnPUFk5AlzWK4q29EbmprU7LVxl8ABnfQ4lcEKM
	aRnzjUwtLrKOzhPo2PvPqP3zpZ0jlq1DFD4nseIZSW6qMxs7VP7/CBxSnt1YOfdSxw++JEAvlSeKx
	vgkRMLwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPXK-0000000AQJB-072t;
	Thu, 30 Jul 2026 12:06:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPXH-0000000AQIA-1nzl
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:06:52 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHvXA2709590;
	Thu, 30 Jul 2026 12:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TLFI1D
	H5Dxr/Yiy/SDTZRNjsS12F4yyfeN6Y3hj9j9s=; b=TQ2tL07Vnmx2y0/5jIgTfs
	O+47Yd8sYySY0hvIfN+lXRcETGqeliI37P7FIxE0xk2gk0wFpf/8WrFQZNudn4gD
	X0Jmo67eaSDhB4IU7ZOe/s3xPSk4mH4bekNCaCO+7iWoMhwt/XC5lT4aKYUsR4D5
	RDB28wvbWlmEwtTXGx38hjXjc8dnSoqSSje5h7VkOFUPEBkWRfOggexAuRniawSS
	jP63C0zVpJ8TUGlO8+LixmvbOio1OyXu5dUVLZ2UkMBZk+8fW8UVmY5Ubzxc6r2D
	XosMLfFFzoI+A2Frm0tJL//pDQk4Z1ElGmfRhkNsAsXrrBsYCsMcp/tqkzvyGTrw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7qjhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:06:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBuMh3032524;
	Thu, 30 Jul 2026 12:06:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkb7cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:06:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UC6gN449611244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:06:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 256AA5805A;
	Thu, 30 Jul 2026 12:06:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B2158060;
	Thu, 30 Jul 2026 12:06:39 +0000 (GMT)
Received: from [9.43.106.218] (unknown [9.43.106.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 12:06:39 +0000 (GMT)
Message-ID: <00d41520-8956-472b-84b0-13597d59a176@linux.ibm.com>
Date: Thu, 30 Jul 2026 17:36:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvmet: propagate percpu_ref_init() failure in
 nvmet_ns_enable()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730043105.3071328-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: R7Sdkjugv8rS4txKDA2xu1absjZJl0dg
X-Proofpoint-ORIG-GUID: lx_fJ5AcspDu7rPIQQ1ogGQu6F1KBTpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX+78nqox7sTBR
 e359GVIITX1vZhrLWr9jue0UnR+4JQbW2mkmBAgN9NSPlIXJkjkbTqjYHGEKC2+c35QKcwGibjn
 KGUyIAaUJKIgUePAovCEkL3VFqH9M7I6pmPo9n3SkseEyVRHvRLk/LFf/PBV00/PiCD6dsS29Ni
 g/lMmH2dLK3wDIzqxwWNA8oJzzHlDq2nH9LR05NhdXgEOTKTwX48TovoNx3L35rm1DBoft1EGvs
 6/Gg/8/l6MJLmq508SPgdfN/5a0I7gJ26g3iafT5eKtoJf//Lfsl21XS015rdAyN/xoaMbCCBWj
 gtoCqYK2IWT4WeFexRoz71Pa3ZhsE82OeICzeyc7iU0USdzQLIkTK1SaafBpwi9Uf6TasI8AXIT
 ZMueiN+pO7y9qlM5Yj0Y1r+ATy9Vxatl3M52JRd+YuaRJACgAgNK6TA3NblsBOk6/yiOkwnjdOB
 M/7Nw95iiMM7ujw02Xw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b3e54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=mf2lht2G9qoOOO8l_xcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX/p9Ru9JYbxXp
 nJufPl2NZeT1co0n6cbZGUlTqSqLH6m2raIvCfkFHY/+XloJU6Iij1yvrp7qHKeZ8tBiBz5VxlS
 5Ypf6ofWOfBEyI4MmJDafBarCJkebdo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_050651_479142_C8DA6617 
X-CRM114-Status: GOOD (  14.55  )
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

On 7/30/26 10:01 AM, Guixin Liu wrote:
> The return value of percpu_ref_init() is discarded. At this point ret is
> 0 from the preceding successful steps, so when the allocation inside
> percpu_ref_init() fails the code jumps to the out_pr_exit cleanup chain
> which ends with "return ret", i.e. reports success. The configfs enable
> store then tells userspace the namespace was enabled even though it was
> not and its backing device has already been torn down.
> 
> Capture the return value so the failure is propagated.
> 
> Fixes: 408232680707 ("nvmet: Fix crash when a namespace is disabled")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

