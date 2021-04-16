Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD00C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:07:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D346113D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D346113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EvKqTw4p/Oen3v1L1o1BqNlwvOPXs1GB5W8FQGuZhmg=; b=UWng2cPCGVyvDJC5JHUiMAqarn
	dbgFDGu3rNOCr8vFreG/p/HH6FMj3zTDSeJKwtE7fOt1a2cf1H2R/QgREM3+bWENow4ukERE1Lcdl
	NkuPgg7/JNeeVePaPIM8TPJeyRUV5gghPGZ4At3o/uAcQDocr6Rf1/RN1xL9T9DhgfA1aogd7pywZ
	YASe//oLCs9seNWavoVTjARX9/3dcHM8PG0ImofO6+xQT+NHlJiiHNEAMCIbL65ox45WkxgeaakDF
	gQ4Ie9XcgcjRGnU7P8HrE/ZK8LqPIYnzkzysJfCwwJqyqW2XMCojMen/4101vxaQS3kJPpJ9A/IZi
	hsvvDaiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEor-000aNs-SY; Fri, 16 Apr 2021 03:06:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEo4-000aFw-MY
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 03:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=0pHOl3gc6FgaM9gkuTMO11kRJ60BVzbYuYLbpirGp8I=; b=mTvEnITTiVRU2vz3xr0xAMsT7x
 VAVGlZebYMbriGgF4ySzMtyGG9+VFY9rNKk8wrkLEZvOpNGZR6dGwV/XTfC8z6f4ijIae2qNEdwUQ
 GjpWA3BduAyS56QRl7hCA94TVn8tQYfEi4LFgBjg0mTo37Wx+It523Pf7GA+7Tqce5iGCURUhQhnE
 jblepYonpQSZ+YAHp+CJz5G0vJtbfMnLerFydGSfLD62PbRiTuTDcka+Vn/gZiTgA3/AaMsc43WjK
 WO8yXNmbJvRHe17/HrIuMLa+CiwkfWxeImjqMjeq+7HG2AiTZjlPMgXiDDxwkvu7kjEuWkj7Ju1v5
 BI7DnYnA==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEo2-00930p-2P
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 03:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618542366; x=1650078366;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vUztHQeoC7q+dlfBS4+pbWv7aImp+UXJRbacb2BFxI8=;
 b=Jbbsf7RY92fy0Wp9eXv9k375xeyw/yrocWE9wv8kbZZgkP/D8XqcMcyf
 jTlRmRliRgUufaM8+gAilYZr42mfXgPKh1TARD/VsgjQR7onzIfalAzVM
 x/sseUMDhPDPytBkAN16Q5xXP4gFJz1daTR4noYxNEusZ+w3ARToYF7zD
 PUukOpubjZia0qUUCtmmbH5E99sAgjFvXfPwFiyP9jcWJN2ypjXJh4sWx
 3rSoFxDUqnjIClPcOzIbJPZXOHlSKklP8mAHrvlcyJABvcMI/cRcplk3w
 y4qbgYVYUtv3w5mdGN3+71vb2q4BeiUP97JhynGgRP1VVhE0R3eac+3De A==;
IronPort-SDR: UmjwVWdMEYJVawLp9uvk9NUOe0QhSyiy7Q8i2HQVbJ7gNHbYzbpa+v5M83xmFwjF93Kvgn3YAF
 mh6p7dC4Lsy4cWONczjMt304tq1emB6N/AqzzEB1s1VNahBzp9YnXwI867icJLgaxiZ+jCRJJp
 eeLKn+DImkcET9QEcKUCBhQgYzMY+ZZeay4Bqt+pq3tWn5B4PKoAbIrrQRnTzGu9eUqAgHrsMS
 e8UxjsGcMfqE60Rk0zTbDFYwaZ0RXL/CTH7HSgLuUnBL475o6Yzk9d/5TVwQ6J+nWinveYew3J
 nnQ=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="164423083"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:47 +0800
