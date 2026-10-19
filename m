Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C16CCF2D6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tXNfQSk8w5bCsKCQiiMuDFw/Pxco8MwvKv0f7YR8YHw=; b=a0wzcsG7ZYZHYvhhqx6b+eeArX
	w9HSSlGuhk3Z3TXp6nl675JPe455qup7/yNHMsvb5Xc6K73XyTFdcz0Z8iP+LZ5TjPOtlzTVG5YYm
	anVU3vWoQUcUNBZjW5uMEU8hXuGMJYmfZW6MVrg6DtbCk16a5gu3U9QrwRm6ikOcO5vdt4x03Egtz
	BtE6SPuF/TYLH26sXrsEx5g3kBggcXZEWfpTkr+tJk4gcpvHSp9yMTacFBlSUqWq1n2WFOs/xB7to
	M6ZAlqoKGCZQCddEGabx4rslszX06NKzdPHps3deAH8egUmRyPMsCQkOHDFdefXJ7xTnBvOBq8gPo
	IsT/ggpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIilh-00000006sKy-29Qf;
	Mon, 19 Oct 2026 08:30:53 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIilf-00000006sKa-0HYC
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 08:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792398648; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tXNfQSk8w5bCsKCQiiMuDFw/Pxco8MwvKv0f7YR8YHw=;
	b=hDoA1gaHSDNQFFryk0XObdgyw890gsIeG2aja3h4wBIvRionEB5/rd/vu6+YNigeClBmiMt2Qq9ftQdMfutMj1ag1qoGWMJT/RLqV0tOqImlTckl4wqGYAvuyLE0RK/SDsSU049/HLE11uUV+nBjMen9GE92CJ1jigd33AFyAfk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XD3.1sO_1792398646;
Received: from 30.178.69.0(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD3.1sO_1792398646 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 16:30:47 +0800
Message-ID: <62db7029-2ef2-40fb-8e04-ed29e9e4a963@linux.alibaba.com>
Date: Mon, 19 Oct 2026 16:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] nvmet: implement the FDP feature
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-8-kanie@linux.alibaba.com>
 <sashiko-outbox-176587@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-176587@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_013051_277782_810D978D 
X-CRM114-Status: GOOD (  24.04  )
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



