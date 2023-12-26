Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4333C46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZP89U5iI+ZOGbul/rGJx5xdVPmDPO8s/x15b5WTokFA=; b=G4kFeW5Dwq6ifWjRBktKlIwmAC
	zW6cIwLiM3jv1RcizooWcIJgheXCQhoj4LHdXxseqcBhYbWVyM5NqjQXoaYyriEawvQKSgd47KRkV
	fCZrSI4CG9kx0bafK7ZDoA8gtZNamObZF3wRFScKHxpMbtVDxto+Zq3yXor2Xy5soDDP1+16GiSla
	knPap20xEWtgWWaCfILgdfpzsHBgdGLUHmdi124LwBVIw4giF5fuPVFrf/wN6+YDgJdkswIoXq2hZ
	y8PIP5LSyDoQscvJX/f/Dn6XQ3NEl8ywiXbsEKmkq5kXQuMhF2hL+R755qFziDMyeZrU3BF5Xq8zF
	i6QUq6GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI1XP-00Bq2L-1P;
	Tue, 26 Dec 2023 07:07:39 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI0tx-00Bno4-2u
	for linux-nvme@lists.infradead.org;
	Tue, 26 Dec 2023 06:26:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id B60E1900113;
	Tue, 26 Dec 2023 14:26:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.69.247])
	by smtp.cecloud.com (postfix) whith ESMTP id P9454T281469132009840S1703572002760720_;
	Tue, 26 Dec 2023 14:26:43 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhangyanjun@cestc.cn
X-SENDER: zhangyanjun@cestc.cn
X-LOGIN-NAME: zhangyanjun@cestc.cn
X-FST-TO: kbusch@kernel.org
X-RCPT-COUNT: 7
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.69.247
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <8338b95bdc23b83f9c35ebc57a578131>
X-System-Flag: 0
From: zhangyanjun@cestc.cn
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhangyanjun@cestc.cn
Subject: Re: [RFC] nvme-tcp: fix a possible double-free after failed to send request
Date: Tue, 26 Dec 2023 14:26:40 +0800
Message-Id: <20231226062640.1121456-1-zhangyanjun@cestc.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_222654_289317_C2F11567 
X-CRM114-Status: GOOD (  21.91  )
X-Mailman-Approved-At: Mon, 25 Dec 2023 23:07:37 -0800
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

From: Yanjun Zhang <zhangyanjun@cestc.cn>

Thanks for your reply and attention!

