Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A663CF5386
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vynqQb+LFL50YuzMaN6tqVDPeupJamqeiRXhg1Uib6E=; b=Efz5TWhOfC0S3rIbV3Yce+95ZL
	dMYY7xGOaYvRNQKiSO9xIT5A+Aw1JXKCgMb1q9BhmVsVOiu/NYwJpQCBUlvUgeMSKZSQBURrEBJNP
	NRqARDowuMgZxjuXFgPnnqd0nxaM6d3mQPcgbUSkPQCWJMAYmXs9L6+4MucBW+wHvXZ3NKm2u76Ad
	2kpn2MaazSPoMNLvlNExYMrt6VXFoR7S7NmiHvyiCoZ+OjpG+nHXPhQWg+HaO+fte/pC9b2CBKoSK
	fRB4N7q2q/qdoyrxo+M6CF0w9aCxRCqYA/DMaTjZC8+GU8yUHTmYmFXkna6Yik93pIrBoXnUuLa60
	RR2XsA6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bRo-0000000EYQv-1ru8;
	Wed, 23 Oct 2024 13:30:48 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bRk-0000000EYMX-2Smd
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 13:30:46 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 077ECE0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1729690235; bh=vynqQb+LFL50YuzMaN6tqVDPeupJamqeiRXhg1Uib6E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=fOlUBqDwAhgf4O+iWP05FxcifUAshxvvrMqZuD+uVZ1HW/IcCYMBoth3L/YFgtpRi
	 1zsPxJk+tCgtj07vwuHZuLHPmjOH27JzWiZEHJaR7HdFIX4XnNiSKu5JBJFL4QaeKz
	 Ulxg4jvFzYf8XSpQhSySAE6D5ieLFmRleZC66Bl1Lv+iUYGEFMYOoWwvPuMg9qjsLD
	 DkiUvz4PrXGWYop6ac5sjQIdOO9oUaif+3p+Vma/OuY4boPW20G7gEjRWsXb2FBshU
	 sPHqrBcFqikugB9+QX5OLuaz/hI/qEjmHlddVDIje169cOuFVirqwDd8GRoxObHuVV
	 Al3kgeVpraXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1729690235; bh=vynqQb+LFL50YuzMaN6tqVDPeupJamqeiRXhg1Uib6E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=c13CIAD0tj1xpy/tXVZvSZpxvA0bErhb9NXXSNY/vAV3YI7j4aeyI+mgHMahxWXav
	 Mb5w/U6M+/QdMiK4ZfgIy26ra3Iq2pk7dK8lsOcpO8N0F0a3ciOH597QRj+T4DSBIc
	 iQx5twnJG+t+FVQ7tVUg1dAARqmRP5yKeXP2cF1sDcpVhMAP1cN7Ke0ttcJnQepPYi
	 +udBHlY/UKtFXImR73qzOW+I/JznSuOTwmlY2EBC0IDEaIi1ZzgdvhvU7SEa/QFGgS
	 YzLyLPNxmzl5pG3ZoOytX9IwI2D5fLnWmfQey0+3GX63syFXwhHM62w1WxpOBjnPCA
	 8JNx5uFsWYZFQ==
Date: Wed, 23 Oct 2024 16:30:33 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Sagi Grimberg <sagi@grimberg.me>, <hch@lst.de>, <kch@nvidia.com>,
	<shinichiro.kawasaki@wdc.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <20241023133033.GN22571@yadro.com>
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
 <ac5147d1-59ae-4bdc-abba-f57d85972b4d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5147d1-59ae-4bdc-abba-f57d85972b4d@linux.alibaba.com>
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_063045_514997_CC2BD09D 
X-CRM114-Status: GOOD (  16.84  )
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

On Wed, Oct 23, 2024 at 03:06:10PM +0800, Guixin Liu wrote:
> 在 2024/10/22 21:18, Sagi Grimberg 写道:
> > > +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
> > > +{
> > > +    u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> > > +    bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
> > > +    /* Reservation type, bit 15:08 */
> > > +    u8 rtype = (u8)((cdw10 >> 8) & 0xff);
> > > +    /* Reservation acquire action, bit 02:00 */
> > > +    u8 acquire_act = cdw10 & 0x07;
> > > +    struct nvmet_ctrl *ctrl = req->sq->ctrl;
> > > +    struct nvmet_pr_acquire_data *d = NULL;
> > > +    struct nvmet_pr *pr = &req->ns->pr;
> > > +    struct nvmet_pr_registrant *reg;
> > > +    u16 status = NVME_SC_SUCCESS;
> > > +
> > > +    if (ignore_key ||
> > > +        rtype < NVME_PR_WRITE_EXCLUSIVE ||
> > > +        rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> > > +        status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> > > +        goto out;
> > > +    }
> > > +
> > > +    d = kmalloc(sizeof(*d), GFP_KERNEL);
> > > +    if (!d) {
> > > +        status = NVME_SC_INTERNAL;
> > > +        goto out;
> > > +    }
> > > +
> > > +    status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
> > > +    if (status)
> > > +        goto free_data;
> > > +
> > > +    status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> > > +    mutex_lock(&pr->pr_lock);
> > > +    list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> > > +                lockdep_is_held(&pr->pr_lock)) {
> > > +        if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
> > > +            reg->rkey == le64_to_cpu(d->crkey)) {
> > > +            status = __nvmet_execute_pr_acquire(req, reg,
> > > +                    acquire_act, rtype, d);
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +    if (!status && acquire_act ==
> > > NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
> > > +        kfree(d);
> > > +        INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
> > > +        queue_work(nvmet_wq, &req->r.abort_work);
> > > +        return;
> > > +    }
> > 
> > Is there a reason why you queue this here and not inside
> > __nvmet_execute_pr_acquire
> > like before?
> > 
> Because I should add a "if" branch here to prevent unlock the pr_lock
> and complete
> 
> the request. Instead of twice "if", I merge them to one, just let
> __nvmet_execute_pr_acquire()
> 
> return status.
> 
> > > +
> > > +    mutex_unlock(&pr->pr_lock);
> > 
> > Hmm... you keep this mutex taken and release it from the work element
> > async... Not a
> > great practice...
> > 
> > Any easy way you see to avoid this?
> 
> Sure, this is not a greate practice, I will think deeply and find
> another way.
>

Guixin, please, take a look whether keeping that mutex locked during
aborting is actually needed or not. Probably there is no such need -
pr_lock protects ns.pr.registrants_list which is not touched in abort
procedure.

BR,
 Dmitry

