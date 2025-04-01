Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B0BC36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UB+Tl1HycxRo03uQvmeNmgSx1fpNzOY9ad+JlydmGrk=; b=eXVc8nixnJXjw1VUz6+jphIxAC
	UfJAw60lnXZFLbKIDK2IjwAMKgsqbMobWXl+qTvrm4UNxf96/Br2W8sCUBwhx1TbTQWjUxI7tQcZS
	mt9gNwm9hCvVtTwTbXUKH7VlLjlZ8lp0Y2SgqRwY9kjobe/VYPaXn6f2FgtrjtjW0tM7Hqsx1xpiX
	t36G0ahLeuf2J50uC0nm5js1x+n8Q5kLDEu0ExDG9My8AF9SC0l4TcusUEpJFveDSwP/auk0x3YjX
	1xEV/eFVDOJwnu+gGkodB+5PRdJfaMnNwb19RW5XWVTbHztOSi8JqN5hCidxV8SoY68peQrtEvf2b
	scibGhjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzblC-00000003Rzv-1T6g;
	Tue, 01 Apr 2025 13:34:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzbj4-00000003Rfs-1mS2
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 13:32:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531D3nwX026740;
	Tue, 1 Apr 2025 13:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UB+Tl1
	HycxRo03uQvmeNmgSx1fpNzOY9ad+JlydmGrk=; b=jUnLRLn/usOTK+/SEweGIK
	/Y6L+qXSHhtfdYFL/YGMznnt/Tk85EuK1N0pJkLNLBc2HIHPDK5TE5kARri/qkej
	88HIhl1I1a0REioEr1iqURJooF8q4+B1N6ee/drrnUicwucYT7nucDlWxSCklHqS
	u40p05TAFEdZ5vBBwAFPfeVgu14RIUwNVBys827xrOdZwv7IrOvFug7m82ZNVZ90
	EPGtQSekjGcW40dWvw3BwDyiBVI4bTJysuKcqrMqCaLcsqSTH7n72bYI/dmLTSTC
	M6hAEkXIBXJ3uR7xYeCqLr7JMY+h8CF+tmzq7hSRuhUm2YKPpG+ZJ4Y5mnUPi87A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r8h9tk4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 13:32:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531A2v0O005404;
	Tue, 1 Apr 2025 13:32:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww2acdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 13:32:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531DWGcF19333824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 13:32:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B945805B;
	Tue,  1 Apr 2025 13:32:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED67C58059;
	Tue,  1 Apr 2025 13:32:12 +0000 (GMT)
Received: from [9.109.198.185] (unknown [9.109.198.185])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 13:32:12 +0000 (GMT)
Message-ID: <7cb33ebe-2ff6-4c3a-82f0-c4ed547e8a25@linux.ibm.com>
Date: Tue, 1 Apr 2025 19:02:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>,
        randyj@purestorage.com, Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 43Qqq5eKFUOoAm97BJPLd403o6HbNLgV
X-Proofpoint-GUID: 43Qqq5eKFUOoAm97BJPLd403o6HbNLgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_063222_489643_7D5A75B6 
X-CRM114-Status: GOOD (  25.24  )
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



On 3/24/25 5:37 PM, Daniel Wagner wrote:
> The TP4129 mendates that the failover should be delayed by CQT.  Thus when
> nvme_decide_disposition returns FAILOVER do not immediately re-queue it on
> the namespace level instead queue it on the ctrl's request_list and
> moved later to the namespace's requeue_list.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/host/core.c      | 19 ++++++++++++++++
>  drivers/nvme/host/fc.c        |  4 ++++
>  drivers/nvme/host/multipath.c | 52 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/nvme.h      | 15 +++++++++++++
>  drivers/nvme/host/rdma.c      |  2 ++
>  drivers/nvme/host/tcp.c       |  1 +
>  6 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 135045528ea1c79eac0d6d47d5f7f05a7c98acc4..f3155c7735e75e06c4359c26db8931142c067e1d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -239,6 +239,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
>  
>  	flush_work(&ctrl->reset_work);
>  	nvme_stop_ctrl(ctrl);
> +	nvme_flush_failover(ctrl);
>  	nvme_remove_namespaces(ctrl);
>  	ctrl->ops->delete_ctrl(ctrl);
>  	nvme_uninit_ctrl(ctrl);
> @@ -1310,6 +1311,19 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>  	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>  }
>  
> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> +{
> +	unsigned long delay;
> +
> +	if (ctrl->cqt)
> +		delay = msecs_to_jiffies(ctrl->cqt);
> +	else
> +		delay = ctrl->kato * HZ;
> +
> +	queue_delayed_work(nvme_wq, &ctrl->failover_work, delay);
> +}
> +EXPORT_SYMBOL_GPL(nvme_schedule_failover);
> +
>  static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  						 blk_status_t status)
>  {
> @@ -1336,6 +1350,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  		dev_err(ctrl->device,
>  			"failed nvme_keep_alive_end_io error=%d\n",
>  				status);
> +
> +		nvme_schedule_failover(ctrl);
>  		return RQ_END_IO_NONE;
>  	}
>  
> @@ -4716,6 +4732,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
>  
>  void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	nvme_schedule_failover(ctrl);
>  	nvme_mpath_stop(ctrl);
>  	nvme_auth_stop(ctrl);
>  	nvme_stop_failfast_work(ctrl);
> @@ -4842,6 +4859,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  
>  	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>  	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
> +	INIT_DELAYED_WORK(&ctrl->failover_work, nvme_failover_work);
> +	INIT_LIST_HEAD(&ctrl->failover_list);
>  	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>  	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>  	ctrl->ka_last_check_time = jiffies;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index cdc1ba277a5c23ef1afd26e6911b082f3d12b215..bd897b29cd286008b781bbcb4230e08019da6b6b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2553,6 +2553,8 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>  {
>  	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
>  
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>  	/*
>  	 * if an error (io timeout, etc) while (re)connecting, the remote
>  	 * port requested terminating of the association (disconnect_ls)
> @@ -3378,6 +3380,8 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>  	/* will block will waiting for io to terminate */
>  	nvme_fc_delete_association(ctrl);
>  
> +	nvme_schedule_failover(&ctrl->ctrl);
> +
>  	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>  		dev_err(ctrl->ctrl.device,
>  			"NVME-FC{%d}: error_recovery: Couldn't change state "
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2a7635565083046c575efe1793362ae10581defd..a14b055796b982df96609f53174a5d1334c1c0c4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>  void nvme_failover_req(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>  	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>  	unsigned long flags;
>  	struct bio *bio;
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>  
>  	nvme_mpath_clear_current_path(ns);
>  
> @@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
>  	blk_steal_bios(&ns->head->requeue_list, req);
>  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>  
> -	nvme_req(req)->status = 0;
> -	nvme_end_req(req);
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	list_add_tail(&req->queuelist, &ctrl->failover_list);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +

Why do we need to wait until error_recovery for scheduling failover? 
Can't we schedule failover as soon as we get path error? Also can't
we avoid failover_list? 

Thanks,
--Nilay 


