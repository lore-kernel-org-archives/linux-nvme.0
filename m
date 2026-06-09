Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E42CD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yzpBdmqR00NJXRV/QMHlb7IZINX0y728JCMjvxooZiA=; b=iZID8s5F9/9TG4ZiEa0AVoVKCy
	jAmnrQBvWvC0ei6bth3La2Z1h8D6XmDmHY9u15K19Bw8JbYTKmwMqkUEVeLX7Q+rxMrl3xvHkAtca
	KDs7OgxCnTKUBU5pybBfdv8BxVTwWIB8VAoaqhRWJlwfRr/lAO/ow8B2GIWISoOhHEROhZy9A2idj
	C8oSpl4Fg5I+JWJp3NZ/eJHAWNdGR8C1UbArIuBaXpji1NDK7IH9e5W1gulhZZnRtqXsO1Su30ZGJ
	4HjMhmYGUl74LGMblI/1P/tH1RuHS+0h1WnMLBWrCQXb65sM8FquZDfto8gp6XKFHKP24HIsKVeWH
	FOa5XKcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX1R7-00000006DOl-0mcp;
	Tue, 09 Jun 2026 18:44:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX1R5-00000006DOV-2OAs
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 18:44:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6E9C6024D;
	Tue,  9 Jun 2026 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565DA1F00893;
	Tue,  9 Jun 2026 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030666;
	bh=yzpBdmqR00NJXRV/QMHlb7IZINX0y728JCMjvxooZiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UiYAFwCZ88XQ6mfPAuSpviquDL2BdwgLXK3Gw7OenlQ57aOkHTKddKRzdc9QiG3i3
	 oyEjOSiFjNdjEc+sxJMoDlFBSpgszzK7ZbAydWYGI12mKlGpP1HXH6Vc1aI/ppOUIf
	 UZpsCeRQsOfb184XweZufdawiBeyRlgo23hOiiNh0Fs1PIKFADnqq8R+JmqUJXIAcS
	 Qli42DOQbTL2+TA4ukIImI5dsRDtLePw+Q7sBaMMjkKznpOgqR+ArVqr9e7ThWAINw
	 9zBigr9CFuK50Be6Qvft7I1zUsPFWZkgVTMIeS7aFD/Q+tIOxEMUPIPu69Or7GuQTc
	 GFKXaGfj0TJZA==
Date: Tue, 9 Jun 2026 12:44:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: target: allocate ana_state with port
Message-ID: <aihfCMQewU3kR_5J@kbusch-mbp>
References: <20260608051223.6884-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608051223.6884-1-rosenp@gmail.com>
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

On Sun, Jun 07, 2026 at 10:12:23PM -0700, Rosen Penev wrote:
> Use a flexible array member to remove one allocation. Simplifies code
> slightly.

Thanks, applied to nvme-7.2.

