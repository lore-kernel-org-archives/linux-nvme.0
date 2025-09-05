Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5383CCA0FED
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YJWgWfDm6ivkldEpXn7f11b2QqQQK+HwiXbMQjKp/OA=; b=0dbavV+wSGHAHigbuT8r3zw/ak
	Gn5nGC4a6cwC1gnH+qB5hrmuJCS0G9mazQT1ZNfSeml+O0BF6u5B6tJiGTFfLdg5Z7lDusTBzj00m
	0/z8pKFaQ5anyKFRRvpU66/kDAVjXQ30LgZreBT7OAyRR14gm+VLatYjV3jIcq6mf+yEUqLDgyJog
	4b9v5YRm92CbHldlNC2bLc+7SHXcUHZnXiWRekwA7EnfMr/7BlAhuzR4umqm0xb8+6zGSpUvB3di+
	K3k+1t6kokzWQWYgE9YMcB8bozMpIa8ln1i4RxRK7EVfmk50347vOkccqR0Xezpxctk0YTsloUeGA
	/L79ulew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugZU-00000005YYX-3U6I;
	Sat, 06 Sep 2025 00:14:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uufoc-00000005G6r-0HrY
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 23:25:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114758; x=1788650758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvDJg2Gz33BS+doCIEG0sIMD3bw8L32HmXlhTBzK+YU=;
  b=E3k7Wd4ICjNHTP3S1TA4vu9RR9OVgZRuKxGb+/jdQ1xFuoffdQUTz/iN
   l13VITEvHAjrl+YlAOL2WuqhJULOzeTRXzKn198fIbDQ44USEsmY07VvC
   64BLN7FaOed6oKWI1oR17F6c8FHAqeKaAWfrcf1hjNFHBQM76x5xSmXZ3
   cW6jDauevxF2eQG8Hfhiom9xhBFm/TK0JXQlfGE3jfzZDendKyTWzgHuD
   KYFkkOqbXgk0OEK2gWNiQm5VIpLWp3YC1M3IC0ZWfMkAiqVCVm3h8BfO4
   vCF2rGxBZku5cjcnXJ4WV1tNsA8+NEQoVQtTA5uNOctJfXkZuf8Tn4Fh4
   g==;
X-CSE-ConnectionGUID: gi3ZCT5dTreyNBvX8j+DNw==
X-CSE-MsgGUID: jrfLzoNuSbald2+WW9H86A==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109647312"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:54 +0800
IronPort-SDR: 68bb7182_49WnaAxgyJuJsYLZjBCRtSFrm0bJOfB5u/E/UQvbpOZQXzo
 JyzUf7NHKY+gEhGyMq5U+8DmUfOu4AaQCUyWHCQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:55 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXL36YNz1SHvj
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1757114754;
	 x=1759706755; bh=xvDJg2Gz33BS+doCIEG0sIMD3bw8L32HmXlhTBzK+YU=; b=
	cRNSGdAFPb07GFoLCSozal6DjXlFMSOAc2TqLmbajdhZk2ozUVAiFyf8UlPwWdg7
	SvzkTo8Ppo5pB9ydkhopxCi4GWyje1+pXSZ4/ce7wmJoZAaUNp8/iGv6V+yOSEuD
	PRKZZ+7QCFW2pRsic50CXbGTALfDcZ61RcogRWsk9DT6y7d+i6lpESH4iUjDGVwi
	Yqe7fZ5cg6ChyU0VI2OHC9JTal7go0mh9E5XnuKjVJwbyy2JM9KevttlAgQmV9W0
	BzXgAbMf2uQ/X9EkTGfw4WebetEDGAAeRbfb2kK5BBGWWVbTH7SOCNCqG812B+w3
	AA6a43shABrWbATQQOZj8g==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Ct4dX5tjjD3J for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXK3RYFz1SHkR;
	Fri,  5 Sep 2025 16:25:53 -0700 (PDT)
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v2 0/2] Preclude IOCCSZ/IORCSZ validation for admin controller connect
Date: Fri,  5 Sep 2025 16:25:48 -0700
Message-ID: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_162558_193792_1C7CA13F 
X-CRM114-Status: GOOD (  11.57  )
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

During negative testing it was observed that when ioccsz and/or iorcsz=20
were cleared to zero on a Target, a new connection to an administrative=20
controller failed to establish, due to driver validation of those fields.=
=20
Since an administrative controller does not support I/O queues, these=20
checks should be excluded for such a controller.

Kamaljit Singh (2):
  nvme-core: add method to check for an I/O controller
  nvme-core: do ioccsz/iorcsz validation only for I/O controllers

 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--=20
2.43.0


