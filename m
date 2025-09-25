Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953CACAC5B1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CBeJyWAi6NKZMG5/2/u9swMHkQYnP4cs2x5hU+brmE=; b=P2EYtUWF+xpRlkpf8FBezZj1Vm
	yWR2KYXyPINu4jgFe8fLMVxqh7mlcebBz3V/IDoO2+zV00oEoHpBcEwwNahAHg2WW3NwIMkpzlQNH
	cA6zTZanGKJhTW/JIZ5mkOcVCKvg2uzxZURsBpG3LtwdDL/gYTdfzV3+hCAC66S1rVlQA+kKQ0jAn
	wJNi+3XPtL82YGpHUTMuM836cIpjHynTl3dww65/FzJQqq7cgoT0tkHSl53HYfoH0h+jy/xUGPvKA
	qaf4zYxQNjv19OpVShNHsyjjkwRCEbQwHoHV4sKxNDa79PAzBWZJidanpPFcfprZ0/eJebuhgjsbT
	rNodS63g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oQp-0000000Awcg-40EI;
	Thu, 25 Sep 2025 16:02:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oQn-0000000Awav-0CvP
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 16:02:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F87A6C347;
	Thu, 25 Sep 2025 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758816171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CBeJyWAi6NKZMG5/2/u9swMHkQYnP4cs2x5hU+brmE=;
	b=bI7h+GuYRA4hQR8z3fw4gLD7oAXd05Wnpb5TFlGQ4wGdB1HAEU6Czr+8wYExltMNvTOur2
	YYnlmBRVRNse4yMBkOMIJRpwnbs57Xb0pN2H9xmhd+7wO/vB6yKUC+Rc574aqy+nU4zvAl
	C7eyPAB5Kh9DwqSFvv7gS4KZk9nQulM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758816171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CBeJyWAi6NKZMG5/2/u9swMHkQYnP4cs2x5hU+brmE=;
	b=O/ZtkHDkmWOXtOapyiSIFssGNWtlYAgAV3RzHDCHDCgIg02p8RLyEMXWIeQ8VUYycHQBLv
	VWwUxqW7X1XRFZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758816170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CBeJyWAi6NKZMG5/2/u9swMHkQYnP4cs2x5hU+brmE=;
	b=rlS2ksTMkW/LHbNxBcheJnYj+MOO4XQq5vd9pdqaYNfC5T8yQWMLIsOPpIV88mD0gmb5sX
	ZVFDyorHUdoA3XW/7mbJvTrcHqs2z8UTopgSZPrcIh6sYfdPZFtookUfUs3Gb1ffv5iPV8
	uKxiFkfch6+8LginM2G4ySfCyPfW2WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758816170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CBeJyWAi6NKZMG5/2/u9swMHkQYnP4cs2x5hU+brmE=;
	b=Jf19fYbBJXZ/yv8vmHD+U06F+y5WTOzb/qFy7DkXcOY3qID0rboRGd66Pliai75Poxq1d/
	HcsFo/1Tkkns3vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE05113869;
	Thu, 25 Sep 2025 16:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2N4aOqln1WgJXwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 25 Sep 2025 16:02:49 +0000
Date: Thu, 25 Sep 2025 18:02:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
Message-ID: <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
 <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_090253_392207_EFBC92B8 
X-CRM114-Status: GOOD (  17.79  )
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

On Thu, Sep 25, 2025 at 03:06:42PM +0300, Max Gurtovoy wrote:
> Sure, test case can stay.
> 
> for example one can:
> 
> 1. create a port/subsystem with max_qid = 20
> 2. connect from a host
> 3. destroy the subsystem/port (this will issue a reconnect/error_recovery
> flow from host)
> 4. create the same port/subsystem with max_qid = 10
> 5. reconnect attempt X will succeed and new host controller will have 10 IO
> queues - tagset should be updated as it does today.
> 
> WDYT ?

