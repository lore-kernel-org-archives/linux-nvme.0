Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221FC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:59:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089A1222D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4KnGf9t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PIVGEZRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089A1222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bFn8JPlDJLUd7q4BhVq6xJZwGcq8q8aKZgsWFM65Jnk=; b=c4KnGf9thmktZXr41BsA4zwUe
	exIZXce/NGYwrjCJvkBwSB05D4xP7LkaFVBl13MPbLzT5YtSkSWBru+rnWSMcGQgnuw3AXvd+bQFT
	qKReMW1eG+p4ASVmJKRkzgZOuq0EA1P0YIc+rWdDJTCv4aPN598RL0y1bfFYOYOWLb5BPlLgOBLSd
	mTJPRN+BUhCyqmNRVqUodFHZ3wTI8P4majBARJTzWxso+1j3GIdsp9EHA78skXH4oAv8x1jawqjEn
	VTmPpMFLDeTJ54A6Ru16otNIRqNzEzrcjV7GbTge/e2TaGX5EJBAHa7BRMiqjJMxg97zMY7BSzRYO
	D8Fvi/8HQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWd7-00086z-1j; Mon, 19 Oct 2020 14:59:21 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWd4-00086E-02
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:59:19 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEtYI4169437;
 Mon, 19 Oct 2020 14:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=k2ve5aDzngQwz4/9KvkBZ9ItJnh86sEekMd8zK55YNA=;
 b=PIVGEZREy12ed6aHwBA6l2DBQ9Yto6Pe+eIJUGlsLqWlD3JbonCm0tKQrV6NYy12pyyA
 aO0VVGCjVHUm1N6EHAl7fd4gF87nIYh8glgbu+Cd9IdlVL3BYqtGtpvN/wVOEqfPQE9K
 lgo2XQH2TvgnqDRWpXVsViQBJnV41R4ERr5jxjvJNi0Kk2yxjpW74zJ1mLEkgQT+xe5q
 LeRiQn4Kbc3MPXgKHwJsE05CbXJFbs4E0+7N1+PiYbcgd9mBYOqPpOw/FZ5lIA7YZFn2
 u0bcaXV9Bd7FlkbmnSfb4JcI4pIvkTWmdNJnRbYuwguXDq2GAUl3XGx3qGOrgvMJxsLO rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 347s8mnxt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:59:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEtpFg126989;
 Mon, 19 Oct 2020 14:57:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 348acpjsjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:57:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JEvEIZ014949;
 Mon, 19 Oct 2020 14:57:15 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:57:14 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nvme-fc: wait for queues to freeze before calling
 update_hr_hw_queues
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016211724.48707-1-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:57:14 -0500
Message-Id: <14FF47F2-A7A4-4335-82D0-86615D1920DF@oracle.com>
References: <20201016211724.48707-1-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_105918_204482_46818347 
X-CRM114-Status: GOOD (  27.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Oct 16, 2020, at 4:17 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> On reconnect, the code currently does not freeze the controller before
> possibly updating the number hw queues for the controller.
> 
> Add the freeze before updating the number of hw queues. Note: the queues
> are already started and remain started through the reconnect.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c81ebe94d8fe..7067aaf50bf7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2885,11 +2885,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> 	if (ret)
> 		goto out_delete_hw_queues;
> 
> -	if (prior_ioq_cnt != nr_io_queues)
> +	if (prior_ioq_cnt != nr_io_queues) {
> 		dev_info(ctrl->ctrl.device,
> 			"reconnect: revising io queue count from %d to %d\n",
> 			prior_ioq_cnt, nr_io_queues);
> -	blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> +		nvme_wait_freeze(&ctrl->ctrl);
> +		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
> +		nvme_unfreeze(&ctrl->ctrl);
> +	}
> 
> 	return 0;
> 
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
