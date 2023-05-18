Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D09C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZxA1iJDS5vfnHjjxmuZdgHUmHetv2HJ2mfgP5BVjafk=; b=LaIyjPgEdevQzVAhak5f1hsB6F
	VaY2Yig/oCI7NromygTbd/xg0ABEsEki/eF3py0TPMawctaVhRYRg0jJCXktUYQZNUbWGwZWTATEq
	gupnmqGPvKYTyMQimCRkxarFa9jSNiNpOXwIJ3gmsSQsL6OGNZWvp9g847RFXE98nfE9tss1OOLQb
	L9BcH0F9rDoLvoc51MIYuso5Le4jLZndnn87DSYZBRdmJELV6k4Sd7fHob9KYA2glKMSfGYpQI1/I
	ITfp0HF3gbXZYfs4g2bpoo3aMNZlGKrPaLzzmJfV/Q/wAsuOvdOt4PdSNpdgFMbkDF0jXb7/2/sSr
	cqPr+/bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlpy-00EJdU-37;
	Thu, 18 May 2023 22:11:06 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzlpv-00EJc8-2q
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 22:11:05 +0000
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ab1f0b6abeso2242787a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684447861; x=1687039861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxA1iJDS5vfnHjjxmuZdgHUmHetv2HJ2mfgP5BVjafk=;
        b=Lg2rPVbg++0hvl1g0cuOq8uw4MssL4Fw0ibW9U9ANe16/urlWBQAOrRsytGal2AL1g
         8lHYnFAltUsdI/hqHpv/yT4FXqCpRcPEUccsS8ywreIZzZFv/5zRdqw67KiCJjDVvMaP
         caJejpDeGf+jHwtbKIUQqUQnvlCxnY7YR8hGDdG7gBZhSowCRwfnWAJp+pKKtLzTvZ3l
         Gxzww//UmcsDjMRSea32l4FHlPZ8/0wio1N9RpHaDNHLlw0EqFw4C3/ghBe8L4fCYe3X
         FqEggL+mtludyjmiwvtkOO5UtzviigahbW2BJ5h1tAWI4kSrV+krMFtYKavS1swCm9xs
         ZeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684447861; x=1687039861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxA1iJDS5vfnHjjxmuZdgHUmHetv2HJ2mfgP5BVjafk=;
        b=X9VmT9WWqg14xNawlJPjdao8W94HjbFUYsxyPCPelRb38me6pUYPZwOPMtxoJawkCs
         QHtcpJM1uFbDCyQ4CNuYjEXqS9yP0rjI0XFrEKbFc4YLxL0/C5mcAdkGvC2soqqjDYPG
         tVAqT1Ro9QBOOT+5f41JhSmDKcBBOwga0LUIZurJPKSiRjuo0Z3pE6L8pycX4nFsyfBm
         aYooPH2JUUGzTDlSHyRMPK8iiAOc6sdDsw0WnH1fFxwGfF/Zecm0v9S7t++yFKMDOVnS
         qvEv4jsnrph1JPk82y4wRmKDRE+08OO3C3s4vrzt8vz9RAKkunr/8R2IHCS13vLR0Tm5
         Eslw==
X-Gm-Message-State: AC+VfDzq24ZOeGo3SiYNroEp14a3AwxgPXmftHSBe11uDLgAySxMsrOn
	PaMPxjB9moEIIzM5bOOXKT4=
X-Google-Smtp-Source: ACHHUZ6jZqkL9BtmKX9koysM4rrvcoNlcWRB1cH8rW5UrepFBc2NFPzYNYDYNGi8HxSDzQ8Of1V4fQ==
X-Received: by 2002:a9d:68c5:0:b0:6a6:3e1b:6d97 with SMTP id i5-20020a9d68c5000000b006a63e1b6d97mr34438oto.6.1684447860589;
        Thu, 18 May 2023 15:11:00 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id p23-20020a0568301d5700b006a42e87aee4sm1092262oth.32.2023.05.18.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:11:00 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 0/2] minor changes regarding multipath-head assertion
Date: Thu, 18 May 2023 19:10:52 -0300
Message-Id: <20230518221054.56378-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_151103_922799_0CD537C3 
X-CRM114-Status: UNSURE (   7.79  )
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

Irvin Cote (2):
  nvme-core: remove redundant condition in nvme_ns_head_multipath
  nvme-core: use nvme_ns_head_multipath instead of ns->head->disk

 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2


