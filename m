Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F499C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:40:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9204660C3D
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9204660C3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8qrQ8QOofX2DFmV9i6VYQTOR9TmCjakzHlMtn37+dwo=; b=VWs5a16DFg0OkWPJUrayTU6Fj
	OWftQweGw+wnuedYHvGT+cZO3vnRv9opjJBTWKj55Z5pc4PBqp3wzVA7LFM0BRs8aXxyYn8P3TFki
	uvnAXYJ1IZXkEBBnN8KUcty2V7rZeqWZmAQbArS3bFwdfWz5Jpl9tf6aarJCZ9slukHuXwJeoNBAy
	haBngO35wZTgnzWOFesFxihhQjlG1qYI9hJ+ZxiyzZ7Fu7ImVWo5Nap07XC2MQxtvXVEzBuTXc2ba
	89OV1SkzBzR+II4RrW6215vWc8FIA40E07gWT0CN2XLuR1dcka2VF/kkfBTDyW4nw5QfOufjQCQMM
	KNRJ5qxVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53mb-00052j-8n; Thu, 28 Jan 2021 09:40:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53mZ-00051f-6D
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:40:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AE443AC97;
 Thu, 28 Jan 2021 09:40:04 +0000 (UTC)
Date: Thu, 28 Jan 2021 10:40:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
Message-ID: <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_044007_372715_A0B6FC03 
X-CRM114-Status: GOOD (  14.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 05:18:56PM +0800, Chao Leng wrote:
> It is impossible to return NULL for nvme_next_ns(head, old).

 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 BUG: kernel NULL pointer dereference, address: 0000000000000068
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000000ff67bc067 P4D 8000000ff67bc067 PUD ff9ac9067 PMD 0 
 Oops: 0000 [#1] SMP PTI
 CPU: 23 PID: 15759 Comm: dt.21.15 Kdump: loaded Tainted: G            E       5.3.18-0.gc9fe679-default #1 SLE15-SP2 (unreleased)
 Hardware name: FUJITSU PRIMERGY RX2540 M2/D3289-B1, BIOS V5.0.0.11 R1.18.0 for D3289-B1x                    02/06/2018
 RIP: 0010:nvme_ns_head_make_request+0x1d1/0x430 [nvme_core]
 Code: 54 24 10 0f 84 c9 01 00 00 48 8b 54 24 10 48 83 ea 30 0f 84 ba 01 00 00 48 39 d0 0f 84 01 02 00 00 31 ff eb 05 48 39 d0 74 67 <48> 8b 72 68 83 e6 04 75 13 48 8b 72 68 83 e6 01 75 0a 48 8b 72 10
 RSP: 0018:ffffa69d08017af8 EFLAGS: 00010246
 RAX: ffff92f261d87800 RBX: ffff92fa555b0010 RCX: ffff92fa555bc570
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000001 R08: 0000000000001000 R09: 0000000000001000
 R10: ffffa69d080179a8 R11: ffff92f264f0c1c0 R12: ffff92f264f7f000
 R13: ffff92fa555b0000 R14: 0000000000000001 R15: 0000000000000000
 FS:  00007f3962bae700(0000) GS:ffff92f29ffc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000068 CR3: 0000000fd69a2002 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  generic_make_request+0x121/0x300
  ? submit_bio+0x42/0x1c0
  submit_bio+0x42/0x1c0
  ext4_io_submit+0x49/0x60 [ext4]
  ext4_writepages+0x625/0xe90 [ext4]
  ? do_writepages+0x4b/0xe0
  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
  do_writepages+0x4b/0xe0
  ? __generic_file_write_iter+0x192/0x1c0
  ? __filemap_fdatawrite_range+0xcb/0x100
  __filemap_fdatawrite_range+0xcb/0x100
  ? ext4_file_write_iter+0x128/0x3c0 [ext4]
  file_write_and_wait_range+0x5e/0xb0
  __generic_file_fsync+0x22/0xb0
  ext4_sync_file+0x1f7/0x3c0 [ext4]
  do_fsync+0x38/0x60
  __x64_sys_fsync+0x10/0x20
  do_syscall_64+0x5b/0x1e0
entry_SYSCALL_64_after_hwframe+0x44/0xa9

You can't see exactly where it dies but I followed the assembly to
nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
old) which returns NULL but nvme_next_ns() is returning NULL eventually
(list_next_or_null_rcu()).

And I have positive feedback, this patch fixes the above problem.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
