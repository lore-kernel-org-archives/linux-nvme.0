Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ECEC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE8261279
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE8261279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2Wvm+h7VtqoefnMW0E8W/RJ5vfbog9PSYWUkm7T7+hQ=; b=urHJASKLugMDMt
	MMTppviAsMZYOZ2IinVDwdc5n/q/Md6Kdj/lxFuGGv9ZHUuAGNiL7XpjlP2wSEXht0Bck+hHcO4QY
	jOSBFwh6LUytRG2eT56ahGePxonfCvQjeSizFyLP9QBAOCdGfav+kg8FnqPM2d1JKKvwynoKbDRUh
	SQ9hhvEyu9U2othCQFI98wDDBFVM2tcVscu8zaehSZahZd7i0ELPa9i6oJozblqEqDvEKP8M1MWGg
	kmJzDv7j39aw4zqbGrljgEFDDF6UbRAA3BoO2wkC4F7wiNEsyHKLE66ya96trXbfhAOTC6tQYEf5y
	3YXt/1XpjmcMiq81FRfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Mmo-008mZ9-Ff; Mon, 05 Jul 2021 11:29:14 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Mmk-008mY4-Vj
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 11:29:12 +0000
Received: by mail-pl1-x636.google.com with SMTP id f11so10124857plg.0
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kv5OPrW1MnKWMcIbZ3trrd+al1+EAKtRvunL6BZrDoA=;
 b=qaSvR7+zvSKPIdNr8aXKgQPz8vdmBW8741ZwmdTJU1pZNoW30SiDPis8qTHLIhaCDK
 HXSVdUBK7Yvy2zakqyyQ8BWkJPFirHAvnbXaJX447mDg+gOlutuN1iYNOnJaFGJwt1Me
 qmN3pau/Y7eq2uO80G6NnGgbwLrFlaszdWERlU12f+l5ZzFQoy2l/hbcF16Vv+Afp3lP
 T5K9IpYb1zhdW0tN7XChKJ08z3pkhKkORKkN7UlNBAb5LzXJRqknHaWKxOzyDZNUEVt/
 TaU0hmlqld6HuYpcP0awx+JTxQ11wi0X3tcepU+FL1pbk9FtW3mDXER3fjfYIW9kZGpf
 1MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kv5OPrW1MnKWMcIbZ3trrd+al1+EAKtRvunL6BZrDoA=;
 b=DkgV0MMh39wDZCdln1CW6DgaB4/Xa3Y6VzbfpEw3HaIcsUKQuzAz34POL36n36sipH
 jiNjXnniGAOnJpcwk4sO+qSSOn6kWmtUkuNf0VdeVCK6mvterplncjpeN/B/67j2/v5D
 8TeM0oKtfBB2FRs/QZFpJ/kcIJ0TVxEwj5acpiyf6s0aqF5TnNU5QOgKzxDArr6gtSQ6
 Js4dnLbt1eTgIrrNxbExzt4gLXBQ/1tECQVZ5Gn2jY5IPOyRf0ibuGA8GQnbzlelOnow
 1f8/TfMw547hnNRZgPKIAWFTWiPRy4vr4kEZgxMZdFDV7kRxa0pVFJKMsNFSL7NlHKVA
 C+ow==
X-Gm-Message-State: AOAM5311DYxagZ2qjwvVzYudncWL/0fElFnfv8WUqa8oXHpGeAdr5qAG
 soEPv0yRTqWoxsWRDjHeAQYiPO/ggtnN5w==
X-Google-Smtp-Source: ABdhPJzktXT3lKjFc8xt08I1ewM5SVGOXBmW6ghcg2PNQZH34mFqnWzlemdY8hz7sFx/m8Ba7VN89w==
X-Received: by 2002:a17:90b:e94:: with SMTP id
 fv20mr14873942pjb.162.1625484550175; 
 Mon, 05 Jul 2021 04:29:10 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id u14sm12705654pfk.10.2021.07.05.04.29.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Jul 2021 04:29:09 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH v2 0/2] nvme: add set feature tracing support
Date: Mon,  5 Jul 2021 19:28:15 +0800
Message-Id: <20210705112818.49577-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_042911_082204_20E84588 
X-CRM114-Status: UNSURE (   8.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add set feature tracing support to host and controller side.
Also fix a style problem in nvmet_trace_admin_get_features.

Changes compared to v1:
* The output style fix is extracted to a separate patch.
* cdw11-cdw15 is keeped in the output. All suggested by Max Gurtovoy.


Hou Pu (2):
  nvme: add set feature tracing support
  nvmet: add set feature tracing support

 drivers/nvme/host/trace.c   | 16 ++++++++++++++++
 drivers/nvme/target/trace.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
