Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC7FC28B2E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8rfESo8x8v7gjQHt4j6zjNqC5nQ6gQK8EAIDHFRYP0=; b=ebhuKNy0RJU/7WAP6za5jtkpPF
	ye6kzdZ/B4byTkBtjAMnwaN0CHutFlywbz2MubNzibfSkakHS7BykZ+I4sEwXH03ezXhjWnRVPbqA
	2AF746e1LKqeEn6fxqKngIehiUkRg5ms5O0kyQkRu+OZ4LyuLZH21zrAWmqiQfHCWjb3qzpa3lO56
	C7eLGKWsVEnl1Bfii7BybLN2cKveqgocGh2Brj1iD0JLam2suMh+PMxXjcR0zEXhg8mHot7Un5Ool
	1NZzJu2K2+qG+CBdkaQxT6nnA+bE0foH/MTqhEByjl0+tmzDNNWaQmCM4f4CxfFrjIcavNizBZzDq
	cNVRilGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trhyU-00000003ctN-3WQo;
	Mon, 10 Mar 2025 18:35:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgzm-00000003VWm-0C3n
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Mar 2025 17:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z8rfESo8x8v7gjQHt4j6zjNqC5nQ6gQK8EAIDHFRYP0=; b=EtZaefOx0fRsnUFI3C6sm8iHxd
	UmXZSjwyitOf9sFE2ii5RNrmpmzINKfNsCctI87aQ4yGbw3qxFtm2zw9oBrt9CXvLG+PpdmfWl1D4
	t5nhVZOtlUD75NhRB1zMa/H8PcTlid+Vnpj7D9oTySYYyJJetY2RdPoXph14D7bEG4UcEi7rbFxmI
	dqbdv6vadtUXhBoV4zYa8aS3UgedcZ2FVtraDgsKp7Xmtx21E5iuP5ylozJK+yzlpeRfXlPECTali
	gR2MJ2W9d5fXU6OHkUcv4igIuU4XcCEiJUW6Ca05vZogO4itb3SQxBKSMYlYM2oj1VXQWhKASAp9c
	aWwUBUgQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgzj-00000001zAD-0x0M
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 17:32:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 001855C26ED;
	Mon, 10 Mar 2025 17:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123A3C4CEE5;
	Mon, 10 Mar 2025 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627969;
	bh=z8rfESo8x8v7gjQHt4j6zjNqC5nQ6gQK8EAIDHFRYP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM+ry0XHst+hVgcCe5UkRDh/e8ZrnNkOXjMy7rysy8e1TiWayHgRLRE/AaJHn9NcX
	 IDM1MIGU2uFxzbRLs1Wa08aetMo4CNqQ804j3i7jazZfUPCW29Ax9H3f+3BcF172Qq
	 uFAUymLuuvbNzAlsc0KEAaF/Ced7uubyrwgXB+BWNSfYj08D7351lH1fM90iFtoH3u
	 fZFSE1UnunwsBpV7q7PcTcr0/BCPQxgaiFUsetHFzmVhIDuLZF3rEK2Rn+JjpRg1ui
	 k7wbYLz0XWGzeE3pODsMNdsdUZ416mIkJ1Vdf52E8coU2w4u3AdZFsNzw1ursCm91z
	 Wf/jGRX+VL/0Q==
Date: Mon, 10 Mar 2025 11:32:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: remove stale comment
Message-ID: <Z88iPpCGFLaWwtBr@kbusch-mbp>
References: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_173251_476082_8D4C6201 
X-CRM114-Status: UNSURE (   8.12  )
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

On Thu, Mar 06, 2025 at 10:53:31AM +0200, Baruch Siach wrote:
> The ns variable has been removed in commit 62451a2b2e7e ("nvme: separate
> command prep and issue"). Drop reference to ns in comment.

Thanks, applied to nvme-6.15.