I can't remember why this approach didn't work when I added the test
case. IIRC, the fc transport was way too buggy.

 set_qid_max() {
-       local subsys_name="$1"
+       local subsysnqn="$1"
        local qid_max="$2"

-       set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-       nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
-       _nvmf_wait_for_state "${subsys_name}" "live" || return 1
+       _get_nvmet_ports "${subsysnqn}" ports
+       for port in "${ports[@]}"; do
+               _remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
+               _remove_nvmet_port "${port}"
+       done
+
+       set_nvmet_attr_qid_max "${subsysnqn}" "${qid_max}"
+
+       local p=0
+       local num_ports=1
+       while (( p < num_ports )); do
+               port="$(_create_nvmet_port)"
+               _add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+               p=$(( p + 1 ))
+       done
+
+       nvmf_check_queue_count "${subsysnqn}" "${qid_max}" || return 1
+       _nvmf_wait_for_state "${subsysnqn}" "live" || return 1

        return 0
 }


[  965.045477][ T1741] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2.
[  965.049342][   T69] nvme nvme1: reconnect: revising io queue count from 4 to 1
[  965.082787][   T69] group_mask_cpus_evenly:458 cpu_online_mask 0-7
[  965.087982][   T69] nvme nvme1: NVME-FC{0}: controller connect complete
[  965.357063][   T69] (NULL device *): {0:0} Association deleted
[  965.390686][ T1741] nvme nvme1: NVME-FC{0}: io failed due to lldd error 6
[  965.392129][   T66] nvme nvme1: NVME-FC{0}: transport association event: transport detected io error
[  965.393259][   T66] nvme nvme1: NVME-FC{0}: resetting controller
[  965.422856][   T69] (NULL device *): {0:0} Association freed
[  965.438365][ T1788] nvme nvme1: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  965.542093][ T1952] nvme nvme1: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  965.552933][   T66] nvme nvme1: long keepalive RTT (666024 ms)
[  965.554266][   T66] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  967.473132][   T69] nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport"
[  967.475251][   T64] (NULL device *): {0:0} Association created
[  967.476634][   T66] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2.
[  967.479208][   T69] nvme nvme1: reconnect: revising io queue count from 1 to 2
[  967.506681][   T69] group_mask_cpus_evenly:458 cpu_online_mask 0-7
[  967.511893][   T69] nvme nvme1: NVME-FC{0}: controller connect complete
[  967.807060][ T1985] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  967.984963][   T66] nvme nvme1: long keepalive RTT (668456 ms)
[  967.986014][   T66] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  968.029060][  T129] (NULL device *): {0:0} Association deleted
[  968.131057][  T129] (NULL device *): {0:0} Association freed
[  968.131752][  T815] (NULL device *): Disconnect LS failed: No Association


This seems to work, there is some fallouts in the test case

root@localhost:~# ./test
nvme/048 (tr=fc) (Test queue count changes on reconnect)     [failed]
    runtime  6.040s  ...  5.735s
    --- tests/nvme/048.out      2024-04-16 16:30:22.861404878 +0000
    +++ /tmp/blktests/nodev_tr_fc/nvme/048.out.bad      2025-09-25 15:56:00.620053169 +0000
    @@ -1,3 +1,8 @@
     Running nvme/048
    +rm: cannot remove '/sys/kernel/config/nvmet//ports/0/subsystems/blktests-subsystem-1': No such file or directory
    +common/nvme: line 133: echo: write error: No such file or directory
    +common/nvme: line 111: echo: write error: No such file or directory
    +rmdir: failed to remove '/sys/kernel/config/nvmet//ports/0/ana_groups/*': No such file or directory
    +rmdir: failed to remove '/sys/kernel/config/nvmet//ports/0': No such file or directory
     disconnected 1 controller(s)
    ...
    (Run 'diff -u tests/nvme/048.out /tmp/blktests/nodev_tr_fc/nvme/048.out.bad' to see the entire diff)


But the more annoying part is yet another UAF:


