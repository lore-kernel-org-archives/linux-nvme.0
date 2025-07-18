Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3715C83F34
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TuQjTFH4NYHS08rAxsh9puTIes9ZXD84SwiITg+0qBw=; b=n+epztYu0Rh5afvH5hf+h9ub8T
	pPvx/Dnurcvwz9UsR9GhWfzFxepysBSngnKQn4QdS+K7jVIj/Pbww+Yb8P7TAgt2zi/oJwOmIJVWI
	HJ3zTXWP1Hg1WqOp7KrEnDJqkXIWtQpOYKrPRg0URCQwqYGU7JjNw4+8hitHh5tTwL7duiBL7O8Uv
	ip0JbSy3YkeHvGr/FJ4YDwWL85+v0l1KwaTMQSvf+ta4dqxVGLmfiO4oYs1PxUtiPudeif2GbKEo5
	nPEI2ZYPX3kcpEix3hMdG0lvsG3w8mKGxMIxeDFdiMn/W78iYKghCSb1HlLxWS5Lj9zdQzp+2f7pJ
	XLBZ9Ovw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucZnc-0000000BS5O-0nGY;
	Fri, 18 Jul 2025 01:22:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucYjz-0000000BOnJ-2vJX
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 00:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797659; x=1784333659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=En3rA6x2Gu9JvlFAJw2uquATA8Ug4Tk93J3ouV+xvg4=;
  b=mYE91vCQGZ936+x3KfVfdFIu4FAYYCM+1yeOdSx4IJhqAxxy3tZXQkls
   4sFja2yQfJ32RNKJRmaY3RWWKgXHDnOKu7DugiZzOl1PIld7nfE2RgD7e
   rgD67CIB2bxtNGoD40YWGRQRvEOxEVpoZ0RO6ZOpDQYVwYG6GBoIOYmlt
   kM85XQFfmKERUYEW+YFYYoYfJumLwsLpWi51q4kYdlEVccP5ttlRMlVgk
   lnS3A70xiGnRKE/uTbNYDIQ/JMwAv1P9jDaux1YXEznibBWAXbnii79V3
   7zdNZLGEUokCzao354CxpXeShh1Miu1b6UmedhPtr7mpSGcKhSOiQT4gS
   g==;
X-CSE-ConnectionGUID: Msd2YRsnT1i+9hAfqnSvMg==
X-CSE-MsgGUID: Ls8HruJ7QKuB1wmTh30nNQ==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="91918826"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:16 +0800
IronPort-SDR: 68798334_NBXCOqQ8YsunTCHpgIz+zSIDceWiIt1gk4c3uu6/Lu0G4Jy
 k6bYVJ1eAL43ScvM6tWj0IgykKj9ToBuCQN1eOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:48 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:15 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v3 0/2] Support for Administrative Controllers
Date: Thu, 17 Jul 2025 17:14:13 -0700
Message-ID: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_171419_821979_359ADE92 
X-CRM114-Status: UNSURE (   7.86  )
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

[1] Add capability to connect to an administrative controller by preventing
      ioq creation.
[2] Prevent an admin-ctrl from getting a smart log (LID=2)
[3] Prevent ioq creation for discovery-controllers as the spec prohibits
      them.


Kamaljit Singh (2):
  nvme: add capability to connect to an administrative controller
  nvme: prevent admin controller from smart log fetch (LID 2)

 drivers/nvme/host/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0


