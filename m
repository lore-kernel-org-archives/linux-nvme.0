Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5452CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QD47gaMB3hRw3A72AyUeF5gMpuhU7YrMMvYc5XhYmdQ=; b=kktXt+zJx/Upjqp6FnxcGnoxYu
	QsN5lGP9m8n5n63L4C7tgUSefPvpLqrx7D47xx7rhMH22lbxqtI7Ueo/Wwhd5y6QGrUbs7wCpf93t
	1WurdT4D3Ay7T7SwbWNlloAiHC3oBT125lp/yBt4S1P8+rMomWcJXUdJ5J1Xjg9eo9GXnaJGJ6g8t
	cdlIqY+v/6aRcKRs9Ivct42CdvCAQAICjvJmi1OVB5vd+uoI2VXBkJCqDnrMXXSI5rPvrQkJGhCYe
	5hlnZKt1DvOyiqKINypCZwJ7bQD1BJrUXqSvz4C3wPL3yI17Ab9VNEthFhrZiOnW/+1RH/mANyIq9
	JtIAPKEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeda-0000000DOIA-1l2e;
	Tue, 13 Oct 2026 15:41:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGedX-0000000DOHJ-3DDW
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:41:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7337D43A17;
	Tue, 13 Oct 2026 15:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D111F000FF;
	Tue, 13 Oct 2026 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906115;
	bh=QD47gaMB3hRw3A72AyUeF5gMpuhU7YrMMvYc5XhYmdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zq13cvx6LpPGrOkrWpKHNn125PN6MAYszEJL9ovsqQsOB7Eh38pYI3SuIkZiIQb+7
	 UemeYxQFXMI/hCOW8iv94+q1pRYQNu8Piq0DfZ9eeT7nsUVFqm5CN3Uma5/9EPhAWq
	 HmPUux1/UgLRiUS2S+yL7sjU7X1cXSxMBrpe2c1JtXnXf4utGYQTHy1fwBt04fzCTq
	 +V2GSnyuPsAIE+Qdgxqfqibvoka+KqC5crdgqwAQWoV9yCmLyNSTciOL8qZGdpoU42
	 3jo3pmhg191poyjfrOduu29YGdr6CJygrKaBjn4mqESP495I5/Z2qgP73My+lKsAIh
	 AjEigddj8yUYA==
Date: Tue, 13 Oct 2026 09:41:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: require authentication before property set
Message-ID: <as5RQT5VrqCJCrv4@kbusch-mbp>
References: <20261007063041.26180-1-tjdqudcks0424@naver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007063041.26180-1-tjdqudcks0424@naver.com>
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

On Wed, Oct 07, 2026 at 03:30:41PM +0900, Sung Byeongchan wrote:
> I/O queues do not perform independent DH-HMAC-CHAP authentication.  They
> instead rely on authentication of the controller's admin queue.  Fabrics
> property commands, however, are dispatched before the general admin command
> authentication check.
> 
> An unauthenticated peer can consequently set CC.EN, connect an I/O queue,
> and access a namespace after admin CONNECT reported that authentication was
> required.  Reject PROPERTY_SET until the admin queue has authenticated.
> Targets without a configured authentication key are unchanged.
> 
> This was found by source review with AI assistance.  A localhost NVMe/TCP
> wire reproducer retrieved a known 4 KiB namespace block in two independent
> boots without completing AUTH_SEND or AUTH_RECEIVE.  With this change,
> PROPERTY_SET returned NVME_SC_AUTH_REQUIRED and the namespace data was not
> returned; the no-authentication control continued to work.

Thanks, applied to nvme-7.4.

