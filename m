Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E62C3065C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=se6jfb/v1et6PcMuRB/KBSPvpwjbJZaQl+6VD80FxM8=; b=jDneoiNs7dTc/JgIJMLZQLTres
	WpaETsHYZ5g5FIgDULXygXUeHyFdxK4cxKrvGQ484KocA5rtbJCke9/0qgCA1BomZAX8icx7f6Ehr
	A4+edE1y1dA30y6TWoOA1b1aPHQXqDmqI9jLnpsjDiy+Tu998Up1aekEIcHX5VbdQ/olaNpEVfjbA
	kF0MLsCIv+8OuU5QoIpmy2KPLz9RRlF1ZhBaPLM90yumDxyAEGfJdZkewtR3uXB1mdfmujotbTF5T
	c01eJCBTuKODg5pZ3qiiR6I51b31NbvkHIdGsjo8P17q7kyEo19BKu+Bb/QjYTeAiQ8GLNVpXgu9w
	IV233+Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOjL5-00000007ntG-3TpN;
	Tue, 02 Jul 2024 19:38:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOjL1-00000007nsN-3L7B
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 19:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719949129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=se6jfb/v1et6PcMuRB/KBSPvpwjbJZaQl+6VD80FxM8=;
	b=JCDgolB6jtzPMPzYbB1IIrVJo49KVQRvHtSV6/j1jo8leZGWvXUpvnmuJMrXYdnLcwJx5M
	GMiQkRepSkmuwTVOWDCU9Bk8jdvTgZgEjX6uG/JEhFnSlwpMSBhTSlEhbvUll/gMEHo82e
	POZ/UA3c0t1RKf+KPIWUoK1fmix4dxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-0IaLz6piPfC7IKM31SLcJQ-1; Tue,
 02 Jul 2024 15:38:45 -0400
X-MC-Unique: 0IaLz6piPfC7IKM31SLcJQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A47131954B24;
	Tue,  2 Jul 2024 19:38:43 +0000 (UTC)
