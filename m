Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB132C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Fh5Q0fclU5Kv578t8uLI8jR7YtKpZoXnS2iHfEtp8Y=; b=x0Z9G+U3bOW8S35qQydzb7QWY+
	AuFfJs6RWR+seA7hNu/fRI5UKfpudlTQXmiy78oTMGF2V2PhXoQ3SF2poouLAMmlTFJ6mL1FDRt2z
	Phf28qCLtvBSu35e7syvptTZIfKz0ShPrlUcVKrSWmtTUrsbdHoiMtF1gdMn42hPAkhP/ysokFz/X
	H4j7NEljmcx1pmZSQ9dAVCSu7IFfEVfFXzEvue6uwCOGEWxhgNnNUoJoF1b+A/m2hq1Ts60SE+l6l
	d5oqmzeaytkzyDboud01gJDwKZz4nqGdIhrgrHo/fVmPrwggOCOVhzYZAhtxpLtMmxN7JPvtnbQ3M
	uJ/2zHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk0-003Nke-0G;
	Mon, 24 Jul 2023 09:20:32 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrjw-003Nj5-2q
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:30 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbe35e028aso7205475e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190425; x=1690795225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Fh5Q0fclU5Kv578t8uLI8jR7YtKpZoXnS2iHfEtp8Y=;
        b=G8XbFxztTRzT5XNC0M4Lc3o/N/bPzU1aRDrK7jg6S632hUYBAFJHlGYhMC29OoT0sk
         gP1utXZGtWJMDieFa0tNhcLpgRmN3e69+R0FAil10qxYbeGaZ2x3CQ1dvzjORrQLhqwM
         n+2gp79lymX7GN2EXWAMv3Kgb6cud/OI4wpjrfklmAUKvTRhz+RPkcpy0qMFu2G4hZYr
         pUQITByU+Azp0Y855SLFODXK0Q6qoc5AbQj88D5rm92ae2f6KwhYyaP7DVhHCFnmLKge
         Rr755wrGRJeAuWQt9lMIKDkjBltXMRxXPcd+wigvl3qBHD22n/aLi9echcfy+tCT5y3f
         XLvQ==
X-Gm-Message-State: ABy/qLZ+/+Y9x568hoHTiGi0IxCxkjTOBYvknWinc89C3Um8oEueBoEk
	P6P9sXUxB2i4GVb/K+RgwIefjFUf0dg=
X-Google-Smtp-Source: APBJJlER1Of71MLrbmun8zoaDakWtCEdIwEHe0fZdOnvD6a8uMkpQU0dWZKJJpWVR2LA2H06kz4KFQ==
X-Received: by 2002:a7b:c8cc:0:b0:3f9:9a6:eb68 with SMTP id f12-20020a7bc8cc000000b003f909a6eb68mr7734275wml.3.1690190425383;
        Mon, 24 Jul 2023 02:20:25 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:24 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 0/6] support traddr as dns names for ip based transports
Date: Mon, 24 Jul 2023 12:20:16 +0300
Message-ID: <20230724092023.708335-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022028_943775_0C96086C 
X-CRM114-Status: GOOD (  14.00  )
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

Currently nvme-cli is able to resolve an ip address from a dns name if
traddr argument was given as a dns name, so it does that and passes down
to the kernel the resolved ip address.

However, if the dns resolution changes over time, the kernel will not
be able to reconnect because it has a stale ip address. While this is
not a real use case for nvme subsystems, it could be a valid use-case
for discovery controllers, where the resolution is made from a dns
name that may load-balance/failover over multiple endpoints.

The last patch (7/6) is for libnvme to pass down the traddr as a dns
name if the kernel supports dns queries.

The inspiration was taken from the nfs client that does this for
redirects or locations discovery.

It is an rfc, so feedback is welcome.

Sagi Grimberg (6):
  nvme-fabrics: add helper to resolve ipv4/ipv6 or dns name
  nvme-tcp: use nvmf_resolve_address helper
  nvme-tcp: re-resolve traddr upon reconnect in case it is a dns name
  nvme-rdma: use nvmf_resolve_address helper
  nvme-rdma: re-resolve traddr upon reconnect in case it is a dns name
  nvme-fabrics: expose support for traddr as dns names to userspace

 drivers/nvme/host/fabrics.c | 29 +++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/rdma.c    | 21 +++++++++++++--------
 drivers/nvme/host/tcp.c     | 21 +++++++++++++--------
 4 files changed, 57 insertions(+), 16 deletions(-)

-- 
2.41.0


