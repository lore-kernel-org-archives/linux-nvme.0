Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECF606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s6BdTfgV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oa6WbmMK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=q/o6QxtsxIf6wcwI2DDGmVfiQhlWyQPeAmbQHDbpAN0=; b=s6BdTfgVTxFoJq
	lpYR5ZPfetrm8jRrwzTupwdf4hQSBk/GVTTz/U9CulTJ7nlQr4f6KPn6HIkAB7BGMrXQwVosUWsVn
	loId1UbRmpTDiZ+M4slEX4iBHZVGHjGgGAA+vllBJlWMPz9khMMBF7GaNjhW8vYG6NIA2isNAn8Uq
	cuewJ3GJvZkht76+78U//nJuWKEcuyy+2vYXETSvt2pEEHKuvdoAqtXLo/8tbIxHqY17s5DioJZbH
	XNqZQAoGpPRsC2jGIHWpI4uxoK5y5Fm+4MaxaeMcpPErr8pxklHILlxIFuxZ2V1/QecEbaEY3KcrC
	tZo2Xg3X4SFqzS35H/vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYJ-00000001t5I-3bhk;
	Mon, 16 Nov 2026 10:03:07 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStYF-00000001t2j-2J89
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:03:06 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ed11653a91so18579845ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794823383; x=1795428183; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/o6QxtsxIf6wcwI2DDGmVfiQhlWyQPeAmbQHDbpAN0=;
        b=Oa6WbmMKlT7m2flyZHhV8wDNea4eKkGkE9JqArnzdGTqiTIRqgtVmD9EOzC1MFSb71
         XSmUIUO6fd6vFzkl3lF+AxDEOo+ZYcpi9Ot0FShxjD703mYCch1DfSuCe1dx5d3uYdHH
         RYsN5nY+Lx9CyCiZTicEyrAzwbsKU/bRTbAmtDpj8XCFjvwGFO2vmKE9Y21meGBCb+Ss
         JH3SMYBHneYYrs1hE1kavdzBKBWTnwN5FmMTcV/dbtiNBhYw5/1hXlEqKi+3ZKD3F+WA
         2QQF864BmAIOdX5UDYgdc3Zj6FEnBUkaRnAIVH6veQ1mjLTixvl3gSI6xeG0H72ul96B
         R86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794823383; x=1795428183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/o6QxtsxIf6wcwI2DDGmVfiQhlWyQPeAmbQHDbpAN0=;
        b=nUmNAzRj/rukkyvn3wOhoyeOugToTXHhi5bLg8BvQqLTGmkYLfBecK6fLgRoUQfK4r
         odCD2rj6nzW3o2df4I5c3pgQlpmW3yxVCtYUBQs1N3bVUebd1fW3WMjwzDnHbWsSF1Sw
         i0eyEAhyl4zfLDxtC5VoTSBI1qdtHCezk559y7vdvUHn2htKxGjgUh26q4HQPBqZ6E1O
         uD+jLnVGqhjO+3B6EnMUxn6mzRI9rGpdNQ3wmZxHYvL6I0qGVAhggFYRT2VLPcIkbjW+
         U+gnSPZdPRfLAeIFw2hoeRjjkP/LIW2E6I1o3+LTR4qOJb+ephUdx94n3JQybLXu4E5E
         4tNQ==
X-Gm-Message-State: APuU4Z8K1bz7063NRB9eOeUjxWI0m3W25+Kul7NDHCiF6TtOyY3sxgkJ
	U5zLEWlBSYVy/0etSSE1LMagVo3aODOg+6PL0NcrA1Hqc+5lh8EnerMtdqnC9TQY
X-Gm-Gg: AZFdTZdeWBnAP20ffirtPRpqhYSrM8zLoFto/PJJ7GFGvZ6yGcWdub/eILFdd9n4eQo
	Ifw+MoJNt/xeF0IgAoyIGlV5rJcbeF6/5bfw8Pg3Tvt87oDnbQ43N2hQO7w7xxq+1HAYq5ZCvyY
	VEnVGiwricPoTZXwM38Lw8mjMuXON+ykaq7P/zGNPNhL7Uz/KV4BQVL+PIqSKda4wdOGsZCOE95
	/iYxwN34Nwb+U/z4vsSR2r9V8fEYou8vrGldPLSkaaR7gRunp39kOT1hD+N3FeVdWh1OV5Smg3f
	aiMP0lPaP+DlMg1RB5PtwMjGz8q0nW1cOz1ndkq23UirfCG+chrGIIfbni9fVET3D11Ai1zYZih
	Gyk31waaQLtFJmRntcpPo3tvlI+BwyR5DGx8FWo9k7OsE1tFjtIMwrEycoFuHAA9LXUwAyNm4tx
	q2dPEhTZh0wg+PkVdwBgC8Dy4xg3miKfyg6MBzWSuhWfrDUd93StEXTY+Zo1mTA708ISRUu4zxO
	tYohrUUQ/KGerJnUeTkVIY3NE8owovINL6DaTAJL8S4OlbMHYgi+ReC+qoFleKVIjDWtRp+8VvS
	8X/nV/xyxdwMbKQVtxhRSRzLAMrvQiSXbNlJBpO7q8Hpx4+cpQ==
X-Received: by 2002:a17:903:1ae3:b0:2ed:2b2f:8632 with SMTP id d9443c01a7336-2ee0dacd4b5mr104107235ad.22.1794823382649;
        Mon, 16 Nov 2026 02:03:02 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d994dsm33804245ad.33.2026.11.16.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:03:02 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org
Subject: [PATCH 2/2] nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret
Date: Mon, 16 Nov 2026 15:32:44 +0530
Message-ID: <20261116100244.7824-3-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116100244.7824-1-marting@netapp.com>
References: <20261116100244.7824-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_020303_588906_1F4E29BB 
X-CRM114-Status: GOOD (  11.78  )
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

When a connect string overrides dhchap_secret or dhchap_ctrl_secret,
nvmf_parse_options() frees the previous raw secret with plain kfree().
The invalid-input path already uses kfree_sensitive(), so do the same
for the replaced secret.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c262538523fb..5ed91557f070 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1026,7 +1026,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			kfree(opts->dhchap_secret);
+			kfree_sensitive(opts->dhchap_secret);
 			opts->dhchap_secret = p;
 			break;
 		case NVMF_OPT_DHCHAP_CTRL_SECRET:
@@ -1041,7 +1041,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			kfree(opts->dhchap_ctrl_secret);
+			kfree_sensitive(opts->dhchap_ctrl_secret);
 			opts->dhchap_ctrl_secret = p;
 			break;
 		case NVMF_OPT_TLS:
-- 
2.53.0


