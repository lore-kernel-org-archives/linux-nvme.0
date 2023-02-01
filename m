Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3729C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58Tfi173ERs9OUw9L1zwdDlJOVbL23MEwjmuky4U9Ww=; b=xVZSd193FWkNvVg7PQRUXrbs0O
	FSBGV2MRCeRBjnXa2/BAKpFgUMqGHGFRvqX4w7iOy9ztm0JouMK3qGEKJR/7RylnP7d8YPmZXJYla
	M4G0S5UMlW/s0MWh/vHWHp961bAyMZa08wqDs17kNnTVgJ37z+HR2Xwa9MGbEZGgOmPo5R2W+8h0j
	dFDaIHuqILNyV/LHk4BtN2GhjQlh1bvhwpz36MB2RVYNUy+TTS9b3zK2buZDELwSr8neUA6//BAk+
	e9pow6TX+fkFCWBPfozNkonjcVnwfNwQfKJxPXuDnsjv8qxWNEb59jNbe5x++hvxxwkEVrW+oy2k7
	aJyTgs6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8QI-00Amlc-TU; Wed, 01 Feb 2023 08:24:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8QF-00Amjs-Gj
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 08:24:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38BD033AAB;
	Wed,  1 Feb 2023 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675239888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58Tfi173ERs9OUw9L1zwdDlJOVbL23MEwjmuky4U9Ww=;
	b=OKjqQUqwBgG/Sfpc/uoU5Sx56kE5iImydUnva6J30uSDicOFMtKGaoZ1GKlOvlHDHcSZE2
	JtujsYO9ynynYWXnREKOfy/M82G+FHIAtR/+Q+0Mu2v3ob/0ldPdX7ThftYhtarT68aXlr
	kM5tTV/ngnZ7+VNsS942uK98d/DU1bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675239888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58Tfi173ERs9OUw9L1zwdDlJOVbL23MEwjmuky4U9Ww=;
	b=0tz4F7B/BCCC7CfYdP3YddtXoEKCwEcQ2DslgT+Z+57GGWhaYQKyhyUHzIf/5wSyjg5i6S
	cpEcWJlgrBBfdCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AC7613A10;
	Wed,  1 Feb 2023 08:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JPy5BdAh2mO0RQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 01 Feb 2023 08:24:48 +0000
Message-ID: <e2a630c9-a398-d105-8b54-fa266e210e1d@suse.de>
Date: Wed, 1 Feb 2023 09:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: nvme-6.3: blktests nvme/003 null pointer for fc transport
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <jsmart2021@gmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
 <40b14fe4-7d7f-b4ee-b058-d0d39b9fa6d4@gmail.com>
 <20230201081003.a6l22z3rnl6snkds@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230201081003.a6l22z3rnl6snkds@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_002451_747614_90275B17 
X-CRM114-Status: GOOD (  19.74  )
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

