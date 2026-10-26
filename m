Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723C606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eSvkZ1x8;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FzU4VnzK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kZdzXgxqnZUDvgMXf+kiOm1fRbjDSnKoY5uKh+Y1VmM=; b=eSvkZ1x8av7NvX
	DAF0i1qSlGwtVcwhBOTD29ADjUSCMw/T3dUm5IjbxXbCi5LDd11HP4stg1GQhp6lmUi6sm0NOmptL
	Eg28O9fRzhaaI+PmISX/ioB1FLZASvnRLcVWiPyhkGNa/CwZgpCbGlq/n0U4HFGkEBgA/f9M7n8ZS
	urGMIzrny8cdMGIe89+IyQLGPyIciyM0Xj4F2A2zjYE/s/z9Lf8+LcwXkn0MfnUJjmzfP8KzZZf3g
	NYUiZOz2lRcINz+RxpkfT7JJcGYlzaFnXZpxwvnlNeunA00AD2YM8AQJ2Mp4/xWIh7wl1aGit9/z0
	+R5PHnPliL4qlOjYYAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLADk-00000001bNr-2dFa;
	Mon, 26 Oct 2026 02:13:56 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLADh-00000001bNT-3E5P
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 02:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792980830; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kZdzXgxqnZUDvgMXf+kiOm1fRbjDSnKoY5uKh+Y1VmM=;
	b=FzU4VnzK7lDZtV/ywI1yv87YVixav0DxHvpUtgsC55b4A8G57JUmfJT716XWZpBz425eSa5yt9bKkAo9tRUL+kGxiVXwqr45fV9pz9JNpILw96yGfEiSHVJBr7cXOT71Ro8WrenxYBsy+1ooUdXdR+RwnQWAGq98XqniDLNHVQw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XDRRzTU_1792980824;
Received: from 30.178.69.120(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDRRzTU_1792980824 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 10:13:45 +0800
Message-ID: <0da017d8-0ee2-4104-a864-3377f9c8e1cb@linux.alibaba.com>
Date: Mon, 26 Oct 2026 10:13:44 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] nvmet: implement the FDP feature
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
 <20261023080251.2606443-8-kanie@linux.alibaba.com>
 <sashiko-outbox-182513@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-182513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_191354_154115_5E9682EE 
