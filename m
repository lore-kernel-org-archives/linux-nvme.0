Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F6C5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=; b=3Enj53nrpQ96b6JUd3h1mwfJxY
	P6aGTObOPh/dTHFPFqd7a9ao06wAuU+0RueoCgFkXNmiSjyrBzDd+DnOf+puNQJyTw0EkMn92qt9S
	/80+oAazbs+G6fS6sF9NybgZmLLZNuWMv9gAcr4KFORPh1iSZQA10OHD3vFaxWvYoEl86VWqjX29d
	M9s0qg0c6wVvLrl3rrO71NpQx1XkdHHkQ6F3MjqM4UWaNLXfplQs6urP7dRNz/PYYy1AyZvLn3yjt
	DT7ReltCPhJ+Z3B2c0vjCIrhJT5dBtzi1QOtXVGPihCw88A2rKIs6ktVB55vCjivIdGBTP4J1Tf+i
	KgU+9YNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6gN-0000000FzEc-34sO;
	Wed, 12 Aug 2026 10:59:39 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6gK-0000000FzDw-352m
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 10:59:38 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso11519635ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786532376; x=1787137176; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=;
        b=poVasTszkOeXKnBPCJUX2369dCILjlycT7ef7GSHBcae1frzGgbuA0gXVqdJm95a9+
         XukqnL83FhCpYKkZGN1CoH3YerdomTH00F7xtxJZuYWihmaB+ygMIpD0hMVHcrmF/Okq
         WcolrsNrh/McTQiC9JhiMZhZzS870H3yprutKKPpsxBAuqRCiS4uhNtHH/7qm6C+wqvL
         FoSPFl35zYrqvXH5IcRFVB/9ABltqqSuJGEFoRVUh6w6kItIkZletzYDxh6LcR1bJD3L
         2Cin8x2D//6Gg2ayBHcs6ip3rMmdrhDrhq/wxGKkJ0oWI4maSuDrKbTTPizu/3e3a2dl
         CPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532376; x=1787137176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=;
        b=IR/ziwm7e/FzNcfq9kHyBgX+V1+XFiPjSfdM8bOul6R5VWqQ0geOE4n5LYyGtdjpFa
         W8KrJbCYPUB4U4/a1M9GPzfiHpv2s+/Tt3u3jOzVG1OmafQLIG8Tlo1wm2bBgJubUPpf
         Q+UOfH2yyemr9kgtBeMkOUPe7B45Pu4gZ993xd5rvkO5PJvqQInDmyAfs6jNJSL0lh1A
         O/adw+mumtdlZ1/x0HiSBRO1nj0cCn3UO017ESOWQ1rHyGL2JHoepBs8S7v3cAj6yEjA
         18qCg9LMbk5xl2fhg861R24kiB5Pl6X6jOng45NaKZY12HnDEHaE2WUO394sM9jf3j8i
         4jkw==
X-Forwarded-Encrypted: i=1; AHgh+Rrm7/4csGtnWtdmiPac5MdeJTpX/8ij35iM+95N69nWTTxkiXucM4ct3FFQV+AsD6/VPBlJJdTKY/TV@lists.infradead.org
X-Gm-Message-State: AOJu0YwjP0/naKHjMGcxB1JPD+e2El4/71qhdFNqWFsPDNG+npq25Hck
	gGZKcMWuC8LzOP822H9XJg+Jc0lVrqDJ2RGiCbOSapeHy6mt7IYuU1vW
X-Gm-Gg: AR+sD134Zu4hzRhLkG7Mqn4LDGNPdwoDkEGwqrOQwcpu2ypR/OSarlplvOjU9SBIFt+
	i0+dgWaEdbbUKHz6cOs0WjfuM8zZAdoqaiX3KR2tqWFXyjdRbbSb7ezK705V/6gfKszDN3NNBKA
	ubIQZ8COG6fk2bbCV0e2UKPTuatqPgaVPBRhYU2I7cDw8DpsTXiTqNUXeeHUpi58xgXxBEPr36J
	6asEqHh1FSUgvMg8iXU77jnkurX13NPgBJ7XcZ0MlHzxrpR4CYAPnKzzFp9Ze7iSRZhqV4BPdLv
	bIpkumDGJnwuUySvCxoqIFSUWuiljW5Q+FYmO5wU7Az8a0vsmzbpgR1xbcaaO1JfOfQhmWzdtqS
	T+X8BAf/NPwsiX+F6Ld7OyHws9WcNs55nreRooFtQnDbYrA7T8txpVIjDl7Q+g0B3HoUTXb5B9v
	7P9D0rl279HkYWtMgFGVYQK6mFX4b/8mpyXYqsgkU59Ne2Vhk9hS4nq9p67y1+VO29ZQcb/4Y=
X-Received: by 2002:a17:903:11c6:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d3452f5c1cmr47925805ad.8.1786532375860;
        Wed, 12 Aug 2026 03:59:35 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d351151177sm4574795ad.31.2026.08.12.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:59:35 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Wed, 12 Aug 2026 19:59:31 +0900
Message-ID: <20260812105931.55438-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ans_4i0GcU2YAkKl@kbusch-mbp>
References: <ans_4i0GcU2YAkKl@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_035937_090271_D543AE20 
X-CRM114-Status: GOOD (  11.57  )
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

Hello,

Thanks for the review.

> Can't you move the setting from the "fail_ctrl:" label to the
> "out_put_ctrl:" one instead of duplicating it for both?

Yes.  I had kept both because I was not sure the put inside
nvme_uninit_ctrl() could not be the last one, which would run
nvme_fc_ctrl_free() before out_put_ctrl: cleared the pointer.  As far as
I could tell nvme-tcp and nvme-rdma use the same uninit-then-put ladder,
and testing does not show it either.

I swept fail-nth 1..200 over the connect write with fcloop and failslab:
unpatched hits the report at 17, and with the clear moved all 200 pass,
21 of the injections landing in nvme_alloc_admin_tag_set(), so fail_ctrl:
is covered as well.

It also looks like moving it drops the window where opts is already NULL
while the fabrics sysfs attributes, which do not check it, are still
there.

v2 on the way.

Thanks,
Rihyeon

