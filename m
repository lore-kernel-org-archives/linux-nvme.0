Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEC4C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2719520738
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mkRc0UPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fkJy257QjWd1c9/Pctm5dikuk3zovQLhdWG15tDPAEM=; b=mkRc0UPBo08x9uH+jW6xRArq0
	scYpeZMF4vyLD9zZqIdD1tCMtoDH3joBszXft4IH+ohw1slFfFHCDJl+DpGxINN/wTAH+aboujHis
	aqVq1IUbPnVm5WvE7TIkOlcIlTEaOQNKuV4NkqO4iOSvqx5CRPwachErYZyZphGEbWp2WfId/jIpC
	hup9wwhsxGXS3HrhNUYcCci2W1Yqw+/wwyORqNyRngX1QTf3yC3+v8F+xUsG1ZVkqTpcpYIKsB+4B
	rLbDrwhm1wVhssJWYe8r9doYlUw3wQStRsOiljQSJ3qM21Pl01u+wpCKoJ9Y23Fy/JYqJgeFfwd4H
	CrkEPTj6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k91ou-0001s8-C3; Fri, 21 Aug 2020 07:50:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k91or-0001r9-L1
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 07:50:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2EB0868C4E; Fri, 21 Aug 2020 09:50:35 +0200 (CEST)
Date: Fri, 21 Aug 2020 09:50:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due
 to nvme_set_queue_count timeout
Message-ID: <20200821075034.GB30216@lst.de>
References: <20200820035406.1720-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820035406.1720-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_035037_826265_ADCC024F 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 11:54:06AM +0800, Chao Leng wrote:
> A deadlock happens When we test nvme over roce with link blink. The
> reason: link blink will cause error recovery, and then reconnect.If
> reconnect fail due to nvme_set_queue_count timeout, the reconnect
> process will set the queue count as 0 and continue , and then
> nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
> because the admin queue is quiesced.
> 
> log:
> Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
> Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
> (881)
> stack:
> root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
> [kworker/u12:4+nvme-wq]
> [<0>] blk_execute_rq+0x69/0xa0
> [<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
> [<0>] nvme_features+0x73/0xb0 [nvme_core]
> [<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
> [<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
> [<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
> [<0>] process_one_work+0x1a7/0x370
> [<0>] worker_thread+0x30/0x380
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x35/0x40
> 
> Many functions which call __nvme_submit_sync_cmd treat error code in two
> modes: If error code less than 0, treat as command failed. If erroe code
> more than 0, treat as target not support or other and continue.
> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
> by host, is not the real error code return from target. So we need set
> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
> the error to INTR, nvme_set_queue_count will return error, reconnect
> process will terminate instead of continue.

But we could still race with a real completion.  I suspect the right
answer is to translate NVME_SC_HOST_ABORTED_CMD and
NVME_SC_HOST_PATH_ERROR to a negative error code in
__nvme_submit_sync_cmd.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
