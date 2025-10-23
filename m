Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF72CCD1BE
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WH1xS7wE/rslryLXjjmY7YbUcRZYX4S+Qqq3QzfUnAY=; b=tS3mpO8cUn06VFl8fmIgtmPZWx
	cc0pJ9RV4V3Attw5RuJLcGpxLhgpEJy5FlT9GdrykB8/57DSRcLIKw4aqTKHuWiFDV2V83/uscn1Z
	8DQjsdk8tWy19eH7fUmdOFpjEh+cwueFDbul38soIx0ujmIwvZ9dkEBB0U/2xbQ9C0Cj/3JU7ikbQ
	iQmSbKZe5P9+eaFRTRh4iSjVEElWVXt2oLCMXr3iDf4l/nCxMGkWJqQ6qQhP3YjJZmGIYsBC3hIle
	PfWQHlvErFeSthUf3q8NLytAxUfrrgXE0/AZWfiqbUqzM8N1XRnC12cSOT17CPfXtB9Id3yRR2gap
	xEoOubHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvYn-00000006RnU-03MC;
	Thu, 23 Oct 2025 13:40:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvYj-00000006Rn4-2lxm
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 13:40:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E777227A8E; Thu, 23 Oct 2025 15:40:47 +0200 (CEST)
Date: Thu, 23 Oct 2025 15:40:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
Message-ID: <20251023134047.GA24570@lst.de>
References: <20251022231326.2527838-1-csander@purestorage.com> <20251022231326.2527838-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022231326.2527838-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_064053_841036_F3489999 
X-CRM114-Status: GOOD (  14.62  )
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

On Wed, Oct 22, 2025 at 05:13:26PM -0600, Caleb Sander Mateos wrote:
> io_uring task work dispatch makes an indirect call to struct io_kiocb's
> io_task_work.func field to allow running arbitrary task work functions.
> In the uring_cmd case, this calls io_uring_cmd_work(), which immediately
> makes another indirect call to struct io_uring_cmd's task_work_cb field.
> Introduce a macro DEFINE_IO_URING_CMD_TASK_WORK() to define a
> io_req_tw_func_t function wrapping an io_uring_cmd_tw_t. Convert the
> io_uring_cmd_tw_t function to the io_req_tw_func_t function in
> io_uring_cmd_complete_in_task() and io_uring_cmd_do_in_task_lazy().
> Use DEFINE_IO_URING_CMD_TASK_WORK() to define a io_req_tw_func_t
> function for each existing io_uring_cmd_tw_t function. Now uring_cmd
> task work dispatch makes a single indirect call to the io_req_tw_func_t
> wrapper function, which can inline the io_uring_cmd_tw_t function. This
> also allows removing the task_work_cb field from struct io_uring_cmd,
> freeing up some additional storage space.

Please just open code the logic instead of the symbol-hiding multi-level
macro indirection.  Everyone who will have to touch the code in the
future will thank you.


