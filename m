Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8EEC5516F
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mMCg78w4nArdMSmuoX9u3Vf0N4D7/uJHZojvJTOum3o=; b=qw2YWQBPdpbkbWn0gj2UdZl/jn
	0zdL1975qglaEhktfgZ6CMsXlKgeAROMNrkhOND40YMjPsIPRc888bjzi3UW5FFSKZNvGvAz/Jmrs
	sSvK2tqM9mkNDySJwkUTiJIG2KRsO5rkNrfpaIk8Yb/IdezHfRUT4I/GKEbqSTgTylmpFZPCxFgaQ
	FDDPGnQWVQZlZi8m2o3bQThDkYPXGG6N7iF9spGaqxlWTz510cIdYIfjDphpQYYqLfahDFzwvMkmu
	t24ycxRtQe7TDCCX6p36Yn7BIYDsbwliHVaneZOV02VKtLUpqP5p6JlHmmJRXWWkSb5O7TxdIdvqf
	FIJkRpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vY-0000000E2ku-0C19;
	Sat, 01 Aug 2026 08:18:40 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vU-0000000E2kU-3qlj
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 08:18:39 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cbb973e6749so1984321a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785572315; x=1786177115; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMCg78w4nArdMSmuoX9u3Vf0N4D7/uJHZojvJTOum3o=;
        b=qlU2oWBWK1K8OjZl1BYmzR8A354HQz8BlQj+igQXN0SHLYmNNbYoZfTZzLyx2gpTqd
         bpkq/3KNJZuX7PIkeyRmXszLC1jRJa2Kniyw2XimxGf/uUmpCsnFqDQTVExANOaak/dA
         fKVgXIepiid8fIPhg57tHxCG7H76SSOonSPVX75WfALwqwbkcfm8LBSocbyWlfSBkuRA
         wepI7jLUq5g9Z6qvjxQ2pACOCsNS+GBMLaLS3OkNkM5guiSPxenuUoxcWzOtESnCpNK2
         oi4DxkAs5/DNXoICUdlpTvS/aoUAaWzgxlFAsN5TpMJR9setqqksOuWNPwCabpbnTtwp
         IC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572315; x=1786177115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMCg78w4nArdMSmuoX9u3Vf0N4D7/uJHZojvJTOum3o=;
        b=l9cmKA18g+17GAvMQ3XOwL+98Td87CiSWJY1DjUkvnPFALr2yYS9wYKSeXspqvnwM0
         cjV54piwxtJryfhZzWgGwlWHhqOliclc0MpWjgv/FXjnoM+xYkzCFOLo7xgbe5Z1M6cp
         XlwLzHq01LyS7gg2SWF2EgySb5Lnz2w2vpIqGMgGOcT46zfnHVQiaJdHR857kPvleHYj
         x9ls3yi06on2BQbtYwi5KU8PH612xocW5tqN+znt1fgbBkCdyKyeR4Z6LoSkKli9qYwX
         RrJPV6quf8R/0Y+BL4aksFhTqCikYnkRODA0BoVkHbpdiYGeqznZlNlYuoNeJwU8PolD
         KZIQ==
X-Gm-Message-State: AOJu0YzeQIk9N4M5C7NzzzOhMtupIDoDDgFz1QYUtVerJNqX+HlOywJF
	zzbbP2qciprexnYrdX1tgPpQ1d8FDSOHGxWSpW/FrvWcE1pYs5J6oLbjPbAnugBN82PLeeawc2k
	EszER
X-Gm-Gg: AR+sD10KsNJp5ddw9FeoDra5P7FJ80iKuX3N3/fEJ1ghv+oDfrAvMeJ2aS8ucOd59Vx
	tIsH2n9UKpEtAxmvW1P5XwI/VsJAPU88z2rrDYe63+3VVQI+bOLGtjXUgOdc3gmL457yxQcluQV
	ceaO/eHNEu0Ra2mJN+kZySXkATSfGvlPxDB7W1dSFrNINY8dWKFe2K65mDcH6HlKT+jKp8Z1ojR
	C+rra2LpNNR2mL0C3MYoxPaf6VtfjYn8bi+cUV3ZzW/e6a8I1mVr3dlarXBco4BN0id9S4bc0oD
	mVjpWuZsrBBWoGbZJxDO73NT0DYJYWdK1fwFREHHoB6a1l4H1RsvKcFAbRzYYLKAS1cVWGBmYrZ
	ulir8y2b9EB9+OydsgrY/mhMFFMPfkR3X0S5VfaCFqlZDJf4nU8hy2qQsbqVFGNxbSpipI1KkTq
	R77C1nPvSquP7t3oWgv/UllZHJLJoP58RKSIk6ENeTtBYwAQgp3+T9SLlsOBAeH08yf+lD3ZtKS
	DQuI9yGElf7cMQZ1VHGew==
X-Received: by 2002:a05:6a21:103:b0:3c0:9c1b:d0c0 with SMTP id adf61e73a8af0-3c92a99a476mr2480966637.75.1785572315609;
        Sat, 01 Aug 2026 01:18:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9a40sm1433003a12.25.2026.08.01.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:18:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v3 0/2] nvme-tcp: two checks on the C2HData receive path
Date: Sat,  1 Aug 2026 17:18:16 +0900
Message-ID: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_011837_242687_C411F289 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

Two problems on the nvme-tcp host receive path, both reachable by a
controller sending a C2HData PDU that does not match the command.

1/2: nothing compares the bytes actually received against the length the
command asked for, so a 4096-byte read answered with 512 bytes completes
as fully successful.

2/2: the C2HData gate reads blk_rq_payload_bytes() without first
checking blk_rq_nr_phys_segments(), the rule commit 25e5cb780e62
("nvme-tcp: fix possible crash in write_zeroes processing") established
for the send path.

v3 fixes two defects a reviewer found in v2: a CQE phase tag evaded the
success test in 1/2, and 2/2 had stopped rejecting a C2HData naming an
idle tag. Both are measured; the notes under --- have the detail.

Reproduced on v7.2-rc5 against a test target on loopback; no real hardware.

Link: https://lore.kernel.org/r/20260801060201.1879499-1-yhlee@isslab.korea.ac.kr

Yehyeong Lee (2):
  nvme-tcp: reject a read that transferred too few bytes
  nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone

 drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


