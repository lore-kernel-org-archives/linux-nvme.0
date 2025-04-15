Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0CC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThqIT2AP0ALdm3s55dR+LeeXUEMOdOL616ZKy1RI59M=; b=t3Z9C2ty55FLSyimhnoxLbcUgx
	g54vEqkXaExz2I9hAz7M28E8/9XLNs8TZE0AmbYdswNFRUQJj2fcEBFCysFsP2tzmMnk5SBXy+8Cu
	lfHW2OvxM4QpUj6TyfpqC1C+N7AfxTOgrJbIDo1nk01NhlCcNY+frZx9IskTnI9BGBYyLlzZpBf/e
	cURcVlc6ggczxLHVRzNnCIG+Y651zmy7xlBor8dOwMF+xNNiHxmSY9xm2tZ8UyGroJLu26dNrEH1x
	SBTxt36mIwwMfS6eicMWbd9yTUqAAUvnBxDMtJ5tPWV8uVPocgypmpzFDXtDDzs/d4BQdOXyOLUwd
	C/eAiUHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4hm2-00000006BnS-3eS9;
	Tue, 15 Apr 2025 15:00:30 +0000
Received: from out-177.mta0.migadu.com ([91.218.175.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4hlz-00000006Bi5-24Ok
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 15:00:30 +0000
Message-ID: <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744729222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThqIT2AP0ALdm3s55dR+LeeXUEMOdOL616ZKy1RI59M=;
	b=JfOw9fE3XB20w4yNNTribRYtTimDQReFh7xmzCU5IRTsrYinXOz2Tpu126UMgv2DdFSmfF
	l9moYHqc2nW+tDq9a7NQpfU3vMcb0Ne6VA7h7f5zXZ05L1Crkw+rdqmsz+CxLdsgbeEZpG
	/MLeubNBGS+ONK3ru+xr5gY8wxM+Ouk=
Date: Tue, 15 Apr 2025 17:00:20 +0200
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Bernard Metzler <BMT@zurich.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_080028_833485_FE652730 
X-CRM114-Status: UNSURE (   7.07  )
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

On 15.04.25 15:09, Bernard Metzler wrote:

> [  106.826346] rdma_rxe: loaded
> [  106.832164] loop: module loaded
> [  107.066868] run blktests nvme/061 at 2025-04-15 15:03:04
> [  107.081270] infiniband eno1_rxe: set active
> [  107.081274] infiniband eno1_rxe: added eno1
> [  107.089683] infiniband enp4s0f4d1_rxe: set active
> [  107.089687] infiniband enp4s0f4d1_rxe: added enp4s0f4d1
> [  107.264770] loop0: detected capacity change from 0 to 2097152
> [  107.267376] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  107.271276] nvmet_rdma: enabling port 0 (10.0.0.2:4420)
> [  107.312957] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [  107.312973] #PF: supervisor read access in kernel mode
> [  107.312979] #PF: error_code(0x0000) - not-present page
> [  107.312986] PGD 0 P4D 0
> [  107.312992] Oops: Oops: 0000 [#1] SMP PTI
> [  107.312999] CPU: 1 UID: 0 PID: 123 Comm: kworker/u32:4 Not tainted 6.15.0-rc2 #1 PREEMPT(undef)
> [  107.313008] Hardware name: LENOVO 10A6S05601/SHARKBAY, BIOS FBKTD8AUS 09/17/2019
> [  107.313016] Workqueue: rxe_wq do_work [rdma_rxe]
> [  107.313030] RIP: 0010:rxe_mr_copy+0x58/0x230 [rdma_rxe]

Hi, Bernard

An interesting test. Can you find the line number of 
(rxe_mr_copy+0x58/0x230) with crash tool?

Thus we can find what variable is becoming NULL pointer.

Thanks a lot.
Zhu Yanjun

> [  107.313041] Code: 83 7f 7c 04 49 89 f6 48 89 d3 41 89 cd 0f 84 f9 00 00 00 89 ca e8 68 f7 ff ff 85 c0 0f 85 95 01 00 00 49 8b 84 24 f0 00 00 00 <f6> 40 28 02 74 28 44 8b 45 d4 44 89 e9 48 89 da 4c 89 f6 4c 89 e7
> [  107.313055] RSP: 0018:ffffb00b40467cc8 EFLAGS: 00010246
> [  107.313062] RAX: 0000000000000000 RBX: ffff8f64434f804a RCX: 0000000000000400
> [  107.313070] RDX: 0000000000000400 RSI: ffff8f64b8c9cc00 RDI: ffff8f64bef78a00
> [  107.313077] RBP: ffffb00b40467d00 R08: 0000000000000000 R09: ffff8f6440b68e00
> [  107.313084] R10: ffffb00b40467d50 R11: ffff8f6440b68e00 R12: ffff8f64bef78a00
> [  107.313091] R13: 0000000000000400 R14: ffff8f64b8c9c800 R15: ffff8f64470d1000
> [  107.313098] FS:  0000000000000000(0000) GS:ffff8f6b8dc9e000(0000) knlGS:0000000000000000
> [  107.313106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  107.313129] CR2: 0000000000000028 CR3: 000000069d81a004 CR4: 00000000001706f0
> [  107.313148] Call Trace:
> [  107.313164]  <TASK>
> [  107.313170]  rxe_receiver+0x1310/0x26d0 [rdma_rxe]
> [  107.313180]  do_task+0x6b/0x1f0 [rdma_rxe]
> [  107.313189]  do_work+0xe/0x20 [rdma_rxe]
> [  107.313198]  process_one_work+0x1b3/0x400
> [  107.313206]  worker_thread+0x25b/0x370
> [  107.313212]  kthread+0x116/0x240
> [  107.313218]  ? __pfx_worker_thread+0x10/0x10
> [  107.313225]  ? _raw_spin_unlock_irq+0x17/0x40
> [  107.313233]  ? __pfx_kthread+0x10/0x10
> [  107.313239]  ret_from_fork+0x3c/0x60
> [  107.313246]  ? __pfx_kthread+0x10/0x10
> [  107.313253]  ret_from_fork_asm+0x1a/0x30
> [  107.313260]  </TASK>


