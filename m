Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BC4CA1013
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w3LRq2jCcXKday7uyZLwo/6MDkY9u0o9rI0JTv9ri6A=; b=K1BlimvTLdIwyEwmZKBjYz+s/p
	3IdmrHbzZ38uMbr/qXPFSo9ORhjeOQ60AIde6NHZN27E6tvgplFtf2CGtbd961rxxyRc6uapLEG1D
	l4mTkWybg+0/azFS0uGmRCab3JdrE3ZOKGlOvsPdrSNZ40eDblLWOuyzFqeNmSqp/ogT/r6xhQuLm
	HpaSN/5KVP5SFEryw7udol6YpnecYm79jq1+5855FCN1GrKzv5f51LfSoeK5N4T06GPshWN77ZAO3
	C5I68NyxrykAz2GGZw2KbmmER32TqcwWkispTZAprpmU32YABggTHwpTX2ppEngqyUQolpbePU2+r
	8BhUiyTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugYW-00000005X7Y-1vKs;
	Sat, 06 Sep 2025 00:13:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uudhD-00000004dsw-3eUh
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 21:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757106611; x=1788642611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CYVAyYXPatsdLzMjk9BfS+eVNO3wXN5nXzMRYuQDU6Q=;
  b=KMkxL87Uf16GsxmSdyHow9oEMGYEx6AXTY6INiQipvQN4chngw/yBXq8
   mmCJTEDF8p1aDmTwNooGmWi7F6vZKJUKeem/ukdYVHLFSrEVkGIlhE3iP
   rB1HtjiIDypq7ga9kcSIPMogLaFxiAPm4UIy7bD9ka5RfNUIy1OmIuakd
   /7tUEPnp4YEKqE6Cly3PjG5c6Lgjo/aO8XSheRctBuDy5mFrB0PDilw/O
   vqEAkMxljnZ30cOGsXKRSPyMpnWrQL+x3oR9UbxRC1wsBkK/YK0aWS0RL
   ze2vQfQMZEQMpR4xJq/qCFog4fnCpLTyoFFeLKq/khutW4Am22hREZVd5
   A==;
X-CSE-ConnectionGUID: Oo0PCSEHSI+e7HqltfFi5g==
X-CSE-MsgGUID: amgOZdp+Rf6o5PWDEJYwjQ==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="113683280"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 05:10:06 +0800
IronPort-SDR: 68bb51ae_HUupEXEvnQ+kNJjso/p0KFEdGeECNbW0A/AW32mZq4BlQf/
 ftSCYwpA/EodJx/W8oGyj6zMaE3dtrIvoAHk3QQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:06 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJTWf0j3Dz1SHvm
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 14:10:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1757106605;
	 x=1759698606; bh=CYVAyYXPatsdLzMjk9BfS+eVNO3wXN5nXzMRYuQDU6Q=; b=
	inaA4eHunSj5nhdp2qJFBHVOSuII8fs/VeBdonbMSgc+7gS91rZ+yrcmDjaBqIcz
	alUzFezuLbwx7WH2DyA8EHdAs3faSFfr8IQIVQ89UYqk+X07o9QHq/OScWHoMAtP
	S7gUZrtcaL7G3ArS4D6HBBQ+w0OMfvSFp9vDgLQSTSGbs7Ge5GQs1DU/6IjWV3IC
	rZaaPBlM7tbd8mbHn/+H4Ajs9ICNfa40WeZGD+GUsQCPErIH12zBANTenVad27OX
	YB6a4WlWvXlBFik+1CkYuExBpmflCecFGWIZM+5delNBZCNs1sIH1L4pXe0CHzdk
	OzRn7PIUD5jH7MEgfEjpHA==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ndj-c_6O6T6m for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 14:10:05 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJTWd0f9Nz1SHkR;
	Fri,  5 Sep 2025 14:10:05 -0700 (PDT)
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
Subject: [PATCH v1 0/1] Preclude IOCCSZ/IORCSZ validation for admin controller connect
Date: Fri,  5 Sep 2025 14:10:00 -0700
Message-ID: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_141012_003535_0BED5F5F 
X-CRM114-Status: GOOD (  11.74  )
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

Kamaljit Singh (1):
  nvme-core: ignore ioccsz/iorcsz checks for admin ctrlr

 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.43.0


