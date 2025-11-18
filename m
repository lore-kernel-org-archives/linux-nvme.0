Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB3CEE33B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chL0AeC1sE1jRvX2dHBjsOg4ETHkbn1RseNLnGh0dfk=; b=WzrDTjG4ZruT5ypRXE8EAveLzb
	xZwWwxp4JsY1CHO+5Gp9ude6ESpM2wF5WIuRNKLp18bBE0X5kFkjl5tsQcETSgMXjNAElL4KGye4v
	XauS0Nc3C0mTXa6O/2ba2iIoB95x/D5L2M+7J9eotEXGSel5H//dP6HiBGrbi6037LmZVpO1I9lgC
	Am/QvMlx1jXKC1fGnKySc3SJ/5VzCmTcgQWYcPsVg1gLwn8oVK/ZtrvOFE3H3Zu5ZmP7CRcTWDrgp
	mlrzLz94pG5HjBGl6OJuhS/IV5s2dYWHxqzChVqYv1zUd6zRhUMu/4rw+c9CjYSfSBdhN/Gyk4JLh
	zW1/S2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLPRA-00000000r98-2v3n;
	Tue, 18 Nov 2025 17:24:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLPR4-00000000r8g-19Xf
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 17:24:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8BF86401FC;
	Tue, 18 Nov 2025 17:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C298CC4AF0E;
	Tue, 18 Nov 2025 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763486649;
	bh=M8Z67lOaONf/tmr+4o9HrN9eRSIJ2trYjVqjqfGfxlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XPVP0681fm+BDVWzM0jz/sIjLLt1GdLomjG5YXAx+Zwhr1YqRHlqYk7G1Rwvp0xtt
	 j9Vl+YXUPYOuniWU8p19EsOTMVRxDU+Fs4EJWw32rsuuU6QjR5rKEpJzHsw24NDSDX
	 PNg4Tw29sMCMrztnEiDPNb3xpNN+zYplwhvCyPXk=
Date: Tue, 18 Nov 2025 09:24:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, David Laight
 <david.laight.linux@gmail.com>, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-Id: <20251118092405.230a6acb4eea49ecc62c65bf@linux-foundation.org>
In-Reply-To: <aRxMtmatG7wbqJKL@black.igk.intel.com>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
	<20251114060132.89279-1-409411716@gms.tku.edu.tw>
	<20251114091830.5325eed3@pumpkin>
	<aRmnYTHmfPi1lyix@wu-Pro-E500-G6-WS720T>
	<20251117094652.b04c6cf841d6426f70f23d22@linux-foundation.org>
	<aRxMtmatG7wbqJKL@black.igk.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_092410_358813_96A20997 
X-CRM114-Status: GOOD (  10.21  )
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

On Tue, 18 Nov 2025 11:38:46 +0100 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> The file also needs to fix the kernel-doc
> 
> $ scripts/kernel-doc -none -v -Wall lib/base64.c
> Warning: lib/base64.c:24 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Initialize the base64 reverse mapping for a single character
> Warning: lib/base64.c:36 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Recursive macros to generate multiple Base64 reverse mapping table entries.
> Info: lib/base64.c:67 Scanning doc for function base64_encode
> Info: lib/base64.c:119 Scanning doc for function base64_decode

Thanks.

--- a/lib/base64.c~lib-base64-optimize-base64_decode-with-reverse-lookup-tables-fix
+++ a/lib/base64.c
@@ -21,7 +21,7 @@ static const char base64_tables[][65] =
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
-/**
+/*
  * Initialize the base64 reverse mapping for a single character
  * This macro maps a character to its corresponding base64 value,
  * returning -1 if the character is invalid.
@@ -33,7 +33,8 @@ static const char base64_tables[][65] =
 		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 26 \
 		: (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
 		: (v) == (ch_62) ? 62 : (v) == (ch_63) ? 63 : -1
-/**
+
+/*
  * Recursive macros to generate multiple Base64 reverse mapping table entries.
  * Each macro generates a sequence of entries in the lookup table:
  * INIT_2 generates 2 entries, INIT_4 generates 4, INIT_8 generates 8, and so on up to INIT_32.
_


