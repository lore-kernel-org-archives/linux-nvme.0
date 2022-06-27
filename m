Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52747CCA473
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8ZF72YbeF/RJpCQl1RXIbNJ3YhldUZw7Udy9DHT6plI=; b=pOJK2/ZQrE3F7C8mkvRB0DWGLY
	jW1fhoiJAajqbNpsrEcQU8qyn6ki5ub41Xo/HVVoRZ9AyiHSoLwsJG7BA3XMbHU4+PYQqXvOZ+9Qe
	jRt41sFs0FD1wTdSa8gVAkzQeEV84DloO/HinYTV7hI7uag5pJPYw9i0SWOEWsPA6YcNr7SdyKXR6
	cam/cdWBzhGdNgGyHb4XrMyFp/F8z6xZ4qIVXJbS4M1FTq95bOPultryLFsIU3G6FymAKQA6+pXKV
	pkKgb1HpX19QXQygpYrIf+AHZM6ylQ5JKmLNbpEbun65O/Gawmxm0NleE6WqLCaI/9NHmAkdRvOev
	X7j4LiDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jqF-00Gh8d-AQ; Mon, 27 Jun 2022 08:11:31 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jlh-00GdpQ-JU
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 08:06:51 +0000
Received: by mail-wr1-f44.google.com with SMTP id e28so6648724wra.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 01:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZF72YbeF/RJpCQl1RXIbNJ3YhldUZw7Udy9DHT6plI=;
        b=4O9QR0oeOcT0rXXm2JE2It4XVW29upEm5j9vp3jUEqZ2iXOYU+0muPDYlSzDWoulRi
         fK9YKxidIp85qsDSLbK0zfwKjWm/4mLEfueQDEYphIQZJw9D5/Z32M16firCmfHDXV3S
         i78KhAk/Kvjv348ufFZ82xhyxwiYkpu4CFlfkpX1/oO71QaY5PT24ou5kO45L2NgeE+5
         atfjhZ/QUMSHMjNGvX11H/5+J4IODMLmA3NGSglwQPCMtDHW29i3dqHWIgtetx35cSXr
         wr0y+5dcgDGfFjCSFsgUfCGJ3EqKWZ7w2xCr3rq/FmjctCzIQpxDvJoajiQTdDXsMaaM
         jIew==
X-Gm-Message-State: AJIora8YG+g9MVfB2jmI6CNX/QMhtSFqhIhkbiuQpa21UuHbaisQf5q+
	oxvXDrxrwNh6l2DoZll3kfawKVmlufc=
X-Google-Smtp-Source: AGRyM1vq5YPCrzaiab4+LRbQGCDnhGFGtwzUNh8U0IXRpo0S/rYgIKjLLBDAHaa1Op6/XCV/MWrzuA==
X-Received: by 2002:a5d:5262:0:b0:21b:84a8:8417 with SMTP id l2-20020a5d5262000000b0021b84a88417mr10957245wrc.119.1656317202167;
        Mon, 27 Jun 2022 01:06:42 -0700 (PDT)
Received: from localhost.localdomain (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003942a244f47sm17515654wmq.32.2022.06.27.01.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:06:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH libnvme] fabrics: don't treat host_traddr 'none' as a valid hostname
Date: Mon, 27 Jun 2022 11:06:39 +0300
Message-Id: <20220627080639.108828-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_010649_687619_E15B4969 
X-CRM114-Status: GOOD (  10.70  )
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

We treat 'none' as an escape value for optional arguments, do the same
for host_traddr.

This makes prints like the below go away when passing --host-traddr=none:
sh[3244]: failed to resolve host none info

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index d87b25961237..916179180294 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -960,6 +960,8 @@ static bool traddr_is_hostname(const char *transport, const char *traddr)
 
 	if (!traddr || !transport)
 		return false;
+	if (!strcmp(traddr, "none"))
+		return false;
 	if (strcmp(transport, "tcp") &&
 	    strcmp(transport, "rdma"))
 		return false;
-- 
2.34.1


