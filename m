Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E6606A335
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Zd8jdZDq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzKxpAXa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v1prrXTQL5enhUgRfv7SgNZPLHZi035rI9AU6gpS8T0=; b=Zd8jdZDqLZO8xzYNljzEnaYo1t
	OpzJS7Y/dCboUihyPsvjlR1wZycukiHivEGHgSI42SvrWM+UtOSSqNlJSFVWIvRuQzV+fFrpmdhup
	RUQipJbzbf3YzFwC4h3Zk7e1rwSB4uHBti7ZSfHWKwoYxJTkZK/mhuB5/i/9CNhKDZ/gysjoWVnQq
	szq1pT2BTjViEiLxZdaYTa9sfne0Xyt7jbK1vLQ1aDBMqXxL5Ac4bO+jREhfbGP4+Te2qFE5cVpty
	ghqmmWPJBcG4apRxRn080Db6NcLBd/EOtZq9/rF+ruDVDWUDdQbRoTdNkPDPF6M3QarSHw1V0Ze4y
	+Vv86ftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5Zg-00000007NHF-37Kd;
	Wed, 28 Oct 2026 15:28:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5Zg-00000007NGz-1T8h
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:28:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 354B8602BE;
	Wed, 28 Oct 2026 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948BA1F031E9;
	Wed, 28 Oct 2026 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201302;
	bh=v1prrXTQL5enhUgRfv7SgNZPLHZi035rI9AU6gpS8T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZzKxpAXaIP4i5ZjUWAleQpCNLEouQ2W/CZDoQT9Kcnmh0tHIN14wwGAWOgUoOy31Q
	 z2TnQ2N0Q/TMW/xJsS3aJ/tL5eNovg4VyI/shizr72b61tAnCeYmROliJAtWt6ZylP
	 0SfPak6ZZrItdcf/gVvU53PEuZad1rHTky3hFzpgYCsgWqCcWdsdaUIEilTUo7RzTl
	 8G/5hFKuGdElcBWlRfX1TQvTKzJe5YdDy3WBT+luUFB4UYo5ZmGUiOAvyoWHUOxrRo
	 Rdl0TvEhyPuA+rFqNgbrOUPWwB/Gss/maDWPwI7bBihByu6x7Vnt7djlpen1JMkmO3
	 XaOzjK4eDaT1A==
Date: Wed, 28 Oct 2026 09:28:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH v2 0/2] nvme-tcp: handle TLS control records at connect
 and on receive errors
Message-ID: <auIUldDuE-ldewcg@kbusch-mbp>
References: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
 <auEreAhSYCdGCWvt@kbusch-mbp>
 <a0e96bea-b2bd-4c7b-ae94-a13c57c86f3f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e96bea-b2bd-4c7b-ae94-a13c57c86f3f@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:19:36AM -0400, Martin Belanger wrote:
> Could you add these tags to "nvme-tcp: start error recovery when
> read_sock fails", if nvme-7.4 can still change?
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org

Done. I'll force push the branch shortly.

