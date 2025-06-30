Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D35C7EE39
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xL/vGJLArtaINrpiPHGlZvQpRL8URw123tDElmRJjPQ=; b=1rEO9d3Ys7uuOThgldASWSDViI
	dF6fbCcpl2ZjQb9e+YNKLjFdhAnalKoVzsks2QZODD3mHPbsKyPRCQblUmaZIMgDx5fzDhJVa/PgK
	gagYyVzAMNc7ZuD8bmIhW8wApM8YlFL8UxXUViwTIilqBJ//WyG6NZN8WNJJRzDYcPavgN1RXFjJC
	cH7zuv/wv+e/0S5sF2FWrtPuas9r7AIcJaVXPW1TFdLnprYK5vmi8Vp1iUvPvdMu7sc7HSTozNqyv
	va8ROK0fUKGy+dVXU0HGEmtT8mym/j1p+HtCuzqgx8ugIuGxWFgvIvBPNGka1VRN/A8pl4EEu+eBf
	38QfWo9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWArQ-00000001ksI-00R7;
	Mon, 30 Jun 2025 09:31:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAqa-00000001kr0-05nk
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 09:30:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00CFD21166;
	Mon, 30 Jun 2025 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751275841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL/vGJLArtaINrpiPHGlZvQpRL8URw123tDElmRJjPQ=;
	b=x/0hGoAieie8nucN654zWUlq4aE0thKtdy8lIIOIC8lu9jjQVIsJWDDTz84kVGc/S7q+WI
	STtCP38ZLN30ZrJwhPGF7CfB0wZygKDAUxeHKm10C4WpoSJBUckYERHqOYgY4nVpstowlt
	PPDXzoyAuVU5K40V2CzZXY3v/QLfA88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751275841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL/vGJLArtaINrpiPHGlZvQpRL8URw123tDElmRJjPQ=;
	b=fm1qz8sI57nhVKWRJd+ce/bTE3SreI/kf2IG4Ps7homqyC7x15pPYNHLsokK7gbCaPEegv
	xVbQvAjb1ocjPkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751275841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL/vGJLArtaINrpiPHGlZvQpRL8URw123tDElmRJjPQ=;
	b=x/0hGoAieie8nucN654zWUlq4aE0thKtdy8lIIOIC8lu9jjQVIsJWDDTz84kVGc/S7q+WI
	STtCP38ZLN30ZrJwhPGF7CfB0wZygKDAUxeHKm10C4WpoSJBUckYERHqOYgY4nVpstowlt
	PPDXzoyAuVU5K40V2CzZXY3v/QLfA88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751275841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xL/vGJLArtaINrpiPHGlZvQpRL8URw123tDElmRJjPQ=;
	b=fm1qz8sI57nhVKWRJd+ce/bTE3SreI/kf2IG4Ps7homqyC7x15pPYNHLsokK7gbCaPEegv
	xVbQvAjb1ocjPkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C992F13983;
	Mon, 30 Jun 2025 09:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eUPRMEBZYmgYEQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Jun 2025 09:30:40 +0000
Message-ID: <8f2def4e-cd13-41c0-810f-c944e7f12474@suse.de>
Date: Mon, 30 Jun 2025 11:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix suspicious RCU usage warning
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
References: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_023044_209454_1F6FCFEA 
X-CRM114-Status: GOOD (  19.04  )
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

