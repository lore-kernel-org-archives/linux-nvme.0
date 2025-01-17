Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD394C02185
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7fKQJKlRwwvNQzUUn/etSC3eslnmt+/aDWavkdxJI0A=; b=fhVIRaLiVIn7bolQwJpluz+1A5
	rxlLwg5X0tSxxzQVVQQKlwOYBB0pujkzVrDSBA2zbo8lglAD54FsihJTO4i+Bovl7EuyRgB9RKuxJ
	s3r04wgQWbXMvbAYGmuzcBKjuh+SZTzZPPsEg2KLfcGXLVVXy9iQZyokHAgQnF9h5bm8UyeSgDcsW
	hUhyzkRid33BbUwK/7m8pE/umLWOhHYWeW9mpaWyz1ILKc98bQjditEX6f1bSxdDvMGHeRaG0uaq0
	GoU8v1hbYRMgONtEDPcfyoekGEYFgeX2CHaIwyJCMpDxuCW0zH1n8r6sE4mCaweO5W2eq77jdGq0D
	PCiaJqjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYpVJ-00000000q0R-2UX0;
	Fri, 17 Jan 2025 16:47:29 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYpVH-00000000pzo-0u5R
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 16:47:28 +0000
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=lcADisCFzhmo0ZJ4kmEAVT0aL8tLgB1mtA9B5TH0LV0Mw6HSyWE7IK97qaXVwiDei2WmUFVjCyJZKvm9OpdEgBwX3xjVXu8YmmNujdfJMlDB8sCDTPktF3h+SLU8qU7eaoR6g4isoTZ6HARsNEOiFRz4UfyYdVOe3pLVGkld+0MNIt7oQpjrbOIyMfDthycRVFKusRmpmutKa9QOC88FwbClfEM4eFkj/BWQLXrhNi0WMgWY+Lv6VTOYSBymvLvVRqZbhWN1TMhl4io9woEksdlw3sLBGmq7zOlOLkahY1g4QUZj6cblzOnTihm3DUqNM2pXsHBaOotvU8nARPC6Xw==; s=purelymail2; d=saulv.es; v=1; bh=7fKQJKlRwwvNQzUUn/etSC3eslnmt+/aDWavkdxJI0A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=zCqipda1ciQ9470p9fKtzHJha74OfHg7UKCQdw773eTjvUOzp+o7pzA+4u8Nimu5f0zVovO/NFPDo+QAjYIEAIGjgFNGMOaJhCyU25sik00IxYchMQNnSJia5vWMlrKELZKrcVur/owBi0r7E2k5fr65y4xLrPlMGxoxf/DddOOOGrO/7NzpZSNym6w75602YwwEL8J+/WAG5u25hYP2eM7kgAJaeBCr2Os/TPBULwS+d/ffJqPqRyXHHtWkacB2lFT3GZYUbi1mAYo+IqwZzLvC2slWNsNi9oE+J76rMAxxLzd/xNE0uInm1BfOt4P1a91IfrI+gxJ0m96apzBghg==; s=purelymail2; d=purelymail.com; v=1; bh=7fKQJKlRwwvNQzUUn/etSC3eslnmt+/aDWavkdxJI0A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 707430678;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jan 2025 16:47:07 +0000 (UTC)
From: =?UTF-8?q?Sa=C3=BAl=20Valdelvira?= <saul@saulv.es>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: =?UTF-8?q?Sa=C3=BAl=20Valdelvira?= <saul@saulv.es>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Avoid the deepest sleep state on Wester Digital SSD
Date: Fri, 17 Jan 2025 17:46:53 +0100
Message-ID: <20250117164653.1751-1-saul@saulv.es>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_084727_427963_08F28CCF 
X-CRM114-Status: GOOD (  14.03  )
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

The Western Digital PC SN520 NVMe SSD has a firmware issue that causes
it to hang when APST is enabled. This bug freezes the computer and
forces the user to cold-reboot.

Add a quirk for this model to avoid the deepest sleep states.

Signed-off-by: Sa=C3=BAl Valdelvira <saul@saulv.es>
---
Hello, my name is Sa=C3=BAl.
Here's a patch that works arround a firmware issue I've been
experiencing for years in the aforementioned SSD card model.

Long story short:
4 years ago I bought a new laptop, and for some reason I was unable to
install Linux on it. Everytime I booted Linux, the computer hanged after
a few seconds.

I've been working arround this issue by setting the following kernel
parameter: nvme_core.default_ps_max_latency_us=3D14000

Adding the NVME_QUIRK_NO_DEEPEST_PS flag fixed the issue completely.

This [1] page from Dell's web mentions a firmware update for this SSD
with number 20240012 that seems to address the issue.
The problem is that, as far as i know, Western Digital doesn't offer
official firmware updates for Linux. At least, I haven't been able to
update it.

Here's some info about my SSD
- Model: WDC PC SN520 SDAPNUW-512G-1014
- Vendor: Western Digital
- Firmware Revision: 20110000

Hope you find this patch usefull.

[1] https://www.dell.com/support/home/en-uk/drivers/driversdetails?driverid=
=3Dffk91&lwp=3Drt
---

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2634f437f33..20a94e479caf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3760,6 +3760,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 =09=09=09=09NVME_QUIRK_SHARED_TAGS |
 =09=09=09=09NVME_QUIRK_SKIP_CID_GEN |
 =09=09=09=09NVME_QUIRK_IDENTIFY_CNS },
+=09{ PCI_DEVICE(0x15b7, 0x5003), /* WDC PC SN520 SDAPNUW-512G-1014 */
+=09=09.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS },
 =09{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 =09{ 0, }
 };
--
2.48.1


