Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702E2CDB47C
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 03:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBvnVmPnUiQfp6vv7BT9mspvaKrN6O97Y9PD5JsXnEY=; b=yVXhY6DGShHkzWPkQ2vhRlRniw
	75qfapWX3waZAO0df8xyQXbC+4ngpQlZKhIzQkkQ7MdoSdCtbSPN/kZzcjZ/1f1XomuXQD7DDcRrK
	jD0cvMtnjcl+j8MFhCbETrWe5yX90DhRLAYjwDOwDAnz0/Lc052C5evpLu/BAD9IfZ2O7PAo71U2h
	Hl1TSYaMIGXf15PDaJ+rTBeVRXzxlvmLtO7X+y42p4gP+FyrnUQFbZEogoL3d2NBq7/qLW23H2SkE
	qLLoILy6IZUC3agRZp38n433ZM92o2KyumYQX48HSnMIt9NyaGeusVovjS9zNRgZogZwj6DE+YjRg
	dF3Z05Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK7PB-0000000DRR0-0CWC;
	Sat, 15 Nov 2025 03:56:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK7P9-0000000DRQY-0Smo
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 03:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763179009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBvnVmPnUiQfp6vv7BT9mspvaKrN6O97Y9PD5JsXnEY=;
	b=cmEtNdn8Sb/2fJVMc74IBftuDnCLyoTBRH/jjWrdJi1MnoDgjxl7czIcF5SSYhe5Nhsl1H
	mpZX3BsfclImeJZBUE282jS69z0nt+eGXlh5oXieYrrI/AbdjxrhmDiUAXIDK4Jo/Z74jk
	OQp1Xv/IXHtqpJX6tKvVJrKSJtqNfYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-hSYa1aYtNw2RN2k8JBG0aQ-1; Fri,
 14 Nov 2025 22:56:43 -0500
X-MC-Unique: hSYa1aYtNw2RN2k8JBG0aQ-1
X-Mimecast-MFC-AGG-ID: hSYa1aYtNw2RN2k8JBG0aQ_1763179002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC1741800451;
	Sat, 15 Nov 2025 03:56:41 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB90019560B9;
	Sat, 15 Nov 2025 03:56:40 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id 39DCEC3FD9; Fri, 14 Nov 2025 22:56:40 -0500 (EST)
Date: Fri, 14 Nov 2025 22:56:40 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <1529dc0e-bc1f-4672-98d8-f9ccfe5c1fb7@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ex7kc9D9UqpycpZ_5-eJ0hTkeDlNrrtJQXZbRByLQYg_1763179002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_195651_247641_E2AAECB4 
X-CRM114-Status: GOOD (  13.36  )
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

Hi Ewan,
On Fri, Nov 14, 2025 at 12:47:14PM -0500, Ewan Milne wrote:
> Could you maybe add WARN_ON(!list_empty(&rport->ls_rcv_list)); so we'll
> find out?

