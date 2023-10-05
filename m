Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEB0E75451
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=; b=3iPt7tKKSJ3SS+r+Amw5cDex3s
	0JNu6t4YscJ9Xk3DrC47cRnsAAXG5TVdYJbrdvNigoQJHti8BHO7NJyvFuV6ImZ/B8dSIEIxwitMQ
	e8o3XrL718b/xlK6G6DGxbWmKVeFTH0fNa3EIc1RtNGYT41jrewL7HnmZTGMMWDnjjNE6o25R8Jfb
	JIqp1WNnRffp8puovpFpg3S18Q8R4ichJ81i5hGjao06mdR6IjSvgk8g0N8BqRrtP/RvnMqtcafov
	G/QMoGwwkwsPTyEOh3jwg6B6GiBQKhI0DmeHETlYax1bL8Ivw8nZ6TrlWkGFhC5u1tcXcdvx6J2Fv
	PgswJO7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRak-0048Nv-1E;
	Thu, 05 Oct 2023 16:52:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRag-0048Mb-1H
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 16:52:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BC2CECE23AD;
	Thu,  5 Oct 2023 16:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05CC433C7;
	Thu,  5 Oct 2023 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696524764;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNfm48lPKFk4SywQqYaqYcII1gJDK81NxrWN29C2L9Z1vr4lu5Uzzl1pWCSJI+VOB
	 VPH4ztGOHA9Gt4nfo0k0xg9ejrC+pPq/4QQjXQZ4mYT90S8XBxrJ06DrWZrLXOreXy
	 WCG8PMykRR3/lSQxA65BEcF/9oaQRdT4i8A/KBvELObtjC/n8gUff0AqydoDujBqew
	 u2bbKnaH+7O57LPXEc1dB01sKJMvCf4n38LAZzYsVGSn5+G4lb27hbZZvDDGrLnKTe
	 vkAhat+pspxwFBTM49pfQa0Mg0UnMqXtLUEdtI37isa6+7kKUXFus+Lxp+3MpdHFo9
	 k23e7jNpA5yDw==
Date: Thu, 5 Oct 2023 10:52:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Message-ID: <ZR7p01KL3546e2mr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231005161408.it.584-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005161408.it.584-kees@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_095246_602334_5084AA82 
X-CRM114-Status: UNSURE (   7.04  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied to nvme-6.7.