[ 1090.923342][   T69] (NULL device *): {0:0} Association freed
[ 1090.924134][   T69] ==================================================================
[ 1090.925072][   T69] BUG: KASAN: slab-use-after-free in process_scheduled_works+0x27a/0x1310
[ 1090.926115][   T69] Read of size 8 at addr ffff888111efa448 by task kworker/u32:6/69
[ 1090.927054][   T69]
[ 1090.927329][   T69] CPU: 5 UID: 0 PID: 69 Comm: kworker/u32:6 Not tainted 6.17.0-rc4+ #651 PREEMPT(vc
[ 1090.927333][   T69] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
[ 1090.927336][   T69] Workqueue:  0x0 (nvmet-wq)
[ 1090.927342][   T69] Call Trace:
[ 1090.927344][   T69]  <TASK>
[ 1090.927346][   T69]  dump_stack_lvl+0x60/0x80
[ 1090.927350][   T69]  print_report+0xbc/0x260
[ 1090.927353][   T69]  ? process_scheduled_works+0x27a/0x1310
[ 1090.927355][   T69]  kasan_report+0x9f/0xe0
[ 1090.927358][   T69]  ? process_scheduled_works+0x27a/0x1310
[ 1090.927361][   T69]  kasan_check_range+0x297/0x2a0
[ 1090.927363][   T69]  process_scheduled_works+0x27a/0x1310
[ 1090.927368][   T69]  ? __pfx_process_scheduled_works+0x10/0x10
[ 1090.927371][   T69]  ? lock_is_held_type+0x81/0x110
[ 1090.927374][   T69]  worker_thread+0x83a/0xca0
[ 1090.927376][   T69]  ? do_raw_spin_trylock+0xac/0x180
[ 1090.927378][   T69]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 1090.927381][   T69]  ? __kthread_parkme+0x7d/0x1a0
[ 1090.927384][   T69]  kthread+0x540/0x660
[ 1090.927385][   T69]  ? __pfx_worker_thread+0x10/0x10
[ 1090.927387][   T69]  ? __pfx_kthread+0x10/0x10
[ 1090.927389][   T69]  ? __pfx_kthread+0x10/0x10
[ 1090.927391][   T69]  ret_from_fork+0x1c9/0x3e0
[ 1090.927393][   T69]  ? __pfx_kthread+0x10/0x10
[ 1090.927395][   T69]  ret_from_fork_asm+0x1a/0x30
[ 1090.927399][   T69]  </TASK>
[ 1090.927400][   T69]
[ 1090.943292][   T69] Allocated by task 64:
[ 1090.943818][   T69]  kasan_save_track+0x2b/0x70
[ 1090.944401][   T69]  __kasan_kmalloc+0x6a/0x80
[ 1090.944907][   T69]  __kmalloc_cache_noprof+0x25d/0x410
[ 1090.945507][   T69]  nvmet_fc_alloc_target_assoc+0xd3/0xc70 [nvmet_fc]
[ 1090.946279][   T69]  nvmet_fc_handle_ls_rqst_work+0xd89/0x2b60 [nvmet_fc]
[ 1090.947078][   T69]  process_scheduled_works+0x969/0x1310
[ 1090.947689][   T69]  worker_thread+0x83a/0xca0
[ 1090.948204][   T69]  kthread+0x540/0x660
[ 1090.948668][   T69]  ret_from_fork+0x1c9/0x3e0
[ 1090.949193][   T69]  ret_from_fork_asm+0x1a/0x30
[ 1090.949744][   T69]
[ 1090.950018][   T69] Freed by task 69:
[ 1090.950493][   T69]  kasan_save_track+0x2b/0x70
[ 1090.951015][   T69]  kasan_save_free_info+0x42/0x50
[ 1090.951579][   T69]  __kasan_slab_free+0x3d/0x50
[ 1090.952116][   T69]  kfree+0x164/0x410
[ 1090.952565][   T69]  nvmet_fc_delete_assoc_work+0x70/0x240 [nvmet_fc]
[ 1090.953331][   T69]  process_scheduled_works+0x969/0x1310
[ 1090.953953][   T69]  worker_thread+0x83a/0xca0
[ 1090.954488][   T69]  kthread+0x540/0x660
[ 1090.954941][   T69]  ret_from_fork+0x1c9/0x3e0
[ 1090.955504][   T69]  ret_from_fork_asm+0x1a/0x30
[ 1090.956078][   T69]
[ 1090.956359][   T69] Last potentially related work creation:
[ 1090.956980][   T69]  kasan_save_stack+0x2b/0x50
[ 1090.957522][   T69]  kasan_record_aux_stack+0x95/0xb0
[ 1090.958158][   T69]  insert_work+0x2c/0x1f0
[ 1090.958708][   T69]  __queue_work+0x8b3/0xae0
[ 1090.959206][   T69]  queue_work_on+0xab/0xe0
[ 1090.959703][   T69]  __nvmet_fc_free_assocs+0x13b/0x1f0 [nvmet_fc]
[ 1090.960471][   T69]  nvmet_fc_remove_port+0x1c5/0x1f0 [nvmet_fc]
[ 1090.961215][   T69]  nvmet_disable_port+0xf6/0x180 [nvmet]
[ 1090.961895][   T69]  nvmet_port_subsys_drop_link+0x188/0x1b0 [nvmet]
[ 1090.962683][   T69]  configfs_unlink+0x389/0x580
[ 1090.963207][   T69]  vfs_unlink+0x284/0x4e0
[ 1090.963722][   T69]  do_unlinkat+0x2b6/0x440
[ 1090.964245][   T69]  __x64_sys_unlinkat+0x9a/0xb0
[ 1090.964808][   T69]  do_syscall_64+0xa1/0x2e0
[ 1090.965311][   T69]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1090.965978][   T69]
[ 1090.966272][   T69] Second to last potentially related work creation:
[ 1090.967076][   T69]  kasan_save_stack+0x2b/0x50
[ 1090.967593][   T69]  kasan_record_aux_stack+0x95/0xb0
[ 1090.968162][   T69]  insert_work+0x2c/0x1f0
[ 1090.968643][   T69]  __queue_work+0x8b3/0xae0
[ 1090.969142][   T69]  queue_work_on+0xab/0xe0
[ 1090.969663][   T69]  nvmet_fc_delete_ctrl+0x2a5/0x2e0 [nvmet_fc]
[ 1090.970397][   T69]  nvmet_port_del_ctrls+0xc7/0x100 [nvmet]
[ 1090.971083][   T69]  nvmet_port_subsys_drop_link+0x157/0x1b0 [nvmet]
[ 1090.971825][   T69]  configfs_unlink+0x389/0x580
[ 1090.972396][   T69]  vfs_unlink+0x284/0x4e0
[ 1090.972909][   T69]  do_unlinkat+0x2b6/0x440
[ 1090.973413][   T69]  __x64_sys_unlinkat+0x9a/0xb0
[ 1090.973943][   T69]  do_syscall_64+0xa1/0x2e0
[ 1090.974476][   T69]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1090.975129][   T69]
[ 1090.975410][   T69] The buggy address belongs to the object at ffff888111efa000
[ 1090.975410][   T69]  which belongs to the cache kmalloc-2k of size 2048
[ 1090.977002][   T69] The buggy address is located 1096 bytes inside of
[ 1090.977002][   T69]  freed 2048-byte region [ffff888111efa000, ffff888111efa800)
[ 1090.978600][   T69]
[ 1090.978864][   T69] The buggy address belongs to the physical page:
[ 1090.979596][   T69] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888111ef9000 pf8
[ 1090.980717][   T69] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 1090.981655][   T69] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[ 1090.982626][   T69] page_type: f5(slab)
[ 1090.983067][   T69] raw: 0017ffffc0000040 ffff888100042f00 dead000000000122 0000000000000000
[ 1090.984053][   T69] raw: ffff888111ef9000 0000000080080005 00000000f5000000 0000000000000000
[ 1090.985165][   T69] head: 0017ffffc0000040 ffff888100042f00 dead000000000122 0000000000000000
[ 1090.986228][   T69] head: ffff888111ef9000 0000000080080005 00000000f5000000 0000000000000000
[ 1090.987286][   T69] head: 0017ffffc0000003 ffffea000447be01 00000000ffffffff 00000000ffffffff
[ 1090.988313][   T69] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[ 1090.989355][   T69] page dumped because: kasan: bad access detected
[ 1090.990209][   T69]
[ 1090.990557][   T69] Memory state around the buggy address:
[ 1090.991315][   T69]  ffff888111efa300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1090.992367][   T69]  ffff888111efa380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1090.993417][   T69] >ffff888111efa400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1090.994529][   T69]                                               ^
[ 1090.995387][   T69]  ffff888111efa480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1090.996312][   T69]  ffff888111efa500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1090.997232][   T69] ==================================================================


In short, nvme/048 should be updated and the UAF needs to be addressed.

