Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F1C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cTHkFJSQ2K8wx/Vs8JGGyKy8bvOP6JQMyHvN9rm+uF0=; b=zPe+DKy/s5l+ACNmQoxL519nCc
	w0tletKSsh9TL+8v8OV5pwapdUI/b5lGldFpsiVrgxbvQNhDGzgUB3QmSrDwmVVGA5TqSm03dn3q6
	bZDygHMdy/JbO/c8gx674NQuBYT9+y+NuUnAr5rnKhjDrdbsjS3JVsXX3JkjT5T34oV7Rxhuj9yZf
	j2nqXTKYM01QLDVaKIanJrtjN/HWLpucAk5JD0bI4mZbPgTGBpdmciaffVKnCQF+ixpov148PxSrK
	SkvSs5kITBT9AfJY290QPAFXKalWbjUXBY9fhJvf1AQrxrtY38OjV2G1eV+61mVax/QRfdK5BNT/O
	HTGHs1PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHN5-00E4Eb-4J; Thu, 22 Sep 2022 08:15:47 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHN2-00E4BO-TT
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:15:46 +0000
Received: by mail-wm1-f54.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso809042wmq.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 01:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cTHkFJSQ2K8wx/Vs8JGGyKy8bvOP6JQMyHvN9rm+uF0=;
        b=RYpMmdXJ+8lPhpXimUgD0aBKOxf3nyzZMJTUl0QzPs7nTueGXtmGn5gETRyV7jan8w
         JgRksu7VrS9fT729RPgQI95aNwS3/ybt4xSs5dtKEQ3ZqMk45HA+nNaklIz1B5XwwJyk
         D37dlGz583pHU6GhMYKuHQglFsc9nBGgVCnw/+rcjhpC8JWO2TzEEh3DX3MM/ncsrAEJ
         YlcRhHIFmKD01zZHEhgTUtlPVNaSNQS9dBSMYPK8o1kqL4mtusXVpXFoM7db9mhpkByD
         LAV50oTpsU569MsMIcwylZxoJnHhixZdXIs03sclM0Q0oMLOA2J/G3xn3bxsfDbhUaGw
         gw4w==
X-Gm-Message-State: ACrzQf24QSnWzX+lTfpxXM48YteWc49YXivR5fMLWmFO82Idhzyo8Cof
	jE3RcznM5BIFJkvVbr6gxYcOt8W+BjU=
X-Google-Smtp-Source: AMsMyM4YeEC8bGdae4gD7GC4PyBloJlLLH3jMFjaxrSeRYhbzH1uJKY/3u1BzYHQL1/S02MXL+uCNA==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id r11-20020a1c440b000000b003b3330d88d8mr1463669wma.31.1663834540551;
        Thu, 22 Sep 2022 01:15:40 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t126-20020a1c4684000000b003b32aa0fabcsm5016997wma.4.2022.09.22.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:15:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 0/2] Fix missing AENs when discovery controllers are disconnected
Date: Thu, 22 Sep 2022 11:15:35 +0300
Message-Id: <20220922081538.13364-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_011544_988632_08174506 
X-CRM114-Status: GOOD (  11.66  )
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

When a discovery controller is disconnected, no AENs will
arrive to notify the host about discovery log-page changes.

Fix this with  trapping a new dedicated kernel udev event for persistent
discovery controllers that reconnect. Prior attempt tried to use
"connected" event already sent by the kernel however this also applied
on the first connected, causing undesired side-effects when issuing
a simple 'discover' command.

The patchset includes the nvme-cli counter-part as well.

Sagi Grimberg (2):
  nvme: enumerate controller flags
  nvme: send a rediscover uevent when a persistent discovery controller
    reconnects

 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  8 ++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1


