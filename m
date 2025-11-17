Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A8CCE8D6B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 17:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eL3y6nECUMXRHGssV4q/VtRkS67zrx3g5Vsv6v1H41A=; b=2keoOXmYOmJU+gt7MxorbsOs04
	TpxqjDGeW81qIKJlEhYY377IABt0tqVwT4L9/mW5qn1c9KSOURiVK3lfl0lsvOsRk+ElcwgCR8bUm
	/CisRd6ZRPjb7sIjeAfOMq40lTNdAMRyvNDBJaYCO4Z2C+zTjf4Tz0lSDu3/B1Yug4Av+HpDCLpa1
	QgEJa3YW/rbzmH+O6k5TUwak4WFC4PGlkcTQQaG4QKyaz3cygw6rHulIOOqz1grjYkRAuENXVlQlO
	EHlpnUa33D0v/9csetRTLJKwr+0U/d1a5KkB8MrxwknveOVNYTQlHbGhjM9ltnEiEw3LjViN8meBm
	RfRfWhxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3Ja-0000000GYx5-1GEQ;
	Mon, 17 Nov 2025 17:46:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3JY-0000000GYwd-33JQ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 17:46:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B9E85601EA;
	Mon, 17 Nov 2025 17:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C1C2BCB6;
	Mon, 17 Nov 2025 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763401615;
	bh=8fQeAXFxhDLHZ8XWH5bVVIvjxQoz0qNlME78SIkpr88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rsgCdPZ36Z3bVe/8qCb1BmS51FkMU+kCpPEgDGsqknMmPH4I1YAoorVLzSplynX4z
	 PzjCrDLx8f447Xr/nHhHMUBIsEvWZ8KfOv44mjgvdYldPsKDE9N0Fvza28ZufnyX2u
	 Me+X470C5QBNVCLTm9wZhmJBU2XW0OE2nNlnmouw=
Date: Mon, 17 Nov 2025 09:46:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: David Laight <david.laight.linux@gmail.com>,
 andriy.shevchenko@intel.com, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-Id: <20251117094652.b04c6cf841d6426f70f23d22@linux-foundation.org>
In-Reply-To: <aRmnYTHmfPi1lyix@wu-Pro-E500-G6-WS720T>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
	<20251114060132.89279-1-409411716@gms.tku.edu.tw>
	<20251114091830.5325eed3@pumpkin>
	<aRmnYTHmfPi1lyix@wu-Pro-E500-G6-WS720T>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Sun, 16 Nov 2025 18:28:49 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> > Reviewed-by: David Laight <david.laight.linux@gmail.com>
> > 
> > But see minor nit below.
> 
> Hi David,
> 
> Thanks for the review and for pointing this out.
> 
> Andrew, would it be possible for you to fold this small change 
> (removing the redundant casts) directly when updating the patch?
> If that’s not convenient, I can resend an updated version of the
> series instead. 

Sure, I added this:


--- a/lib/base64.c~lib-base64-rework-encode-decode-for-speed-and-stricter-validation-fix
+++ a/lib/base64.c
@@ -83,7 +83,7 @@ int base64_encode(const u8 *src, int src
 	const char *base64_table = base64_tables[variant];
 
 	while (srclen >= 3) {
-		ac = (u32)src[0] << 16 | (u32)src[1] << 8 | (u32)src[2];
+		ac = src[0] << 16 | src[1] << 8 | src[2];
 		*cp++ = base64_table[ac >> 18];
 		*cp++ = base64_table[(ac >> 12) & 0x3f];
 		*cp++ = base64_table[(ac >> 6) & 0x3f];
@@ -95,7 +95,7 @@ int base64_encode(const u8 *src, int src
 
 	switch (srclen) {
 	case 2:
-		ac = (u32)src[0] << 16 | (u32)src[1] << 8;
+		ac = src[0] << 16 | src[1] << 8;
 		*cp++ = base64_table[ac >> 18];
 		*cp++ = base64_table[(ac >> 12) & 0x3f];
 		*cp++ = base64_table[(ac >> 6) & 0x3f];
@@ -103,7 +103,7 @@ int base64_encode(const u8 *src, int src
 			*cp++ = '=';
 		break;
 	case 1:
-		ac = (u32)src[0] << 16;
+		ac = src[0] << 16;
 		*cp++ = base64_table[ac >> 18];
 		*cp++ = base64_table[(ac >> 12) & 0x3f];
 		if (padding) {
_


