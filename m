Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB4C4706C
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jan 2024 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z4FLoYKu0c+SJIrrt4FWl6S1AbWIJshNVaV2tLLGEvQ=; b=u3poBv3VIvQmzDcV1d5lEr4sGh
	zBFp8O3w85is8M7wvWdYIQqQPZQVLmuoCLmrF+W5dFmLbwboXMhbN9KNmM2aFiSwlBA8WDF7sVS/B
	4wY4IcTWa1IAyYX0f/Ez4/kZt8vFVXquS9MV96dMK6xck6znwWVb77JlGgRVPh70RwdFspxJUXA0y
	8kD22HTFscmH/bCcODbeSuswg1f/ooKghXsjPa9kFotJTxebNJfQgwIxQs0azUiABH41mBjJA/p9d
	59MoEb1xwvr3TKLe2y7gCIBWcMFM2iAcXkaXdFGRLKORC6rp+j98P7c6wvsCsYT89DyymjZmORJzS
	zTo9FCKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOlaZ-005jU2-37;
	Sat, 13 Jan 2024 21:30:47 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOlaM-005jSx-2c
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jan 2024 21:30:38 +0000
DKIM-Signature: a=rsa-sha256; b=Siu6XkZWG8L6TLijKnOfjoW8EkYqjuMYuKzQAjJk87vPyGiqVHhMOlCfa4+Lg6AW+7SHV1tnjuCCVWuefPbrllQcNs3upBdYTVFLvp2uFl5UenmjA1SK1J/oLo/4s8pK3JJCNYG0GsP9mpwuKmJZOqBN5fUkddHoPbg7BQeftZJc0nzDgkP5VL47joymHAhXIOQE6ni8opaqb3BhoFZvtWRSXZeqxYkih9/99KPSawuoKafnznypJ/jzCmDrzu59aQ2ueOLAZZJDDGYpa+MGxUaTprqr6zayr5S8ivN+uEvizTHuTccVotd4g7A6uUJT9Ln8t7U/wlN9SiM8V0P+dQ==; s=purelymail3; d=saulv.es; v=1; bh=VKuuWLJdOLtOo5vS5LLuHdQOxF12RdZV2ZClFFbfqeo=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=nrzdZhuM1WWTVBFlxJkHi9OPVMT+2+OqBdnFFteMwNqMNDrmkWMHpB25nMneLBU3NGsdgTF/O5N7+Zm0pct+0OimFcsgu/xqUCXvKOAlhYjUauZFShlAnCrslKFnM+7Mehp7YACQ7OixXuyfi1ZSVjqvUsGK8YA7uNZWyC//nf6bNagO5rhg2gVSRwSPHSv00GsOmqCdDtCYozRQXHHRgnOvt/QW5UOG2KHMNCdYy9mDVm+fULi1++gx+HC5V3sfMD51FctKMKMdqHUxioKer1brS4p5c9EgwQD45x43c6nPBguY+x1EZYQ2R2wNrQF71wRiHTMmVR7yTOmOpqmyhQ==; s=purelymail3; d=purelymail.com; v=1; bh=VKuuWLJdOLtOo5vS5LLuHdQOxF12RdZV2ZClFFbfqeo=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -218814721;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 13 Jan 2024 21:30:00 +0000 (UTC)
From: =?UTF-8?q?Sa=C3=BAl=20Valdelvira?= <saul@saulv.es>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Date: Sat, 13 Jan 2024 22:30:12 +0100
Message-ID: <20240113213012.30898-1-saul@saulv.es>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_133036_690204_7AC89799 
X-CRM114-Status: GOOD (  16.24  )
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

The WDC PC SN520 SSD hangs on boot when APST is enabled, unless the
nvme_core.default_ps_max_latency_us kernel parameter is set to a lower
value. Add an entry for this drive to the 'core_quirks' table with the
NO_DEEPEST_PS quirk to fix that.

Signed-off-by: Sa=C3=BAl Valdelvira <saul@saulv.es>
---
This patch fixes an issue I've always had when running Linux on my
Acer Extensa 215-22 laptop. I think it might be useful to other people
with the same hardware as mine.
This is the first time I submit a patch to the kernel, so I hope I did
everything correctly and that I'm not wasting your time.

 drivers/nvme/host/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0af612387083..496563704c63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2626,7 +2626,17 @@ static const struct nvme_core_quirk_entry core_quirk=
s[] =3D {
 =09=09.quirks =3D NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 =09=09=09  NVME_QUIRK_NO_DEEPEST_PS |
 =09=09=09  NVME_QUIRK_IGNORE_DEV_SUBNQN,
-=09}
+=09},
+=09{
+=09=09/*
+=09=09 * This SanDisk SSD hangs on boot unless the
+=09=09 * nvme_core.default_ps_max_latency_us kernel parameter is
+=09=09 * set to a lower value.
+=09=09 */
+=09=09.vid =3D 0x15b7,
+=09=09.mn =3D "WDC PC SN520 SDAPNUW-512G-1014",
+=09=09.quirks =3D NVME_QUIRK_NO_DEEPEST_PS,
+=09},
 };

 /* match is null-terminated but idstr is space-padded. */
--
2.43.0


