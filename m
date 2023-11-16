Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A348C072A2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 03:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9N0bTTxlmLQZmCaZT+ohBEqtgaJuk9MEI4Wwgnd6A6c=; b=Ekq6okE9/+1z6Q/dsPH1tA2thu
	37oI9j3AyF2pyd7tLzlBDvFzKjczt7g8It8KJbUj6QnqaJt4iATGa8FwkJXKyCY+oZrCK/9yYO036
	bxS2XUf5tEOD8HKAYGK80K73kCMmmGF6mCfKvq5cm+nt8pTAGNfU7xjp27kIgcMBO1DaaGjLsmKMI
	6qIkAmgv1IPFtbq5Td8OKefdB45pJkS3olJChW73q7R1cGZAu5GlaCrRU4zZNpeQRW4CndCi+31kr
	Idl/rlhHTC2PxrXTQ+UG1if5t6VZ0zNXLM0WxJ0CFXC6zvMnsK8Hql02J7JefqYH/dXB8dNURBSBr
	USs5OOLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3T3t-002JRC-1S;
	Thu, 16 Nov 2023 03:29:01 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3T3o-002JPn-2R
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 03:28:59 +0000
Message-ID: <0af842c2-dec8-7e49-7528-e46bacdaa127@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700105328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N0bTTxlmLQZmCaZT+ohBEqtgaJuk9MEI4Wwgnd6A6c=;
	b=otkpDWNyL+05D6ot7/jR6PzV5ppMBtLWtvol2vd4HOtquLjNHqaXEZ5ccN5cUYZbGnSZf1
	2YmEeEoevmZBSF98a8T77gNKW4CAwiPx4RZPuphCX3amAthBFd6RCdgVCbulDxwbJvuX8e
	nXI9zy2MjHgRfASlQ3+HsYkJcKo/vC0=
Date: Thu, 16 Nov 2023 11:28:39 +0800
MIME-Version: 1.0
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `nvmet_tcp_execute_request`
To: Alon Zahavi <zahavi.alon@gmail.com>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_192857_491576_D942DE54 
X-CRM114-Status: GOOD (  21.70  )
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

Hi,

On 11/6/23 21:39, Alon Zahavi wrote:
> # Bug Overview
>
> ## The Bug
> There is a null-ptr-deref in `nvmet_tcp_execute_request`.
>
> ## Bug Location
> `drivers/nvme/target/tcp.c` in the function `nvmet_tcp_execute_request`.
>
> ## Bug Class
> Remote Denial of Service
>
> ## Disclaimer:
> This bug was found using Syzkaller with NVMe-oF/TCP added support.
>
> # Technical Details
>
> ## Kernel Report - NULL Pointer Dereference
> ```
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 800000003c2bc067 P4D 800000003c2bc067 PUD 3dfc5067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 2363 Comm: kworker/0:1H Not tainted 6.5.0-rc1+ #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffff888013b0fba8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888013d50000 RSI: ffffffff833ddfe5 RDI: ffff88800e5a33e8
> RBP: ffff888013b0fcf0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800e5a33e8
> R13: 0000000000000000 R14: ffff88800e5a33e0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000016faa003 CR4: 0000000000370ef0
> Call Trace:
>   <TASK>
>   nvmet_tcp_execute_request drivers/nvme/target/tcp.c:578 [inline]
>   nvmet_tcp_try_recv_data drivers/nvme/target/tcp.c:1232 [inline]
>   nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1312 [inline]
>   nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338 [inline]
>   nvmet_tcp_io_work+0x202a/0x2990 drivers/nvme/target/tcp.c:1388
>   process_one_work+0xb54/0x18b0 kernel/workqueue.c:2597
>   worker_thread+0x663/0x1300 kernel/workqueue.c:2748
>   kthread+0x357/0x460 kernel/kthread.c:389
>   ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
>   </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> ```
>
> ## Description
>
> ### Tracing The Bug
> In the call for `nvmet_tcp_execute_request` (see code block 1), there
> is a call to `cmd->req.execute()`.
> When executing the reproducer, the function pointer is pointing to
> NULL, thus the BUG: Unable to handle NULL pointer dereference.
>
> Code Block 1:
> ```
> static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
> {
>      if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>          nvmet_tcp_queue_response(&cmd->req);
>      else
>          cmd->req.execute(&cmd->req);
> }
> ```
>
> The reason why `cmd->req.execute` is NULL when we get into the
> `nvmet_tcp_execute_request` function lies in the `nvmet_req_init`
> function (drivers/nvme/target/core.c).
>
> Code Block 2:
> ```
> bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>                                   struct nvmet_sq *sq, const struct
> nvmet_fabrics_ops *ops)
> {
>      ...
>
>      if (unlikely(!req->sq->ctrl))
>          /* will return an error for any non-connect command: */
>          status = nvmet_parse_connect_cmd(req);
>      else if (likely(req->sq->qid != 0))
>          status = nvmet_parse_io_cmd(req);
>      else
>          status = nvmet_parse_admin_cmd(req);
>
>    ...
> }
> ```
>
> In the `nvmet_parse_admin_cmd` and `nvmet_parse_connect_cmd`
> functions, there are some assignments for `req->execute`.
> For example, here is in code block 3, the assignment in
> `nvmet_parse_connect_command` (drivers/nvme/target/fabrics-cmd.c).
>
> Code Block 3:
> ```
> u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
> {
>      struct nvme_command *cmd = req->cmd;
>
>      ...
>
>      if (cmd->connect.qid == 0)
>          req->execute = nvmet_execute_admin_connect;
>      else
>          req->execute = nvmet_execute_io_connect;
>       return 0;
> }
> ```
>
> ## Root Cause
> When executing the reproducer the `nvmet_parse_connect_cmd` is not
> being called, but execution is continuing to
> `nvmet_tcp_execute_request` .
>
> ## Reproducer
> I am adding a reproducer generated by Syzkaller with some
> optimizations and minor changes.

Could you try the change to see if it helps?

--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1062,7 +1062,7 @@ static int nvmet_tcp_done_recv_pdu(struct 
nvmet_tcp_queue *queue)
le32_to_cpu(req->cmd->common.dptr.sgl.length));

                 nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-               return 0;
+               return -EAGAIN;
         }

Thanks,
Guoqing

