Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D46FC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ubymrhd54tzuuW8+QwvrPoW8/T4iZvXjSIvdacIW0y8=; b=1CUB9Mfjke5Xpj203TZQ/1oGyi
	bcPJMd9Pewi87Cy1lUBukquL3unVOSwRAHIjHCnq2U+McCpHi5is0DrUtNd85fmO+Tx4H7nMN/AhF
	PuhYLPrJAyjwyZfzXiPlO2cyCjLW7+hwmTuiRWtWnZX7jsqW5Etg8aC1a33J+TAlps1FKZKJLdugL
	p7y+oanCHxLptegtoLObisfO+RQRyojwC2qFkSx4U6qMH2L1sgWGUn16ZcZ12MnoQWQZnDXv+NJKz
	DmPh+5B0207i5XUI+6y9U/Rkthle8aiGA0jfLBXhz1+Mz9IU6ZEqtJmkEmliUcnDFZw0Dv9DJyqqP
	Eb2xRYTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4hz-00000007sg1-2CY5;
	Mon, 13 Jul 2026 00:39:43 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4hx-00000007seq-0Tva
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 00:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903180; x=1815439180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=adqQhugJHK47JgeINkEIkwojF3rjhzF7YFCYUgsD4eo=;
  b=owvS2EjcdMOVduJzS8lUqEEYvw2oeAf8qo2dfjUCWxzVDcWpVtBeb/rS
   OVy2OlrVSHw+HeMaGYq5uBNA8pno+OTt5SAeCgnwa0ZdmocsTgcAHA6Ra
   7vfK2NI37iX8rt/wDJwDdnFeyzDrybhcH0LOvuBDMwTlhQHWKwsyNK8eY
   z8aFbVn17isJIcWqf6npWpmiZzOcoJSmJ+TH6QWG13nBVn35wOykxEu8O
   2ZmlOaOmaUV5sr9eiiOlAXR2/Az+7EmB4idSARg1AvD+w0RG9H+wxuyot
   piwAz7CS4jn2qXgbx656+auE4HsYDBQ3st0GtGrhyG+nA/shW2W5FaNen
   Q==;
X-CSE-ConnectionGUID: sfMgKXbmQFSL7gM1p/hmNA==
X-CSE-MsgGUID: rLfAxrQES4O5vw23vJlHPA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596180"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:40 +0800
X-CSE-ConnectionGUID: n+vRsjd3Q8amGW6SBS3dmQ==
X-CSE-MsgGUID: Nq7w2+SDQLCUAfW0SYYYBQ==
IronPort-SDR: 6a5433ab_2GRttI0iqx2z8uCTSExYY79761OMNuScTWIE0xEFCwj+APz
 c7XZ1ZpYx/P+S08ot9hbrpVO3PIEh1DWDqqGYYg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:07 -0700
X-CSE-ConnectionGUID: JKikaooRTNKRyiEIfg7vWw==
X-CSE-MsgGUID: BGbR+eC4TDiFrZaUUs7yqw==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/4] misc fixes
Date: Mon, 13 Jul 2026 09:39:02 +0900
Message-ID: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_173941_180384_8B1C72CD 
X-CRM114-Status: UNSURE (   9.29  )
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

These are miscellaneous fixes. They do not affect test results, but worth
fixing.

Shin'ichiro Kawasaki (4):
  check: fix exit status code handling
  nvme/rc: use _set_attr() in _create_nvmet_passthru()
  CONTRIBUTING: clarify that GPL-2.0 is not applicable
  new: guide long command options

 CONTRIBUTING.md | 4 ++++
 check           | 4 +++-
 new             | 3 +++
 tests/nvme/rc   | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.55.0


