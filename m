Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF7EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukzWseSMiIPsTawRuHLxnxGMRUQfPdY39JS+gDycJ28=; b=YJhCleFILYRRTtFZR/tLHBENey
	SZSfyR9fVjog113IcSE1vhSu1UGA7Ak/KQGwZEkLptz/rLzuhIB2oA1PPOxgiVUt6G0OrLMqtOo8i
	67KoXu0uhPIm6brkrZFTRRwk62+zSwu0AZOkypKCopwttmZtRYp+4cyT03uIBJK3caRYcfED6mR9k
	CeUtX/PgP7ZiMnE9R8t3294i5zaME2OQEHU9Kc8jEYiBAGCBBGQv1CnGUQhsyWDsZL5lCwJIWOyGi
	CADIMYIUfaehlKGwRl/UF1vfdL4ieKcBaKXG9tVezf6d7G5iII6mS+8jNqqKN0fdXJmxvNkPYVkE4
	u8yEup1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qUB-001aZR-D4; Mon, 27 Jun 2022 15:17:11 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qTN-001a9R-28
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 15:16:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0A239B81062;
	Mon, 27 Jun 2022 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63126C3411D;
	Mon, 27 Jun 2022 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656342977;
	bh=LCPAlO6GYl8hvXLERDi+A/zzSOWnD9x9n5Jul0NIduQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GG4xDhvzUAO5gZnuJzQ/C2rkwDtudAqdOaY4jyYGsVJR8QKWW7zyYn/9Y4quxWY+O
	 InoxVXcy0SIpo2WOcvwA4pTOJqoPAcjJjZ9d+Ap1IdThy9UD4CqRzp6jT7mZT/AcSQ
	 Yh6BTptbnqBXSXCqxXElrH1ZXJuSbsrLSY7Xoaa9JXU3vmLAGG118C/guxPtSp191j
	 t6dpN1qY8Aibq8svQpxcZbtPTWancAS5oP4NFJ7x56wonUXJSIg6N/Bg7rr68v/ol1
	 0f9mDHGJjkxOplpwh93sZoqCNIxwuo07DCXUFWuWLvGQwQ2Bmv9myA+a//S3Kj6pS/
	 j2JOTD7u1hPLg==
Date: Mon, 27 Jun 2022 09:16:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] Add new clear_ids attribute for passthru targets
Message-ID: <YrnJvv8XwpajD+Iy@kbusch-mbp.dhcp.thefacebook.com>
References: <20220622224724.19623-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622224724.19623-1-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_081621_329413_7482FAE8 
X-CRM114-Status: GOOD (  11.09  )
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

On Wed, Jun 22, 2022 at 03:47:24PM -0700, Alan Adamson wrote:
> If the clear_ids attribute is set to true, the EUI/GUID/UUID is
> cleared for the passthru target.  By default, loop targets will
> set clear_ids to true.
> 
> This resolves an issue where a connect to a passthru target fails
> when using a trtype of 'loop' because EUI/GUID/UUID is not unique.

This looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

