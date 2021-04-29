Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C353BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247316143B
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247316143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AyHgnrFDW129VVTWwexRV5WvvhmOSCCCatTV9fhKiS4=; b=k/awoFaEHU9jEmNjMOnSK/iXj
	57Ix4V+C/Rw05g29tyQz66ujS1Hm/2HSxdzgyEFDLXq1onPyBrqC14gfdZ+fjY6WHbrQ89Lq7py7e
	53TpWTRDcpFqKKzTW2dG6pYbFTjFBmkQuBdUGdunTQgXKQbJP9xRg5luu4o7f79Z5hW4UCJ6wzq53
	MbaImDf1ZppipXl9xL0PWXFvrlB728nPuo+C6Z35xu/aEJ9VMbHCy9EFnPfuzEQhO2jCqvFzV0Wq0
	6rbUU4637RAiZuPPeF149cls1e1QT8miRoUo8PcCAikUj7y9ETZ2DHosdSD+DMsZgQf1YcwVxyXSv
	XdS5hEfpw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcBe9-006CeK-Hv; Thu, 29 Apr 2021 18:44:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBdw-006CcP-2N
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 18:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ZqRGO7NdY6cVUTRhm4isPiXpDZOz9+Q7Vn3ryYtsops=; b=24NGnbdB1z31b+a6GA2MaxNAi+
 nt9bYXaGJFpmWrigLfnZD47IXc1qq6OeRaqJqkj+oUVKq8OWGivr50FzvRs3k+xKDJW8LOzUeDDGl
 130W1MWxpSdlY5O+qS6ve6VYE4/IdF5jbO5bJSq84veTe5IfcTSig5jhDswShGP7q78tztZupckMl
 G+D6wLG3GZNuxUfIaqyIXk9XMiXm8F9rHctkE1BOGRRhvTrjaVJTiLrbSUYI36egVLJiRAQNvtbeQ
 5eeY3AfMsJnrqWIrmUg9V5+AEc4+npUZnbEJh0SmkkwSbU3e4VJjmjalnQz0RxGH7mGRwcY9m2Alg
 Nyzqp+0A==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBdt-000rJ2-Kz
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 18:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619721844; x=1651257844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mAEQO96t3JWDzmkUepqiV0zzrfQ+p5SkyG/85K/djQg=;
 b=cHGMpDnz6IGA1SDvgeFjPr1xw/58/uWZE4iSkj8JBy6UxBwx3iUGEUub
 r+tmpRn7b8PtIIwEO7hcKTwxRqvOPqlCc4rD8fRAjJqLD0e5QchMpwlNS
 5vdBT061ZRQQ+MEOIg1lR6dRI1qlGCHMLm+fDKuAtLfSDFKkawxSdgFuw
 UNYGF/kZGr6vfnIcIehoqUGt2bO0MkjA8JqBTnfS4EsFckG6d1RzYCgeO
 1Wd4nOaPVKBNw9f44cm86dKqAydc+R0BfkX55CfgmofNAXAs4kKei6Tg5
 dyy+MBI6VC95a6emcdVtw8qVE6DPxcASWWVkyVBDDV4J+jVI5lt0BNi4X Q==;
IronPort-SDR: BOaLS6NT2mcTCjov/dQtymojyWHGJl0BSy0K2U+ku5k/Oxk8rvwVho7i87iQTBz1PU+XK3MeHj
 9H81P6GKRJcwQ9cJUAgFqJvSqL40NjCjkt7ERLswtYB1/XrIIi491/gZtIVpmVPkA74e2aaPxn
 KIGSYZlXyanxrcWoShMMYNX+IPBXKDcSkUZim37jZSYDMBZCX8ZR/NENLIsbhWehgz8ZZXsc7h
 F8ba95DQh+Gx+XmFdJmnicDs/H4pYA622CTlXH6MR1+Yj048ct9u7W6wthmQrWIgse4+cEr5UQ
 nbE=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="171236404"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 02:44:04 +0800
IronPort-SDR: ubjp5S7GcKHJEDJqr50pH3KrJoFqd1Wne9r3yxLQuc7oFmo8TQLeR53yQNO1jlfZq45Gd3hhIP
 ozyLQDzX3MrIA+t8aaU5P59mNr8+DhGJdvWI4OAK/vx6jIeY3lL17R6w3U13LaXoicKwtYca79
 DrozwMxOP0kyPIxIZ/cqB/itZgL7xkzzCLNkOGtQUeZqHRWXunNMkEhmALrV2YV0BWi8ngNbxO
 e0/4QzvdZQXY4hKETWDtGzmhMUvBpv784RNN6njrj+231hFu8nTy5ccpwM50ZfGjRaJOGBHgVn
 dx3yEbM9Yip7LzngYNh5rsAz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 11:22:53 -0700
IronPort-SDR: Cq9eZ+0817wWMb3ZGkPXMYTr2DrcTwfGNYlItLXh0+Ho/h3xWBzCNFnL3b4I0Xbl/DuU7oCt28
 hWLaq+JRT+ESYqpl/bFVUu1hf6tsbBvPbKf1BaopsHnxjrNN46PKh3eB2eZnff2QyXjHJo5ao2
 pjiE9eRhPSK34uEXAshVEhF/Sl8VZY/BvcgZHRUaXWpEOlNzStnS5ioiNNjmQN7lC7Q/yXExiZ
 1q2s2IFE02CuBa1xnLf4S9UWu0/E8XYkKH/LfhDgLLhgDStV5CuiuJTSfMdHKKbX/77ZrlZQIn
 vTI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2021 11:44:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] nvmet: check sg_cnt for inline bio for bdev-ns
Date: Thu, 29 Apr 2021 11:43:56 -0700
Message-Id: <20210429184357.9185-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_114405_715066_B5A1CDDE 
X-CRM114-Status: GOOD (  13.07  )
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

When handling rw commands, for inline bio allocation we only consider
the transfer size. This works well when req->sg_cnt fits into the
req->inline_bvec, but it will result in the warning when
req->sg_cnt > NVMET_MAX_INLINE_BVEC.

Consider an I/O size 32768 and first buffer is not aligned to the page
boundary, then I/O is split in following manner :-

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
This will result in the following warning message :-

nvmet_bdev_execute_rw()
	bio_add_page()
		__bio_add_page()
			WARN_ON_ONCE(bio_full(bio, len));

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 9a8b3726a37c..5355956fa4cd 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -258,7 +258,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN &&
+	    req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	} else {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