X-CRM114-Status: GOOD (  23.72  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/23 16:26, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] nvmet: fdp: nvmet_fdp_lookup_ns() checks ns->enabled instead of NVMET_NS_IO_LIVE
> - [Medium] nvmet: nvmet_get_feat_fdp() fails on non-FDP namespaces in mixed subsystems
> --
>
> commit 306dfd499967efa07a30c35673d8c81562928443
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: implement the FDP feature
>
> This commit implements Set Features and Get Features for the Flexible Data
> Placement feature (FID 1Dh) and advertises it in the Supported Features log
> page when FDP is configured on the subsystem.
>
>> diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
>> index 17949e3665293..5008294984885 100644
>> --- a/drivers/nvme/target/fdp.c
>> +++ b/drivers/nvme/target/fdp.c
> [ ... ]
>
>> @@ -83,3 +87,82 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
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
>> +	rcu_read_lock();
>> +	ns = xa_load(&subsys->namespaces, endgid);
>> +	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
>> +		goto out_unlock;
>> +
>> +	if (!percpu_ref_tryget_live(&ns->ref))
>> +		goto out_unlock;
> [Severity: High]
> Can checking ns->enabled instead of test_bit(NVMET_NS_IO_LIVE, &ns->flags)
> here race with nvmet_ns_disable() and nvmet_ns_enable()?
>
> After commits 42b0f5196dc2 ("nvmet: defer setting ns->enabled to false in
> nvmet_ns_disable()") and 3fdd281e0a04 ("nvmet: don't allow I/O admission
> after percpu ns reference is killed"), nvmet_ns_disable() clears
> NVMET_NS_IO_LIVE and tears down ns->ref before setting ns->enabled to false:
>
> drivers/nvme/target/core.c:nvmet_ns_disable() {
> 	if (!test_and_clear_bit(NVMET_NS_IO_LIVE, &ns->flags))
> 		return;
> 	...
> 	percpu_ref_kill(&ns->ref);
> 	synchronize_rcu();
> 	wait_for_completion(&ns->disable_done);
> 	percpu_ref_exit(&ns->ref);
> 	...
> 	mutex_lock(&subsys->lock);
> 	nvmet_ns_changed(subsys, ns->nsid);
> 	nvmet_ns_dev_disable(ns);
> 	ns->enabled = false;
> 	mutex_unlock(&subsys->lock);
> }
>
> Because ns->enabled remains true across percpu_ref_kill(&ns->ref),
> synchronize_rcu(), and percpu_ref_exit(&ns->ref), a concurrent
> nvmet_set_feat_fdp() or nvmet_get_feat_fdp() calling nvmet_fdp_lookup_ns()
> can still observe ns->enabled == true and call percpu_ref_tryget_live(&ns->ref)
> while or after percpu_ref_exit(&ns->ref) frees the per-CPU counter.
>
> Similarly, in nvmet_ns_enable(), ns->enabled = true is a plain store with no
> release barrier after percpu_ref_init(&ns->ref, ...), whereas NVMET_NS_IO_LIVE
> is set after xa_set_mark():
>
> drivers/nvme/target/core.c:nvmet_ns_enable() {
> 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL);
> 	if (ret)
> 		goto out_fdp_exit;
>
> 	nvmet_ns_changed(subsys, ns->nsid);
> 	ns->enabled = true;
> 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
> 	nvmet_debugfs_ns_setup(ns);
> 	set_bit(NVMET_NS_IO_LIVE, &ns->flags);
> }
>
> Should nvmet_fdp_lookup_ns() check test_bit(NVMET_NS_IO_LIVE, &ns->flags) and
> use percpu_ref_tryget_live_rcu(&ns->ref), matching nvmet_req_find_ns()?
Sashiko is right, changed in v3.
>> +
>> +	rcu_read_unlock();
>> +	return ns;
>> +
>> +out_unlock:
>> +	rcu_read_unlock();
>> +	return NULL;
>> +}
> [ ... ]
>
>> +u16 nvmet_get_feat_fdp(struct nvmet_req *req)
>> +{
>> +	struct nvmet_ns *ns;
>> +
>> +	ns = nvmet_fdp_lookup_ns(req,
>> +				 le32_to_cpu(req->cmd->features.dword11));
>> +	if (!ns)
>> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> [Severity: Medium]
> What happens in a subsystem that contains both FDP-enabled and non-FDP
> namespaces?
>
> When at least one namespace in the subsystem has FDP enabled,
> nvmet_fdp_subsys_configured() returns true, so the controller advertises
> NVME_CTRL_ATTR_FDPS in ctratt and NVME_FEAT_FDP in the Supported Features log
> page. Every enabled namespace is exposed as its own endurance group
> (endgid = nsid).
>
> When the Linux NVMe host scans namespaces on a controller with
> NVME_CTRL_ATTR_FDPS set, nvme_alloc_ns_head() -> nvme_query_fdp_info() issues
> Get Features (NVME_FEAT_FDP) for each namespace's endgid and checks whether
> FDPCFG_FDPE is set in the result:
>
> drivers/nvme/host/core.c:nvme_query_fdp_info() {
> 	ret = nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
> 				&fdp);
> 	if (ret) {
> 		dev_warn(ctrl->device, "FDP get feature status:0x%x\n", ret);
> 		return ret;
> 	}
>
> 	if (!(fdp.flags & FDPCFG_FDPE))
> 		return 0;
> }
>
> Because nvmet_get_feat_fdp() uses nvmet_fdp_lookup_ns(), which rejects
> namespaces where !nvmet_fdp_enabled(ns), won't Get Features fail with
> NVME_SC_INVALID_FIELD | NVME_STATUS_DNR on valid non-FDP namespaces instead
> of succeeding with result 0 (FDPE cleared) when nvmet_fdp_subsys_configured()
> is true?
Sashiko is right, changed in v3.
>


