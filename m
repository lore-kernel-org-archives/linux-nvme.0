Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0166C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dnaIqBDbCyzz5sazrfv/hnRno7qZfKznnneM3yQMjCM=; b=2f5Px8SXXbNlDCZzNrFfmd8OZR
	Px1w8hDFzzrY3LRFhxAK30YYDyp7blTkpeqHxvnXNVKmv0cVJP/OYVkwd3kMS0aW7uLTVwJiqZ7EP
	5sLCC60ooALs4gcildZzhOQhqqa92PaA6uYPmLxA/D34cHWACrjvula+mwX12CTANieamHjBOXAPd
	JnwilhJ6xina+Nhx+7bCDQMELak8h0n5PZa6YTOWP5+23Hq5J5to0rcYgPArU8AO0JBEoO2JcYapU
	tWquS0C/zrf40U7w5sKB/OMwcxnyCNF3hO+AYz8ohAj6zTXGYTzBWmytXhPkijJwUIqsp1aDT/H//
	2+minJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Dmj-00BKij-OV; Tue, 14 Jun 2022 21:09:13 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Dmg-00BKgg-Gp
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 21:09:11 +0000
Received: by mail-wm1-x331.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so73646wma.4
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jun 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnaIqBDbCyzz5sazrfv/hnRno7qZfKznnneM3yQMjCM=;
        b=MwWXD1NNdJsijjlQJJW+hNC4fPHeDS8AEPvHcuz/8lHZsA9tkqL4Pr6WtJGAPMUaZC
         KFMTrUCG7jpUAOdVA8ONDaHYlx7fC+pQqrycdkojypvNFyInjRvrZZi+tG2UkCaIvxU3
         159lKe7u++XEplrQY2rbKa9FRbwnbK8U7btZqPJKU8vJ68LXdiL+xpoVkMBf20nDaJZm
         UHJonySUtkt5LxWzc+pIvKHrqQEk+BYXmbke0Tp0AW3n3euPFa3WaF/WRf9QmgEBzS62
         Xq39bEq9yovUJ5IiS0eOUR7D8Z0qEq7CssoGnAHVGsFTWsn/Rp6g9Sh6piHg/nEKVehX
         PeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnaIqBDbCyzz5sazrfv/hnRno7qZfKznnneM3yQMjCM=;
        b=4wq3X6gFAk3fOuzzFU/tWBFROOel91rqvroElQeY2Tr9xCUz2VbdNBEeX9i1ZeuUvA
         3wllAaA3pEMXaqEzlckD2caqu5yvP3SgTGQu/eOP2SBZMtc6SBSzjAP98YF3nc1W70qE
         QdIXk+Fwl2eLB/jIPckclkxtVjhyEZNyuV08HsPMv+YbSd54MqmjrRqMBBX0IeuSqm/9
         KYx4R4O0x8qET3zdQ6DKAXwjxxqSj5VYeEBOEkKWMqln3y5/aQS33fsSEJ8CtqT1AMgZ
         cLotkQTZyluN+2NjL5mYWO5R+hQtZ0KHPl8gupgEipjKnXv6Pt76PZ4co29HbRwlRl+Z
         ltFA==
X-Gm-Message-State: AOAM531uGZ/Fsyd7tnz1CejLrJvCaLbjYceTghcHrElp3n9wbAYYR2M2
	t8vZZdm0YH9sgTVe8jcv/NY=
X-Google-Smtp-Source: ABdhPJxDEqxbYgDFnbrpmUxjhMd1J8pScMFMyx/vcs+fF91/xTqFxD+utNYUUXhFZ56En6vyc+3cog==
X-Received: by 2002:a7b:cc13:0:b0:38e:67e3:db47 with SMTP id f19-20020a7bcc13000000b0038e67e3db47mr6112096wmh.133.1655240947652;
        Tue, 14 Jun 2022 14:09:07 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056000080f00b002183cedbf34sm3546649wrb.73.2022.06.14.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:09:06 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] nvme: Ensure char members of struct nvme_id_ctrl are null-terminated
Date: Tue, 14 Jun 2022 23:09:01 +0200
Message-Id: <20220614210902.744318-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_140910_602173_4815C2E1 
X-CRM114-Status: GOOD (  12.19  )
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

When issueing an identify command, the resulting data structure stored
as a nvme_id_ctrl struct, contains a couple of char members.

These char members features:
- the serial number (sn)
- the model number (mn)
- the firmware revision (fr)

As per the current code, nothing enforce these members to be
null-terminated which causes issues when manipulating them with regular
string manupulation functions.

This commit ensure the three of them are always null-terminated.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..0f7e625e8bd0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1274,6 +1274,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 			sizeof(struct nvme_id_ctrl));
 	if (error)
 		kfree(*id);
+	else {
+		/* Ensure that model, serial and firmware fields are always null-terminated */
+		(*id)->mn[sizeof((*id)->mn)-1] = 0;
+		(*id)->sn[sizeof((*id)->sn)-1] = 0;
+		(*id)->fr[sizeof((*id)->fr)-1] = 0;
+	}
+
 	return error;
 }
 
-- 
2.35.3


