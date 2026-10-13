Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC28CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=weVoMVk7+8IBm1YGLO6BLCJKDE8BQGTsOSBOllMfeck=; b=kYGZ3/1xH6xzZGdYLKy7uoodMV
	l2vRVvLsLpa4gYtj49ZnplnCB+DKtB+aKBr88aUdWUaKrDeL9mdcGPRB0wZBZQaHdp9eNJqMHwhIW
	Z1d2ZA9mDzZaZ+A+ooBTfUyg3FrGld2PWGcD8xhvi1wMwLSlRaePowBJfIoaXWhanw5Da9T/LXjzE
	+5eTenGQcouEjjVVeNjEMTIvOSwccYQL7hBoXU0H54L2AnJFxqwSO/VUW0+DyooopQhFRWoD22y49
	KWpOA2pO/kRx7beHUtAUctTZ17CRWz0wXW7xXAkL9SFqq3oBtqoICpcAMHdYcm8WMB//hvA7LB1su
	Jmz7TUCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGep6-0000000DQnR-1my9;
	Tue, 13 Oct 2026 15:53:52 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGep3-0000000DQmR-33Gu
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:53:51 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2dd76b1361dso504865ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791906829; x=1792511629; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weVoMVk7+8IBm1YGLO6BLCJKDE8BQGTsOSBOllMfeck=;
        b=uUH9Jzyt18UWoFWlZlae3IVsJL5hNkSZJhfZDWuC28P8A3b20fHXDPSeVKZkhptj3n
         lJ7/WW8jnLg3EHsvx+8N2+NlN/RM4Gf1BGOuOfLJXlG1jfjeaTnhHXg01AQZixkw8oAd
         8V1fLp91LniDmLPwi0NJMEX1XR6/vFcKuVAA93STUHVpdPicF2mFboQMn38HFPgdb1zo
         31yktFT/qEvSEtZysvpqmBJkHkTsjO82Is0XlfMN5EeTNIm7xOmfpOaVu2F8IDEE6QVt
         9nwBJ9kEusnoRVfKW8PtoyHNLim5VkTFgLroT/MwtmZ3esIj4C65IB9hOyMQl+am4wlf
         EI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906829; x=1792511629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=weVoMVk7+8IBm1YGLO6BLCJKDE8BQGTsOSBOllMfeck=;
        b=Libg58UHQzEP6hruS2r524wxpaPMgtEMS8ZVIaXYhB6Rw0tqtzTQ9ygAz/m3SMH0gN
         R/z6pv+A6qZUpgPaQ0BEwMXVUxiABx6++RT2J3PMWEyp2tF2jk7wtP5XMPRJREfbRmfx
         1tXEBMOA6GJ7AlrSKoPwFRFGEc5KSU2HWPxVi4oUlsL+au/8FLHbGHt0LYIVJZVLtZan
         X7KAurxTWla1obvzy2r4aSmTcmsE2lKg3gAus3i17smTg94jEnivGj12XrEs3Q/v0wMN
         mCC3zpMcdnCyUpfU94pM4YFJi3+Lxda5tt+krtmXpXa2tSggcGgjHaBr8X7D03sNaqNt
         g+8w==
X-Forwarded-Encrypted: i=1; AKwUvBylpfEgje0K2W2Srq09tTOqRiXeRIwUqwTGlhJ9zcAMHIp9gv2lngpOQAKLZ/T9gl5uPsU3zjRGFvMw@lists.infradead.org
X-Gm-Message-State: AFq9FYIfmhj+m1adVTdoitjot9yPeozsUr8tr3d7NVs3ja/D5hCbGZn9
	4Ij0StlOtnNxjIjxH7wf1+FkxuK3GzhysD33LD+jB/k5mf2W9+L8rDilcrRTB5/3jxQ=
X-Gm-Gg: AYBFou1Q0q3AVPuFJRXvU5CobHMOaCFRuxNUdMjfzDKnrvpzwjI4nMLOEIVt+0pfmNG
	YjYwmx5nURWCTbhDtWV9lyIoFuDQRL5DhYGf1Lg/dp7Ee6JMYPi0W8U9afy++r5lsSjRuBnCagZ
	C2wsesQWot5qZlHIU8iNd49OSPy5k6bgMZpHqMH/+/aDZ1XdaBrvYzNw4Quh893qeFqM8OJE4IL
	j45v/jEldWWYGhGeOl4Cj/TIh6R5ZwQIXM6jmbmZqAZdvvb5nOM6GAmD/GM8fzDx1B5uzGt+bSR
	Up2NoURTPFNae3BNufoS/7HmNA39CoNO96sDU5ThcTmbM38STcM9E6JSYJ+XTMZJM1GOeDYPd6J
	qnYEsEeKFGrUf3NZ5CTTQPNS7Gtfg8Y1ciY5EfDUOxPG8wzilBI9L9E6W+Jyez/izOc8hhhytAE
	DxoPnE2SrgNJFiYXfSsI8SKlaZLA6Drb0lG4yjhecAWGkqWb3Ew+4pDBAvS6kKdvhI2B6BfCMii
	yDHktQjaiOeC/pdAD2B6r9fxanS2vg=
X-Received: by 2002:a17:902:d583:b0:2e8:3f72:4c2c with SMTP id d9443c01a7336-2e842f1519amr122389725ad.62.1791906828923;
        Tue, 13 Oct 2026 08:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5fd2sm59793355ad.50.2026.10.13.08.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:53:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Wed, 14 Oct 2026 00:53:07 +0900
Message-ID: <20261013155308.3188757-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013141904.GA14323@lst.de>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr> <20261013141904.GA14323@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_085349_791178_FB7A935A 
X-CRM114-Status: UNSURE (   6.43  )
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

Agreed.  v2 adds a ->get_mdts callback that advertises the 16 MiB ceiling
so a compliant host keeps its transfers under it, and keeps the
allocation-time bound as enforcement for one that does not:
https://lore.kernel.org/linux-nvme/20261013153316.3178656-1-yhlee@isslab.korea.ac.kr/

