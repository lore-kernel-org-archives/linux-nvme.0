Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE4CD2C55D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JWvtorGO4818oZ6n+v9kZT5rSMF5oxZ3REq5ECBUfM=; b=jTZ2RvSyeY5hkGTPmGUZbovo0D
	v36ypsgkltlYNa0kzNeR443TDtNpH9FAI4YGg592fP55bltKVP8pcG9L2o+tDm3vKK5jPXhyCsqev
	KIjdH362RKm2t2uNR8pyq2MyaFA+EgqyGexJ+ZzzN7q7JebKXDgLFueznaRsmwzHxYs1Gw6xLyd52
	YmJqa5C4XBaDCe/5Y6lAXc7sVvwMI32QdJ2FlFn0DE6WT5OBVar4PmKH/oMZs8oVTdV/Q7jQ66v5D
	opoIemA0Y4+fki8PL4W38eo9iMatExhEKfrETxd9yHvMFTe8waXRmuNpZ+0t+T0Cm/JCbxsPgrCX7
	8LOQlfhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fkb-0000000B5PT-2T90;
	Tue, 22 Oct 2024 14:20:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3FkZ-0000000B5Op-1Vc2
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:20:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA02F227AA8; Tue, 22 Oct 2024 16:20:39 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:20:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <20241022142039.GB17410@lst.de>
References: <20241021110331.125962-1-kanie@linux.alibaba.com> <20241021110331.125962-3-kanie@linux.alibaba.com> <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_072043_579766_0FA5BFE5 
X-CRM114-Status: GOOD (  18.91  )
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

On Tue, Oct 22, 2024 at 04:18:52PM +0300, Sagi Grimberg wrote:
>> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
>> +{
>> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>> +	bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
>> +	/* Reservation type, bit 15:08 */
>> +	u8 rtype = (u8)((cdw10 >> 8) & 0xff);
>> +	/* Reservation acquire action, bit 02:00 */
>> +	u8 acquire_act = cdw10 & 0x07;
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_pr_acquire_data *d = NULL;
>> +	struct nvmet_pr *pr = &req->ns->pr;
>> +	struct nvmet_pr_registrant *reg;
>> +	u16 status = NVME_SC_SUCCESS;
>> +
>> +	if (ignore_key ||
>> +	    rtype < NVME_PR_WRITE_EXCLUSIVE ||
>> +	    rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +		goto out;
>> +	}
>> +
>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>> +	if (!d) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>> +	if (status)
>> +		goto free_data;
>> +
>> +	status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
>> +	mutex_lock(&pr->pr_lock);
>> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>> +				lockdep_is_held(&pr->pr_lock)) {
>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>> +		    reg->rkey == le64_to_cpu(d->crkey)) {
>> +			status = __nvmet_execute_pr_acquire(req, reg,
>> +					acquire_act, rtype, d);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!status && acquire_act == NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
>> +		kfree(d);
>> +		INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
>> +		queue_work(nvmet_wq, &req->r.abort_work);
>> +		return;
>> +	}
>
> Is there a reason why you queue this here and not inside 
> __nvmet_execute_pr_acquire
> like before?
>
>> +
>> +	mutex_unlock(&pr->pr_lock);
>
> Hmm... you keep this mutex taken and release it from the work element 
> async... Not a
> great practice...

It's actually invalid for a mutex.  You'd need a semaphore for that.

Guixin, can you test the code with lockdep enabled and see if there
is other fallout as well?  Thanks!

