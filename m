Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB7C43460
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A04460FEF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A04460FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ugNJSnZe6YsO3e7qzlGzn2JsxymGfdI2guRzyAhH1Bo=; b=BHvbN3H9vPfZupw9vWMuj2+DCY
	ID+5Pa5v9UnPQNTER5KHo2T+gS/HirTV7d5GgVDev3StFKCecAebTcL0rNe3Pd2Cnv2fp+Q0oreOw
	wcU3fffNitb4wyQKkRITzW0GffxZFhVNLTpTN91B82nLObA9vUsQmU2NM1s4vpqCwTrSx25/T9kUU
	CoJ4Lkp6o0Tb1pJqLpIOAGpyah9sIvy1S2mpy4tfJS+c3uwU7gzBZ2w43b7FQoxchPYpco54sAA/A
	alvY8mAot+7HApFA+FhstH2psnXOI08cnTslENt5m6FfloLMWIx9zuwQ3eKLvaRTLBoJ+0kGEc1IS
	eFcMo2Fg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXamQ-0045mF-Da; Sat, 17 Apr 2021 02:33:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam7-0045kE-Pr
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 02:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=CENqtrJ5pIl83gxa/5uTwu9yZ9p7Fvljc0w0x+QYRdY=; b=oV840Xahprqr7hLtBQllK0yQsh
 VRDJ5UTI4ITFiCawb3OqtI+6qUiv2eoamP+aezTwU/DDvOnwXyCmoophK4gCiJ13jDD2xiB3+5hF+
 L3BOEjj9ODIaAlLvr9lOogObp/WDlAQFMqkTwH2O1zHcM6lf72Y4hVD/YSeYDm2shmpACHoYO3psW
 jAD4AAbgcFbISS4fJ4G9MG24bFw/ByPgkZY6XpJvhI4RRUQGc833o+s+PTcTN05fS+GjCQj7fhADX
 ElgnFQhckwCCwM6MBgSpeJAWwKQIdQMxMAQzqm7J2NtxZJrS6eQBn1lR52rVYRZsYbw4PU75WzZDi
 2jW3uAXQ==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam2-009pji-2a
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 02:33:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618626810; x=1650162810;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/zdC0mF6U3RynH3N4WrC5BU1TgJS0HECRdezkU53JhM=;
 b=rPUDBa4oiEIk3vlisY8KHUyYNtQBuag1NfRabVmwDgXYvMpO5BwpbNEB
 Q37AJz2Q9gMJhh444aiI6tZGbzOBv5p4l6yBq0tw0KvVJRgjAaN5eUSsg
 a5YQNZ0AdU5TohiHO5zDMQH6vlBrnYImrVYLw1bEya7uvA5sToJnYT2Gs
 jSHQcNmioJVy/BmZiofBguAi1zw8/PkkFHOpjLWvesDMf5za987ynKcdB
 sbgTVU3MW9LK9bJ/tOrAZBS4PTS9p3amn+Wp47/Fh6yxa/hUyPIAtjokT
 8K4zAdeJzAQQLHZDMWRfb5woUaHn+nljIS2Ih3Ptsekq9mhfrNaqgX2EU g==;
IronPort-SDR: KKLAIivrodtmuhvV9w6OiMzSEg5Opy+VGGLVfYzxb6RZalLFbm8pezH5arqKsXh1922GuOqG8s
 IC4w3NjN1B+N+Wgc1e3eu4rN626ZI9DKxq4ahZRdYqmHws6J06s6F8f/ITjeGZfPAxpcSFhhZU
 xRVEdSe5KQVxgBGMtOZaNibSaxxnz8Q5e9S0FsscrvHHy+oDzMKoDPJ+WEie7zJ2wBmBstEcRr
 +i3FFX3FRatkij4m37fLpWt/8Xum3dfFgSBoKCEV5VI6y0BT+z//bzquOo8SGaOBaFTx+XLP/w
 XLw=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; d="scan'208";a="276118883"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:26 +0800
IronPort-SDR: 2ZbU8jY30eZKeYtvuG+2iregWOjCZqvZh6At/cjKQBSDzTXeUN3v9T9UUiDc1n8yTDxilFifkA
 JCXtlByzCvifeGI7NonnPou7UnJOLTQZNK7qHQJ/HC98FTf6WJZrJN7+cUEqJPjTVN7fZRe4iu
 lv003hm90NRGXMdjEStF9arqHTncQOdzirAf3hrg0bFxf7DcrsIDIOvwj/Lswjxr4GON68v1uM
 qpp6J333wHTs4YaOx1vWMMA8bzfSuyCxLtWkdeqzHiHeHh6Ze3QTCHvAoNnbMMNsKElp+Tx68n
 c2Rzyh793nm69zrFM1/m8Ui+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 19:12:39 -0700
IronPort-SDR: 16C8yH8D/rdxr7PuzxuUa8rWesM6KtsM3HDeoMg5sHjMNQvboeWQIps+YwRvcomtoPwI1MlqpW
 jtUKTWfjkpWaBLNjN5xtPZuKGF4EOTxwjzXBqX1pWi0R8zPmCngifSjkXAeqAvXMy9NAI4LKZT
 f9KAxP0v20dDFF1Ae8+mSXucvh3MQe66TKjwZTiapM7cpv7MSLw49bM8YbT4PQ5+coB0yQiIBP
 Nf6yxq7YFcTDZpXsZ740QZx0uXdp4NshbQe/QyHeTBtItwgM4/uiFWqOvW+Hfb4m7ddW6kfsUA
 efs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:24 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/3] Fix dm-crypt zoned block device support
Date: Sat, 17 Apr 2021 11:33:20 +0900
Message-Id: <20210417023323.852530-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_193330_149479_77E209E4 
X-CRM114-Status: GOOD (  19.25  )
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
max_zone_append_sectors to 0. This change is done in patches 1 and 2.

Patch 3 fixes zonefs to fall back to using regular write when
max_zone_append_sectors is 0 (Note: I can take this patch through the
zonefs tree. But since I have nothing else for an eventual rc8 and next
cycle, you can take it too. No chance of conflict).

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

Changes from v1:
* Addressed Johannes comments by renaming the CRYPT_IV_NO_SECTORS flag
  to CRYPT_IV_ZONE_APPEND to avoid a double negation with !test_bit().
  This also clarifies that the flag is used solely to check zone append
  support.
* Removed btrfs patch (former patch 3) as David is taking that patch
  through the btrfs tree misc-next branch.
* Added reviewed-by, Fixes and Cc tags.

Damien Le Moal (3):
  dm: Introduce zone append support control
  dm crypt: Fix zoned block device support
  zonefs: fix synchronous write to sequential zone files

 drivers/md/dm-crypt.c         | 49 ++++++++++++++++++++++++++++-------
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++
 fs/zonefs/super.c             | 16 +++++++++---
 fs/zonefs/zonefs.h            |  2 ++
 include/linux/device-mapper.h |  6 +++++
 5 files changed, 101 insertions(+), 13 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