>> In storage clusters constructed by nvme-tcp driver, we have encountered
>> the following crash on the host kernel severval times.
>>
>> [248514.030873] nvme nvme1: failed to send request -13
>> [248514.035916] ------------[ cut here ]------------
>> [248514.035918] kernel BUG at mm/slub.c:379!
>> [248514.037647] invalid opcode: 0000 [#1] SMP NOPTI
>> [248514.039416] CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Tainted: G S 5.15.67-6.cl9.x86_64 #1
>> [248514.041376] Hardware name: CECLOUD CeaStor 16114/BC13MBSBC, BIOS 1.37 02/24/2023
>> [248514.043433] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> [248514.045576] RIP: 0010:__slab_free+0x16a/0x320
>> [248514.047751] Code: 24 20 e8 69 28 78 00 44 8b 44 24 0c 4c 8b 54 24 10 44 0f b6 5c 24 1b 0f b6 74 24 1c 48 89 04 24 4c 8b 4c 24 20 e9 28 ff ff ff <0f> 0b 41 f7 46 08 00 0d 21 00 75 a0 4d 85 ed 75 9b 80 4c 24 5b 80
>> [248514.052500] RSP: 0018:ff51b1a6c0273bf0 EFLAGS: 00010246
>> [248514.054798] RAX: ff2378e68268b800 RBX: 0000000080080004 RCX: ff2378e68268b000
>> [248514.057038] RDX: ff2378e68268b000 RSI: ffca59110c09a200 RDI: ff2378a480034d00
>> [248514.059245] RBP: ff51b1a6c0273c90 R08: 0000000000000001 R09: ffffffffc0901a0a
>> [248514.061386] R10: ff2378e68268b000 R11: ffffffff86e06000 R12: ffca59110c09a200
>> [248514.063423] R13: ff2378e68268b000 R14: ff2378a480034d00 R15: 0000000000000078
>> [248514.065428] FS: 0000000000000000(0000) GS:ff2378d32fe00000(0000) knlGS:0000000000000000
>> [248514.067456] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [248514.069531] CR2: 00007f4759e1c800 CR3: 0000001b5e5a6005 CR4: 0000000000771ef0
>> [248514.071706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [248514.073916] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [248514.076130] PKRU: 55555554
>> [248514.078392] Call Trace:
>> [248514.080640] <TASK>
>> [248514.082898] ? sk_stream_alloc_skb+0x66/0x2e0
>> [248514.085231] ? tcp_skb_entail+0x11d/0x130
>> [248514.087595] ? tcp_build_frag+0xf0/0x390
>> [248514.089980] ? nvme_complete_rq+0x1a/0x1f0 [nvme_core]
>> [248514.092433] kfree+0x215/0x240
>> [248514.094918] nvme_complete_rq+0x1a/0x1f0 [nvme_core]
>> [248514.097469] nvme_tcp_recv_pdu+0x534/0x570 [nvme_tcp]
>> [248514.100070] nvme_tcp_recv_skb+0x4f/0x23e [nvme_tcp]
>> [248514.102699] ? nvme_tcp_recv_pdu+0x570/0x570 [nvme_tcp]
>> [248514.105317] tcp_read_sock+0xa0/0x270
>> [248514.107958] nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
>> [248514.110666] ? nvme_tcp_try_send+0x16b/0x200 [nvme_tcp]
>> [248514.113431] nvme_tcp_io_work+0x4d/0xa0 [nvme_tcp]
>> [248514.116247] process_one_work+0x1e8/0x390
>> [248514.119085] worker_thread+0x53/0x3d0
>> [248514.121980] ? process_one_work+0x390/0x390
>> [248514.124887] kthread+0x124/0x150
>> [248514.127835] ? set_kthread_struct+0x50/0x50
>> [248514.130836] ret_from_fork+0x1f/0x30
>> [248514.133841] </TASK>
>>
>> By analyzing the vmcore, we know the direct cause is that the slab object
>> request->special_vec was freed twicely. According to the error message
>> "nvme nvme1: failed to send request -13" and nvme_tcp_request->state =
>> NVME_TCP_SEND_DATA, the pdu has been send by nvme_tcp_try_send_cmd_pdu.
>
> So what exactly failed to send? incapsule date? Or h2cdata?
>
According to the nvme_tcp_request->state is NVME_TCP_SEND_DATA currently, I think 
it shoule be incapsule data failed to send after the cmd pdu has been send.

>> And the nvme_tcp_fail_request would execute nvme_complete_rq after failed
>> to send data.
>
> That is correct.
>
>> Then the nvme_tcp_recv_pdu may receive the responding pdu
>
> Which PDU was that? Isn't the controller expecting request data?
>
The received pdu type is nvme_tcp_rsp. It should not reveive the data matched with 
the above request that has been completed because of failing to send data or take 
some extra actions for this request? The sent pdu with matched request is nvme_tcp_cmd.

crash> nvme_tcp_request.pdu ff2378b7cee425d0
  pdu = 0xff2378dfe9c5f9d0,
crash> nvme_tcp_hdr.type 0xff2378dfe9c5f9d0
  type = 4 '\004',

>> and the nvme_tcp_process_nvme_cqe would complete the request again. To
>> avoid this slab object double-free issuse, we try to make the following
>> code modifications, can you give some suggestions, thanks!
>>
>> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
>> ---
>> drivers/nvme/host/tcp.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 08805f027..84f724558 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -581,6 +581,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>> return -EINVAL;
>> }
>>
>> + if (!blk_mq_request_started(rq))
>> + return 0;
>
> First, I want to understand if this is a spurious completion, meaning is
> this suggesting a protection against a misbehaving controller? Or there
> was actually something that the host got wrong?
>
What can we identify is the nvme_ctrl->state = NVME_CTRL_LIVE from vmcore, and there is no other 
error with nvme ctrl before the message "nvme nvme1: failed to send request -13".
It looks like always doing well, suddenly an error occurred, but we can not find why it failed?

[237163.158966] systemd-journald[379035]: /var/log/journal/a888731b91ba4a55bf056a48723bbc51/system.journal: Journal header limits reached or header out-of-date, rotating.
[248514.030873] nvme nvme1: failed to send request -13

> Because this sort of check does not belong in the tcp driver.

Or should we add check by comparing nvme_request status with NVME_SC_HOST_PATH_ERROR?
NVME_SC_HOST_PATH_ERROR is set by nvme_tcp_fail_request, but I am not sure if this 
check has other impact? 




