Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D9C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799996143E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799996143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4qWHnVbCKEvbI6sq+driuzBpeBCPIMbFRyCLdvCcAPY=; b=qUUAI6i7Oo8qXus6sFJACgYMg
	0h5+VJ2eg6kZdQ7mmV/2fjE21xPqTgSSISTNoICpIl5sEz0oC+FEUsJC0RgIAtgVBaMGNuPpGgzZb
	vY6zR3pVC+raaks+1tTXuAHZ+3abj8zShvEaQAw8fTqAJ2AQVhCSsjHHxv1LNUb8UTtMGtw4Dvwgk
	szBDTA60eJba4K+JuvsNOa3nt1j1app1WCZG4JSLrtGSuMW0kpWut9VdruBp3O9U8YpOuSeOLIZrQ
	KDhwTg3g42faPjwG1Pr+ZgWXy+F5L4Q9z1wBAZwNbrKGe1uBIog05jkNZLymlUqGY1wTNnUh5y1kH
	HLOL0u0uw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcBeM-006CgK-P1; Thu, 29 Apr 2021 18:44:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBe0-006Ccv-Hq
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 18:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=VE+TtUFdifW+hfUkuBs41Spk9+IpMLVysSSWe1llg6M=; b=gzd+fICIA5TklDVt1PMd+BrpN4
 9UfyjFCuliViWv2mPjWbEmCTndl6gtZkjl5TF/APZln70H4WQ5V99X5IOF8Ycg4WNZBvH4dFcs5X5
 X6QANEL7u/zNqqW4BPPtMw7k3wBXVBUj/RQ2CSzLuXxYTekoWlThBwDEww8e5Aq9X9qXeO38m8B2B
 CpPgHG1UTJFJu5VChc53O5QxQzr8BVUS0SDuC1EUlqRp7MNDbpBVrpE7p2Tk1ZbkWtgKszJGQOwWA
 NnlicSy5yY7XX8knVY6kJAm97izTlsBPS8Q+Y221+mcQIGwU3FO4tHwQ1vKJgBBUUy26tEYd/7zCC
 EkwnaujA==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBdy-000rJ2-24
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 18:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619721848; x=1651257848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PvHKBryTRQAgyckeMoNBuQrcNJP0S5fvAloevgML65M=;
 b=EU0oM3CfQjC6p3hPEmq8xcnE/FjQKG/1g7OsI+TYCra8Nq+0DpGLRbfQ
 gzNutaE7sbu2YBIQ4r6NIwnyvn7abZk1UGzPxb/zz5xLKQR+vzuwg7Xox
 CU6G5vpSKh1j8lqXBPZBjxAsHVRUosiXd77keIi6AjUkN8vVAm52J47ab
 /Cpzw3DokGccrVMD19lDgygMG2jdW2/LAq/M2WmljBYw3/Q1cJGhvpkw2
 TmccCDCpL5ja3e4o4cYqyn7IXN2D4xGNOL8Py6yg5VUAN8vDOmyDFJLju
 3iUUO5y8SI8QWcYTKDAm82SlQvawuJpi10JyP5qvchW9TRjdQIHuswEib g==;
IronPort-SDR: x4G+utp6h1jp1FyojDQWESIcJe+gwOI65LEA9YUJVkfs6mGL8gqSdSSW6CWEfl5CdLOvyBePSA
 qQyS7KDJ5z56XO9fCbx64oHzRyFJoItHwX+4dhnanGJAKC532QqgeAOCi/iuUQVPrTkQkaE3wf
 HL++DlBoh6V0+sFu5uVqAY5HoSr0boYS+VeaNlXY0Ta8TXhrKOqXBb+a1ga7fjKXmCMw1tOOYI
 pEy7dFK8oK2IgQs5hFexKpU72BRmSnwvRbcd2O2CRbY+KiNGeXUJYAq940aTCZoyOSEAMHPJpI
 vcg=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="171236415"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 02:44:08 +0800
IronPort-SDR: 170q4VLpEE+esttqQ+FbmOIHmsuRyksShNaOGc2v6CSHcETwDYqvw/qqdtT4HShHMiXeuGqOhM
 v/Ul4ZKuHI0KbNbeg59R/bYlh2wTqhoaCsYOXYbqsE/pgfehhCFEvkbBdRlzm1hI+wO6P4DJYj
 8rOOPFQzDYXM65fFX0BcLQENIgidekbsrKfXO64Wfnl694MfNuLYHn6M+qzLsneXqxts2lW1kp
 iC9SchSJg7taTu/nboTd5MD73JzRzTifTKSpzxQu6yp9eXDOJ/SZ6uWfCA0x37wOv9HB3d/rLT
 TPBhwPiLLuJHxvbqmR+almmM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 11:22:58 -0700
IronPort-SDR: rd7XSEDX7lgvmRALcxIfT/0cf33680x/LLuLDmyfw0U3OMErgzboK5f9N9NSkh1rlLRIAE2aAV
 z/5uF2LT9DcnkMPKG5wf80YmnQ0Z91JZUW7ccFu+05NMsZgVOefV0VJ5IJXIfBQwSs2viQx+xD
 kbf9CERut5cdc8ofD6J6gBKbjN64hnWSnDw0mJpET0KO0gR+A1U2sJz1Czo4UfP3QQzfMHcuOR
 lpT1jJ1527dR4VT0VVyxJYI0gCIBTep97nb6QHf3kkWmrIfORKWDGESAgbQeCwoWsRwpxeKjaH
 At4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2021 11:44:10 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] nvmet: check sg_cnt for inline bio for passthru
Date: Thu, 29 Apr 2021 11:43:57 -0700
Message-Id: <20210429184357.9185-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_114410_128801_84BF5433 
X-CRM114-Status: GOOD (  14.62  )
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

When handling passthru commands, for inline bio allocation we only
consider the transfer size. This works well when req->sg_cnt fits into
the req->inline_bvec, but it will result in the early return from
bio_add_hw_page() when req->sg_cnt > NVMET_MAX_INLINE_BVEC.

Consider an I/O of size 32768 and first buffer is not aligned to the
page boundary, then I/O is split in following manner :-

[ 2206.256140] nvmet: sg->length 3440 sg->offset 656
[ 2206.256144] nvmet: sg->length 4096 sg->offset 0
[ 2206.256148] nvmet: sg->length 4096 sg->offset 0
[ 2206.256152] nvmet: sg->length 4096 sg->offset 0
[ 2206.256155] nvmet: sg->length 4096 sg->offset 0
[ 2206.256159] nvmet: sg->length 4096 sg->offset 0
[ 2206.256163] nvmet: sg->length 4096 sg->offset 0
[ 2206.256166] nvmet: sg->length 4096 sg->offset 0
[ 2206.256170] nvmet: sg->length 656 sg->offset 0

Now the req->transfer_size == NVMET_MAX_INLINE_DATA_LEN i.e. 32768, but
the req->sg_cnt is (9) > NVMET_MAX_INLINE_BIOVEC which is (8).
This will result in early return in the following code path :-

nvmet_bdev_execute_rw()
	bio_add_pc_page()
		bio_add_hw_page()
			if (bio_full(bio, len))
				return 0;

Add a check to consider req->sg_cnt when using inline bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2798944899b7..d65d76129000 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,7 +194,8 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_VECS)
 		return -EINVAL;
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN &&
+	    req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC) {
 		bio = &req->p.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	} else {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