IronPort-SDR: 1GFvyQuAgtkKjH33BTMvmn70GHiMbeLvG9ePSKeNZSwVko0YNPJmvbY+yUxa40yBHMnK7N7OX2
 kHhOqzSo/dHOfj22kl8a82Q/Xp4VkpJDFonY7GMlGnE9DsqF/JTQHwoxdgdUyviSjLbA7cw0Rs
 /JDndhABwUI44Mfk9JZZDhYbp9dxcuDpTY8FEXFkrcb1WN/YC9FhxQINj7gMLn46Avs5tartyY
 a5cx5w6aR6gud9PV151+ZfyiGLet5ea4Ha5ecH+m4H+hTjxZn2SfaRcs83Oy/Wn6SIPDJjRDXk
 zCiKtzZJyQOjAiDW/1ZiVT1s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:46:24 -0700
IronPort-SDR: 5uaHx0ME4yfxIf/TiutCrTMnLjb2kBOpJtRTKSLg4tH5AbhRWHekMEEGKLa3AXqEYy3a31snCo
 ElUXAQxKJQa6aOhWFDCPzlc/IpBsAx5KR6EDXe2ZmlnAA88cCbpAMSRLACPaVf/fHSYLQd8IgO
 DxavW3RSuugPmrGUFvYDSFHbIBbCHilMvHw4PQpzJEgqusd0uGMzfwXRxK2a2urB4I+6r1cg8f
 s/TX9LXikk5YOZaAYTcUE+pTyB5gwDGLNtSP+JbbsKm5Z1xjY+x4TV2Bu/ZpK3jUK5XA0aSsC7
 IoM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:29 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] Fix dm-crypt zoned block device support
Date: Fri, 16 Apr 2021 12:05:24 +0900
Message-Id: <20210416030528.757513-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_200606_206615_6C2BEF5E 
X-CRM114-Status: GOOD (  17.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Mike,

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
of the zone to be written instead of the actual location sector to
write. The write location is determined by the device and returned to
the host upon completion of the operation.

This interface, while simple and efficient for writing into sequential
zones of a zoned block device, is incompatible with the use of sector
values to calculate a cypher block IV. All data written in a zone is
encrypted using an IV calculated from the first sectors of the zone,
but read operation will specify any sector within the zone, resulting
in an IV mismatch between encryption and decryption. Reads fail in that
case.

Using a single sector value (e.g. the zone start sector) for all read
and writes into a zone can solve this problem, but at the cost of
weakening the cypher chosen by the user. Emulating zone append using
regular writes would be another potential solution, but it is complex
and would add a lot of overhead.

Instead, to solve this problem, explicitly disable support for zone
append operations in dm-crypt if the target was setup using a cypher IV
mode using sector values. The null and random IV modes can still be used
with zone append operations. This lack of support for zone append is
exposed to the user by setting the dm-crypt target queue limit
max_zone_append_sectors to 0. This change is done in patch 1 and 2.

Patch 3 addresses btrfs-zoned case. Zone append write are used for all
file data blocks write. The change introduced fails mounting a zoned
btrfs volume if the underlying device max_zone_append_sectors limit is
0.

Patch 4 fixes zonefs to fall back to using regular write when
max_zone_append_sectors is 0.

Overall, these changes do not break user space:
1) There is no interface allowing a user to use zone append write
without a file system. So applications using directly a raw dm-crypt
device will continue working using regular write operations.
2) btrfs zoned support was added in 5.12. Anybody trying btrfs-zoned on
top of dm-crypt would have faced the read failures already. So there
are no existing deployments to preserve. Same for zonefs.

For file systems, using zone append with encryption will need to be
supported within the file system (e.g. fscrypt). In this case, cypher IV
calculation can rely for instance on file block offsets as these are
known before a zone append operation write these blocks to disk at
unknown locations.

Reviews and comments are very much welcome.

Damien Le Moal (3):
  dm: Introduce zone append support control
  dm crypt: Fix zoned block device support
  zonefs: fix synchronous write to sequential zone files

Johannes Thumshirn (1):
  btrfs: zoned: fail mount if the device does not support zone append

 drivers/md/dm-crypt.c         | 48 ++++++++++++++++++++++++++++-------
 drivers/md/dm-table.c         | 41 ++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c              |  7 +++++
 fs/zonefs/super.c             | 16 +++++++++---
 fs/zonefs/zonefs.h            |  2 ++
 include/linux/device-mapper.h |  6 +++++
 6 files changed, 107 insertions(+), 13 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
