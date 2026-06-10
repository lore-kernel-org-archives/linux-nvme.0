Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003C5CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7dPxnf5y5nMzhvPFhwEK1bpTsY+rN0L+Z7guGps/tU=; b=bCDNfcnyH3n5at5g6rDmvSpgrg
	uoeaeisaBxiP0iHFXKop2c94Pf74aJ/xie8aBxqK+lUePzry+RSl7vxrY+rInVfOejmnT2t7kJxu/
	UMqvLzZ5/air57uCUT/JV8XnxsOdUBd2Eaxbijcsama7Qy26faJosgbOLtSCjkIqaAyK92cLA2Smh
	eGTuLf/ggsc9igD7Xy35/DUmpP83xu3OLzSJX/U47y4b0vqMdWHJlZBkVAdqCW2SgToiTa4JCQmWo
	ZM3bT8grq7mtUDTAR3PX8wVcwkUijqyC+jZhkszV0Uekc2jEEVU4C9owM+yC6LbtsZD/8vjGJoYwr
	1Z/5/qcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXK1a-00000007vfq-0Kah;
	Wed, 10 Jun 2026 14:35:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXK1Y-00000007veY-2XZ4
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:35:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 292AB40DE3;
	Wed, 10 Jun 2026 14:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EAD1F00893;
	Wed, 10 Jun 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102120;
	bh=r7dPxnf5y5nMzhvPFhwEK1bpTsY+rN0L+Z7guGps/tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kG1fpCvAgjW1xsinLyUplTJKlJgsZmn2iUWFgBQr2k/s+Q3GUIlVAVCEJ6R3kRXq+
	 CuJ5LJJe4VlH+Ht7DafWjN9MamWTgRDeRnvOl6HB/kg04B8VzmB13Tl3tAaepNZYcO
	 M5JsvbVj5X9tq9+iW/5+joMs5q1QOkS9hWvvq8Ii9fpWRVXauyLX95SRZHCvoKZF0e
	 C2XVNfEhogy4zi8gIm3AH3Nyg4bq8xRT7wgAxZeD+GOjkA6MCFF/1+LdCWEpcMCCVC
	 dePaZiiosfseJxMcUiIh4EGGiCm8aGdY6MJH/tglg9/71wHPnnqCbttNiQM4HlDvkU
	 Af3lfcfotIwRA==
Date: Wed, 10 Jun 2026 08:35:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: mlombard@arkamax.eu, mkhalfella@purestorage.com, randyj@purestorage.com,
	hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
	emilne@redhat.com
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before
 it is initialized
Message-ID: <ail2JuRcg6lE007b@kbusch-mbp>
References: <20260528092734.258899-1-mlombard@redhat.com>
 <20260528092734.258899-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528092734.258899-2-mlombard@redhat.com>
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

On Thu, May 28, 2026 at 11:27:34AM +0200, Maurizio Lombardi wrote:
> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> A new nvme-fc controller in CONNECTING state sees admin request timeout
> schedules ctrl->ioerr_work to abort inflight requests. This ends up
> calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
> admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
> see the warning below. This is because ctrl.queue_count is initialized
> early in nvme_fc_alloc_ctrl().

Thanks, applied to nvme-7.2.

