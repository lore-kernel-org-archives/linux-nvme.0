Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AA3FD8FC9
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0o8ap932mOYwnvHfeEAhza1GO32RNiScrGyiw8pru4=; b=l/L50HX2zgqMXPQvlEJYJwfPjq
	YZQK9jTYCgWgNujFvFJPuWpjz+alYVSTloCIhAJemVWKfQ/8ECuedcyDrUhhrBr2S/n0kh70KKCsc
	kCX40sn0GaFBtvlWa9HCR8BzylnYuLqKzMmF2kt4Rgn+TzuEWGajRV0bYq3FO4BxG3pBcU5C91qL+
	ECFxWLtVVs7gNhGYrSfwMm4bCVbZSO/6rYkRKSVZHLX78hFRVZJZHRBVTdMA6DiZo93uSqXvF0f/R
	M2dlo71CKYPLbGoqPdkYuQHZ92hp+dUXQ/EW032lneGLKN5Vm1WOGzaj+2eOsim7IEHxljFukcvGz
	dJb36jmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdDB-00000006UxR-05fO;
	Thu, 26 Feb 2026 15:23:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdD8-00000006Uwf-48qP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:23:32 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QFCF3w2733894;
	Thu, 26 Feb 2026 15:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x0o8ap
	932mOYwnvHfeEAhza1GO32RNiScrGyiw8pru4=; b=Z80EfCVLo7+AGOUuiOID2C
	hd2kz6ohNcnqIRW+ZrDaIWWqMwk9bcRvok1UBxV4fVJzUcXCVfuQ8CvYLi4IugWF
	pXm+9ORValrsqU71Ov+2613AWFloff5oChrgD+bg2W7nLibA0wNZ5mwu91SYLfW5
	Lw3C5O+15I7QUAzZyVj5+DnPWQVqZHVTGwMx8+OJUrRPU6VwcJPAWBXkW2C5mbbW
	UEDFIdkH7j6iD8MsyNyXgNEJ3jnM2WmXgnRhywUf5+WwV//jKsUDivEF7kOG9FaS
	P3K7EOnULGRguLwUi0fkn20wUrveixe/KUzBQI8o8StbtrEFwyUqXeor2NTOBSFA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr781d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 15:23:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QFLvMv015764;
	Thu, 26 Feb 2026 15:23:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1svc02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 15:23:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QFNE2f262936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 15:23:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B684558053;
	Thu, 26 Feb 2026 15:23:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502E858059;
	Thu, 26 Feb 2026 15:23:10 +0000 (GMT)
Received: from [9.43.72.132] (unknown [9.43.72.132])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 15:23:09 +0000 (GMT)
Message-ID: <717bbe4d-d0ac-46b7-b609-a0389900e220@linux.ibm.com>
Date: Thu, 26 Feb 2026 20:53:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme-tcp: teardown circular lockng fixes
To: Chaitanya Kulkarni <kch@nvidia.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de
Cc: linux-nvme@lists.infradead.org
References: <20260226025658.86496-1-kch@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260226025658.86496-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cNdIYIFa2pId3v05P2VBsIg9lUmgpl05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEzNiBTYWx0ZWRfX4aIm6e9qsd9R
 0T7Pfxq/bxoyJrHIfOCAEYf3smmPCqY4PZQid4QJz+YCl8Lg+ga3p1+zcOtrPYifPx4/h/80rBF
 KA+0CfP9NAp7Xeao7rZvwTmK6bfWDCE/VFT2tJ8Kb3tyA4XbUUH9STw6NQG5BiYbBl43EfjhF+9
 xKLkR38gfs7fLoDzDjWHt0gg9Paj/nmWGT84F65FdJE1VT/HwFDeafdwY86YWErVezTt0rb09Nb
 lVpxr5A/faWdRuPX3ucYRMbqzqD2mPf+pTrpvyeG1F2ORx+fwbYADtLs1gkOlUz8vj0fbYy2H9v
 IUUkzr4FkXF7h2hp+xKnKiC9v+SbaI5MrkoZx8uW42D3bVUIu8P0P9rPi90sRjrr8Csu6FWKJeL
 sDrduOFOOzlWwPHJ3uu8gLov1FnHTG+sJjGloCkqVrS9+xQYdeHB2XF2yCgA7z00LlKhJNMqj8/
 sjihizQxsHazfbhOuMg==
X-Proofpoint-GUID: cNdIYIFa2pId3v05P2VBsIg9lUmgpl05
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a06564 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=IxJE-fU8GdHpeRMf8LoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_072331_035983_72227F06 
X-CRM114-Status: GOOD (  15.75  )
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



On 2/26/26 8:26 AM, Chaitanya Kulkarni wrote:
> When a controller reset is triggered via sysfs (by writing to
> sys/class/nvme<nvmedev>/reset_controller), the reset work tears down
> and re-establishes all queues. The socket release using fput() defers
> the actual cleanup to task_work delayed_fput workqueue. This deferred
> cleanup can race with the subsequent queue re-allocation during reset,
> potentially leading to use-after-free or resource conflicts.
> 
> Replace fput() with __fput_sync() to ensure synchronous socket release,
> guaranteeing that all socket resources are fully cleaned up before the
> function returns. This prevents races during controller reset where
> new queue setup may begin before the old socket is fully released.
> 
> * Call chain during reset:
>   nvme_reset_ctrl_work()
>     -> nvme_tcp_teardown_ctrl()
>       -> nvme_tcp_teardown_io_queues()
>         -> nvme_tcp_free_io_queues()
>           -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>       -> nvme_tcp_teardown_admin_queue()
>         -> nvme_tcp_free_admin_queue()
>           -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>     -> nvme_tcp_setup_ctrl()             <-- race with deferred fput
> 
> memalloc_noreclaim_save() sets PF_MEMALLOC which is intended for tasks
> performing memory reclaim work that need reserve access. While PF_MEMALLOC
> prevents the task from entering direct reclaim (causing __need_reclaim() to
> return false), it does not strip __GFP_IO from gfp flags. The allocator can
> therefore still trigger writeback I/O when __GFP_IO remains set, which is
> unsafe when the caller holds block layer locks.
> 
> Switch to memalloc_noio_save() which sets PF_MEMALLOC_NOIO. This causes
> current_gfp_context() to strip __GFP_IO|__GFP_FS from every allocation in
> the scope, making it safe to allocate memory while holding elevator_lock and
> set->srcu.
> 
[...]
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


