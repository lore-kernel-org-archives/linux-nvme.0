Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A59CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryu8HrbGopPS++BlH/oFGGPY6Erp2jwhY2d5xXtbxk4=; b=eduhSwRGA+NBJnZPF0HNAh/SXx
	usaoZInTMJ/E+gdxaluBfdDLCXQVwgHJKkECczjV946mMRv9SfK6iWcQggFB3WyIB8yeM422uP09g
	qL0rwoc0uSFbuD8GZtcS8IPGNm5b3lAksgfnfp00/SrJya0WWD14+bQGxMLNIeTMcCmOO1W9w8wa8
	mc4LJxfGsclISAfzRu1HKRNhWefyi5Z+DD3o5ig2MMuZIB+zUz5OELbc2puHSSZA5Xw9KZw0hsak9
	hu5pFAt9ZGYElWdoGfSx9lhUj+tN7loMJIivWXqVbd/1e7swTjFcU6ZhbQ1gk+G1iMT7WNDx9dxDl
	ZLrLhyRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTx2c-0000000AIhR-07Pg;
	Mon, 01 Jun 2026 07:26:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTx2Z-0000000AIh1-1Dcu
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:26:28 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VGLD1V3263017;
	Mon, 1 Jun 2026 07:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ryu8Hr
	bGopPS++BlH/oFGGPY6Erp2jwhY2d5xXtbxk4=; b=jBkSbjkGyC3aCEmV+4ZZbh
	y3kE/3PgNKevOmTCN0VOzVCIasyIvnwCy9GrKQJJjdCHMYu46G5nvDFKYy9ecNLp
	hANt6OonaB7WhHjp3oCR0UCeKworXcFR2U85dsmSyYfHYCYbZ5XzgKDj1lzZUyva
	usn2OVNCo+HPAgAgxyI8T5Z4JO6qVi1tw4nxicHilKuY/rZh60doCyb0s+FKA/+j
	xymu1bS6MqNMRcRZVrByaYf0lyg6GhynitDRsY55fwGBM7vhKo5sIdHm16keBeg0
	vqWIbH5uILtM6j70a8Fp25vCNQu/whCXbOC0uyYzZmC/MkLxMkpAKdwH3vNXZyDg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4qfgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:26:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6517OQSu023837;
	Mon, 1 Jun 2026 07:26:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jvyd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:26:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6517QClj29557410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 07:26:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9597A58055;
	Mon,  1 Jun 2026 07:26:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A6BF58043;
	Mon,  1 Jun 2026 07:26:09 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 07:26:08 +0000 (GMT)
Message-ID: <52933605-108f-489e-a31a-5524844e7c18@linux.ibm.com>
Date: Mon, 1 Jun 2026 12:56:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
To: Kuniyuki Iwashima <kuniyu@google.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Marco Crivellari <marco.crivellari@suse.com>, Tejun Heo <tj@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, linux-nvme@lists.infradead.org,
        syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
References: <20260530081059.428303-1-kuniyu@google.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260530081059.428303-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iWJlRLLfeIbY0jj5V5KtikyPrqZ5wpHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3MCBTYWx0ZWRfX7rxDJqMifGCg
 w3byabaJk1nXHM+HD3g/SKmpDX6AP0RQvBwsaH3QKdiaNcwm3Qb6KQ+Xm8jWj/ExkLdq7zuPYjw
 dhdq5O7qksSQm6j89y916hhpJ6nT8VQCidzdBdT0zjO8dB5vOxetg19qwJd43pB7sgvP9D1iqJe
 /Mqpvk9ETl3R0iHPpiro0OtEIi9VPKTwvMF6DhbSF0o+h9Yh+GnjKLJpBsxWDZGT0BgWSXwnJJO
 HaQNz+4BrHXivkudg7+/vIhKRKTV8A5VhtBBe1bD6nOVYKFWlo8ibKiuAnbT3qkkr6EqAuHC8Qn
 mQoAx/rLTKI8DMC8BZrtFxGJ97bhiKBVyCPvjZCMj0/rTivd9hp5Z6cl3w4BrH5f/IUZfVThVM9
 960lb2UdiJ0P8Gu4d/3X36JSXdqwh3U9vowBBPB+zeHl97a6oRWB4RHWLjglko8/fzgmjl+FpdX
 rM+gqlN8RXP01VgfZnw==
X-Proofpoint-ORIG-GUID: 5vF9PauZUMgEupuZcBYSKdGet4Aw93fD
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1d3416 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VnNF1IyMAAAA:8 a=ZFmSVnsuCCONPfhWVtMA:9
 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_002627_339648_6BD8A95D 
X-CRM114-Status: GOOD (  19.40  )
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

On 5/30/26 1:40 PM, Kuniyuki Iwashima wrote:
> Since commit 21c05ca88a54 ("workqueue: Add warnings and ensure
> one among WQ_PERCPU or WQ_UNBOUND is present"), we must explicitly
> set WQ_PERCPU or WQ_UNBOUND when creating workqueue.
> 
> nvme_tcp_init_module() sets WQ_UNBOUND when the module param
> wq_unbound is set, but otherwise, WQ_PERCPU is missing, triggering
> the warning below:
> 
>    workqueue: nvme_tcp_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
>    WARNING: kernel/workqueue.c:5856 at __alloc_workqueue+0x1d02/0x2070 kernel/workqueue.c:5855, CPU#0: swapper/0/1
> 
> Let's set WQ_PERCPU if wq_unbound is false.
> 
> Reported-by: syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a9a86.323e8352.141b09.0001.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   drivers/nvme/host/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 22be0e0eee07..fcf54cc38c3c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -3046,6 +3046,8 @@ static int __init nvme_tcp_init_module(void)
>   
>   	if (wq_unbound)
>   		wq_flags |= WQ_UNBOUND;
> +	else
> +		wq_flags |= WQ_PERCPU;
>   
>   	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
>   	if (!nvme_tcp_wq)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

