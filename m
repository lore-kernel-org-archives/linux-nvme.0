Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD34C5AC7A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzOSRUF+7X160qCUSiX8xJSfS6L9qF78Knb+9kxZ4EU=; b=A7jl8msBq5weGjGWWyHoysW6rf
	0XCANnkN+4TrGuZzc3/47RPRCFxu34gJ16WSfU205PF74P7meL4Twk9Bz4JJOxYIJMPVdgupmoxiY
	FicCRGryubjR2sqxAHU/32n4B2ogbrPMTdvKFPxdqz/6hXqmXRMkzrOkx3qzA5Nc6+E76LREAnRHk
	RaI41VbPfbD7UvPun1wsUX92O/xAteIDhy3xJM/6HG/E4gB2gxIn4e2PQg3tHxvwxOYznc09jyDI8
	i3JcZfRWF4dj/QQk8bUIuZl9Y+76shNHeaaMtDpJeY3IeSXDG3HhJpNqKtPE9ppCjVB6FuCWxhXx1
	9rnGkSGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsMcW-00000008LoR-3dDk;
	Fri, 07 Aug 2026 15:36:28 +0000
Received: from smtp.forwardemail.net ([149.28.215.223])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsMcQ-00000008LnY-42hv
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 15:36:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1786116982;
 bh=zzOSRUF+7X160qCUSiX8xJSfS6L9qF78Knb+9kxZ4EU=;
 b=bGA5O8fMx+3mpa8dEAsVX8gBzEWMf4qfDC60f+O3XgBiWCGfy3I9BUoBYBK3sWfVqT+kHXHKg
 Fjwui7aU1NLWwM7GavUV0Owzz3q6nzbtGMbOy5aUuKmZy9Vuhxdgfp/qfORFjw3Dl4EGnACy3Lm
 0ZhFK+AO6okoRpqhwfu75jFQdxZWLs41b/GP+S2dvD2Lk+LnCjtusGYXRdcprXRoV4C2T/e9K4U
 txMl1A5YoPfJOcXk9QgDJQF/wYOkOaKWn0G+xnqtDWkPAx9r40A+zcdnHaB+zUeugSHGZSoE6fK
 eP6oX8/kLUfPvORen/7K1md2xVs84ymy7cWFaJQtdoCQ==
X-Forward-Email-ID: 6a75fb6318a12650795556ff
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 07 Aug 2026 11:36:01 -0400
Message-Id: <DKITMCODIHJM.PFQGZCZKZJIH@ubuntu.com>
Cc: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] Apple NVMe fixes for macOS 15+ firmware / M4
 support
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sven Peter" <sven@kernel.org>, "Janne Grunau" <j@jannau.net>, "Neal
 Gompa" <neal@gompa.dev>, "Keith Busch" <kbusch@kernel.org>, "Jens Axboe"
 <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg"
 <sagi@grimberg.me>, "Arnd Bergmann" <arnd@arndb.de>
X-Mailer: aerc 0.21.0
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_083622_996353_3CE28FF3 
X-CRM114-Status: GOOD (  18.09  )
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

On Thu Aug 6, 2026 at 11:27 AM EDT, Sven Peter wrote:
> Hi,
>
> This series fixes a bunch of bugs that were working fine with M1/M2 NVMe
> controllers with older firmware but are now starting to bite us.
> With macOS 15 a new firmware is installed for the controller and both
> XNU and the controller are a bit more strict now. This firmware is
> required once we add M4 support.
>
> The first patch fixes a panic that can happen when the controller fails
> to initialize, which now happens for the first time with the new
> firmware. The other fixes then make it work again.
>
> Best,
>
> Sven
>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
> Sven Peter (6):
>       nvme-apple: Destroy the admin queue on removal
>       nvme-apple: Don't set a DMA direction for commands without a data t=
ransfer
>       nvme-apple: Never set the opcode in the NVMMU TCB
>       nvme: Add a quirk for page aligned admin queue buffers
>       nvme-apple: Require page aligned buffers on the admin queue
>       nvme-apple: Drop the PRP null check chicken bit
>
>  drivers/nvme/host/apple.c | 32 +++++++++++++++-----------------
>  drivers/nvme/host/core.c  |  5 ++++-
>  drivers/nvme/host/nvme.h  |  7 +++++++
>  3 files changed, 26 insertions(+), 18 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260806-b4-nvme-fwabi-000386148b21
>
> Best regards,
> -- =20
> Sven Peter <sven@kernel.org>

On MacBookPro18,1 (J316s, 2021) with macOS 27 beta installed.

Tested-by: Joshua Peisach <jpeisach@ubuntu.com>

