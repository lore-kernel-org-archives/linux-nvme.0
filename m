Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE8606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w0zdsSFv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QzyoOlaT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hyqruqqvfeXpK1j4gd7UuPjj27nKLfEHLTernuMIBy8=; b=w0zdsSFvxyr/CB
	GX9LsDc+1OsBY6VYDqsqUvZ+oOcsBbJnNf3rjcZ5EF/yR7bosyU9U8uBBeX++TPjam8smGIhLXoWy
	Sb2ih8xSt1M/yRPGNEa9bSeYI1gfN6DrevdZmzRliOuT0oiq/ZZkCK797HAI4hrDqHedTOa5Z5zhx
	ehpH7Rvh/NtR79W94kcEOyM8lUgkj6iKXWNhxWuCFqARZs32m0qplyF7XFXHj+Ifyh890Y9R76UtW
	HLZ4JWNebJkSRoxcVngDNUcbONht7Nmb090OttpdF+dlBrKquIZaIDmyIC8cJBEhAWw3BV+8n5VSg
	ygBYSrPNdut4egBp4Z7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoEd-0000000CJHQ-1YPU;
	Fri, 13 Nov 2026 10:10:19 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoEa-0000000CJFg-1EvN
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:10:18 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1095353a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564615; x=1795169415; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyqruqqvfeXpK1j4gd7UuPjj27nKLfEHLTernuMIBy8=;
        b=QzyoOlaToeztDO1I6t0DAIFgn1Ja9RcNWKjQSgRDl8dgNtLbnvVg8mVS7I12RIogxd
         0KHnRMQsYUe4Yc2Waae6yySziK3wOruiU00Zr/9tRkKF0MPyUiR29Pj5U2yAb1DxU8Ia
         Nl8s7y+r721c2tJiGUs9z56u14Syb5jJWzoDCT4AYSv33Lrv6x6Sipwg/Q9wCtlqNXBl
         Ve3RfL7UDXlw4+ZORPdMJ5Klr8sydzGD5yJMsEmor6HzrzuqOgXLo587QILLXRwrMX40
         xYKRJBRBywmBJSFNwsJZLWT/LA675mvmKa0ala3ImNfSSMVzVidl98k7b7q/hSzsM5EV
         eMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564615; x=1795169415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hyqruqqvfeXpK1j4gd7UuPjj27nKLfEHLTernuMIBy8=;
        b=atYcP0BWN5rtSh5uA0N67pZyx9Ocau5t2rSlCmSDHk2T2HI2aERXQXhEWP5LJ9jnys
         5Fl1YN23Abof6wBTrIrHQWhsZNNPd9pmf/wXp3kBSAXyf/OvqV672ptO8MjumsxPSGfe
         hehzFyFquAfimHUERV0l2G8JI0iIjTx2FBoDg/BhX4HCwhox8GfZwSj2VSRmlxL292V2
         OLx2wyu4jhn77GEO7cOrNu5DSdFgr1cVDsSqr4LmmhGInQg6Zz0Uis74ui0G1JUzSspv
         +02HiPxVRBnWH7ryktP20QCsb45lIGRBwmOhtBYExEMWkK90dnvQsmSraOGlVh/zh/QT
         Y0cw==
X-Gm-Message-State: APuU4Z8tU7H/ZZZBq1tfLfHwsl3+ckJeqy+6c881Zl6GwIs8KW6jvjbS
	EfIxHjY4svJue4qx32C3c9T0LF2PN2+uBq3QNIrfa4nTti6iATFYjZ9HPGxv8hhE
X-Gm-Gg: AYBFou1TrPMslL8VzGKbR9Dcaj37cxr02Xd5mea9tVXBow1uPBEbf+mdsQDAMH7hAnX
	c6KEUiYZ8wAeRpG5D6nUiDJWg2dkrZ5eM0vzF731n0EEhwSUAEnuyW3imnKZkfrCy1uUHZ/JOAh
	bG0DQpGAyKIj3x/vuq17bd5TeZAOYYzq3aTWhGxJQRNX+NKycH6xbOsWaOeGiGZ+n3WnmsvNdar
	esbrwAtTEWu8M/KpgxdWG70CoG+KsXNnSqmsFA8RdB67XV27SZvp8gQXDguH6Uy/w6TDGo2YMFg
	z0WnT1igNDw14f3VsgSzV9gqXEPcD9+Cp7I9L6Xlot5VoQWEDj/t9zJQNTrzU6+aLQTGsEPwE5+
	1Hqf6BKNgA1AGq2ERX1acIyvit5zytQE7WdAJxemK7UE0QAPqVqYj+JZxAnzkMfKH9AqVvsFacA
	+9b+rm5itq4ptsNyUxCvxSDxiefgASObJWGDW6qBs8BXQGDkSJLh8dFAZupkYjXqFrGlJahAGK4
	Mm6+ZpT2iqFTw0vEjv7nTp2Tqg4SPfMJXyMDqnVJ7drb+DbqEJaKPbbylolvwvRHSzwirNHf48X
	zWpQjj5207TrlK8F++8JagNmZl5EEQ==
X-Received: by 2002:a17:90b:1cce:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3b1b0a4a16amr1766572a91.52.1794564615277;
        Fri, 13 Nov 2026 02:10:15 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3af2dsm3826016a91.9.2026.11.13.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:14 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 2/2] nvme-fabrics: bound keep_alive_tmo to avoid overflow
Date: Fri, 13 Nov 2026 15:39:51 +0530
Message-ID: <20261113100951.17577-3-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113100951.17577-1-marting@netapp.com>
References: <20261113100951.17577-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021016_362490_90CA55F2 
X-CRM114-Status: GOOD (  12.31  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

keep_alive_tmo (kato) is only checked for being negative, yet it is sent
to the controller as "kato * 1000" ms and used as "kato * HZ" jiffies for
the keep-alive timer; a large value overflows both.

Reject values above INT_MAX / 1000, which (as 1000 >= HZ) covers both
conversions, as the target already does via NVMET_MAX_KATO.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 25029978b978..b4ca0f9fd703 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -837,7 +837,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 
-			if (token < 0) {
+			if (token < 0 || token > INT_MAX / 1000) {
 				pr_err("Invalid keep_alive_tmo %d\n", token);
 				ret = -EINVAL;
 				goto out;
-- 
2.53.0


