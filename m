Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F12CA0FFC
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2024 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofvcmsIzmGFHZAic7DYuV5dO+iFBlWE6WXXoxlqccUA=; b=k/QSnKAM65VZPQIdM3npVjd/Wq
	KtEds8ImK0YD6gnxlxRBogwIDELstMDi4hQ+Q6FxslQJNGynwTVDfZyxtqzMKq6m0/YM5EWD0XSAR
	89u7niSYXrA34VKSWIm+XtVRoovFb59Azhia74Ho4l/3Abcu77E4k3mPjNQsyrm0Tv5QKjOPwNnSe
	BEk1UjR++N/PUTbTyiO7UsOoymwl6k23f3JQRrMAMqQoZ3mHr7cNKkk/NEVGrnidP+1hYvl37DIKT
	nHx8xeiOhzb2V78CSZsGDjmVlCbq/34t6s/mL5FZNitY9AtFzbaLgu3IB4gVO4NpoM5QjIpgKDlay
	k5rGieOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk30O-00000006gIH-1CrF;
	Fri, 30 Aug 2024 14:53:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2z2-00000006fr9-1nHn
	for linux-nvme@lists.infradead.org;
	Fri, 30 Aug 2024 14:52:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ADB54CE1E8B;
	Fri, 30 Aug 2024 14:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C111C4CEC2;
	Fri, 30 Aug 2024 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029531;
	bh=I9Pun/kr5/Bslk1OWoitzFURlDAnR56ZIlRPk6WxJHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFdiNl7wf/63BOblSwKODZiX7S5A5LeZM/dU+JwZLejJ2uQcoPwEUC13IBmw0xSPn
	 VPsHaG0iSbZ8r2FnP0+i29QaPkrxRFAh9WBwiTw1QqPoKpfq3eXOyLVZUN7EPlv9IK
	 R8TIvxryxdqMv/A3RQ8un9e6Dk/DqA8Rv6Sr3DZwF1vbsX/EN6hfdB+mVEN8x6DLdb
	 IqhDXNvVWvjZOOeXUSfFa6RERcJaOewpy3GZMvz3IPymIkLvNNXqBaGJNZximYvmAI
	 DZbCaG85evIGRV4QZ66xYtioXXIqG0MmtZUaSisgMoJS+LbhXnSZYdXhQ/XHb6EyFx
	 VCxl6QvpxTDEg==
Date: Fri, 30 Aug 2024 08:52:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org,
	amazon-linux-kernel@amazon.com
Subject: Re: [PATCH v3] nvme: fix metadata handling in nvme-passthrough
Message-ID: <ZtHcmYvTTmZfTEXY@kbusch-mbp>
References: <20240829133217.1627-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829133217.1627-1-pjy@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_075216_658535_BAA794C7 
X-CRM114-Status: GOOD (  12.32  )
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

On Thu, Aug 29, 2024 at 01:32:17PM +0000, Puranjay Mohan wrote:
> On an NVMe namespace that does not support metadata, it is possible to
> send an IO command with metadata through io-passthru. This allows issues
> like [1] to trigger in the completion code path.
> nvme_map_user_request() doesn't check if the namespace supports metadata
> before sending it forward. It also allows admin commands with metadata to
> be processed as it ignores metadata when bdev == NULL and may report
> success.
> 
> Reject an IO command with metadata when the NVMe namespace doesn't
> support it and reject an admin command if it has metadata.
> 
> [1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Thanks, applied to nvme-6.12.

