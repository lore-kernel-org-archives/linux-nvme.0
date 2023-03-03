Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8165FC7EE30
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Mar 2023 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5zopUhSZR4nkgoF37Z7IJFVZw6US6XTQc82K6HvaCLE=; b=eANQJVjDY0o2m/wIHSr8aoTnXW
	YqfwRFEvzWqyxGyQdKfVvq6hg3TJtqklJee8P9MacLn6z4HywYSuKV5Xcvk18AQRZEN/olOy47CJt
	7fK5Wc/ZRYk+6WsZK/I/SymmT4Ixzo/HLxIoH18kBBY/W3SSv5uqdYiipG71/VcR+ciiHliBH3jCV
	HTnh1ZnHogjTUIZG6nixcngPZwvPKrwqXOrxwgtrYpnE0CJJ+zutbMpfcYAEEinKLcalBXGqKgBbL
	P6b7NbZ9KNGA+9vEJcBX5C7bMuVZ8Lij7i4cLyTTEEIcGxKOSvdCtNmChnZQ2xK4JgtbD5jq320WI
	yXgKlN2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY10m-005V5Y-Nr; Fri, 03 Mar 2023 08:43:32 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY10j-005V1u-1g
	for linux-nvme@lists.infradead.org; Fri, 03 Mar 2023 08:43:30 +0000
Received: by mail-wr1-f52.google.com with SMTP id l25so1504226wrb.3
        for <linux-nvme@lists.infradead.org>; Fri, 03 Mar 2023 00:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zopUhSZR4nkgoF37Z7IJFVZw6US6XTQc82K6HvaCLE=;
        b=7j8SxEKwT2ZEmt/8c2VWQXBMcQvTyaPVYvVBX8rdHTsn9MCae8Qm089zZLviS03m/m
         1XejIoauKy6dSL0QKcuK+1cf8x1/Nt1YLrol/VJgnriAlDq0zB48jh5yjWYYiu5RZymO
         DQTPy/TNQDjgxzhIMD19iBC57ZvktOA3DenAKkPBNDVwK4FJwyVcJ1Ai6hMwOHv2x52W
         pk5bHPzxd1p1j/pL8NpydB1ncrUsDpnRmhjzH45O8DBszhO78aH0NDVEJHj1jFPe9W7z
         5BBKs46glOx5iB/aYNz0avaiwD8ecF+86ZhrYUoftsnFvs78lvhCk/4AvsvNBgdAyLsT
         TYrQ==
X-Gm-Message-State: AO0yUKUxx7LiocCcJwa1dH7/hdhxxHbljUKM0MOHHxfVWRHtlUuMZCLP
	eTm1nTaQ0WCvgRQHRsKWt44=
X-Google-Smtp-Source: AK7set/zp5p2gfC1nzcIyStzta1ZCdmnN8WTjLmEeJySo1EzFLj/PD5hMxA8WX0oIr+eI9IMLlCcsQ==
X-Received: by 2002:adf:f80a:0:b0:2c7:1210:fe61 with SMTP id s10-20020adff80a000000b002c71210fe61mr708106wrp.3.1677833006285;
        Fri, 03 Mar 2023 00:43:26 -0800 (PST)
Received: from localhost.localdomain (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d4e91000000b002c559626a50sm1587399wru.13.2023.03.03.00.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:43:25 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] docs: sysfs-block: document hidden sysfs entry
Date: Fri,  3 Mar 2023 10:43:23 +0200
Message-Id: <20230303084323.228098-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_004329_132479_8041CE99 
X-CRM114-Status: GOOD (  10.99  )
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

/sys/block/<disk>/hidden is undocumented. Document it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index ac1e519272aa..282de3680367 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -705,6 +705,15 @@ Description:
 		zoned will report "none".
 
 
+What:		/sys/block/<disk>/hidden
+Date:		March 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] the block device is hidden. it doesn’t produce events, and
+		can’t be opened from userspace or using blkdev_get*.
+		Used for the underlying components of multipath devices.
+
+
 What:		/sys/block/<disk>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
-- 
2.34.1