reproduced twice with just the warning, no warning and interestingly
both had the same variation with workqueue hitting a list corruption:

	[ 4326.096413] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
	[ 4326.097073] nvme nvme1: NVME-FC{1}: controller connect complete
	[ 4326.097078] nvme nvme1: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
	[ 4326.097570] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
	[ 4326.110785] list_del corruption, 00000000f88351f8->next is NULL
	[ 4326.110813] ------------[ cut here ]------------
	[ 4326.110814] kernel BUG at lib/list_debug.c:52!
	[ 4326.110893] monitor event: 0040 ilc:2 [#1]SMP
	[ 4326.110899] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc nvme_fabrics nvme nvme_core nvme_keyring nvme_auth sunrpc rfkill virtio_gpu virtio_dma_buf drm_client_lib drm_shmem_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_kms_helper fb virtio_net virtio_input net_failover failover vfio_ccw mdev vfio_iommu_type1 vfio iommufd drm fuse drm_panel_orientation_quirks font loop i2c_core nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng des_s390 libdes sha3_512_s390 sha3_256_s390 virtio_blk sha_common dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390 [last unloaded: nvmet]
	[ 4326.110958] CPU: 0 UID: 0 PID: 164768 Comm: kworker/u9:5 Kdump: loaded Not tainted 6.18.0-0.rc0.53c18dc078bb.1.RHEL100912.el10.s390x #1 NONE
	[ 4326.110962] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
	[ 4326.110964] Workqueue: \x98 0x0 (nvmet-wq)
	[ 4326.110980] Krnl PSW : 0404e00180000000 000001e1297369f2 (__list_del_entry_valid_or_report+0x112/0x130)
	[ 4326.110987]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
	[ 4326.110989] Krnl GPRS: 0000000000000030 0000000000000000 0000000000000033 000001e12a9136e8
	[ 4326.110992]            00000001fe51d000 0000000000000000 0000000000000000 fffffffffffffff8
	[ 4326.110993]            0000000080238028 0000000000000000 0000000000000000 00000000f88351f8
	[ 4326.110995]            00000001016f6900 0000000000000000 000001e1297369ee 000001612a8cbca8
	[ 4326.111003] Krnl Code: 000001e1297369e2: c02000441908        larl    %r2,000001e129fb9bf2
		   000001e1297369e8: c0e5ffcb7e58       brasl   %r14,000001e1290a6698
		  #000001e1297369ee: af000000           mc      0,0
		  >000001e1297369f2: b9040032           lgr     %r3,%r2
		   000001e1297369f6: c02000441913       larl    %r2,000001e129fb9c1c
		   000001e1297369fc: c0e5ffcb7e4e       brasl   %r14,000001e1290a6698
		   000001e129736a02: af000000           mc      0,0
		   000001e129736a06: 0707               bcr     0,%r7
	[ 4326.111015] Call Trace:
	[ 4326.111017]  [<000001e1297369f2>] __list_del_entry_valid_or_report+0x112/0x130
	[ 4326.111019] ([<000001e1297369ee>] __list_del_entry_valid_or_report+0x10e/0x130)
	[ 4326.111022]  [<000001e129130d58>] move_linked_works+0x68/0xe0
	[ 4326.111027]  [<000001e129134554>] worker_thread+0x1f4/0x440
	[ 4326.111030]  [<000001e12914036c>] kthread+0x12c/0x280
	[ 4326.111034]  [<000001e1290b9d6c>] __ret_from_fork+0x3c/0x140
	[ 4326.111038]  [<000001e129bfa11a>] ret_from_fork+0xa/0x30
	[ 4326.111042] Last Breaking-Event-Address:
	[ 4326.111043]  [<000001e1290a66e4>] _printk+0x4c/0x58
	[ 4326.111048] Kernel panic - not syncing: Fatal exception: panic_on_oops

Something I did find interesting and saw many times that might help:

	[ 4325.112850] nvme nvme0: qid 0: authenticated
	[ 4325.113206] nvme nvme0: NVME-FC{0}: controller connect complete
	[ 4325.113745] nvme nvme0: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
	[ 4325.129993] (NULL device *): {0:0} Association freed
	[ 4325.130010] (NULL device *): Disconnect LS failed: No Association
	[ 4325.178364] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
	[ 4325.410043] (NULL device *): {0:1} Association deleted
	[ 4325.430596] nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
	[ 4325.430754] (NULL device *): queue 0 connect admin queue failed (-111).
	[ 4325.430758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-111)
	[ 4325.430761] nvme nvme0: NVME-FC{0}: Reconnect attempt in 2 seconds
	[ 4325.430767] nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:2543b704-63fd-45d1-bccd-32e33962e07b
	[ 4325.470264] (NULL device *): {0:1} Association freed
	[ 4325.470282] (NULL device *): Disconnect LS failed: No Association
	[ 4325.112825] nvme nvme0: qid 0: authenticated with hash hmac(sha512) dhgroup ffdhe8192

(the "NULL device *" part)

I agree my patch does look like fixing the symptom, but I haven't touched
the nvme code before, so it's very possible I'm missing the bigger picture.

-- 
Aristeu


