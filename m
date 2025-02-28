Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B1C282C1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jh8vbYNYnAIcE9CyTf4BhDISkt5yCae96d3hjvlWfJI=; b=pRX/65rM6XfYMddZfupLoOFxyV
	a0j5TfeRtmVN5v9umAqrU5zUpTb7XT2ZdeN8vOB3hjecbOXxnFgCccISnTBtO2X04JBaM3qgYubAG
	QpSekZaElNZ4bMQQEVADFqSv35r5IQWm3hQXX8kgiIn6SOUIn5gYTdZu1EbD/v7BtOblPzLCcjw7v
	6Q21ehJqJaE2Owxx8ROBmJv590SyKMfiNm57w/RX/uVRhypZs2GY7qvntpykf6PoNUeBrJH6dGUy2
	AkJuu3bdzDW3gyxl3RCbKYSkal86VSXKwidjTZbD9RCFIMQ5B+KupbYZQtYMbKBkkRXlYU/ts9XuJ
	JpBd2LNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnts5-00000009rzS-1OIi;
	Fri, 28 Feb 2025 06:29:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnts2-00000009ryM-36kL
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 06:29:15 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S0fhos017877;
	Fri, 28 Feb 2025 06:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jh8vbY
	NYnAIcE9CyTf4BhDISkt5yCae96d3hjvlWfJI=; b=VUWIb2MBTS2yuwwY4KuOIo
	nRb7Ko9Fiz5DMkBwJBxVlndSzvf74dpLR/aNppZr/PMOSsTk7urXove40IkGoO2i
	TWfAjo7DZzSqTzlw5Fb927w/0ICDGNw8RHhzJoXufu3b8lkw2CBYEGr6W8oMg2Er
	ei+v4MjIIjqhHI0YBMBuSCliM6TaJFwgF+VpmOVOm0Ze4+1jdRvBuMl+jvYGkkpt
	R8yjmVf7dfD5Tx/ZtDzMAT5NYDNSNW8AmVgiYYlzNDV2t6qWQry7Vb1XwUInFjL8
	hmtd2owsJ9EJN4VHWQE0IzCDya0jXEbEjKx906Kpl14wkUyrHmwdkd0bm+14FfSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpe21n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:29:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S63OrC012457;
	Fri, 28 Feb 2025 06:29:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt57r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:29:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6T23M23331384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:29:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAD1658056;
	Fri, 28 Feb 2025 06:29:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4B158052;
	Fri, 28 Feb 2025 06:28:59 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:28:59 +0000 (GMT)
Message-ID: <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Date: Fri, 28 Feb 2025 11:58:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250228032541.369804-4-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: elnEcWRFPBm-yQ6qxc2csW1NX2BTc8JM
X-Proofpoint-GUID: elnEcWRFPBm-yQ6qxc2csW1NX2BTc8JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=937 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_222914_912846_6A3338EB 
X-CRM114-Status: GOOD (  19.48  )
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
> The new NVME_MULTIPATH_PARAM config option requires updates
> to the warning message in nvme_init_ns_head(). Remove
> the old warning message and add new ones.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 818d4e49aab5..c2b7e6834535 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  			dev_warn(ctrl->device,
>  				"Found shared namespace %d, but multipathing not supported.\n",
>  				info->nsid);
> +#ifdef CONFIG_NVME_MULTIPATH
> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
> +			dev_warn_once(ctrl->device,
> +				"Shared namespace support requires core.nvme_multipath=Y.\n");
> +
> +#endif
> +#else
>  			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> +				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
> +#endif
>  		}
>  	}
>  

As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies 
that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
So above logic could be simplified.

However on another note, I really don't understand why do we need to add 
new warning here as there's already a warning present just above your
changes.

Thanks,
--Nilay



