Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257C8C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dokBtUEkeW2DF1vj7vNLxtLe/rjpPocqYPrcKPhyfQo=; b=S4EtV4dAX6ery+5rtzxYPxlnqo
	bctCD0gHgH2Qz941YwK4jU0RKYjTWHXpWQ9bnAHYEHT515CsouGJn44D/Enx+13vCVhbdMmT+ENcL
	5O5dK7e0weBo9AhnrNKzo7hL9a0H9KGSgtKzymE7Gm8CfCwz43cmgTlhmS7nHIjT3PJG4eW+LUKzU
	YZBvHrcnpgXVlPaO5Mp+lGff6UM03Uf4zusNrUG2atFD8k1uf7wHwhGs7X+hthP4SD/qO4GkOFSLO
	46i3rwMPfFTcGoNXhJg9VbPbSdx3+PKKmx9xZFmQczesjmpuH6C8vm08Mj+9EUbkDB8lhqa5rpFf9
	9p6+BQ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIYT8-007vc6-Lz; Fri, 11 Feb 2022 16:08:22 +0000
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIR3S-0069k0-FA
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 08:13:24 +0000
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59--iQ4s60VMteKmR-laGXkKA-1; Fri, 11 Feb 2022 03:13:16 -0500
X-MC-Unique: -iQ4s60VMteKmR-laGXkKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ADD046860;
 Fri, 11 Feb 2022 08:13:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD6E5610F4;
 Fri, 11 Feb 2022 08:13:12 +0000 (UTC)
From: Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: gtiwari@redhat.com,
	sagi@grimberg.me
Subject: Warning: hit due WQ_MEM_RECLAIM for ib_addr work queue
Date: Fri, 11 Feb 2022 13:43:08 +0530
Message-Id: <20220211081308.256810-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_001322_670946_FA9335C7 
X-CRM114-Status: GOOD (  10.77  )
X-Mailman-Approved-At: Fri, 11 Feb 2022 08:08:03 -0800
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

Hi Team,=20

We have following warning=20

 13:25:49  kernel: workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ct=
rl_work [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib=
_core]
 13:25:49  kernel: WARNING: CPU: 7 PID: 1067276 at kernel/workqueue.c:2620 =
check_flush_dependency+0x110/0x130
 13:25:49  kernel: CPU: 7 PID: 1067276 Comm: kworker/u65:3 Kdump: loaded No=
t tainted 4.18.0-348.9.1.el8_5.test.x86_64 #1
 13:25:49  kernel: Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_r=
dma]
 13:25:49  kernel: RIP: 0010:check_flush_dependency+0x110/0x130
 13:25:49  kernel: Code: ff ff 48 8b 50 18 48 8d 8b b0 00 00 00 49 89 e8 48=
 81 c6 b0 00 00 00 48 c7 c7 50 b6 8c 82 c6 05 d3 1e 6d 01 01 e8 09 40 fe ff=
 <0f> 0b e9 0a ff ff ff 80 3d c1 1e 6d 01 00 75 95 e9 41 ff ff ff 66
 13:25:49  kernel: RSP: 0018:ffffa9e4072b3c70 EFLAGS: 00010082
 13:25:49  kernel: RAX: 0000000000000000 RBX: ffff8c87c5136800 RCX: 0000000=
000000000
 13:25:49  kernel: RDX: 0000000000000001 RSI: ffffffff836dffa9 RDI: 0000000=
000000046
 13:25:49  kernel: RBP: ffffffffc06fc380 R08: ffffffff836dff20 R09: 0000000=
000029a00
 13:25:49  kernel: R10: 0002ee301d21f585 R11: 000000000010490c R12: ffff8c8=
44c5b4740
 13:25:49  kernel: R13: ffff8c87c3d9bb00 R14: 0000000000000001 R15: ffff8c8=
4538da178
 13:25:49  kernel: FS:  0000000000000000(0000) GS:ffff8c87af1c0000(0000) kn=
lGS:0000000000000000
 13:25:49  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 13:25:49  kernel: CR2: 00007f8e63a4f000 CR3: 0000000160b3c000 CR4: 0000000=
000350ee0
 13:25:49  kernel: Call Trace:
 13:25:49  kernel: flush_work+0x8b/0x1c0
 13:25:49  kernel: ? lock_timer_base+0x67/0x80
 13:25:49  kernel: ? try_to_del_timer_sync+0x4d/0x80
 13:25:49  kernel: ? work_busy+0x80/0x80
 13:25:49  kernel: __cancel_work_timer+0x105/0x190
 13:25:49  kernel: rdma_addr_cancel+0xa3/0xc0 [ib_core]
 13:25:49  kernel: _destroy_id+0x17/0x240 [rdma_cm]
 13:25:49  kernel: nvme_rdma_alloc_queue+0x193/0x200 [nvme_rdma]
 13:25:49  kernel: nvme_rdma_setup_ctrl+0x34/0xa70 [nvme_rdma]
 13:25:49  kernel: ? __switch_to_asm+0x41/0x70
 13:25:49  kernel: ? __switch_to+0x10c/0x470
 13:25:49  kernel: ? finish_task_switch+0xaa/0x2e0
 13:25:49  kernel: nvme_rdma_reconnect_ctrl_work+0x22/0x70 [nvme_rdma]
 13:25:49  kernel: process_one_work+0x1a7/0x360
 13:25:49  kernel: ? create_worker+0x1a0/0x1a0
 13:25:49  kernel: worker_thread+0x30/0x390
 13:25:49  kernel: ? create_worker+0x1a0/0x1a0
 13:25:49  kernel: kthread+0x116/0x130
 13:25:49  kernel: ? kthread_flush_work_fn+0x10/0x10
 13:25:49  kernel: ret_from_fork+0x22/0x40
=20
 Seems like in IB code path for WQ ib_core WQ_MEM_RECLAIM removed with 39ba=
f10310e6.  As per the description of the patch=20

    "The ib_addr workqueue is not memory reclaim path due to its
    nature of invoking callback that might allocate memory or don't free an=
y
    memory under memory pressure."
=20
 I see other patch when hits similar warnings related to flag WQ_MEM_RECLAI=
M=20
=20
commit 659e3c71d106b0dd4ce6520e4dcd6e
Author: Jack Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri Jul 24 16:45:08 2020 +0530

    RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
   =20
Do you think nvme-core should also do the same to stop this warning ?. Let =
me know if you agree with removing the flag I can send a patch
or any other suggestion to avoid the warning would be helpful.
  =20
   Thanks
   Gopal=20


