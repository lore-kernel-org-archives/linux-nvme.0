Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4BC105F78C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5oJ/cToPaZn4nNpIBi2bpHttzEv3gVVaEFf6eLddWk=; b=VtA2nJRZyOUyyiTuskCgsePVuW
	1XyS1PXKhMkQQQNQhXxg9LwL1Pl6/SJQgqLX33YI4TnsXcspK4rey+6sOTGP4+r+2gk2+/pfUoxF+
	vYyKfTmIl3MD92N/k2sonVfYLp4+iS/jH5qfT/AXgX1+TJxi56HBEsp7Vlj5M5iYvhHI1SfB/VkoG
	e+SSTsTgKRMeT3Q2a+kLLyqlf0YfsYOj9Az7JGFs0FfY/Mo25UmEe2BAhOS73cpq43MT0G8L/cl1x
	2E6DUG/9JxzoXg6DVQaSpGOO/iP0wC4JEvQRDhF5yCupbK4zkwEBGKDSJIl4v9bXA83ZgzK7hx48e
	URSlFU9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w11RS-000000005qx-40Je;
	Fri, 13 Mar 2026 12:16:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w11RQ-000000005qQ-3XzP
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 12:16:34 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 7f89b76f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 13:16:30 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 13:16:29 +0100
Message-Id: <DH1NBHVBHGZ3.1SXZHVRXCJLUF@arkamax.eu>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <dwagner@suse.de>, <hare@suse.de>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/2] nvmet-tcp: fix receive path error handling and
 state machine
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "yunje shin"
 <yjshin0438@gmail.com>, "Maurizio Lombardi" <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260311160920.465209-1-mlombard@redhat.com>
 <CAMX6_QHFZE35qNXZyn8-SDkoQ6dUAuSLXSH__65CWxLtSTx5rg@mail.gmail.com>
 <DH1M262WZRUE.2FR90L883CA9F@arkamax.eu>
In-Reply-To: <DH1M262WZRUE.2FR90L883CA9F@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_051633_225749_B3717CFA 
X-CRM114-Status: UNSURE (   7.12  )
X-CRM114-Notice: Please train this message.
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

On Fri Mar 13, 2026 at 12:17 PM CET, Maurizio Lombardi wrote:
> On Fri Mar 13, 2026 at 6:58 AM CET, yunje shin wrote:
>
> I guess that the msg_data_left(&cmd->recv_msg) check in
> nvmet_tcp_try_recv_data() prevents the derefence of the uninitialized
> iterator, so this is why it doesn't crash.

Ah!! I got it!

The trick is to enable the data digests:

[ 4486.731644] nvmet_tcp: queue 2: cmd 12292 pdu (6) data digest error: rec=
v 0x1ee9aab3 expected 0x4d76611a
[ 4486.791455] ------------[ cut here ]------------
[ 4486.791464] percpu ref (nvmet_sq_free [nvmet]) <=3D 0 (0) after switchin=
g to atomic
[ 4486.791491] WARNING: lib/percpu-refcount.c:197 at percpu_ref_switch_to_a=
tomic_rcu+0x200/0x210, CPU#3: swapper/3/0
[ 4486.793089] Modules linked in: nvmet_tcp nvmet nvme_keyring nvme_auth hk=
df rfkill vfat fat fuse loop nfnetlink vsock_loopback vmw_vsock_virtio_tran=
sport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs virtio_net ghash_c=
e net_failover virtio_blk failover virtio_console dm_mirror dm_region_hash =
dm_log dm_mod i2c_dev
[ 4486.798659] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.0.0-rc3+ =
#1 PREEMPT(full)
[ 4486.799172] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[ 4486.799579] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 4486.800009] pc : percpu_ref_switch_to_atomic_rcu+0x200/0x210
[ 4486.800345] lr : percpu_ref_switch_to_atomic_rcu+0x200/0x210
[ 4486.800691] sp : ffff80008001bdf0
[ 4486.800888] x29: ffff80008001bdf0 x28: ffff0000cecc8ba0 x27: ffff00112c1=
6a2c0
[ 4486.801320] x26: ffffb00ad9f97990 x25: ffffb00adc031c80 x24: ffff0000cec=
c8b80
[ 4486.801797] x23: ffff0000cecc8ba0 x22: ffffb00adc036e60 x21: ffffb00adb0=
6b208
[ 4486.802271] x20: 0000adf96ef8a620 x19: 7fffffffffffffff x18: 00000000fff=
fffff
[ 4486.802746] x17: ffff5006507c9000 x16: ffffb00ad9958998 x15: ffffb00adc7=
1b709
[ 4486.803219] x14: ffffffffffffffff x13: 0000000000000008 x12: 01010101010=
10101
[ 4486.803695] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefeff32 x9 : ffffb00ad99=
7f5c8
[ 4486.804167] x8 : ffffb00adc0865d4 x7 : 0000000000000000 x6 : 00000000000=
0000f
[ 4486.804641] x5 : ffff00112c154588 x4 : 00000000ffff82e9 x3 : ffff5006507=
c9000
[ 4486.805114] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c0a=
78000
[ 4486.805584] Call trace:
[ 4486.805748]  percpu_ref_switch_to_atomic_rcu+0x200/0x210 (P)
[ 4486.806125]  rcu_do_batch+0x188/0x7b8
[ 4486.806372]  rcu_core+0x138/0x2f0
[ 4486.806595]  rcu_core_si+0x18/0x30
[ 4486.806821]  handle_softirqs+0x114/0x490
[ 4486.807083]  __do_softirq+0x1c/0x28
[ 4486.807320]  ____do_softirq+0x18/0x30
[ 4486.807566]  call_on_irq_stack+0x30/0x48
[ 4486.807827]  do_softirq_own_stack+0x24/0x50
[ 4486.808105]  __irq_exit_rcu+0x130/0x168
[ 4486.808360]  irq_exit_rcu+0x18/0x30
[ 4486.808592]  el1_interrupt+0x50/0xb8
[ 4486.808834]  el1h_64_irq_handler+0x18/0x28
[ 4486.809113]  el1h_64_irq+0x80/0x88
[ 4486.809340]  default_idle_call+0x38/0x340 (P)
[ 4486.809629]  cpuidle_idle_call+0x184/0x200
[ 4486.809904]  do_idle+0xa4/0x120
[ 4486.810114]  cpu_startup_entry+0x40/0x50
[ 4486.810377]  secondary_start_kernel+0x12c/0x170
[ 4486.810681]  __secondary_switched+0xc0/0xc8
[ 4486.810958] ---[ end trace 0000000000000000 ]---
[ 4486.811288] percpu_ref_switch_to_atomic_rcu: percpu_ref_switch_to_atomic=
_rcu(): percpu_ref underflow slab kmalloc-64 start ffff0000cecc8b80 pointer=
 offset 0 size 64

Maurizio

