Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D3C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o1HrNO41HhUlMUOcVomEX4RTQ0sFHhmGBTrbE0pmJkU=; b=r0mJauQuhtSh2ra64j5Wkfv5AA
	xxV/LGtRw6ZSwf2JWUroa9Gt6sFWjfMVPVkbp570WShUy7TTiGHBqj0EZsn1uoe+5GPvX0QedttM9
	9zKUJamAU4FPRedMe/M5/Y8zsGlD2nxmdOe8kwqXm/nU7iiaMBS7f48UT1rfIcw8fncjGN7xKEJVO
	/u3LFA8yvKLMNEYILVeyIfvY0bVQkHdE5vevAfVlRK/VcRDv1yI7cE1H+GfDE91tbn4qBPcvX3DPH
	4+gxeX/WSqmFbdrEfohVOUsf/6545lv+r5nqxG5tEmGun4LPt7xsXJeswTZp9OH5pUlOrn5yd7HJo
	JStftouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtV-00000006gLb-1s8V;
	Mon, 02 Jun 2025 04:35:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtS-00000006gKU-2THB
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 04:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748838926; x=1780374926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=10HOJgwjs6GuRnqJ8nzCfxEBmE12CnrJJ1uYfaExO3A=;
  b=jCXKqyEWjPeBhEBavgDqExzxbC6RPLn5DXek5SHCBEKLoTSeXhJVne+X
   qC2zQm75KbRsO5xMCN2HZ9Hd4DzWnLEgYnMoMZPt37VQLVaqe6Wyo6STK
   JW5HBQhDfkKM4y6+XJfAWb+MbkgnRH6eON6uogeqA5GKsw5ftMpDgsVDi
   dyvYlws79DbSL/1sA+wiHlnnqNrClG5adEfA0NDTaAZsNX56o1qa2tGoE
   IZfwgGArgo4DdByi+J7Rd1C+o5OfMarDC2YnVPXEO3MWYLDm9+uylG3Iy
   faGi6SMKQW29SZvx54ujwgUjJv4AE6TUCrlpQzqxN5D0keqrYhix8lJ1L
   Q==;
X-CSE-ConnectionGUID: Ho7zB4zgRIWOofQAdAtVwg==
X-CSE-MsgGUID: ut3mmpeAQXqRylZvrKt1hA==
X-IronPort-AV: E=Sophos;i="6.16,202,1744041600"; 
   d="scan'208";a="83253763"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2025 12:35:25 +0800
IronPort-SDR: 683d1bb2_LlCsQngFc4neg7vao16esaGZXiLEEXpKOlGVAzXX8tUhf7L
 nf9kiv+VvOZU4bZo8mULCiGkX4fVYzUAXNHroUw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2025 20:34:11 -0700
WDCIronportException: Internal
Received: from 5cg217418x.ad.shared (HELO shinmob.wdc.com) ([10.224.163.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2025 21:35:24 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] nvme-tcp: fix two problems found with blktests nvme/063
Date: Mon,  2 Jun 2025 13:35:20 +0900
Message-ID: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_213526_624430_28B522F7 
X-CRM114-Status: GOOD (  11.70  )
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

When the test case nvme/063 is repeated a few times, a WARN and a BUG KASAN
slab-use-after-free are observed [1]. This series addresses them. The first
patch fixes the WARN, and the second patch fixes the BUG KASAN.

[1] https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/

Shin'ichiro Kawasaki (2):
  nvme-tcp: avoid race between nvme scan and reset
  nvme-tcp: remove tag set when second admin queue config fails

 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.49.0


