Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBC3CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxPLL65nPbOKx8Ad7shcthb5BP8bWzBb4zc9IRscxoo=; b=zcxBqKsHsxs2vLhzbnn3KiZR+o
	Gw+h1xfLDQCm/GjlBwaoEXH+6nbzm5OAzCPCcbvsY66lnNhr/QQrDdy4eXriYAwaZQoTVJCAO8Lqr
	+3BtCovNnN9Vj6pfmE318vTjbO69f+eM1zuzrjpKscfaQFijKcEpUEA9OllNkW7tIX7DfwRCxSU/d
	1G0E7TB1/rY9i1W7cftiCAOa9fTfuHqfb+q1nck0U9+I43WBPlkwN+9qmku5YWZo0zhHqfOyeJBBg
	euDRxQniHGCZKGN7AkAF5+IjOI8eP5vdhAc23EStU0AAOr63Qxu7XCEhGU6l7FKzqCePJ13qdxL4p
	yiH/zUXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfoC-0000000BlOg-1E0N;
	Tue, 02 Apr 2024 15:12:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfo8-0000000BlNj-2GTM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 15:12:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 05258CE1C89;
	Tue,  2 Apr 2024 15:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1630C433F1;
	Tue,  2 Apr 2024 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712070733;
	bh=3uPvzVIdsw42ja488MvfeVBk4i/s5BNkXf7d+jIAefM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6uenPJ23ll4QSaAK0RGTwR126Fh6imf4EnIqm6uqd6BT8/AjZY+CnMbTUtcw6yWb
	 3MthIWkZmFm1pvJ8a460qsjyzHpPE5ulQNpR5gFiFOvGD9rBkCAf7TCXPTG9HzSxxj
	 J9VoUqo/ynIG4VVwEPC7DhWD22ObuQ7gKpkCb0PDzDmhoqms7bNnubdj2gRuxkC/o8
	 JvjOajTXYNl0ECU6fAiLL/fHzmK+sRTo34vdaNm3phDaHID9fhgIVRuaVAzMc441JQ
	 jgXOgy3y9SgyCux8JRZ/cbhUZ+4BSL+7tvY+KPuF6woBzpGIb2bRN1O0w9QmTTd4oX
	 edTMzAQ1L67Hg==
Date: Tue, 2 Apr 2024 09:12:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
Message-ID: <ZgwgSq3WL_lV9whx@kbusch-mbp.dhcp.thefacebook.com>
References: <20240402144754.751976-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402144754.751976-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_081216_777923_4477B347 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue, Apr 02, 2024 at 04:47:54PM +0200, Christoph Hellwig wrote:
> nvme_update_zone_info does (admin queue) I/O to the device and can fail.
> We fail to abort the queue limits update if that happen, but really
> should avoid with the frozen I/O queue as much as possible anyway.
> 
> Split the logic into a helper to query the information that can be
> called on an unfrozen queue and one to apply it to the queue limits.
> 
> Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
> Reported-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, applied to nvme-6.9.