在 2026/10/19 11:45, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] nvmet: missing RCU protection and live check in nvmet_fdp_lookup_ns()
> - [Medium] nvmet: unconditional NVME_FEAT_FDP in nvmet_execute_get_log_page_features()
> --
>
> commit 121b81584ccf85602ba9ff94dfc9a38064c55462
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: implement the FDP feature
>
> This commit implements Set Features and Get Features for the Flexible Data
> Placement feature (FID 1Dh) in nvmet, using the Endurance Group Identifier
> to look up the corresponding namespace. It also advertises NVME_FEAT_FDP in
> the Supported Features log page.
>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index b293ce418e2c3..93fb9c3d500a3 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -600,6 +600,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
>>  		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
>>  	features->fis[NVME_FEAT_RESV_MASK] =
>>  		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
>> +	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP))
>> +		features->fis[NVME_FEAT_FDP] =
>> +			cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_EGSCPE);
> [Severity: Medium]
> Should nvmet_execute_get_log_page_features() check
> nvmet_fdp_subsys_configured(nvmet_req_subsys(req)) here instead of
> IS_ENABLED(CONFIG_NVME_TARGET_FDP)?
>
> The commit message notes that this feature is reported in the Features log
> page under the same per-subsystem condition as the FDPS bit. In
> nvmet_execute_identify_ctrl(), NVME_CTRL_ATTR_FDPS is gated on:
>
> 	if (nvmet_fdp_subsys_configured(ctrl->subsys))
> 		ctratt |= NVME_CTRL_ATTR_FDPS;
>
> Checking only IS_ENABLED(CONFIG_NVME_TARGET_FDP) causes the log page to
> advertise NVME_FEAT_FDP on subsystems that have no FDP-enabled namespaces
> and report FDPS as 0.
Yes, fixed in v2.
>>  	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
>>  	kfree(features);
> [ ... ]
>
>> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
>> index 17949e3665293..0327970a9cb9d 100644
>> --- a/drivers/nvme/target/fdp.c
>> +++ b/drivers/nvme/target/fdp.c
> [ ... ]
>
>> @@ -83,3 +87,76 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
>>  	ns->fdp.backend_q = NULL;
>>  	ns->fdp.backend_ctrl = NULL;
>>  }
>> +
>> +
>> +/*
>> + * Each namespace is its own endurance group, so the Endurance Group
>> + * Identifier in Command Dword 11, and in the Log Specific Identifier
>> + * of the FDP log pages, directly names the namespace.  Returns the
>> + * namespace with a reference held.
>> + */
>> +static struct nvmet_ns *nvmet_fdp_lookup_ns(struct nvmet_req *req, u32 endgid)
>> +{
>> +	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
>> +	struct nvmet_ns *ns;
>> +
>> +	ns = xa_load(&subsys->namespaces, endgid);
>> +	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
>> +		return NULL;
>> +
>> +	if (!percpu_ref_tryget_live(&ns->ref))
>> +		return NULL;
>> +
>> +	return ns;
>> +}
> [Severity: Critical]
> Can nvmet_fdp_lookup_ns() cause a use-after-free on struct nvmet_ns or
> ns->ref when a Set Features or Get Features command for NVME_FEAT_FDP races
> with namespace disable or removal via nvmet_ns_disable() or
> nvmet_ns_free()?
>
> In drivers/nvme/target/core.c, nvmet_ns_disable() tears down the namespace
> before clearing ns->enabled:
>
> 	if (!test_and_clear_bit(NVMET_NS_IO_LIVE, &ns->flags))
> 		return;
> 	...
> 	percpu_ref_kill(&ns->ref);
> 	synchronize_rcu();
> 	wait_for_completion(&ns->disable_done);
> 	percpu_ref_exit(&ns->ref);
>
> 	if (ns->pr.enable)
> 		nvmet_pr_exit_ns(ns);
>
> 	nvmet_fdp_exit_ns(ns);
>
> 	mutex_lock(&subsys->lock);
> 	nvmet_ns_changed(subsys, ns->nsid);
> 	nvmet_ns_dev_disable(ns);
> 	ns->enabled = false;
> 	mutex_unlock(&subsys->lock);
>
> And nvmet_ns_free() then erases and frees ns without an additional RCU
> grace period:
>
> 	nvmet_ns_disable(ns);
>
> 	mutex_lock(&subsys->lock);
>
> 	xa_erase(&subsys->namespaces, ns->nsid);
> 	...
> 	kfree(ns->device_path);
> 	kfree(ns);
>
> Because xa_load() releases its internal RCU read lock before returning,
> nvmet_fdp_lookup_ns() holds an unpinned pointer to ns outside of an
> rcu_read_lock() critical section. A concurrent nvmet_ns_free() is not
> blocked by synchronize_rcu() in nvmet_ns_disable() and can free ns before
> nvmet_fdp_lookup_ns() dereferences ns->enabled, ns->fdp.enable, or
> &ns->ref.
>
> Additionally, because ns->enabled remains true until after
> percpu_ref_exit(&ns->ref) has freed the per-CPU counter data, checking
> ns->enabled instead of test_bit(NVMET_NS_IO_LIVE, &ns->flags) allows
> nvmet_fdp_lookup_ns() to call percpu_ref_tryget_live(&ns->ref) concurrently
> with or after percpu_ref_exit(&ns->ref).
>
> Should nvmet_fdp_lookup_ns() wrap the lookup and reference acquisition in
> rcu_read_lock() / rcu_read_unlock(), check test_bit(NVMET_NS_IO_LIVE,
> &ns->flags), and use percpu_ref_tryget_live_rcu(&ns->ref) in the same way
> as nvmet_req_find_ns()?
Sashiko is right, fixed in v2.
> [ ... ]
>


