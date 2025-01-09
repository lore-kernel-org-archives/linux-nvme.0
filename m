Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B854E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSHXcFJLnfLZEaJOndtwr0iTOpoNjH5VCixIjOF+AB8=; b=L3MzckGtDbTpWtyy5X2aiX/XmK
	c7ZwBSsh0+zEeUT54Ckf3D2xmJKHp2+p7Iz+C059sNawYvwmeEJbLZ3aLYkc1IOpE1k2l+oitn6vt
	kIkTmWdVWpEChV3UoSz+BCMhOl5papwSUNGBES4cDuRAMw42EH2qEVIC2tcCVFUU6YNouad3xtyQ1
	UyWZIi8YRrG722BTntWZD/XMji4Xed7tXa5ABX7k0Yh6P9IpyJW5TvCiYuKNaUt0rBITh3s5aziWf
	3/oSBl8qZACdPa+EYWceGPNeqR0cmn9bqV6hIZciSWo9oywVgB2Lgc+O33ZXvHND/41aCOx4f+szT
	wUFCyGMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqJH-0000000BdV0-2GXZ;
	Thu, 09 Jan 2025 11:02:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqFn-0000000BckE-295Y
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 10:59:08 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508NagXs026678;
	Thu, 9 Jan 2025 10:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tSHXcF
	JLnfLZEaJOndtwr0iTOpoNjH5VCixIjOF+AB8=; b=lJRrGp+igdZL0PokJgzR1T
	g7gViw6CGq1cjN1lq4orzvqVBWe+cDpvo+w6LiH4vPHr8x1aJJ/5a4Oa5NKW96Iv
	BudickNdHu3+ntyPszR1nIaQxy4GR0v5csvgQ8yRaKsfa9e8QRbQ/mKkORiAx8wk
	xB4XJFYIEN4jmhcpXOuO7+EQtGHa1QTRP2lXXZrqv0b6bGAl8WnpVcLiXFybXeJb
	uic1dIDsRnux1UEWutQWI/rPiuG7fMCKUr1ORT7W2ZMg4s14I3OeXeHcmTN2oYE9
	kG2WV3bxdnxwafdSnUIVly/8uG0+Wbo+xkPTFAlIeyT6/UetZQn5flAVuBXX4aNg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44236b2d32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 10:58:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509929IT013648;
	Thu, 9 Jan 2025 10:58:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap4pw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 10:58:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509Awp2X27263664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 10:58:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2BF58059;
	Thu,  9 Jan 2025 10:58:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D0405805C;
	Thu,  9 Jan 2025 10:58:49 +0000 (GMT)
Received: from [9.171.90.198] (unknown [9.171.90.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 10:58:49 +0000 (GMT)
Message-ID: <d1861001-1a18-40c0-b0ce-9824f9e93d89@linux.ibm.com>
Date: Thu, 9 Jan 2025 16:28:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: initialize the mq_map to NULL
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        kernel test robot <lkp@intel.com>
References: <20250109063043.95996-1-kch@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250109063043.95996-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qlRIXWACAvrfs7oC2ZT0UiR1GyogWMsT
X-Proofpoint-ORIG-GUID: qlRIXWACAvrfs7oC2ZT0UiR1GyogWMsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_025907_684281_3EBDC1CB 
X-CRM114-Status: GOOD (  18.33  )
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



On 1/9/25 12:00 PM, Chaitanya Kulkarni wrote:
> Initialize the local variable mq_map to NULL to remove the kernel
> test robot warning.
> 
> drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> 
> Fixes: bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")  
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com/
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 544d6aa00cc3..d6a40b7dba73 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>  	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>  	struct blk_mq_tag_set *set = &ctrl->tag_set;
>  	int qid = nvme_tcp_queue_id(queue) - 1;
> -	unsigned int *mq_map;
> +	unsigned int *mq_map = NULL;
>  	int cpu, n = 0, min_queues = INT_MAX, io_cpu;
>  
>  	if (wq_unbound)
Looks good.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


