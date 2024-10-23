Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7481D2E01E
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxXWHBQSOd6lJycdHz2a7fp0ilJC/0rjEYUa2hzXXYg=; b=pmeHLBT9hvrsMvcCn/+kCc0y9Z
	Gx4vDDrPbRItaPs2F+hsZLDop3L51mFp7JwD6tsjratNrukjRaR65s3SjM+rX3mmp1PBtXfQTMUG2
	uje7agjyCyWlC/w1W9IbaEAqZzDZ5dHBHI14oxGJOXhmk1n7vTsxMJ6tbLLVUhqA0xVleEzhxzmKR
	j6RJKx+I8xRV0/0VqxoRWWrrDnzmmzKWKtJGIketq993N1zu5Zv/t0h6PtyQJgiy47uay0xpuIJpr
	sbh04JVM5AXoJT6UBMoaKz064nKB8XRSykBhe9FynD6/c4f0F+9yqpkozVQNFmSCo82FyVhaMJD25
	NFAwT7Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3W4Q-0000000DRWT-0s91;
	Wed, 23 Oct 2024 07:46:18 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Vtd-0000000DPIW-2WMD
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 07:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729668907; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HxXWHBQSOd6lJycdHz2a7fp0ilJC/0rjEYUa2hzXXYg=;
	b=MQT/s2vHThsZsXVSHmUkPlaGwek6IfsdxVesZesbUQaM3QuOq3+8QLrnYpCOi3L2A5cW420pKQhVcnzQzIZZVBqeUXC4P4LadPTyujyuehOF0cxOgVHB31oaOOzqpKUsAhHdT0wX4+ALzZpjASmgEXaH0dOoDhWsqX+vTjnDERg=
Received: from 30.178.82.71(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHkWpN0_1729668904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Oct 2024 15:35:05 +0800
Message-ID: <75748d86-5ed2-4310-b02c-500984e6feda@linux.alibaba.com>
Date: Wed, 23 Oct 2024 15:35:03 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
 <20241022142039.GB17410@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241022142039.GB17410@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_003509_822780_BF08CCEB 
X-CRM114-Status: GOOD (  12.54  )
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


在 2024/10/22 22:20, Christoph Hellwig 写道:
> On Tue, Oct 22, 2024 at 04:18:52PM +0300, Sagi Grimberg wrote:
>>> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
>>> +{
>>> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>>> +	bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
>>> +	/* Reservation type, bit 15:08 */
>>> +	u8 rtype = (u8)((cdw10 >> 8) & 0xff);
>>> +	/* Reservation acquire action, bit 02:00 */
>>> +	u8 acquire_act = cdw10 & 0x07;
>>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>> +	struct nvmet_pr_acquire_data *d = NULL;
>>> +	struct nvmet_pr *pr = &req->ns->pr;
>>> +	struct nvmet_pr_registrant *reg;
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +
>>> +	if (ignore_key ||
>>> +	    rtype < NVME_PR_WRITE_EXCLUSIVE ||
>>> +	    rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
>>> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>>> +	if (!d) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
>>> +	if (status)
>>> +		goto free_data;
>>> +
>>> +	status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
>>> +	mutex_lock(&pr->pr_lock);
>>> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
>>> +				lockdep_is_held(&pr->pr_lock)) {
>>> +		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
>>> +		    reg->rkey == le64_to_cpu(d->crkey)) {
>>> +			status = __nvmet_execute_pr_acquire(req, reg,
>>> +					acquire_act, rtype, d);
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!status && acquire_act == NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
>>> +		kfree(d);
>>> +		INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
>>> +		queue_work(nvmet_wq, &req->r.abort_work);
>>> +		return;
>>> +	}
>> Is there a reason why you queue this here and not inside
>> __nvmet_execute_pr_acquire
>> like before?
>>
>>> +
>>> +	mutex_unlock(&pr->pr_lock);
>> Hmm... you keep this mutex taken and release it from the work element
>> async... Not a
>> great practice...
> It's actually invalid for a mutex.  You'd need a semaphore for that.
>
> Guixin, can you test the code with lockdep enabled and see if there
> is other fallout as well?  Thanks!

You mean use semaphore to replace mutex pr_lock? If this works, I

can send a v18.

Best Regards,

Guixin Liu


