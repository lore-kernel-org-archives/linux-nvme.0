Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8D5CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Da+xNBet1Xl41bd7UfmZGuZrF3WOJYqnwGQDNbGAt3g=; b=UvEFObZ2UH7wSB0sqAqSs2XyA8
	w7CYDAnieiNZGDasschLz5m9UjldszSUNACqhB+f9O3Uf09dwI/koriTKg4o3w45UM4RM6lOaEedD
	+qLZ7gHSVL/NvBAsr4Kg0odYn3vLeNi/cLkeQlvCb8XV4u9ZZAjrDWeUmdQFOZjFvGe9MLHuKdQcz
	mMB52m9miY4mZANtAtB1L5sjIJb5S3gO6QyjxSk5VwFQu1j8ieqfQ0L6trljbUiPePW83SNmBNKl2
	4AOGcWjYSG26v4bowSSxtG7sycNC/KwShthglXl5PQdzgxZiZqZPRRJKa+GcIcbcyPIa7axOiozzl
	ViX7XCYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyaEZ-00000008jkP-2jjK;
	Tue, 16 Sep 2025 18:16:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyaEX-00000008jjU-1dqg
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 18:16:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A0756434F6;
	Tue, 16 Sep 2025 18:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334DBC4CEEB;
	Tue, 16 Sep 2025 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758046612;
	bh=su2izlzuG/f0xJC7Io7YPy3C/eDeylPVEWoxq6tJT4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEM3F4eWVRZrwsQCxAQpGMnzqD+2styv4Qrook/lNKTuyAQEMJRge/DB4ngOTDV1X
	 DLux9GAouFv6clIVp8xTmgo0n7p4ObbjIrtp6g5qGqf1xMQWc6tW2AXh2AYoVUl+b3
	 7yqNoBiwRbq8/UXiTpxPoIzHdgmvGgFVHWf8IYXuNUNN5sDdrmj7ygJdaENT/pVwI3
	 Rre0K1J2R6i4kVW9kNt2w9DCcsDt6TzsoDV8n+weX2A47uGjPeLjkrUKUCk2rrt9PT
	 HBDuqnHdUEdgUFsu1kE5xGqvng0nqNAczTdNahVhDI8NrYFqZPnGGsU7mPMkU+CF8O
	 PrrGH7UB9TiOw==
Date: Tue, 16 Sep 2025 12:16:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
Message-ID: <aMmpkm6WIwr-uzOL@kbusch-mbp>
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701205630.64031-1-wse@tuxedocomputers.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_111653_448351_BE865515 
X-CRM114-Status: GOOD (  10.24  )
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

On Tue, Jul 01, 2025 at 10:55:49PM +0200, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
> a high power consumption in s2idle sleep (3.5 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1 watts.

Applied to nvme-6.18, thanks.

