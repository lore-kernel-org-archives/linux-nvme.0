Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE04C44539
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NzuPcvbO3CCe1vqnrs8+MJaknyoLKfvA4/oiCNLO3h8=; b=uXYHBld9jkrFh1yP6vgMMwdoYF
	5wK8GaUumg8TkBCkIXt9p9FjgA0QrgUDORUKG05wiwj9yoxTDC79b2w9RbL5yqDOhwFCuD9cLHoeq
	8NakqJkQ7MJ9Ekdn80u2r7fKPGA8dWCbh/3Ub9MDiFYutbfK2ng2RDC775VN28V74QE1IvkkSc7Uf
	hzafusdjP6iKkB5hZOXsK0hSpqt0k6diaBAX+pxSS6baKrX3mk5aMaQ1WYLqfp22A4rcxiQQEl7d2
	qjs5Nw3BOlUnsX5gYeBfvQ6IoS1WtFA/UgwCKtAfoXvG1VkuIT9WkqSsiny1/NCteEcWWVkc9Ekt2
	a07RIHiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVvf-0000000Bk9y-1eJk;
	Wed, 22 Jul 2026 12:20:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVvc-0000000Bk8x-3IWh
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 12:20:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDFC468D1F; Wed, 22 Jul 2026 14:19:56 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:19:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 16/20] nvme: add context annotations in rdma.c
Message-ID: <20260722121956.GI12774@lst.de>
References: <20260713115444.465704-1-nilay@linux.ibm.com> <20260713115444.465704-17-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-17-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_052000_987646_A15D25B6 
X-CRM114-Status: GOOD (  16.13  )
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

On Mon, Jul 13, 2026 at 05:24:17PM +0530, Nilay Shroff wrote:
> device_list and nvme_rdma_device::entry are protected by
> device_list_mutex. Define device_list using
> LIST_HEAD_GUARDED(device_list, device_list_mutex) and annotate
> nvme_rdma_device::entry with __guarded_by(&device_list_mutex) so that
> Clang's context analysis can validate accesses against the corresponding
> locking requirements.
> 
> Similarly, nvme_rdma_ctrl_list and nvme_rdma_ctrl::list are
> protected by nvme_rdma_ctrl_mutex. Define nvme_rdma_ctrl_list using
> LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex) and
> annotate nvme_rdma_ctrl::list with __guarded_by(&nvme_rdma_ctrl_mutex).
> 
> It is safe to initialize nvme_rdma_ctrl::list while allocating the
> controller object because the list entry has not yet been added to
> nvme_rdma_ctrl_list. Annotate the initialization with context_unsafe()
> to suppress the corresponding Clang context analysis warning.

I still wish the lock context handling in clang could just do the
right thing for fields initialized before the protecting lock,
so we would not need all this unsafe magic.

But to get things going for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