On 2/1/23 09:10, Daniel Wagner wrote:
> On Tue, Jan 31, 2023 at 03:27:20PM -0800, James Smart wrote:
>> On 1/30/2023 3:15 AM, Daniel Wagner wrote:
>>> Hi,
>>>
>>> Hannes added support to blktest to enable the FC transport for it. And as result
>>> blktests is able to crash the kernel. Haven't startet to look into it yet.
>>>
>>>    run blktests nvme/003 at 2023-01-30 12:08:28
>>>    nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>    BUG: kernel NULL pointer dereference, address: 0000000000000010
>>>    #PF: supervisor read access in kernel mode
>>>    #PF: error_code(0x0000) - not-present page
>>>    PGD 0 P4D 0
>>>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>    CPU: 3 PID: 14200 Comm: nvme Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
>>>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>>>    RIP: 0010:nvme_alloc_admin_tag_set+0x38/0x120 [nvme_core]
>>
>> bingo...
>>
>> The cleanup patch "nvme-fc: use the tagset alloc/free helpers" introduced
>> it.
>>
>> See the fix patch "nvme-fc: Fix initialization order" about 10 days ago that
>> corrects it.
> 
> Good call! This is problem is gone. Now I am running into the next problem:
> 
> 
> run blktests nvme/003 at 2023-02-01 09:01:58
> nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> debugfs: Directory 'nvme0' with parent '/' already present!
> nvme0: failed to create debugfs attr
> nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
> (NULL device *): {0:0} Association created
> nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
> nvme nvme0: NVME-FC{0}: controller connect complete
> nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
> (NULL device *): {0:1} Association created
> nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
> nvme nvme1: NVME-FC{1}: controller connect complete
> nvme nvme1: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
> nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme1: rescanning namespaces.
> (NULL device *): {0:0} Association deleted
> (NULL device *): {0:0} Association freed
> (NULL device *): Disconnect LS failed: No Association
> nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
> nvme nvme1: NVME-FC{1}: transport association event: transport detected io error
> nvme nvme1: NVME-FC{1}: resetting controller
> debugfs: Directory 'nvme0' with parent '/' already present!
> nvme0: failed to create debugfs attr
> nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
> (NULL device *): {0:0} Association created
> nvmet: connect request for invalid subsystem nqn.2014-08.org.nvmexpress.discovery!
> nvme nvme0: Connect Invalid Data Parameter, subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> nvme nvme0: NVME-FC{0}: reconnect failure
> nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
> (NULL device *): {0:2} Association created
> nvmet: connect request for invalid subsystem blktests-subsystem-1!
> nvme nvme1: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> nvme nvme1: NVME-FC{1}: reset: Reconnect attempt failed (16770)
> nvme nvme1: NVME-FC{1}: reconnect failure
> nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> (NULL device *): {0:1} Association deleted
> (NULL device *): {0:1} Association freed
> (NULL device *): Disconnect LS failed: No Association
> (NULL device *): {0:0} Association deleted
> (NULL device *): {0:0} Association freed
> (NULL device *): Disconnect LS failed: No Association
> (NULL device *): {0:2} Association deleted
> (NULL device *): {0:2} Association freed
> ===========================================
> WARNING: possible recursive locking detected
> 6.2.0-rc4+ #1 Not tainted
> --------------------------------------------
> kworker/3:13/21736 is trying to acquire lock:
> ffff93fe60e251e8 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: __flush_work+0x38/0xc0
> 
> but task is already holding lock:
> ffffa693c1a4fe68 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x410
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock((work_completion)(&tport->ls_work));
>    lock((work_completion)(&tport->ls_work));
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 2 locks held by kworker/3:13/21736:
>   #0: ffff93fe9882ff48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410
>   #1: ffffa693c1a4fe68 ((work_completion)(&tport->ls_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x410
> 
> stack backtrace:
> CPU: 3 PID: 21736 Comm: kworker/3:13 Not tainted 6.2.0-rc4+ #1 c9afca57e89c2aa3234427c2cd6cd4dd2984ae8c
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Workqueue: nvmet-wq fcloop_tport_lsrqst_work [nvme_fcloop]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5a/0x80
>   validate_chain+0x1e02/0x2730
>   ? lockdep_unlock+0x51/0xc0
>   ? lockdep_unlock+0x51/0xc0
>   ? validate_chain+0x7c8/0x2730
>   ? validate_chain+0x7c8/0x2730
>   ? lock_release+0xf7/0x400
>   ? __lock_acquire+0x8f7/0xbc0
>   ? lock_is_held_type+0x8b/0x110
>   __lock_acquire+0x8f7/0xbc0
>   ? lock_is_held_type+0x8b/0x110
>   lock_acquire+0xb0/0x180
>   ? __flush_work+0x38/0xc0
>   ? lock_is_held_type+0x8b/0x110
>   __flush_work+0x57/0xc0
>   ? __flush_work+0x38/0xc0
>   ? lockdep_hardirqs_on_prepare+0x16e/0x220
>   ? _raw_spin_unlock_irqrestore+0x32/0x50
>   ? __free_pages_ok+0x289/0x4a0
>   fcloop_targetport_delete+0x15/0xa0 [nvme_fcloop 2f0f07bf6746e7b4ec6dff8d226e919dac60e0f1]
>   nvmet_fc_tgtport_put+0x132/0x190 [nvmet_fc cec46c808c67bf2a4fefe925da2828f0b3f2334a]
>   nvmet_fc_disconnect_assoc_done+0x7c/0xa0 [nvmet_fc cec46c808c67bf2a4fefe925da2828f0b3f2334a]
>   fcloop_tport_lsrqst_work+0x6c/0xa0 [nvme_fcloop 2f0f07bf6746e7b4ec6dff8d226e919dac60e0f1]
>   process_one_work+0x26a/0x410
>   worker_thread+0x21d/0x490
>   ? rcu_lock_release+0x20/0x20
>   kthread+0xe1/0x100
>   ? kthread_blkcg+0x30/0x30
>   ret_from_fork+0x1f/0x30
>   </TASK>
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port
> 
> 
> The last last to message never stop.

And this is why I wanted to have these tests :-)
In my original test I had this:

+       _remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+       _remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+       _remove_nvmet_subsystem "${subsys}"
+       _remove_nvmet_anagroup "${port1}" "${ag1}"
+       _remove_nvmet_port "${port1}"
+       _remove_nvmet_anagroup "${port2}" "${ag2}"
+       _remove_nvmet_port "${port2}"
+
+       losetup -d "$loop_dev"
+       rm "$TMPDIR/img"
+
+       # Fixme: need to wait for RCU grace period
+       sleep 5
+
+       _nvme_fcloop_del_rport "${host_wwnn1}" "${host_wwpn1}" \
+               "${remote_wwnn1}" "${remote_wwpn1}"

Problem is a subtle workqueue inversion with fcloop. I'll have to dig 
out details here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


