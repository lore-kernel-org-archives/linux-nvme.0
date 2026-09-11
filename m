Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64C3C88E50
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1POfL13mAfR4xqoiKsgT46uIL4jgbqiRc7b/gxHQ5JA=; b=TjjL1avw42yxInJro366vlFA8d
	PV+xfUbEFYi5xwqn1ZHNugekSeLJCI9Qvk+i2mR4HJ8Lf8cHUfWxp/viC+CPscL0K6FmH+VWeBCOZ
	pzUS62dJY5sQvdwO+ajtvbHlH+RaIc3vsq4Kat2uL8b67ffGUoanjxiwO1RSwDpr1DPkIh/eQwn8I
	8ooYNmjDgbfz7ieOUZ2wgJrqdVeHX9qGhRQ2SsDFFMjyoviZmO9ftxkslfIf4St1strdWUhpWKS5Q
	uXBQM8rz3PFhcwsYfIW4C674oaHHMMJD0qDvbQUR26PD+rx9RTiD5/tuJkfbsS3PjkbOueK6ChL5o
	ajEDGljg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59tT-00000000HW1-2Aj4;
	Fri, 11 Sep 2026 22:38:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x59tR-00000000HVl-37Cs
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 22:38:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF2B6600AA;
	Fri, 11 Sep 2026 22:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01C51F000FF;
	Fri, 11 Sep 2026 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166328;
	bh=1POfL13mAfR4xqoiKsgT46uIL4jgbqiRc7b/gxHQ5JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5bvWApgEQWscvA3C+zr8YHJdxyVzSGvfpHX9Q/mbQKe/Pzp7CgWr7bax5LdJ5Gu9
	 kfj8Zp9L095KthatdaODDxoh3OXY5VZXfC3p0Obu8+PMynjW6p4Uvfvbw7oLRBOlRz
	 ZhB0lvA3TadEJFoIv7R16ZYdNFXgEIk8eKHIgOirUGq3lJ0ZcJZq07toMrBUZeDqPV
	 Siba+fyKHkgAf1XFFfUD8e0a9F5q7LQsnxqHXTpf5HdREWiifTcV44tZL5/+Y40She
	 8zVLG7LPTYns2Ok4dAfHgNvXnoxRsSCQRNXZzHdjub45/Jtcow5yLUWLRVGFXvEbQT
	 9vmELs+6x8CWw==
Date: Fri, 11 Sep 2026 16:38:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, dwagner@suse.de, kanie@linux.alibaba.com,
	jmeneghi@redhat.com, randyj@purestorage.com,
	martin.petersen@oracle.com, john.g.garry@oracle.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH v8 04/10] nvme-multipath: pass I/O type to
 nvme_find_path()
Message-ID: <aqSC9kxn5_MCJOPt@kbusch-mbp>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-5-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815173502.1185929-5-nilay@linux.ibm.com>
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

On Sat, Aug 15, 2026 at 11:04:26PM +0530, Nilay Shroff wrote:
> @@ -804,12 +830,24 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>  int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>  		unsigned int issue_flags)
>  {
> +	struct nvme_ns *ns;
> +	unsigned int op_type;
>  	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>  	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>  	int srcu_idx = srcu_read_lock(&head->srcu);
> -	struct nvme_ns *ns = nvme_find_path(head);
>  	int ret = -EINVAL;
> +	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
> +						struct nvme_uring_cmd);
> +	__u8 opcode = READ_ONCE(cmd->opcode);

Just fyi, the READ_ONCE is used because this is shared memory with user
space. We re-read the same field later when constructing the command, so
if the user does something tricky like changing that opcode, you can
have the wrong group for the command that actually gets dispatched.

