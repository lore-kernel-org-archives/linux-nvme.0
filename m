Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC940C5AD49
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5X0PT+YUeiKYdXdGPuprWpXdWSLK8NlFZJi3oLsU1TE=; b=Rpaq8ASLSBTrYK74nnkTRcCnbY
	RkexYh+AKuj1J1TZARU29ExoFB6SSw5wRqTsdHebrVvDhQqP2hZfQY6S4OxvCaOqsSMc2HPVq7hwk
	uAT8KhKelSXWJ7p4yO5MzSIMh/kGMpVaQo9jZLOBP2LT1gd3+XutuUdU07x2PsqsBzyEJ/OguFEMD
	V9yBB9Q61onZE8IEjon3ne/u2xy7YQqmlGzJAFp0YiEEcVATDRSncGKWrK2qfuWgtlXyRGqn25ILS
	O/RaLpx4a1I6gpM/D16PQHFcvzFl8iBWEEo39FVFNFb6PQit+CkwLVlb05LGskou0VIrrJA7HSYAA
	KQ+4TFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdUu-00000000wD9-3TaR;
	Fri, 06 Jun 2025 20:17:04 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdUs-00000000wCq-0qFu
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 20:17:03 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b2c40a7ca6eso2209390a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jun 2025 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749241021; x=1749845821; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5X0PT+YUeiKYdXdGPuprWpXdWSLK8NlFZJi3oLsU1TE=;
        b=VZeljDE4isvpW8d79a7mc51idXb+NtgB2o2tPwF6F4VVvzX6+AW39pAZigmRBEEuXI
         wMLpkJfehVqPHxn6RCtJ8S5cXIU69dsKaoXIzSe9ftYn3QHCZ+riSLHfmLRyaht6i9Uh
         JoHzFG4LxFz8d+X1KhU1VtALxTS7VciAqq9rDSTnpPHyzsf1LX3//xHfYSN6UyGSd99b
         l2WSPUR7E5317xWfhC5AF+SUQIwFzQRkZC6JfMwXvpobrAwydVIU8lQpnrweC5/BrQwx
         gENgndx3WkquLSabxr3dWP4HnOWgsq8mUlrrB7UAHDKBL2AWPXeKDbNGpNWVxeL9XO1W
         HJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749241021; x=1749845821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X0PT+YUeiKYdXdGPuprWpXdWSLK8NlFZJi3oLsU1TE=;
        b=PZfoDbM6GbrXCECz/VzE3Kgvy8ZTjaVkDewYpT+FvK3sB8KHTpgyobXEtHWm7n3Wc7
         X7sJX9W0XdLGJGtw+lrQeXpHZFaXD0ZOWN6i62gBNJwrE9so3SK2amRi5C4LjacCY28A
         BUSHsYkkm+4wrazw5ElcOF5Chrr6hDVI6FYy1ZS8YSG56UlFNoKfyanCJw5u2OtCs6rA
         q+ugwrahTOVH+KKCoZxI0AXPA1zCXZhuMa2bvNWAJ+nrjfPsfUuKazndOfudEi6J2jJI
         YpyfNkKL5pAVwYQC1WOILGsJZrVi7cCZwq0ViiuGl2dPhFl/LB/iFQ4PnE3QVoOxiFwP
         xDQQ==
X-Gm-Message-State: AOJu0YxaYww7EUWKZDm8xFnNl2W5BkeGWchrBeYR+mJ7r8kFR//Hmwsh
	z6q8vX7dGo9Nf+LbZEBPNavV8nGQ3OljUrLrZA1I1KA4O+jFWnNqX1UbJBbwPA==
X-Gm-Gg: ASbGnctPNQwrQslxThYE7uMZ1bwo2bTJEWBz7fD2pyemtQ7J8Xm93qO0VyAAr1X6lKG
	4q/ciSkWJzYuOasKHrB6rBJs4uwkRAsH9OyKJEwPxq/FrrJlfWm6CjtuCQu17D93GBo1j6eRSx1
	ZAeOOuSk2lNfHm8hyrBg9kQlHz+VOmCj7CMyCxHktncICXUcBDDXB/hVw9QaixxJ9uSLByPry4p
	KDXUSFcbj5k/of11ngFKzp1CHT+ujhdmofzoK+/s/bABZOfIs8e3488vuAKQF/hSSWbVbf7nWom
	6PPl4CCo6nvAFRJuwSwuPa1nCREUAnp2YrHH/Mnej6qPQ+/soQ3wvquj9FbScyumAPkxRA7LJQs
	tlfktMKFND24jhg==
X-Google-Smtp-Source: AGHT+IHyZffFGHUN+guzS9JsHvSo2EPaSOQO1Waz8l3qZK5uY+rfkXJmQPbZ2SrKGW7hHAce+NV3KA==
X-Received: by 2002:a17:90b:55ce:b0:311:abba:53d2 with SMTP id 98e67ed59e1d1-31346b56c43mr8024816a91.17.1749241020928;
        Fri, 06 Jun 2025 13:17:00 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:8b15:3e66:8393:27ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3135c5939a0sm591537a91.41.2025.06.06.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 13:17:00 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH 0/2] nvme/ioctl: improve user request allocation
Date: Sat,  7 Jun 2025 05:16:08 +0900
Message-ID: <20250606201654.9558-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_131702_244371_E95EC4E5 
X-CRM114-Status: UNSURE (   8.02  )
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

Previously nvme command copied for the user request allocation.
But the nvme command already allocated for the request.
So change to just set the nvme command values directly without the copy.
Also fixed the checkpatch.pl warnings for the unsigned values.

Tokunori Ikegami (2):
  nvme/ioctl: split user request allocation from user command submission
  nvme/ioctl: fix unsigned value as unsigned int value

 drivers/nvme/host/core.c  |  10 +-
 drivers/nvme/host/ioctl.c | 230 +++++++++++++++++++++-----------------
 2 files changed, 134 insertions(+), 106 deletions(-)

-- 
2.48.1


