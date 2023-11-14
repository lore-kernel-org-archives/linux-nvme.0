Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB95C07524
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 14:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=034d0+jdxTnUWxQ02VoYkoPA67UyVnzHzKH7yCxURhs=; b=IL+37lZ69dC3diWIxFB81VzrgY
	XsNWZjk2C5UlsL81EMFN0D2qPzoxX4jfwUojfVKcO83L30UJOO+gbRopTSKPusRnIuX0F7qoM8f00
	A/DvnLMYUwXQkk82mVVuNFlVqy8wwd0FjncG+V/8vLaUSOjKSV9d6tBh67gwRKQlYIyozManFYSLF
	nUghUeduc3IHelgOr8ieWelHo3diPmGk/ilOCCs9UOT3kBuascS5e/z1wqD4gc9DV/77vVoIOwZGZ
	0Tqqk1YcjVPHfKomSDoiMpGCAcmRtE+lceQaFL50XhmK5ME273NRIcG9//6A7eexpVpx34k7bJtcz
	R2YtEPZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u21-00G7OJ-2s;
	Tue, 14 Nov 2023 14:04:45 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u1z-00G7NN-0w
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 14:04:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id A0D22B8123F;
	Tue, 14 Nov 2023 14:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3773FC433C8;
	Tue, 14 Nov 2023 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699970681;
	bh=034d0+jdxTnUWxQ02VoYkoPA67UyVnzHzKH7yCxURhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bK5FBxmeUBWWWPv+iIX2Af+RxSBaYf3NI5mkxn0xQLOjG2LWEVGjhs0i6Y9pjcLWr
	 ihkn/6iNW9CIHaxyfS4WSosYPl68R+wL6sr5rMlyFxQiSM/pSDsv65MH3so2B0R2qH
	 AmHNz9GUvcBToA8ZPB5tj8RiUXtX41LMkEl20f1TX/APjV13U0CD8WNas+KuI44tOF
	 u2pHEg+SyN5ZKr5n9BMLfi9t7SrJndNyTW9+POK9RUa7VMf4XhaDUPnFK+Ui6iBTKC
	 czPX/cFZFY2FiwCImMhhlX60NT+vGgUHI0o3Uvh/aX+c8zqUbdf9txvfgs7JBhW9Pd
	 XbU6ot5ir7I4A==
Date: Tue, 14 Nov 2023 09:04:37 -0500
From: Keith Busch <kbusch@kernel.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH 1/2 RESEND] nvme-auth: unlock mutex in one place only
Message-ID: <ZVN-dSBf0y5vrukB@kbusch-mbp.dhcp.thefacebook.com>
References: <20231011084512.1835614-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_060443_472502_1D122742 
X-CRM114-Status: UNSURE (   7.02  )
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

On Wed, Oct 11, 2023 at 08:45:11AM +0000, Mark O'Donovan wrote:
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Applied to nvme-6.7, thanks!