Received: from [10.22.8.41] (unknown [10.22.8.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE9CF3000221;
	Tue,  2 Jul 2024 19:38:41 +0000 (UTC)
Message-ID: <7c0621e9-3af3-4ba9-ad96-3f322adc5a57@redhat.com>
Date: Tue, 2 Jul 2024 15:38:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests nvme/052 failure
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Ewan Milne <emilne@redhat.com>, Randy Jennings <randyj@purestorage.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <39cc7376-1c98-4f1d-aca3-e155a26535d5@nvidia.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <39cc7376-1c98-4f1d-aca3-e155a26535d5@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_123851_938877_B5382F26 
X-CRM114-Status: GOOD (  11.92  )
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

Looks like I didn't test my queue-depth patches with blktests.

I'll pull the new nvme-6.11 branch and try running this test now.

/John

On 6/27/24 01:24, Chaitanya Kulkarni wrote:
> Hi,
> 
> blktests/nvme/052 is failing everytime on nvme-6.11, HEAD :-
> 
> commit 62eaa15c6aeef5011d3d41b69b63e02cf280324c (origin/nvme-6.11)
> Author: Thomas Song <tsong@purestorage.com>
> Date:   Tue Jun 25 08:26:05 2024 -0400
> 
>       nvme-multipath: implement "queue-depth" iopolicy
> 
> Below is the log.
> 
> -ck
> 
> [   36.481199] BUG: unable to handle page fault for address:
> 00000031004600c1
> [   36.482213] #PF: supervisor read access in kernel mode
> [   36.482730] #PF: error_code(0x0000) - not-present page
> [   36.483254] PGD 0 P4D 0
> [   36.483533] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   36.484045] CPU: 42 PID: 1122 Comm: kworker/u235:3 Tainted:
> G           O     N 6.10.0-rc3nvme+ #69
> [   36.484933] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   36.486024] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [   36.486803] RIP: 0010:lockref_get+0x4/0x60
> [   36.487233] Code: bc 9f ff b8 01 00 00 00 eb ad e8 d7 27 72 00 0f 1f
> 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
> fa <48> 8b 07 85 c0 75 33 48 89 c2 be 64 00 00 00 48 89 d1 89 d2 48 c1
> [   36.488619] RSP: 0018:ffffc900023cbcd0 EFLAGS: 00010202
> [   36.488887] RAX: 0000000000000000 RBX: ffff888104a52438 RCX:
> 0000000000000002
> [   36.489281] RDX: 0000000000037abc RSI: ffffffff8159fa30 RDI:
> 00000031004600c1
> [   36.489671] RBP: ffffc900023cbd20 R08: 00000031004600c1 R09:
> ffff88981fcb2330
> [   36.490070] R10: 0000000000000001 R11: fffffffffff21a29 R12:
> ffff888104a523c8
> [   36.490478] R13: ffff888104a52448 R14: 0000000000000001 R15:
> ffff888104a52438
> [   36.490861] FS:  0000000000000000(0000) GS:ffff88981fc80000(0000)
> knlGS:0000000000000000
> [   36.491286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.491592] CR2: 00000031004600c1 CR3: 0000000002a1c000 CR4:
> 0000000000350ef0
> [   36.492004] DR0: ffffffff837ce5c8 DR1: ffffffff837ce5c9 DR2:
> ffffffff837ce5ca
> [   36.492405] DR3: ffffffff837ce5cb DR6: 00000000ffff0ff0 DR7:
> 0000000000000600
> [   36.493359] Call Trace:
> [   36.493515]  <TASK>
> [   36.493639]  ? __die+0x24/0x70
> [   36.493831]  ? page_fault_oops+0x158/0x4e0
> [   36.494061]  ? __schedule+0x354/0xb00
> [   36.494262]  ? exc_page_fault+0x77/0x170
> [   36.494476]  ? asm_exc_page_fault+0x26/0x30
> [   36.494710]  ? __pfx_remove_one+0x10/0x10
> [   36.494979]  ? lockref_get+0x4/0x60
> [   36.495172]  simple_recursive_removal+0x37/0x2d0
> [   36.495448]  ? __pfx_remove_one+0x10/0x10
> [   36.495698]  debugfs_remove+0x44/0x70
> [   36.495910]  nvme_ns_remove+0x3a/0x200 [nvme_core]
> [   36.496192]  nvme_remove_invalid_namespaces+0xfd/0x130 [nvme_core]
> [   36.496566]  nvme_scan_work+0x2bc/0x5e0 [nvme_core]
> [   36.496837]  ? ttwu_do_activate+0x5d/0x1e0
> [   36.497062]  process_one_work+0x158/0x360
> [   36.497295]  worker_thread+0x2fd/0x410
> [   36.497527]  ? __pfx_worker_thread+0x10/0x10
> [   36.497766]  kthread+0xd0/0x100
> [   36.497956]  ? __pfx_kthread+0x10/0x10
> [   36.498188]  ret_from_fork+0x31/0x50
> [   36.498417]  ? __pfx_kthread+0x10/0x10
> [   36.498628]  ret_from_fork_asm+0x1a/0x30
> [   36.498839]  </TASK>
> [   36.498975] Modules linked in: loop nvme_loop(O) nvmet(O)
> nvme_keyring nvme_fabrics(O) nvme(O) nvme_core(O) nvme_auth
> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore
> bridge stp llc ip6table_mangle ip6table_raw ip6table_security
> iptable_mangle iptable_raw iptable_security ip_set rfkill nf_tables
> nfnetlink ip6table_filter ip6_tables iptable_filter tun sunrpc xfs
> intel_rapl_msr intel_rapl_common ppdev kvm_amd ccp iTCO_wdt
> iTCO_vendor_support parport_pc kvm i2c_i801 joydev parport pcspkr
> i2c_smbus lpc_ich ip_tables crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel bochs sha512_ssse3 drm_vram_helper drm_kms_helper
> drm_ttm_helper sha256_ssse3 virtio_net ttm sha1_ssse3 net_failover
> serio_raw failover drm dimlib qemu_fw_cfg ipmi_devintf ipmi_msghandler
> fuse [last unloaded: nvme_auth]
> 
> Entering kdb (current=0xffff88817b1a5100, pid 1122) on processor 42
> Oops: (null)
> due to oops @ 0xffffffff817aae44
> CPU: 42 PID: 1122 Comm: kworker/u235:3 Tainted: G           O N
> 6.10.0-rc3nvme+ #69
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Workqueue: nvme-wq nvme_scan_work [nvme_core]
> RIP: 0010:lockref_get+0x4/0x60
> Code: bc 9f ff b8 01 00 00 00 eb ad e8 d7 27 72 00 0f 1f 80 00 00 00 00
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b 07
> 85 c0 75 33 48 89 c2 be 64 00 00 00 48 89 d1 89 d2 48 c1
> RSP: 0018:ffffc900023cbcd0 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff888104a52438 RCX: 0000000000000002
> RDX: 0000000000037abc RSI: ffffffff8159fa30 RDI: 00000031004600c1
> RBP: ffffc900023cbd20 R08: 00000031004600c1 R09: ffff88981fcb2330
> R10: 0000000000000001 R11: fffffffffff21a29 R12: ffff888104a523c8
> R13: ffff888104a52448 R14: 0000000000000001 R15: ffff888104a52438
> FS:  0000000000000000(0000) GS:ffff88981fc80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000031004600c1 CR3: 0000000002a1c000 CR4: 0000000000350ef0
> DR0: ffffffff837ce5c8 DR1: ffffffff837ce5c9 DR2: ffffffff837ce5ca
> DR3: ffffffff837ce5cb DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>    <TASK>
>    ? kdb_main_loop+0x31f/0x960
>    ? io_napi_sqpoll_busy_poll+0xf0/0x120
>    ? kdb_stub+0x1ae/0x3f0
>    ? kgdb_cpu_enter+0x2b3/0x610
>    ? kgdb_handle_exception+0xbd/0x100
>    ? __kgdb_notify+0x30/0xd0
>    ? kgdb_notify+0x21/0x40
>    ? notifier_call_chain+0x5b/0xd0
>    ? notify_die+0x53/0x80
>    ? __die+0x51/0x70
>    ? page_fault_oops+0x158/0x4e0
>    ? __schedule+0x354/0xb00
>    ? exc_page_fault+0x77/0x170
>    ? asm_exc_page_fault+0x26/0x30
>    ? __pfx_remove_one+0x10/0x10
>    ? lockref_get+0x4/0x60
>    simple_recursive_removal+0x37/0x2d0
>    ? __pfx_remove_one+0x10/0x10
>    debugfs_remove+0x44/0x70
>    nvme_ns_remove+0x3a/0x200 [nvme_core]
>    nvme_remove_invalid_namespaces+0xfd/0x130 [nvme_core]
>    nvme_scan_work+0x2bc/0x5e0 [nvme_core]
>    ? ttwu_do_activate+0x5d/0x1e0
>    process_one_work+0x158/0x360
>    worker_thread+0x2fd/0x410
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xd0/0x100
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x31/0x50
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> 