On 6/30/25 09:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When I run the NVME over TCP test in virtme-ng, I get the following
> "suspicious RCU usage" warning in nvme_mpath_add_sysfs_link():
> 
> '''
> [    5.024557][   T44] nvmet: Created nvm controller 1 for subsystem nqn.2025-06.org.nvmexpress.mptcp for NQN nqn.2014-08.org.nvmexpress:uuid:f7f6b5e0-ff97-4894-98ac-c85309e0bc77.
> [    5.027401][  T183] nvme nvme0: creating 2 I/O queues.
> [    5.029017][  T183] nvme nvme0: mapped 2/0/0 default/read/poll queues.
> [    5.032587][  T183] nvme nvme0: new ctrl: NQN "nqn.2025-06.org.nvmexpress.mptcp", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:f7f6b5e0-ff97-4894-98ac-c85309e0bc77
> [    5.042214][   T25]
> [    5.042440][   T25] =============================
> [    5.042579][   T25] WARNING: suspicious RCU usage
> [    5.042705][   T25] 6.16.0-rc3+ #23 Not tainted
> [    5.042812][   T25] -----------------------------
> [    5.042934][   T25] drivers/nvme/host/multipath.c:1203 RCU-list traversed in non-reader section!!
> [    5.043111][   T25]
> [    5.043111][   T25] other info that might help us debug this:
> [    5.043111][   T25]
> [    5.043341][   T25]
> [    5.043341][   T25] rcu_scheduler_active = 2, debug_locks = 1
> [    5.043502][   T25] 3 locks held by kworker/u9:0/25:
> [    5.043615][   T25]  #0: ffff888008730948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x7ed/0x1350
> [    5.043830][   T25]  #1: ffffc900001afd40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0xcf3/0x1350
> [    5.044084][   T25]  #2: ffff888013ee0020 (&head->srcu){.+.+}-{0:0}, at: nvme_mpath_add_sysfs_link.part.0+0xb4/0x3a0
> [    5.044300][   T25]
> [    5.044300][   T25] stack backtrace:
> [    5.044439][   T25] CPU: 0 UID: 0 PID: 25 Comm: kworker/u9:0 Not tainted 6.16.0-rc3+ #23 PREEMPT(full)
> [    5.044441][   T25] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    5.044442][   T25] Workqueue: async async_run_entry_fn
> [    5.044445][   T25] Call Trace:
> [    5.044446][   T25]  <TASK>
> [    5.044449][   T25]  dump_stack_lvl+0x6f/0xb0
> [    5.044453][   T25]  lockdep_rcu_suspicious.cold+0x4f/0xb1
> [    5.044457][   T25]  nvme_mpath_add_sysfs_link.part.0+0x2fb/0x3a0
> [    5.044459][   T25]  ? queue_work_on+0x90/0xf0
> [    5.044461][   T25]  ? lockdep_hardirqs_on+0x78/0x110
> [    5.044466][   T25]  nvme_mpath_set_live+0x1e9/0x4f0
> [    5.044470][   T25]  nvme_mpath_add_disk+0x240/0x2f0
> [    5.044472][   T25]  ? __pfx_nvme_mpath_add_disk+0x10/0x10
> [    5.044475][   T25]  ? add_disk_fwnode+0x361/0x580
> [    5.044480][   T25]  nvme_alloc_ns+0x81c/0x17c0
> [    5.044483][   T25]  ? kasan_quarantine_put+0x104/0x240
> [    5.044487][   T25]  ? __pfx_nvme_alloc_ns+0x10/0x10
> [    5.044495][   T25]  ? __pfx_nvme_find_get_ns+0x10/0x10
> [    5.044496][   T25]  ? rcu_read_lock_any_held+0x45/0xa0
> [    5.044498][   T25]  ? validate_chain+0x232/0x4f0
> [    5.044503][   T25]  nvme_scan_ns+0x4c8/0x810
> [    5.044506][   T25]  ? __pfx_nvme_scan_ns+0x10/0x10
> [    5.044508][   T25]  ? find_held_lock+0x2b/0x80
> [    5.044512][   T25]  ? ktime_get+0x16d/0x220
> [    5.044517][   T25]  ? kvm_clock_get_cycles+0x18/0x30
> [    5.044520][   T25]  ? __pfx_nvme_scan_ns_async+0x10/0x10
> [    5.044522][   T25]  async_run_entry_fn+0x97/0x560
> [    5.044523][   T25]  ? rcu_is_watching+0x12/0xc0
> [    5.044526][   T25]  process_one_work+0xd3c/0x1350
> [    5.044532][   T25]  ? __pfx_process_one_work+0x10/0x10
> [    5.044536][   T25]  ? assign_work+0x16c/0x240
> [    5.044539][   T25]  worker_thread+0x4da/0xd50
> [    5.044545][   T25]  ? __pfx_worker_thread+0x10/0x10
> [    5.044546][   T25]  kthread+0x356/0x5c0
> [    5.044548][   T25]  ? __pfx_kthread+0x10/0x10
> [    5.044549][   T25]  ? ret_from_fork+0x1b/0x2e0
> [    5.044552][   T25]  ? __lock_release.isra.0+0x5d/0x180
> [    5.044553][   T25]  ? ret_from_fork+0x1b/0x2e0
> [    5.044555][   T25]  ? rcu_is_watching+0x12/0xc0
> [    5.044557][   T25]  ? __pfx_kthread+0x10/0x10
> [    5.044559][   T25]  ret_from_fork+0x218/0x2e0
> [    5.044561][   T25]  ? __pfx_kthread+0x10/0x10
> [    5.044562][   T25]  ret_from_fork_asm+0x1a/0x30
> [    5.044570][   T25]  </TASK>
> '''
> 
> This patch uses sleepable RCU version of helper list_for_each_entry_srcu()
> instead of list_for_each_entry_rcu() to fix it.
> 
> Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/multipath.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e040e467f9fa..5e11b0fdf250 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1200,7 +1200,8 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
>   	 */
>   	srcu_idx = srcu_read_lock(&head->srcu);
>   
> -	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +	list_for_each_entry_srcu(ns, &head->list, siblings,
> +				 srcu_read_lock_held(&head->srcu)) {
>   		/*
>   		 * Ensure that ns path disk node is already added otherwise we
>   		 * may get invalid kobj name for target

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

