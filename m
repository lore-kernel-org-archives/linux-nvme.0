Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720D9E9A04D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cD5qcELz1szuWzdXkgd0fgG80WegTttIPZeozvdhos4=; b=pZoQfywD0i/udgNoUWNa6gKi1I
	Qw+QjAh1V3GSeQXiHoXQG001xJ9+KIY1ZPyXOrsOuOYV0Q6wxLnDGtXMtcBSL30akPwcwQqk0xQpP
	IMdawwuJFxnQtag+XTlYbXhkKEPQ2I8q7WDFfJLraPX0cR201MQ0UHYr5V+cV0+oWjS4qqmCMfe/V
	8r0gBzZyyXgwiulyvfmDphP6E4EUoSo+6lqnNZhPCrqGVaS7ST2eI75QOSS6HO09ln4Ngozo5ohKF
	d6bHK5y1FA8mXsRY5rWcra0WULvS8pBMkFxCCk9lVaVGcKOEbRxRNjcRTd3APiKujpDvsUkt1S1EK
	OTczAdTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst52-0000000Ahb1-2bHV;
	Thu, 19 Feb 2026 01:43:48 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst50-0000000AhZW-0iVc
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 01:43:47 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7d505fe7b24so74621a34.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771465425; x=1772070225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD5qcELz1szuWzdXkgd0fgG80WegTttIPZeozvdhos4=;
        b=NSmxRzd/NGlsS3Oplx3C8Mj4TMpfsBP5lB4LpeIP+zZSikapHyrDb3VuyvvMmQOlIq
         6jax0tG6boV+aezDXjANvybyO00woQaQgBbXMVn8/2MK7y7V5KSgC2g0mo6zO7bbNKon
         DfO72z5NyePKWX/By7F73i/tuRI8rS+5voogJgF3+xMdxqDwrRFl8mMPZHfUrTfg+45Q
         BoeurvqAC5DXNDHM5L/CSNPqgtz+MZsT5erZag2zD3ddSity5gM9luxAFxeNE/aQvgNg
         dy3wUPab6+1t/bR73ktmRVy8f7pIimBuirb+Bv7lSHPWUPF9aesnpLlFTPjMO6vFpjQI
         OATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771465425; x=1772070225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cD5qcELz1szuWzdXkgd0fgG80WegTttIPZeozvdhos4=;
        b=YwwVPDPjjMaa8vu7tSZg1z1N5lXKaCrzjh9/+UW7cExvgqNCSWo9Uw64Nz5g4IpTpv
         frKj31ky64XlR/Gp1vTyQIey3tqaFrfSMVqtTz7OGgP6Yi25j3sY3Q8UjNwcoT7zAQJG
         DVV+97VVaxDcdjJuj9gnZil2DLzkoLND22ll6Ym2pGME7Ej3CI8AQyvpqs4Bxvxk3dyN
         FNFh31aWCDHJuJYtmgjfoRxTCiD8del1Yu9yVOzYEsNw/IgVkQj2xufOYrjEFgWGZnjO
         OWsutZX8u0NlWJ2S6SSpmRc5z1+1Ep+/j0u/HAVK62R22ma7CHdzhJU+sP77p/7Iw9/5
         YALQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzkKVE8mxA2VtS0NRYr0pSJ/CeRDNEG/StoHuFOjw1hQ7FpTscwT422uU3Z3sNBXRXoEOo1rtBOjrC@lists.infradead.org
X-Gm-Message-State: AOJu0YyG4PsGFwCKwjrBlQA5YgKA8dcEcJpAgHuNaRT+Ls83eitvs6B2
	5khYnbTx48I1U2WWZiE5OpWYuxqtSOYcksHulVg05SXPVd4xYLke/N4hdIqhvNVCzQ9dRQF9OKA
	5Zcun/Z4v8NsEZDjci/wcl0+D5cCVH29Deqf7
X-Gm-Gg: AZuq6aKqhDtWDRREg/kp11Gg0asfS3z2RaY777Lw/1x3KfC1FCfYESl/ZWJFskKI+Xu
	0eSSOM9NPIMfGhfkebBwzkesuwU4lBNsjhSJ1m2OrCS7b13UsI06o9rzO770MxcIP+vRa5JBgEw
	1dWgIkrsOQvGKOwGf+dOy0br3bz7PW+8ICH7efiSVzrQTj+6SgrUWKh8Gz6ow++/fwTjC3W3dvH
	In05NSR02czKKzutYgwdjpKGx8sCgWRwHuAjUNZW4EUfIlUBzIdQgLO+riRxcmtW/83pihFrcO/
	gwQUcywomo28GqUKuzBsqK9xv9M8K+x9rPyYv5htfG7CbaxGTERhhwc55FPzx3MSG9jinZWyUma
	1K6fnyrUlvJnfV+Q9yQJ3Ok3KLIzSmhgrD6PX+l/xfHkbj7pFtVgPkA==
X-Received: by 2002:a05:6820:498f:b0:679:ae61:ed85 with SMTP id 006d021491bc7-679ae61f23dmr566445eaf.1.1771465424693;
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-67997aeee34sm737226eaf.5.2026.02.18.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D8A4A3422C7;
	Wed, 18 Feb 2026 18:43:43 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D4182E41D2F; Wed, 18 Feb 2026 18:43:43 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Wed, 18 Feb 2026 18:43:34 -0700
Message-ID: <20260219014335.9061-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260219014335.9061-1-csander@purestorage.com>
References: <20260219014335.9061-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_174346_220492_9FA1C764 
X-CRM114-Status: GOOD (  15.87  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll(). For these
uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
don't set REQ_F_IOPOLL, and don't set IO_URING_F_IOPOLL in issue_flags.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/uring_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b651c63f6e20..7b25dcd9d05f 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -255,13 +255,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED))
 		issue_flags |= IO_URING_F_CQE32;
 	if (io_is_compat(ctx))
 		issue_flags |= IO_URING_F_COMPAT;
-	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (!file->f_op->uring_cmd_iopoll)
-			return -EOPNOTSUPP;
+	if (ctx->flags & IORING_SETUP_IOPOLL && file->f_op->uring_cmd_iopoll) {
 		req->flags |= REQ_F_IOPOLL;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 		if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
 			/* make sure every req only blocks once */
-- 
2.45.2


