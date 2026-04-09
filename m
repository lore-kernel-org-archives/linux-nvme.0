Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4ACF31E22
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XicQCsg1xLD0EvZzKpw7Ml61zswDMzAai5aJo1k2FtY=; b=V4XVCIbRZyxqs9uHe+QR1fd1Qy
	RKK29KhGz7N9vbI86NgSdcKqS04RMjpEf5s3fUGxdrUMRkmK9QDUHHzimtis7q5Z5rGRqD91QuojO
	vl9uMwgczpPIkjWC7Lcd7gRy7n7+DhbVMYcIbcdAkoXw+f30ygTumTfi5KkarknPAgbr0sd6OLvvI
	FaH0Fk50QwtAzxlp1O6q3yIyO4uA03spkcGewN4K8ZXPx4NfjwBxES+BYqTT/4HrkaBQdv6dVOOBA
	RhqHE+iePON8Sc0ZkYlL8cpFOKTHkrGUMM0uHv6usa9FC7afijw8m8uM+GyPekQWzDFG59D4YmoNa
	ByiBDnzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqGL-0000000AgM8-1OmE;
	Thu, 09 Apr 2026 14:21:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqGD-0000000AgJk-2L7u
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:21:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B288C429FC;
	Thu,  9 Apr 2026 14:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41240C4CEF7;
	Thu,  9 Apr 2026 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744492;
	bh=XicQCsg1xLD0EvZzKpw7Ml61zswDMzAai5aJo1k2FtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgwBgatImg74bo08kTBEwRgREjX0eqYeNLjGWphF3btnblTtBsCgd4/TmsT6qy+Y1
	 H8NtOOsSbpfO303NhfKlZ6PlOBguAUon9cGYu8Vvc6XXYLv24H2VxhCIGr9kPXdcq3
	 G9q6oAl3PnJOhbpW4zeICbCwaus4+oK6xLO7Mwvwh84Eq89zEb+93yPlXmOP1rcW1R
	 RQPUQ+6qaTo6njLvlJ2ekzxheVypLYSEW63YUY/CNgzVEVF3cPepalMov5Q1exfCkc
	 dR1K7QI6McP0qgu6X3QOPe6nAQHwXniSXvWPKZ9M3984pIcz304dPGlEehXroVaXe5
	 ZAUotwShfW9lg==
Date: Thu, 9 Apr 2026 08:21:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: skumar47@syr.edu, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix race between ICReq handling and queue
 teardown
Message-ID: <ade16pEF-OrE8vz2@kbusch-mbp>
References: <20260408075131.6221-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408075131.6221-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_072138_404251_C2A1F11E 
X-CRM114-Status: UNSURE (   6.17  )
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

On Wed, Apr 08, 2026 at 12:51:31AM -0700, Chaitanya Kulkarni wrote:
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Thanks, applied to nvme-7.1 with the overly long line fixed up when
applying.

