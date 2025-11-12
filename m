Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DFCCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 04:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=; b=h5pEKsxvKFqlOwf+0KChFJZIEo
	c1HXecyUKfgnn5MO6nfierLNEhFzzWf4A6xQcvDN+6okwCQIaEAHvjYn6kvGTrwBIQVGahR88YROz
	JjJqYTuwA9R/JKCYCUk/qa8mZ5pO2vw5iKnp03rtLN5JFLX4IMgrL+EAZ9eWurJdL7WpTw1P8HDlN
	DTbc1K4PnC8Hy/w2FOhUOmPsoIKeuvbvXJokQsrRn+WWdmdkB1OFz4RC+o+AB+SZ9AegVsL+R5bMD
	O90Oo21C2gWwX5s2Cl/8sLS16WHDfqCcflnM4tQd3Bqf4QLDp843YEqOkcPsCC2G/byjS8zkcsM2V
	nkoGI7QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2T5-000000086aG-1rtp;
	Wed, 12 Nov 2025 04:28:27 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2T3-000000086Zg-0g9V
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 04:28:26 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-340e525487eso276510a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921704; x=1763526504; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=aKopgaKfD78DVZAqBmf2ti2NG50D9DRMS7f5BT2Nwre/kW4R42TAn9qpHh6jd0twDL
         zkZ6iCo4sUaJPzJZtxyhHKexBtYdUSX3gWZ/oXm0OMpGbROXqh9XyXkDItOXOzf0q8Ri
         lNqpVPsJS99jt7o0SHmydqCAhWsSYh7OrOCyfn/ifT16WG6pYtyRLi2uTbTawASozTw5
         S0mirUqD7dQOnizaPRWkjApAhaz+StNqPLlz8VFWOiVPGV/Ow4IwB9OXoeHHY5mIeGzG
         NpjWAbdRjvZ7Z7NRDqdWDBMy74Y57Y9fkLjjbAyk/j892G1j5vdoP9KhPwT7oqPhWhTf
         nOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921704; x=1763526504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=pn/eESbGyhQTso3jDOZA80f8UytTAHWhtlvlhkyXHlY+rNHtm1qVwlV+XhTA8MLNxu
         m2gbnHJ+axyIWpKluEmOXRTD8UNiC3Jo0K7FarlTab5CNHp+LaudZ2lCGQHx6T21N8Mw
         gbVdid07Rb1a0G+EwZc9I+Nw/wkYYZQ+slKP8AwwoeCIYcZudgVcHWRDvhn7g5SDjquM
         hJlSVWLDnajnAaTxvMd+o+VhemjJ6AvczW/6TOQAZr0vFVBtr26zPt5dkc0vwDWNC5zG
         7Ox24Yjx4GKqcMWTXWGcInakFH9QPZsstOtZhQysNKDPIiNg2aPfz7fZHoYa2g36YeMY
         o3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXTKJ5ycCNQEawsUsRWUVcQOFZPVvdy0Oxy8yxh8mebTM08azl5wxLPk8V7p2tVKNk+Aa5N1eNwIctt@lists.infradead.org
X-Gm-Message-State: AOJu0YxSuscumiU5OgZnhKZLd9z0gvJVndk/OVBWitsuptx2fYFAMg7s
	EQ7TD5zPRAh2hA0UC/L/cWTWwXfxL/SYR4oiYvVVSeCIDG0BEKlF898Y
X-Gm-Gg: ASbGnctvnV5XtHy4MD715pZImGEywr78ujftEIrOtBKOOX2fMht/TM5GnvSCyXkfqEV
	h2yCvWBUqcUyB86mPWJbtbPEVaUavvVQZW8J+scGxonw4JUHkQYvLJWY339E638nJspaAXZifn1
	7zSvvOkxR4RVPT6QgWqscXIStad6BcmIiila2aE/WlNIIdFnnqfLFrRfQ3k/Se31+6qPcB4z7Fo
	sKsHmOcNyAsz6UCbjKMEwn3wTEC/VfUaTvp5TkzSbz2juA/a3cFniUAsVZpA6ZKop8hhQW97bXa
	uEmy+KwV3+3eD2rmkWyt7UML3+J6B1Gk3r+xGldsj4So1vyu2LiK+uUFDzN9kuvR8p6AQ7wvY8q
	LmFE7xBjKPfYtDjDHeThlRzs/T+yh0jVwLRS2sI/GO+RT6FCdCNJov7uuwURvXT5St+bgpKx8B2
	RmmI5UnDl6DJvqZQ4peJZDDxKS2kcr3sNdDZJwPe8cVVAF49TgL3lR4m3AnwPTXwdD3GiQDXLzI
	Difkqroaw==
X-Google-Smtp-Source: AGHT+IFz599JMY+HbLZlN+Y4HCQji4lI/mnZmgyLfcZAZDfwLpsK/Yd65k0yw0c8AJv/WsCEFQFd3Q==
X-Received: by 2002:a17:90b:4b89:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-343dde81845mr1915818a91.18.1762921704526;
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/6] net/handshake: Ensure the request is destructed on completion
Date: Wed, 12 Nov 2025 14:27:17 +1000
Message-ID: <20251112042720.3695972-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_202825_205190_AD95ED30 
X-CRM114-Status: GOOD (  11.64  )
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

From: Alistair Francis <alistair.francis@wdc.com>

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - Improve description in commit message
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.1


