Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF9C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=El3kqJbImsrbgw6kfW2iY7nek339URZTmLMs78QVqgA=; b=mNERjepdIxZfXjfsZ35G6+SQIu
	gCvCr5Kzlch77jrclCNsolqZTeSC5KAEiR0P5/Ow+Ehu8YN1pAXC8hKERcYWX4OVMwPJB3sdTV7Df
	BjIohLoofvKBRuBdbM8NUVUBKSavwO5CD0gvQD4KUGDmNWxOCjhgjZbytpVCUUnbapQcsapahvBX3
	XQf1naG0bO11tok/EQ0icSgUqfOpCXQ8ihS0LKVuXj4yllMp80F9wbjyU6hrU8NVEfDE5Li8YOSWX
	jrsr970HOFS80NvklTsZ2Zmu4COGW5hiExpOqmemOburq7INRnHRbzpFY/r1ScLXq41s1xk3v/Adu
	/G2XjMVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPYJ-0000000AQbU-2C1X;
	Thu, 30 Jul 2026 12:07:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPYG-0000000AQa7-2T2C
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:07:53 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHWq62708677;
	Thu, 30 Jul 2026 12:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=El3kqJ
	bImsrbgw6kfW2iY7nek339URZTmLMs78QVqgA=; b=thpdNRtRn/EjrS1xjpykqv
	KbkYXgMprL4zEHWZOAs7VgKvpsBflRK6phpzOv9v95NhcyziJMmGx7rzaqLhd4Z/
	32ZQbj0MwZjgqD763C54fRfoBSGgvbs3mJxXFEnpQgr3spnX0VoMeF+UgRWH/D70
	Yt4S2tMZerCMzKaQvImULjk9CmTeRhC771FqqCeb43hifVO07Xk6XxGva7j27fF0
	UCjYh8quSDWw+39LWyCv6atg4EnnTnRBwaSCCEwY8l+jJAp4AdAjnZ0ElpLIopNu
	a1RZeNr3B5PBdLU/rmpDFKkReAr2C3owzG0Wp+q8vM3rzFaCocG6zZTyiyUjonhg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7qjqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:07:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBuPqV032543;
	Thu, 30 Jul 2026 12:07:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkb7hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:07:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UC7jHw14811742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:07:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5095858063;
	Thu, 30 Jul 2026 12:07:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67DC65803F;
	Thu, 30 Jul 2026 12:07:42 +0000 (GMT)
Received: from [9.43.106.218] (unknown [9.43.106.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 12:07:42 +0000 (GMT)
Message-ID: <74354800-4e22-43a3-aa8f-5e31bcfdf7e8@linux.ibm.com>
Date: Thu, 30 Jul 2026 17:37:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-pci: release descriptor pools on probe failure
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730043105.3071328-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rRb9gjnVc0aJIXJUkEHqf1UsSJLYYeC2
X-Proofpoint-ORIG-GUID: p8mkHFwR7LRKdRuLJbzjHHFVTOO2jI3f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX0n1aGqwC4uHF
 hhYbCbl1vZzJs1pTOP3AI2Afw+zAlbxOLQwSPr7K/WshKqi6xkLnscmIb/n4net6S1JYZR/mI0B
 ByCFRvRGcjaqft9+J35mSL9GG5NjL+lllDLWBqZsbOt3nQ55TtTPqVJjbg+d1nLcOybQ4yNY9lE
 2QgPU9c8xzclXrOLeCyaYT4a6xeHBqI/gzwSbr9UXNeYQ5UQeSQfJlHlYseaG1omFYWPi029Dp2
 9lcyUv55I7evV/W+2w3fXiKLI5CAfFBajLXHOvY6cd1hGFGIfI90EGmLO0xAnRIDWeOogB1C0oZ
 pxiTDVS5SKY+Qf2JYxahrTbLpB+pCf5X4QCtvESj2Fn5x1+QozmMocIHjDnC5YC5cHAMGT3a1GM
 RFhiAhlHMRZNE1fHVH2DI+t/XjmVXwPyIzGD7oMGkwC4xzj3rsbwa9ww1Qzfi79atdbjSaGtBeN
 BUfyRWeFRvm64Ra8tRA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b3e93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=tP06RG6TKp5a_tX1Ax8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfXw7Dj7Y3LRPfD
 l5OHxcpSSu+zZ/f/RXjmhPEdBnNTnW9K9zrhAiQ6zuyUacfiWQUx1fFE+RiZ1c1FEZ/q6L9fuF5
 CYTQaJp202jNVk51Z9NTiDJEDhEtzCc=
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
X-CRM114-CacheID: sfid-20260730_050752_720486_AE192A65 
X-CRM114-Status: GOOD (  13.57  )
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
> The per-NUMA-node descriptor DMA pools are created lazily from
> nvme_init_hctx_common() once the admin tag set is allocated, but they are
> only destroyed in nvme_remove() via nvme_release_descriptor_pools(). Any
> probe failure after the admin tag set has been allocated unwinds through
> the out_disable label and nvme_pci_free_ctrl(), neither of which releases
> the pools, leaking the dma_pool objects.
> 
> Release the descriptor pools in the out_disable error path. It must not
> be added to nvme_pci_free_ctrl(), as that would double-free against
> nvme_remove() on the normal teardown path.
> 
> Fixes: d977506f8863 ("nvme-pci: make PRP list DMA pools per-NUMA-node")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

