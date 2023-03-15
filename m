Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089F3C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nhKO98IRrX0uhZdFXWus3qyBVa8FVw+xrtl9B4zYcG8=; b=IElET//Dg5KbE+0MqytclUhOCl
	bXtdyqfzKHjgxSpPX5vJwrUs2Ht1WOR+GouWTv6s9OkgBX++uMMeMev+79GFCi2O4G3WQf7Y/N3D6
	PNNOBPXERGrJPgvDtZ0CAAEYcrh9hOh2BcjkAB+PILLz62NNfSonQ0YYa5+vnwoDWi8EOGs6ZAtj4
	FrOvjE5KrwH9DnLyTq8+w6usxVm6uzCZgNiDVsVS2+qhdS8ySqajnzt3Apj0pT1WygXs8NKD9JMGO
	2gnFFspEW7D3iulPAnAwaUUKjXcTNec5XaIBRiCrappffX8Id6Jo8eqAL+A1a+gnJ5gAwBAgTSzAA
	GZ5FK1wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrK-00D8Am-24;
	Wed, 15 Mar 2023 10:59:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrD-00D87L-0X
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877986; x=1710413986;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66AD+yhKJ8DTnEgUBTGHfwmP+iI+uuhx6PFl5t0hgvU=;
  b=j2r9kLcU34uc57cYuNZsrhCvUTsxoshJzcrCpJ3tarLDfrFpo8I5SUSg
   /zM89uJZgjOnvqv05CzfIzACGJbUoTwG9CD6IYt6VfBxKlcao9DekfZDk
   fBjmpyIZbVdjDX9yo5Pt5Dav+NpJKhDJLmS7il6wtaao4SdJ0iwC/Zxk+
   KfEKeOm9WcqJdwFefYbGdX6AwntaDJNHyjwFBnr3zlP69oMMSuN4uH4ld
   BPSSij0ofzbXgg794fbqOJZTtsPwFqkANxKSPpREDZfPfkLY+11nsLrHj
   n7+84sZcH1MMYJJ9I4wVEpMOjbBA2zbmCjDsVaTLAHeQVlph7xhwtVWOb
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966387"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:42 +0800
IronPort-SDR: yBedR6uPcxHzJy4//FcBLD8ER7wuEgLSuYwIMDj1R6onBcYCb4A2Wh1mV1wp7ImzYmNYn2Pgw4
 UhhsWx3kscG7tdRom9V4/HzDN66YM4UgAjMGVFjSPj+St4OyiBH653h0s/OsvknD1HbqjLnjGy
 YAwLB+qdPsJS3Xv7+mYk/Lw2t+IZwZuC12LRiDpJExgWyqdUNtchAZa1EzYwCqZYXP/p7c2qtL
 XMGH7e0Nux5Z8T/sUsB/7GjaumO0csrqcAdhIza9ZaWS3N+4qrxPcWrsj0bkI6NKi8jyBZ2AQS
 VcY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:09 -0700
IronPort-SDR: fY5S4LofbAdxNoFOQr0Lqrtv15lgoKPq/XZQEXeHtAI/MSJsyTfJzZ3WCqYYoKCE4JXK8NX4TN
 OWY8p7FbORZq/5Z/ig1udjLruGzKRsBEKerGl4mVlIkWlm87D2r/isO1EnTlIv5D3pWdbe0W3L
 cmrvvvElRPu5GV8PpIIWcp6lAjGDNNttx285yN1TI5eO0GiQi/npFDpE93htWiWRqwGhSTZw4r
 MaRaD+YZmBxnaWBHgxJPbpN6QOzNKG8RuRVvCTHyq7eiv+ACwcf8p29Ycu6YUMrcorFNniqTQ4
 zQQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q20zFqz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1678877981;
	 x=1681469982; bh=66AD+yhKJ8DTnEgUBTGHfwmP+iI+uuhx6PFl5t0hgvU=; b=
	BvsH28y/haBisA/vzn5of4c44XV99LzqoOCdq6uqcL2siZRQ6KF/4rUJBU59gjff
	Ifp4xFt/3x+IgltmSC8DNEc5M3LcXjol06zcv94Ts8CZB+ML29gQPwsYrX2Gq9yZ
	ZS4WFCyHJKbkfKhePfGNHwchAA7OxdOgmG8Un650njJaJxZ0M2YpPiaeacB3huFb
	OuZ69w3Y5Bu/z2pJmLRHWGHGlpcZJh43yVIIW0w0gYFWKvsGJo6Owts5mxndLQqs
	qXczpRoBeBtM41KRVnwbCHBW0t+Tq0kFwHVc9LwTjCEPhWADkTAmYEns6Agb1Brv
	N+i9IZB0bo+JD6Kn4G5s8Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JhkDHfRqHJCq for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:41 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q10Hg8z1RtVm;
	Wed, 15 Mar 2023 03:59:40 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/5] Fix nvme target identify command handling
Date: Wed, 15 Mar 2023 19:59:34 +0900
Message-Id: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035947_293447_BEC9A759 
X-CRM114-Status: GOOD (  10.81  )
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

These patches fix compliance of the target identify commands. The last
patch is only a cleanup and does not introduce any functional change.

Damien Le Moal (5):
  nvmet: Fix identify Namespace handling
  nvmet: Fix Identify Controller handling
  nvmet: Fix Identify Active Namespace ID list handling
  nvmet: Fix I/O Command Set specific Identify Controller
  nvmet: Cleanup nvmet_execute_identify()

 drivers/nvme/target/admin-cmd.c | 64 ++++++++++++++++-----------------
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       |  2 +-
 3 files changed, 34 insertions(+), 34 deletions(-)

--=20
2.39.2


