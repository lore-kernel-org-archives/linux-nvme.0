Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA513C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7TnSvhAJ+JNnQA43xk3rm09ZQiDTe1Ol1Dkr+QHqp4=; b=ejg7WK1M34YldnBxU9NZIo497g
	4HRwyxp/XvL87FKR5cJEOCXy0QnJ3xhdh6+7Et9W8ROJT+4IIXrDxjN4zIoya3ynTn4y5Ok0MyjPb
	j7TZLa0DIvtiFAToImeM/YALUPLxkBw1eKlP3NoWCXG5DJu7te+hjDtly5amg7ttFaLbjAPYbsg5P
	ot2k7nK/uyzvrKwIwZFnCV9vao2LnAo5sryb8p3HS9xnWWyeal8kylnQQaX8z19Cet9c86gZxCqhx
	+66abw3/bH+gobSp9ZooUA2xpb9raLZIZ9SR7lX8PfxHiqWlMVnJkA7llkqYPe5ixz4PmBTzXnBwa
	nCiEl+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOZm-0000000FJBg-1PEI;
	Fri, 24 Jan 2025 18:38:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOZk-0000000FJBJ-0R8b
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 18:38:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 089ADA402C4;
	Fri, 24 Jan 2025 18:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F06C4CED2;
	Fri, 24 Jan 2025 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737743918;
	bh=ReCb/vojGIvm5lQy2J1SzofMH1AKILN8c0RDsMvDF+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfAScODUQ5BCMVpgSt30ZMnv0Pyzu6W2rOKn9XN+haqtvsGNh1ixsctNoQFgS5YAx
	 PqcOMKiyRdiI9tESej8ExuAtkynX2+6rhTnrvViujM2SGStQd0F/VUM+Cn5lEIC6YG
	 8RiLJ1hI2NjfhFC8qlvzZEU+/cSUspDCdmGTS+eiQoXZZpxR5CiIGB5C/Ou3iUpKF/
	 SVywutaftx4+vjrMh0TqdIcqaW2pwoh+1ZPV4tXxgErKtfwOkW5YEuk9eFm7AF5Uhh
	 wqEykPpNoxgQ2g8a8mk1j3xgBWpdX4Mqqv121hxt90QAfH/KRcU1clYK9IDW6+YhBe
	 xezA9NYT5HJiw==
Date: Fri, 24 Jan 2025 11:38:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
Message-ID: <Z5PeLAaAv0SwV-y6@kbusch-mbp>
References: <20250124180342.1628060-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124180342.1628060-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_103840_209022_B965A0A0 
X-CRM114-Status: GOOD (  10.57  )
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

On Fri, Jan 24, 2025 at 11:03:41AM -0700, Caleb Sander Mateos wrote:
> +	msg.msg_flags = MSG_WAITALL;
>  	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>  			iov.iov_len, msg.msg_flags);
> -	if (ret < 0) {
> +	if (ret < sizeof(*icresp)) {
>  		pr_warn("queue %d: failed to receive icresp, error %d\n",
>  			nvme_tcp_queue_id(queue), ret);
> +		ret = -ECONNRESET;

If kernel_recvmsg() returns an error, don't we want to preserve and
return that instead of unconditionally overriding to -ECONNRESET? I
think the suggestion was to set ret to that only if ret >= 0.

