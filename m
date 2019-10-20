Return-Path: <SRS0=Z/zs=YN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CBCA9EAD
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823EE21928
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="StBfrLG+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BMkLgXbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823EE21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zfS20afX9Mz9etGp3hrDUP65tuUCUgKbiLaHq/aIKSY=; b=StBfrLG+z6QZon
	MowPy3qDHpt112MXDhfyxsV+ONKdrsenF97+QoPc9Arh1l71nL4Ms6fCiMT1InXRe527Tk7rIcBkl
	tFuOmKrs+LaOJXEtOLfO7RF0geBhBjAOV2fh/bsAYJOhDUkhhoZFvVwjkKXEPUDVvqgwh3D+ltz8Y
	PCEpMqIGIbR483PCsf8TFfQQsMH7Y+/HGmN2tXLaP84SSdrs6TxcI5v45Ip/E2Cff1OqGPnV31HiC
	Cd/fyKyrD5N6xT2PExp5C5OrOHGfL3t53sEo3wnAaSTyhz/c5iaQ+wNsEC7kWvfXBPRQ9xqLcbnPB
	VgL0qf8fOF2z/W5A4bYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMKqE-0008S6-PB; Sun, 20 Oct 2019 23:42:30 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMKq8-0008Nm-Lo
 for linux-nvme@lists.infradead.org; Sun, 20 Oct 2019 23:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571614944; x=1603150944;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/UNosYy4fGH3jSNC6FWo80lL59SdY8u6GGobtRzBgJg=;
 b=BMkLgXbbjTXIGwXGUXykF98b7QbUjFIxVAqkk+p/JCzLoN0FEFq4/qQV
 aTAic2zh7Rjshms3/6aJg1b4HSpUae9PDPaMWFfusBfUT//7bDyJ4L6JO
 oS4NYPaMW3x3++LGI2IsPPhODywXyErIzz3+oGwpDPGH+udx2Ap/670gd
 FRhOgiig/BLJL0IH1mwAvKy/ZsI/bfmnK6O10Mf7KL9xCUwLuBLux6Xkb
 ofhwVLz5TGA91PtVC7JRnvJWOfEy8Gt96PakAMO1RKgbCISo8kBIthutt
 P6cOiloXPZZ6+iFRzjZ1pzCDvUpIcrYSQRDCOIRo9euERSfNP0h95qgnI w==;
IronPort-SDR: 1+JKtPPoSk3IQ/2Bvi1K+/V2r37eWBAGg2/cx2uu9HGvYbyZ0bU3ipUpM/WgsgqEZCZtf7QKD6
 KiakDRix4n04AaSc2Hxa0MqIl8CChk7nTbLDTmzi97HwS/bVjNgeHaveNqWAVPZ7A4bM/fO49j
 R5Ewye22vBg4YVKcKQb8Vr0zEwjtKWT8t45k5z1UqkkXEbgIKOvEFMq1/PPZHeI8fJvk4WdUwl
 4jCfu3qurX/LurZgv+9tqX2lVg+IF3lDuot0z6yB0cRxOQ0rYQXy1P9c8dSbZCLWjDBt8Dlrvq
 BmE=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; d="scan'208";a="228036408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:22 +0800
IronPort-SDR: 4cimULh3XNmRIst2sjKcqq+D8lqsAmGhyWDXMn2XTHZvQ4GFcADjuqOfcDZf0TjZvl7RLOD1iW
 LXCIFqqytxXiZP7uun7jHUPnMdoptGb5HrcIoYZK4ZdrXDQF1MknuqjfR/iyNy6ur2O+VoAuvQ
 6TMcJXqqHrMmYfkL5EQ9BBcnv/qG+9A09LkfiaNFjH3bSD+WADce5bkOweDeC0ssNz0tU56f2K
 3YfVbJaHh2tyi42pM7KJawuoYs0Ifw8FYmzEjDSen0UKi9r3Ui1w67xsf5fbwriqK4iRthErVu
 TaORoA3nRSoTTSYeQyeEumzj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 16:38:03 -0700
IronPort-SDR: 7BPY8H2q14vbAj/Dl3YTfQh2HVgKgl2aQlUUntJlOFWhwdsZ51p9+a3BmLv4iDizI3Amvl8HhE
 J/RT5sbx6K590h5FBm7e8CrupYcQf6wrqi3xtjld2/S3uzsCuftVukkQZXTUN1fcnXBZnxp8p9
 U+U9pXmRzOMU3x6G0gf2VZ94+SoQslVyVe0fE2z4wLf5EmkR6oRxpsFmE09SXSurTaWAaU8/k1
 HX4Fp1W1/zIGZ4q9YNIYn4JKWXWQG/cX7ZhTG5j1LvUM9rcRKQLTlvwAqQdCAhqLIvrRjcQy70
 Njc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:22 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/2] Small cleanups
Date: Mon, 21 Oct 2019 08:42:18 +0900
Message-Id: <20191020234220.14888-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_164224_717376_B5E0B08F 
X-CRM114-Status: UNSURE (   9.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is series is a couple of cleanup patches. The first one cleans up
the helper function nvme_block_nr() using SECTOR_SHIFT instead of the
hard coded value 9. The second patch introduces the nvme_block_sect()
helper to convert a device block number into a 512B sector value.

Please consider this series for kernel 5.5.

Damien Le Moal (2):
  nvme: Cleanup nvme_block_nr()
  nvme: Introduce nvme_block_sect()

 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
