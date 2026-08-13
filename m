Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFFDC5DF6D
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3gHVSfPx4U68uLlY375AwcJ0acW/vtx4b7mVSQ27/Oo=; b=rZz+Ze8jF/KGQF4B/zd45somwu
	1Z5x6BxkjjwVmRaqFlEFJG530W1emoT3xaN8LkoBI+t5cyEsbuQuzJG/gVwT61kMquV54uAvsmzTw
	Fxa8hjVFw+GAB/MTgg0FvIFqURG/YmJcREmrkqBQiuYRIILS2uJWojCMTUgDU8o3YiE6IHCh8tT93
	5r9oM8iP4Udlw2t47JZwJxwCN13btL875TDC+2BuPQLjs5/Uzp9qEkzhfVs4WxyjsDRd9ecWAL2Bm
	7cMQ5QRlVSRXNji+ScUzu9perE1M7NaTWflVYlBlvZ88TR/xMXiBqLt5g18TQgHAnUn6+CJWiX234
	PPcHTleA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYFk-000000019oP-2mJj;
	Thu, 13 Aug 2026 16:26:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYFg-000000019oB-1rZF
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 16:25:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CEDA7408DD;
	Thu, 13 Aug 2026 16:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFF11F000E9;
	Thu, 13 Aug 2026 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638355;
	bh=3gHVSfPx4U68uLlY375AwcJ0acW/vtx4b7mVSQ27/Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBDZjV70yQ7bfUOjwXJ1AODwaOibJQzBy1dgFCYmiOvskBxSfDn/L9WWkOqP+4UbB
	 UAC+UjOWcRtUJI44CSr8ccmo9lAxFwuO1geddoI7OKf19PIVh5XeLR2A6M9e4JzqqR
	 qOVB0ZZqasui4v79WlyLnVr+9E9g0xmlusKy6M/hrxl+TlSp9KBSmig4E5kL9nEOqd
	 c3JhnuQt0Zb71JOZ2RXS4ldR6Hm/SwBGW6bMz6OkW3RsHcySpziSA2+GNldsXA105O
	 FmI2E/hmUKoEY6lZ2y0ltN0W5E3X5cD5OapZQ8Ixgy2uHBDjc0SRXfMZQLMS6nu2bm
	 rUq+8z5TNtwXA==
Date: Thu, 13 Aug 2026 10:25:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hare@suse.de, hch@lst.de, dwagner@suse.de,
	linux-nvme@lists.infradead.org, mlombard@arkamax.eu
Subject: Re: [PATCH V2] nvmet: fix max_qid race between configfs and
 controller allocation
Message-ID: <an3wEhqGJ59tiynL@kbusch-mbp>
References: <20260813131850.79899-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813131850.79899-1-mlombard@redhat.com>
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

On Thu, Aug 13, 2026 at 03:18:50PM +0200, Maurizio Lombardi wrote:
> The function nvmet_subsys_attr_qid_max_store() can race against
> nvmet_alloc_ctrl() when a subsystem's max_qid limit is modified.

Thanks, applied to nvme-7.3.

