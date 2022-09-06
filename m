Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B4BECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vDZiWmK8Futq3LvM+qJ5RBJCfeHNYVbLXbo217Lp6EE=; b=Ab3nblSbU61D/Io11unXoaB65v
	1+2J80F1Db040Re4IvGSUhvQ24O1ceA38zebO1y4y7c+aCOhSGM9O634G4x2sGkjaKFHbgsI5me6K
	FRTj41mT6cs08Ua6IMkTv2Io/v+xMkqhde3WDXKWcc7WMjHLMRAjcogsgkK4UXGzZQ2g8t5+PSU3r
	W0cWjf9NUQrXVCuHVK3TiUAK9zWl/+3xWQjWRk0H1QjnID5PDdUt3bYv4sl26NKhCUUfkCGK5UzXE
	GHtFI7VWxJuOT1aDmTPlB8bC2sPfY1iIh3EicvVoRhcW2dkSmIZQnAxWmrItfnLTl7KxBOJflRqW6
	7VW7rtYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQgN-009IiD-3V; Tue, 06 Sep 2022 04:59:31 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQgJ-009IT2-Ig
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 04:59:29 +0000
Received: by mail-pl1-x62d.google.com with SMTP id v5so10171618plo.9
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vDZiWmK8Futq3LvM+qJ5RBJCfeHNYVbLXbo217Lp6EE=;
        b=uJ65N/4/Whsp8DEc+bNF7zVfBIQZeSBcLhJl6+9TErrtPuOR6kXLUdEfsiQH+LnZWJ
         yfFftUnS5CpiunDEB9IYn/Z0Fou/o+X5LJP7i51C/5Onq8lPetbdRW65sXfjOKyNtLFA
         Rlqd4Foi5+WqV0DdYfPtoRwgkQx0RFBFLBVmnKSQACSpgmTrbNpsrGe7krPBtFakQAxU
         EgHfucghywAUdujr3DtQzBcEzTSvkoBmNfNUTXsOMRqVuaQ7hesvCe5DmVXXBt73oLj3
         GvR7rbmdcXOPZbRYllWl6bw3lUf2VyxY1z4oj5bXRhdHqbIoPUwaiscHRjuatFFmBj6d
         caGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vDZiWmK8Futq3LvM+qJ5RBJCfeHNYVbLXbo217Lp6EE=;
        b=FuQjVgUUoiDjHy5Sz/Ey0viE4Gt2yw+SE1UFxOLd/g+FJ3aMAIovgU91f58uMUq0Cq
         db4ekHvsq/JChUmgFvcL9lcCd23t7dBj+FuC2mgoErS82uDHGoAanyy82BJAG7CIu9cy
         0n/hZjhO0q3DmFtpGk+9H/Xj6yvod4hCX4X/uAWXMavYfqV6afsni+kUvcPfCIfFEHYD
         Qt4i1yNGNtK4pBHVN1xGg35+rZOElfUDwUp6bWsV+wIxvGn0P2WnCpKCKuxyokzikcb8
         kkS1Hg6Uff/lushQkVKKcaNmlCoQ4G9jL3JLMG5hJRf6mL2ycSAKLbkHi88uDJ/cOFdx
         nSrQ==
X-Gm-Message-State: ACgBeo1N6vO+aadyv4//ownmiDj07eyfHOa6tWFN79oRypeIWfU2g0Kb
	JL2f3hi8M1/HNH2N0CpaIzHgXxVrAxALyA==
X-Google-Smtp-Source: AA6agR4Dn7cU5CzrJ+UhufLj5mmZ/2X8MJH/+9pdzG7U1rsz4gqy1br667iEdJP1Drb0Zs4aIsh0xg==
X-Received: by 2002:a17:902:db07:b0:175:42e2:37f2 with SMTP id m7-20020a170902db0700b0017542e237f2mr29157932plx.13.1662440365728;
        Mon, 05 Sep 2022 21:59:25 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b0017305e99f00sm8552560plk.107.2022.09.05.21.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:59:25 -0700 (PDT)
From: Sean Hong <sean.hong@quanta.corp-partner.google.com>
To: linux-nvme@lists.infradead.org
Cc: Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] Test: check open list email
Date: Tue,  6 Sep 2022 12:59:22 +0800
Message-Id: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_215927_880455_59FC4C31 
X-CRM114-Status: UNSURE (   8.97  )
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

Just check linux-nvme@lists.infradead.org

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 test_email | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 test_email

diff --git a/test_email b/test_email
new file mode 100644
index 000000000000..e8084e7bc088
--- /dev/null
+++ b/test_email
@@ -0,0 +1 @@
+test the open list email address.
-- 
2.25.1


