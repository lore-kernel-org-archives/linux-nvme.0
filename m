Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F105C47DB3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=GKlNhm1DbVrxcay+BYYRopaSk6
	ICPCCHfgtbyFIduiyykVUKALhxTc8Jks4ZEB6y1sMNWRFm+LsLbTCVmMb3evsaT2t66pTg6inVQLn
	tPdIQlOdvIfH7CDWevOQAOnX0SLH/QT2VhDalDjH5uOBhE9GNdYQ8VRil/pQyg9BFEdPi2yx3LzBq
	6c+4czHt2YLctc1EjwE9hbmdkc3VnWGFHSMpWRKNc5BCM7QYmiZdvp5rE4fxVcE0RmOMqu3aw80at
	kUoTmnmgMXErx9jNQqWNkfO/ibgjQrCiOm2a/i01NujYJpYr56DCUsWxecs+PfiOev9cRk/r4KIjA
	n+BSae8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKwh-0000000654E-3L6M;
	Thu, 01 Feb 2024 00:28:47 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKwe-0000000653V-3XNy
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:28:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AD0C4CE1D7E;
	Thu,  1 Feb 2024 00:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7279DC43390;
	Thu,  1 Feb 2024 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747317;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAxVDBKBF87mjYyyaOuCCvHBK+3tut7ZtDKTLMVGmWHj4oyZWHjGmamsf+aLoTqlp
	 YJ+nG/AqsfzIRWUIrN7oVnlDjEAK8+S5J3KrPfGZJE5qCs5e/x1Ybg4zecYeWe7wUz
	 6dE35ETX8VWK7gXKkukty7Nibln148L5ke0oIqbCD7i+yzXexUJbkDcvfEG0VlTvcm
	 pZYHsgyOsUHSz3USG4HzqiumYTX6xua6tO+Ci/1LKtdzGSx1zIlsWx6a/3qd9Muie9
	 hvgyxZhOkuoJJpJxwj9A8NiYAUyFRY7nA/RerNCuljpOYjFMB8tl1FK9miFmKwaRAC
	 Ijgcu4jjjU37w==
Date: Wed, 31 Jan 2024 17:28:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] enable nvmet-fc for blktests
Message-ID: <Zbrls9IEaPe2PHmE@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_162845_063609_B8C4A0E9 
X-CRM114-Status: UNSURE (   7.62  )
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

Thanks, applied to nvme-6.8.

