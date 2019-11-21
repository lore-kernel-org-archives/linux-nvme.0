Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973DEC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 20:31:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672FB20643
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 20:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZdDpZ6U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DkP4+YSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672FB20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N4XgtwcM00bgjMWNNlVpHaejOuxCETLhsZsgMxZL7Z8=; b=aZdDpZ6UUHuavm
	leaUGeGvgdjzYNbWFBviix2JjX1G/+xKSq0kfwJKYfPTpXHDOhnxa9S+CaFPGPL1Qrqh+O2WDK5U4
	aXrSJ/kyMcaqcKZdBeGoV1dUWzwUjSq5SefTXwqShBz6DsSfELcYpgEQjH4DcJvRQlQ/JzQnCY7NR
	QUL9Od5Zwf0BLr8lQGOOmRZkbqwyun6AAI5PTn7eFTN8e9xgC5D0xEJN9TMsJCWAjqnSOOZHDWr83
	in1dc3edCuRMMs1qWaeR1TiO9dXIvbZdRQK2b/Faca0txbomVBaAX3spb9F5GvW2ZWmgKBP0mndLb
	7Pix8kN9dBvoMUmAFG2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXt7E-0007Gj-Nf; Thu, 21 Nov 2019 20:31:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXt7C-0007G8-91
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 20:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574368306; x=1605904306;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6VsFOvqrjwA4VFqgWzxN46ZnEL5ubbv9DJAHXmkuypg=;
 b=DkP4+YSu1DxG+7dlBfOd5V42XWhIIFebaQMzwZMBgU8rilLpUMjn8NgE
 7/2+HObTXArmBwuaF7fMwgy1gaKl7EpqTGiolL7XFYmmsNjUoAN70c7Wk
 8WVsdcmlQM58uCoWQY9lGdVcJz9KXWd21RZyVVUjMXlXWtYmn44lWI9vy
 dScDqi8Vg51SWgBU4Chcvj0z+5nSE4QGVDtp5aXv85iXzs4VyUaTaYDWr
 4gTlM80/dggc6V7XyAxGOqCgvs9l2+xF0t3oL+UR6qyNE2pcXfxdCJ0eq
 d0LmV8UHxth4yIm8FiNr7vka2iPucQqCTusxu1+kCw/23MIv1n1of37+G g==;
IronPort-SDR: 9ABJAqvoGI7gTznh2iD9GKvRGr/ixrU+y0JVo708zM+WyUSehvI4mCrTR9o/Uz4a/AsSl7zvxi
 /DCiHPTx4Bwrbt5pAT+w3o96ffCrVFmjUMfTitA0IWzKfebOdgLk5NMgOXnUXjjgT+Onps/Y0r
 jKzJnlS5ni5jQzrq+BAcO4Pm0MHTLaBKYtYMGPhbzWiN5BXlsV8GyzG8xb13wqR0g7+1g+LwKr
 18zSsIlvQf5PGr6PZqpnwCSl3v3OwgzoFaH2zgtYcObFAi6MHpLSKaENngzTP8OV0fOKV1kNXV
 mos=
X-IronPort-AV: E=Sophos;i="5.69,227,1571673600"; d="scan'208";a="123677413"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 04:31:43 +0800
IronPort-SDR: HsPkXaTyyDY/Wgc6oIdRSBZuZkmG1ou7sk/HazFnYW5My62Vs1gpRBt24EDc3psQKVtLz655Xc
 cMz/IPqKhUDXwVqFm44JbJ60ZpIZocB+7xYCH27CT/fxHteLSWrgmrlg9t796ahxB/OGJ8lSlI
 fUYe0PWchQsBsFDHVuBWITJQL+fv5QamOhH9+RDTozeRtgCglf1tDDQN5Qmc7qls3inCKHLMgZ
 Qdlgwl44tT8WaDavGOoqwMftnEtTgp0RugwfB3SLTIPx1B5Rxd/dax8LEJG4kwgnKoxI5evpNo
 S0rXwNXjU/DEjEfN6uSG9DHz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 12:26:30 -0800
IronPort-SDR: yjwwwMiGVxUf9O/iWsa/SUQGCNgJnPnf0TwehICLyN90ccxLTNLXnoUEmOS5MPe8P5vrfkOz+N
 p9wvzR3e8e8+e26WNBJ6zwL9vZhtS1c4Intr88hPetFUhfp/69E8Dtk54C5akOhe/YlTjVb8KL
 t3TJr8lz4aiYKxZlD7ajSJcmpIpDVXtuWmWFSXU2ryt6W46K3SNd/aeqrnQu7CQB4sFmTGm5t4
 DctGoQKxjLW3RwoRiDVuPHgmqkEgsB6+DHMbxou63zzGBUCBKuYvnyr4Aw9B9oc81chCsItjyy
 Xmo=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2019 12:31:43 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: check sscanf value for subsys serial attr
Date: Thu, 21 Nov 2019 12:31:42 -0800
Message-Id: <20191121203142.537-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_123146_353780_849DEB30 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvmet in configfs.c we check return values for all the sscanf()
calls. Add similar check into the nvmet_subsys_attr_serial_store().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..cc1fd36bf71e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -853,12 +853,14 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 					      const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = 0;
 
 	down_write(&nvmet_config_sem);
-	sscanf(page, "%llx\n", &subsys->serial);
+	if (sscanf(page, "%llx\n", &subsys->serial) != 1)
+		ret = -EINVAL;
 	up_write(&nvmet_config_sem);
 
-	return count;
+	return ret ? ret : count;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
