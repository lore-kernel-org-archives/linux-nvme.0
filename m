Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D75C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeMNm51+6ZKFYZqtAy3GOlGCh8XgJKoAtAG4m4ffCPs=; b=GdvLd4jC4suavRsOg97RfNp9Ld
	WxHAL8UAhdnf/54DpKg9/fAkI+kEiOu+jaqsNzt0GeUPvFM/3m1UOzTnnF6HuByD796smI3K5HM0l
	SEM0RfDQ8BXhhWAuvHlGtrlMCGQEGiGLJ2GpMopCpniEerFNZbIWx5ksD4a+vfC/o5ihu85vTcpxg
	AU4rV74qDdSiSIU3HIlfFdGf7C0VcPREcHP6uqutpu8hm5mgdsErAbFG398ezDJi8FuqJ9eKSigEr
	AYu5IsnZlqn8Xyrpy6jMYVoOrNwcP6yNj7q7gj4H0kKJEq9o0GfFG7YGAwjIfgUKfFAJSFANe/+Jh
	+ZZo61pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tntru-00000009rwj-2zHg;
	Fri, 28 Feb 2025 06:29:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tntrs-00000009rvd-3Yig
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 06:29:06 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S2QDTM018108;
	Fri, 28 Feb 2025 06:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WeMNm5
	1+6ZKFYZqtAy3GOlGCh8XgJKoAtAG4m4ffCPs=; b=q6fOYz9RcBp4dN4PHfK8fX
	6OZz2yp6c5VYU9oyijEgUwz8TYy7WbM4/8NuIdw2JkpO0uCnqsWZiq9Exgux8uCP
	t2uTMkMuiwY7IuLkmxQgbshqx9NHTwkDO85MgUzcxkijjsicgLrZyhRSHeM0NWbx
	Bwcq0qrlVQWwMTOdDGVeOQFY6TKi1u85FYIDCO5R7qtRmDhlk7TwBDGVC1hbp7SH
	cjWivDPZsrvJRGrZQTwoYOK8i1uDx04PwJmwTw2FkkqvqXaGJzMajIyBc7pSuUJM
	U/q2spWNlX1IIZFbRD5U4X9tX5L5j24Oo4CaTB4tEJ8xBmfdY7fNJf35VbwU67+w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpe210-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:28:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5lIY9012491;
	Fri, 28 Feb 2025 06:28:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yw7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:28:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6SnKu12649088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:28:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BED458052;
	Fri, 28 Feb 2025 06:28:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6255C58068;
	Fri, 28 Feb 2025 06:28:46 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:28:46 +0000 (GMT)
Message-ID: <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Date: Fri, 28 Feb 2025 11:58:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250228032541.369804-3-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xjODHAE76ywNgQoU1riXZ7S4wvZgevn7
X-Proofpoint-GUID: xjODHAE76ywNgQoU1riXZ7S4wvZgevn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_222905_029003_8A152C8B 
X-CRM114-Status: GOOD (  24.06  )
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



On 2/28/25 8:55 AM, John Meneghini wrote:
> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
> the multipath parameter is added and multipath support becomes
> configurable with the core.nvme_multipath parameter.
> 
> By default NVME_MULTIPATH_PARAM=y
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/Kconfig     | 15 +++++++++++++++
>  drivers/nvme/host/multipath.c |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 91b0346ce65a..c4251504f201 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -28,6 +28,21 @@ config NVME_MULTIPATH
>  
>  	  If unsure, say Y.
>  
> +config NVME_MULTIPATH_PARAM
> +	bool "NVMe multipath param"
> +	depends on NVME_CORE && NVME_MULTIPATH
> +	help
> +	  This option enables configurable support for multipath access with
> +	  NVMe subsystems. If this option is enabled NVMe multipath support is
> +	  configured by the nvme core module parameter named "multipath". If
> +	  this option is disabled the nvme core module "multipath" parameter
> +	  is removed and support for NVMe multipath access can not be
> +	  configured. When this option is disabled a single /dev/nvmeXnY
> +	  device entry will be seen for each NVMe namespace, even if the
> +	  namespace is accessible through multiple controllers.
> +
> +	  If unsure, say Y.
> +
If we want to make NVME_MULTIPATH_PARAM default on then I think we need to add 
"default y" under config NVME_MULTIPATH_PARAM.

>  config NVME_VERBOSE_ERRORS
>  	bool "NVMe verbose error reporting"
>  	depends on NVME_CORE
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2a7635565083..4536ad5fbb82 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -10,10 +10,11 @@
>  #include "nvme.h"
>  
>  bool multipath = true;
> +#ifdef NVME_MULTIPATH_PARAM

Shouldn't it be CONFIG_NVME_MULTIPATH_PARAM instead of NVME_MULTIPATH_PARAM?

Thanks,
--Nilay

