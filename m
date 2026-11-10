Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F360A260B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WbMPfPZN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gu3JBrLX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=y0M4h/vehAQMF6R3fGbmwS23pY4/kxWDOz1/LJz28sw=; b=WbMPfPZNcLsjUM
	9PpVRkICktOPGvWzCbCGUvb5CtatoA2JPdLcvshD5hVRGnbzYqXDULJkl0+lv+UtykyDK3yytFa9L
	31ql+xMgpOni1QbxVap4or/jeme17WvIz3HcXGm1TuTG4LejCz2GQZBv9rfqxoi/y0+2G0w/fOKiw
	mh9ia/GaQGW7JlB8O6VD7KoSpY22xQhISylDjJwthPsijOumjJX9G4UXICnKBMhp+x1KOSPT9b2SP
	yoaDaroE3XbSSeljXkXcMUAieV0aPvgRuMJ2rtRjmZzYMThlRKAcoziURqbhjHxHpfDcwWhf/3wF6
	VBIOzzLK+2K+1JM0qx1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlNJ-00000003vav-3RRk;
	Tue, 10 Nov 2026 12:54:57 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlNH-00000003vac-2pfr
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:54:56 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so3033370eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794315295; x=1794920095; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0M4h/vehAQMF6R3fGbmwS23pY4/kxWDOz1/LJz28sw=;
        b=Gu3JBrLXdTZxT8vcDkImu7mhqRp9GNFvSE2224F3yx2qdWZUtU2LffO7wnXJ1aSPNe
         BwG6p6GbVehgvBdwuixJ2xggiZq1XkD/qXkvsGKw7jGrJPKb75sBunDskS9xo1Vt9BBg
         AVRwSlJa3+39nfK/HF+VI8u4lfl1H7zwRuzuMVgmaWeEMnmgMl2NDWl84Guki1he2rsa
         zhM/4rEuCahLd+V51GIPVpZboT8iouupueiTL366PFe6cnNuHAu7xbSVLOTiEqAHcLKA
         LnXc7ACrcXVEPjK5Z0cSzlz21yzLLcb0Oa+xYOrZj0XL7C0wOfOD1cl8nnFEAYsMnvqm
         BMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315295; x=1794920095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y0M4h/vehAQMF6R3fGbmwS23pY4/kxWDOz1/LJz28sw=;
        b=GK5uzlyVtnbu/J7BURyPrYioiHhyDc9M3SuVKXv9O/wkFsB3re/7C1AY/5IaO5l05k
         +yk5VgVhGaVFeC0neuHD3LFpjE4NaCRawBBQA815tnPaw2bJBinyDJ+arAdIIS4te6AS
         Uzr4R684KqS/WpiOEeFgbGfVP7Ua9f2jQn82TGRzl8b55voT4RCBC7URqf2y/ML83wdu
         r4ewMwWXe3tle7D1qv5+eppc8KoZMAibyoFZ0LRQuWjnIVZGbU2qbIKVhG0KbNuZ60O+
         riUS7aU/bKeZNpc+R8AZG1g9qJ1Qh1sRtlaeBWsNrPy2CWJ4jqNscTHDUkjn6scml0wI
         JLpw==
X-Forwarded-Encrypted: i=1; AL+hErFsePacZC1zXM7IYpyTqK7pD3sEKJyJpc5JbBBC9UnZOHVyTZUxDVSti7M8PGE8YLZhD1ga9k6clRUg@lists.infradead.org
X-Gm-Message-State: APuU4Z9uwVEPJ/Ak71CGV/crTomAwaGkwUTgSg1Nalkfu424RTOG646B
	QmHFVbQWqTI3NnGTjTLUNL0/2iOPiNiF4gQvtmD55d8xrLoR8VlRneon
X-Gm-Gg: AYBFou2XtvPhQqmuQQhYXC3cpTPHdIgKtOJLZRSbtl3wRnKosN0Q2xfj/AxOjbCEWs7
	8R0mM/O9zGTjesYKmFa1K88t0CqO78/nmmA8ssG0C4U8+pRnB6cOWJszNiivnW2dSbHF1+c4rqU
	RNFefa76Qrz2ynL5piD01fScEdqcKYFjGBiK3qmMHZv+//o632C5uXrzgNUf5SqPm2gZMTt3NHt
	UluUG6dew1EBhrvCHgjYLbFS+CrXrEVG/x7vomhOhdIPGDULE16ijc7RWitybZSb1t5+tLRtGFY
	dnmAYL4nMBkUIjJTU3NmsNQsU9w5JbqrJKuJqg1HRsECJMr0dMV8LTYrJWYJYWH6B9Nfdfmojq1
	4iDjvXMYhJSATqKVyS2N+VD65sj+zP0rPAtNE2+qnycZ99PY20LL4yEv7Hr/58bC/1bbAPnyTL9
	MGsAabEBTvAmReEhgKiGUEAAzEowrfIw+Brvts2SXqJjj+h8LxCOWr4uoxZSHkOPTW2V6s7YejO
	lNwFqMcRdtxz6KB/kkbcKI/PJdga80pM0rN9wAiHFC16wPOCXAYx11Wrw2gWsJ5qE6vgIMhcB1k
	5mXekrvfM9lefQpDjadsCWkJ4srdALPbenzweRaXF2/gmjPYfA==
X-Received: by 2002:a05:693c:62d0:b0:375:9a26:cbae with SMTP id 5a478bee46e88-3759a26d2bemr1808434eec.24.1794315294772;
        Tue, 10 Nov 2026 04:54:54 -0800 (PST)
Received: from localhost.localdomain ([103.170.54.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm7580066eec.7.2026.11.10.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:54:54 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@suse.de
Cc: hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH] nvmet: synchronize DH-CHAP secret removal
Date: Tue, 10 Nov 2026 12:54:29 +0000
Message-ID: <20261110125429.2733-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4ff74c54-7478-4ea5-9e26-32101acd4556@suse.de>
References: <4ff74c54-7478-4ea5-9e26-32101acd4556@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045455_734521_EE4C849D 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hannes,

Thank you for reviewing the patch.

I've sent v2 with the missing Fixes: trailer added. 
The code changes are unchanged.

For reference, v2: https://lore.kernel.org/all/20261110081559.2730-1-sreekuttan2156239@gmail.com/

Thanks,
Sreeraj

