Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C46BC32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094CD206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzmDXgvt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fKJnRWJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094CD206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SZDE6vRl+B27Gj1J1ATNAa4VVJyhqK4c4GZBhiFbHhI=; b=Mzm
	DXgvttXI7+ZmYIg562rGHHZIn+Q5KTSWoJ/l5Q+SFVvYg6Zl6NQ91MQ0UnuIDbhQgfxaoJP9gmMqt
	1iTxSgN7hPP6eHuxVpd1K7oRciVPgUpBtAVotAoJu+1p7gx/GJBGkOYG5jOULv/AdsKIHWiyOd6RY
	5vVnKESBboJlnLv2dKpPBSiK5H2PmzBDLJVrCVRUFmDXyIcFsuvPu8VvzA/jmswYvt9pvcFvwCF8y
	eitQeREiSHbUFaFS6CthyItSLBVmiI5ucKwMwxMM6GsV6Yxg8GDU7EQyIGs095pvp+qGATJUIiO/n
	VpHQzNhN6+rOcjCtattuVOxfofVYpvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipPy9-0003La-Ny; Thu, 09 Jan 2020 05:02:53 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipPy4-0003Jt-EN
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546168; x=1610082168;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vWt5PihIOLN1+Fn+6hk+16ULOGRcr9Dj/Bo3xcAFuwM=;
 b=fKJnRWJF/caff5inLPJlrU6WCV/wSw1uH/RARf8NTeoM+zfdXzpc80YC
 uxkMzjgowJzugR7nW20IqywXwjKzi/NaufoDz3bBO02BKKa87LA1aQ2GZ
 o8pmMavv3YpTiBfq7IFxn4SnZD7yx8aAecnBPhKGkeBOS3TnJOdosA95N
 szPXKfC3aC4rnkR9a8S0hXcjaORePSj5s09eBk+h4R1mbKdoUunI8F7rE
 mgIileZHLVxwxTb0XgQMnFpfpYt06Dr00MTddW4C2a/Tf2hAjWJhYo9kK
 3Y5kWb3J+RDHogs1dE18J5RoNzGpEBRV+n24s8wO+Bel+d41msQCTpzzD w==;
IronPort-SDR: FUGSHI4JDml5Anl8AZR/MGWNADaAm4l7TCUCwV16ogBd45a2xTdDJX3z6tjKr5umXs4fyb59Oz
 VAIU9Av+w81Hba1uyHvLd7T0qrsEkHFFzY+Xk+jzQetRdRs4ZUDhZtFrpaSkx/DIZYtPxTI6ae
 wW69cTlimSowmeDV/VZfRwpD1hQ7qQDUuyJUptrBz4GpiFRPD/uUuvRk2SSY+nRZ1CsoY8qvtD
 W18OIYAKoeEpBtOziwzchkb4j6OBQdJwpbAGjHohbjJXL2gQ98/9H2erKN/bO9UzIwTyTiKwGn
 sSI=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="127021378"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:02:45 +0800
IronPort-SDR: EmNqoeXPsVZ1i8ya3lETnNCc2UzIKTpGQ0lqnr3le2ebDL5kIMaVTK74y1eeMXlstuOqBJnL2N
 I+wUMjCGfHmi7U9QoQrw5DoSFVDJlXOGqKpMpKw4LjaUMgPDOyXPjrPGZ8a8D/fzui1Byl3tJT
 feZ+dMiWNfyL0E3DgOQE7vnk3N563aeESCY2Z9c6AvsBe2IKutseaf1SYQgFHKXG7yHUQCa/E5
 0W3f/xJtbl5Jx0UbwUXrQdzDx5CAOTroWOdP1Rx0ilhYL9iZgl7nEQRKsByC/j1wzHiIZnYGES
 c/pyK4rtoWX5YAKZoRcXMSGA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:56:32 -0800
IronPort-SDR: U5771mFOFsbDrAZbz+I5sqRq7w05svKzJVtuvfdPvNybnpQOvjfCImHNn/jnilP/xI1gg3KeV8
 /x6R0wTw3R2vIs/LfhvmT67AUadtJe+/KRsBh488NwvhKnRd7ocz97fs3Z7uZvhVl3i8QN7lpA
 EURjZGBZyj2xaBXpR3loLrbKO3Dl7B8rWXiQusDv4j4RySX9C7Fm3caO2BW5Ow3viHaJJxkalb
 TKEsYbeYjoRMvebsstlriLSyTxGVvkV6gbNgOJ6zDkjLVyG5YZV1ULRhH3yVhwhT0f+fyyjmZQ
 Wbw=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:02:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] nvmet: misc model, ctrl-id and AEN fixes
Date: Wed,  8 Jan 2020 21:02:40 -0800
Message-Id: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210248_531014_DA733B22 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============7888336333493862387=="
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7888336333493862387==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

This is a small patch series that allows users to configure the model
and controller ID. Also, patch #3 has a fix for missing sscanf check
in the nvmet_subsys_attr_serial_store() where patch #4 provides a fix
to clear out the async event for which AEN is not generated.

The changelog is present in the respective patches.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: make ctrl-id configurable
  nvmet: check sscanf value for subsys serial attr

Daniel Wagner (1):
  nvmet: update AEN list and array at one place

Mark Ruijter (1):
  nvmet: make ctrl model configurable

 drivers/nvme/target/admin-cmd.c |  17 +++-
 drivers/nvme/target/configfs.c  | 135 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c      |  62 +++++++++------
 drivers/nvme/target/nvmet.h     |  10 +++
 4 files changed, 195 insertions(+), 29 deletions(-)

-- 
2.22.1



--===============7888336333493862387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7888336333493862387==--
