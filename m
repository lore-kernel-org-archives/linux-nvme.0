Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E9FD5302
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 06:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AD3Ii58wV2EOha1wfYeoozeOXdglQUIps6n1ldhCb4k=; b=iYF5U8U+9LcRWiVIiNBO7xINiI
	P+AhXdThNGJzia05p/KY+cC8+KaRwnYwykZVjYsBxHpYoNwKUJT4RG6YBhv8DxVSlqiAMze8DMTxT
	6pTNHMHCl01nGEZzH2Af5m/tX/M3pDg5HO2Z/BQfH7EQ/N9mk2jtIsbYdWCv7iBAvz0BsnPKe0O9L
	GuS3LpoVmVI7Z89N15bYSZHHC73vmbu9j47pKyE8YBKQowbuKlLlafmm+JfGqv41U8uEDLoN5UrHg
	aqqSic9pEwGQ1MVEO2Q6q9bxcaXo6adOVdORiBihqj0o/CIUBgaMKcoUvG4ck2ae/J8J6xOHG6NnM
	LY/81RjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvrof-00000007qM2-2BG4;
	Fri, 27 Feb 2026 06:59:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvroc-00000007qLF-1vet
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 06:59:11 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R4aWev2346005;
	Fri, 27 Feb 2026 06:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AD3Ii5
	8wV2EOha1wfYeoozeOXdglQUIps6n1ldhCb4k=; b=ZK7iC3YUc2f4IYYqtG3Vhr
	GJMs8bjcWImD9w7UIX3R9pnH76ZLyvOsSNrIES1xUld3pROYOP0gSjxhL6Rytyd5
	oIv51/wV1RP1afwgYjPWnQVks2pWzDsv6LNAZpn2j+wZNxQXP61LNCxyGz6M7chk
	9FpcV14Qqh+bh2hLaUXjWpre9qwnMSzQ3tELoJMDDzxtugjjYf1ywBggwXFK15M4
	hjAhGtZn31qm1wMo4X+11IBVOVpj6QMx/ztB5YMO3dBzdqJJIphLYwlUCWyFmmrB
	Jhrq+RUhwcexKhg/hY0/0wYo21ateM8AWMmPszE+X15Cx4jVmQqGiNQ2PpbLOxNg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8590q60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 06:59:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R6ZHbq013406;
	Fri, 27 Feb 2026 06:59:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdygtnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 06:59:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R6x6b021627512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 06:59:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24EF558060;
	Fri, 27 Feb 2026 06:59:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F385803F;
	Fri, 27 Feb 2026 06:59:03 +0000 (GMT)
Received: from [9.43.3.109] (unknown [9.43.3.109])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 06:59:02 +0000 (GMT)
Message-ID: <7797a6a3-d47d-440c-a580-40bae546728a@linux.ibm.com>
Date: Fri, 27 Feb 2026 12:29:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] nvme-multipath: rescan siblings on last path
 removal
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20260226183216.2098584-1-kbusch@meta.com>
 <20260226183216.2098584-3-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260226183216.2098584-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1NSBTYWx0ZWRfX+Qru6hcnCa0e
 5y9et9uwVN5bD+80LlUXeZwHfCcMCT0qyxBLW0MSjMGYebPteteRH2CeFZbk6KV5wn03HkGvU1h
 DDZrzVmYgbClnQ6AmL4yilUiZ/aoaZ5f660yC/0Q5NBIaI0xnvVSOJLZU2RZ/WF8iDmRzCGpUUj
 vF7cNOMuhianpfqWAcHLGAmZz8PPAF0tYnKDfyC1MjpyO3ZVgE/4MLntc/ohRBFvznp/ji0Eszu
 gW8JMJf9C9Q9j+hLUaulCo78bFSxCmWhGP1R8bPjicG/C4W2IW/OxviyTF+v9Di2ypwfqwJgQYf
 /muoIhhH9pLxVYKeRN6hwTbXEOXj2i2TcZThvZmGva91LlfWS/IwUJiQQzRxQzPwBaYYeXhw13x
 f3PY7h6izYOABvDdkuASpmvydHs7WolzRSmUrzH2o6WVFiGJgm0LXNlzbH7EyN5q3hXoVu8gh2O
 jg5k/UAPUL5OY2dLLfA==
X-Proofpoint-GUID: X3NvkXbR6K1XrSC8JTR1JrhzcVgRzA0_
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a140bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=FD-8ndJGWIHSRaxKiq4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: X3NvkXbR6K1XrSC8JTR1JrhzcVgRzA0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_225910_648521_61A27C5A 
X-CRM114-Status: GOOD (  27.14  )
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



On 2/27/26 12:02 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When a controller's scan removes the last path to a multipath namespace
> head, sibling controllers in the same subsystem may need to rescan. A
> concurrent scan on another controller could have encountered the stale
> head with mismatched identifiers (e.g. from a recycled NSID) and failed
> to set up the namespace. Without notification, the sibling won't retry
> until the next AEN or explicit rescan.
> 
> After a scan that performed last-path removals, notify all controllers
> in the subsystem to rescan by requeueing their scan work. This ensures
> that recycled NSIDs are promptly discovered by sibling controllers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 19 ++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3de52f1d27234..5bb4b18511b7b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4262,8 +4262,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	mutex_unlock(&ns->ctrl->namespaces_lock);
>  	synchronize_srcu(&ns->ctrl->srcu);
>  
> -	if (last_path)
> +	if (last_path) {
>  		nvme_mpath_remove_disk(ns->head);
> +		set_bit(NVME_CTRL_SCAN_REMOVED_NS, &ns->ctrl->flags);
> +	}
>  	nvme_put_ns(ns);
>  }
>  
> @@ -4530,6 +4532,21 @@ static void nvme_scan_work(struct work_struct *work)
>  	}
>  	mutex_unlock(&ctrl->scan_lock);
>  
> +	/*
> +	 * If the scan removed the last path to a namespace, notify all
> +	 * controllers in the subsystem to rescan. A controller that is
> +	 * concurrently scanning may have missed the namespace due to the
> +	 * stale head still occupying the NSID in the subsystem list.
> +	 */
> +	if (test_and_clear_bit(NVME_CTRL_SCAN_REMOVED_NS, &ctrl->flags)) {
> +		struct nvme_ctrl *tmp;
> +
> +		mutex_lock(&ctrl->subsys->lock);
> +		list_for_each_entry(tmp, &ctrl->subsys->ctrls, subsys_entry)
> +			nvme_queue_scan(tmp);
> +		mutex_unlock(&ctrl->subsys->lock);
> +	}
> +
>  	/* Requeue if we have missed AENs */
>  	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
>  		nvme_queue_scan(ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9971045dbc05e..e73cc2e67ac51 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -329,6 +329,7 @@ enum nvme_ctrl_flags {
>  	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
>  	NVME_CTRL_DIRTY_CAPABILITY	= 5,
>  	NVME_CTRL_FROZEN		= 6,
> +	NVME_CTRL_SCAN_REMOVED_NS	= 7,
>  };
>  
>  struct nvme_ctrl {

Should we consider reordering patches 2/3 and 3/3? It seems like this
patch depends on the changes introduced in 3/3. 

Without the updates from 3/3, if delayed head removal is still in effect
and the NSIDs are recycled with mismatched identifiers, a forced rescan
of the sibling controller may still fail to instantiate the namespace.
In that case, requeueing the scan alone might not be sufficient.

Thanks,
--Nilay


