Return-Path: <SRS0=PlbO=MW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6FBC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jul 2021 09:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A2760C3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jul 2021 09:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83A2760C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xr+uQ2xsxRr0iMCAn/cp/D8bRmY+Kdn/rmm2yzmVu/Q=; b=yOJ9q7YHb97eAa
	jdc60u2HmTZPV8PjRWGzTAZCzmX4EQ9EUdxVm+/vLrL0zFebTW5o4BihNKaYysSj/n+Zi1mzapgBF
	APwkkIFDPHcBTSEG/iCLF1h/dCsl/jJL8HbYv/rGwsd8X6Arjs5hzG/YfaEPnKjKmDp7KEEiKxTDx
	o65A7ADtNZ94WH8n59tfCLKWOlUfxN/YhjmjymnMsRIvOkGqOJTOVe1frmYaTywnsvWf8ZmckTk8t
	KRLAlarW3JfjaTToJPbIW5twl96plvahJX47B+AEj+9jqyRpJP7bkE7fHWv7Yjeo7C+KMDPnpEUhJ
	9Yk1O2WzH579HKbY8LPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m9P8i-007zdG-Po; Fri, 30 Jul 2021 09:49:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9P8g-007zbY-Ac
 for linux-nvme@lists.infradead.org; Fri, 30 Jul 2021 09:49:11 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74B0A220D6;
 Fri, 30 Jul 2021 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627638547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tX5/RKu0XyHgoigeyp4NrtKCQbkwtYgFDjsnzfQWEFc=;
 b=QGaXm8DUlon51mxMrT1Hh2u0EE1CIm+k6kIixk7k8iPh3Hbr4fuDDo4RhoNlEUoli6614f
 Ei9diSThe+C06mx8i/7bcBIFfiF1PsQUNluhxgbjCWTMyCRQPy/aEinV6jfPcRdL098HwQ
 YfzsYr9gDOWYjvF+C+Tv8nleLNr3XlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627638547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tX5/RKu0XyHgoigeyp4NrtKCQbkwtYgFDjsnzfQWEFc=;
 b=9dls7owYLli88ake5BD2Hra8yJI665ZgEXUXF539xtnjS3hfENkA0NATgrWg8E7xra16mf
 b95qxhRpXUtl/LCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F950137C2;
 Fri, 30 Jul 2021 09:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id y8H/FhPLA2FsKgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Fri, 30 Jul 2021 09:49:07 +0000
Date: Fri, 30 Jul 2021 11:49:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v3 0/6] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210730094907.5vg7qebggttibogz@beryllium.lan>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124800.i2lo3hal7kjfc7rk@beryllium.lan>
 <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726172704.j6cbv2qmox2cl2dz@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210730_024910_574746_3620A6F4 
X-CRM114-Status: GOOD (  10.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 26, 2021 at 07:27:04PM +0200, Daniel Wagner wrote:
> FTR, I've tested the 'prior_ioq_cnt != nr_io_queues' case. In this
> scenario the series works. Though in the case of 'prior_ioq_cnt ==
> nr_io_queues' I see hanging I/Os.

Back on starring on this issue. So the hanging I/Os happen in this path
after a remote port has been disabled:

 nvme nvme1: NVME-FC{1}: new ctrl: NQN "nqn.1992-08.com.netapp:sn.d646dc63336511e995cb00a0988fb732:subsystem.nvme-svm-dolin-ana_subsystem"
 nvme nvme1: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: connectivity re-established. Attempting reconnect
 nvme nvme1: NVME-FC{1}: create association : host wwpn 0x100000109b579ef6  rport wwpn 0x201900a09890f5bf: NQN "nqn.1992-08.com.netapp:sn.d646dc63336511e995cb00a0988fb732:subsystem.nvme-svm-dolin-ana_subsystem"
 nvme nvme1: NVME-FC{1}: controller connect complete

and all hanging tasks have the same call trace:

 task:fio             state:D stack:    0 pid:13545 ppid: 13463 flags:0x00000000
 Call Trace:
  __schedule+0x2d7/0x8f0
  schedule+0x3c/0xa0
  blk_queue_enter+0x106/0x1f0
  ? wait_woken+0x80/0x80
  submit_bio_noacct+0x116/0x4b0
  ? submit_bio+0x4b/0x1a0
  submit_bio+0x4b/0x1a0
  __blkdev_direct_IO_simple+0x20c/0x350
  ? update_load_avg+0x1ac/0x5e0
  ? blkdev_iopoll+0x30/0x30
  ? blkdev_direct_IO+0x4a2/0x520
  blkdev_direct_IO+0x4a2/0x520
  ? update_load_avg+0x1ac/0x5e0
  ? update_load_avg+0x1ac/0x5e0
  ? generic_file_read_iter+0x84/0x140
  ? __blkdev_direct_IO_simple+0x350/0x350
  generic_file_read_iter+0x84/0x140
  blkdev_read_iter+0x41/0x50
  new_sync_read+0x118/0x1a0
  vfs_read+0x15a/0x180
  ksys_pread64+0x71/0x90
  do_syscall_64+0x3c/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

(gdb) l *blk_queue_enter+0x106
0xffffffff81473736 is in blk_queue_enter (block/blk-core.c:469).
464                      * queue dying flag, otherwise the following wait may
465                      * never return if the two reads are reordered.
466                      */
467                     smp_rmb();
468
469                     wait_event(q->mq_freeze_wq,
470                                (!q->mq_freeze_depth &&
471                                 blk_pm_resume_queue(pm, q)) ||
472                                blk_queue_dying(q));
473                     if (blk_queue_dying(q))


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
