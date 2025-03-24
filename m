Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB216C3600D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tXONZUZjibgEYj/WgZOKQeD7z/HbOhxU4kuAFBXA/g=; b=tXgjM9ddnCIM/Pw9pa9JO+Vv9B
	EWkTsDr5ZgD9mhHbzS/a9wFPPHmnbaJe+xWmVpF6D4YAk+Cj2qIby2u5GPoQfW+BmXSkSFxpPS+ro
	tl88vmNaaA9m7gmtYle6M16yJcbWXSWzhtczyulteSr5SFF0gsVLCjLXZD5Bg2kbzv3O5ZdrYe2Jv
	eXGUathzLa12RKU0HWCkZBsw7DfP8g41IpFkuBuUsKLJPg4+fKZEBMyp+AtmErHh/r95m/XYhu//r
	wncCMvTii+Z6T5Ze8yk7KEUxl+Bj84PiM166fXZjpQSf0OeKi1t+UTLDgEXQuFgielOaQOboXrd2l
	wIIcUCOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvh-00000003rLk-0JMa;
	Mon, 24 Mar 2025 17:49:41 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlve-00000003rI8-0YGB
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:39 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso7816456a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838577; x=1743443377; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tXONZUZjibgEYj/WgZOKQeD7z/HbOhxU4kuAFBXA/g=;
        b=KKPlpLk6yHEads/3DXJnnDLxWyPkCc0X8PoUDmJsFTXObT6M8FXLVxKoZhu7ooj5el
         fH5XErWz1V9Q9FkbLXQIGRfjhZDAsw1VB5txbT2RSlhyw+7wYiKMatsMySQo8p3Zr2oA
         BRMQ3++u1JtxKCHvnc1VPytYPCu968/UQcUxztz0AQdGIPUPbnyxrFfesLOH8Yip6Pte
         SZttIJ4x3YsP/c1td4+Cv2XgltWGoA5WXuOjySchLbG5362kbTPqDRrSQDqb723Ec911
         glS5/vwV30MrdDYJpLMhGyv7sj0kt8mVx6nLNHdZreD5zH0u641XJGqi552dvUmJamPf
         Cx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838577; x=1743443377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tXONZUZjibgEYj/WgZOKQeD7z/HbOhxU4kuAFBXA/g=;
        b=V+UjUhyK6eOhu20aKjajyVLwo7J4Crv9PbagTYwoDULIQdIv+DbmO5Su4dkqXMgIlv
         fJeboyKqbHeO5d74GqYL4LBr1dh6LT3jqgUtwaAESJS949Ohtif+P+7gQpxzt9iL7HsX
         BPTiV4myn7ujf8jjY7otzl7U1jSlIEbbY01udANjD7h59NweMqFvK6VaoUktHJNOMfoz
         pu2RyEasC2TjeD1TujSWIFoMoNMMAD/1VPVCdKUVpPIAsz5hkyRSlzGR67gcvTICBHVl
         DqqCCiO9l+2fq2zLgUX3bQHM+gsdGAV3SaUim+TgF7gXzqKArDWAiYUEJL3WF/O6dffy
         6HoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7YSNnBMrgFCBGU4fm5eXihjtuBgD4gLelKimzY4kI119c/l+pgN8APBcx9FVNRBThX0cfk9U/2TXA@lists.infradead.org
X-Gm-Message-State: AOJu0YxJ81z50jWMSxylskA5zvmg0UT3ipjbWvnQwbVcWQ5sbiZxyTCf
	Q0ktuwMXiN9kre0GFZ54G2D07XH32NZ6cMZ8agcvfGzgIziSMAnNzTucHY5d2cc=
X-Gm-Gg: ASbGncub2ZPbVVmTC5zWVlhtwMv76LX/vIl+hYvuPRpurRiBXS99LEAqB5uVt4nFvQb
	Lz6pxE2/RHFeopYrTf5esfxBksULddHivJL6aWhSgTkeqP78zl0GBCdnw9y9mczXN3xZVQbV3tx
	2Gw+vmeb1amKQ5au/TDaOm4FIPaYFZUrZDhAWwxXaUlF5GDvV89oJZxe6zJ2AE0Do/GoGxjy3cO
	1ByY7gCDZMkl/bsIS/8+YNcsPEMxRkifnPqYoAQI0wLgb3j5bn4Qazgz520cE8ou2nnIxK320Sp
	oETfBsuHfrD2KGAByvTCC7+VcynYu6HxT7td9tUyt1F1Ol44vU+y39Vvk2T0qQ==
X-Google-Smtp-Source: AGHT+IFbL79g6cqinOTtCUsCU8CN6KpUY9mimdkEF3cRlYokJ0E4qTs9zViNVaPRI+5PA8mVOPtiCA==
X-Received: by 2002:a17:90b:1dd2:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-3030fea2e9cmr24583048a91.18.1742838577140;
        Mon, 24 Mar 2025 10:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:36 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 4/7] nvme-tcp: Move freeing admin tagset out of nvme_tcp_teardown_admin_queue()
Date: Mon, 24 Mar 2025 10:48:57 -0700
Message-ID: <20250324174909.3919131-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104938_191718_3A84CF61 
X-CRM114-Status: GOOD (  12.30  )
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

Update nvme_tcp_teardown_admin_queue() to only tear down admin queue.
Let the caller take care of freeing the tagset if needed. This change
prepares the code to inject the delay described in TP4129 after admin
queue is tron down and before admin tagset is freed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d12b51ed1a9e..99533ff1ea20 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2252,17 +2252,12 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return error;
 }
 
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove) {
-		nvme_unquiesce_admin_queue(ctrl);
-		nvme_remove_admin_tag_set(ctrl);
-	}
 	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
@@ -2374,7 +2369,11 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, new);
+	nvme_tcp_teardown_admin_queue(ctrl);
+	if (new) {
+		nvme_unquiesce_admin_queue(ctrl);
+		nvme_remove_admin_tag_set(ctrl);
+	}
 	return ret;
 }
 
@@ -2415,7 +2414,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
@@ -2436,7 +2435,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	nvme_tcp_teardown_admin_queue(ctrl);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2446,6 +2445,8 @@ static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_remove_io_tag_set(ctrl);
 	}
+	nvme_unquiesce_admin_queue(ctrl);
+	nvme_remove_admin_tag_set(ctrl);
 }
 
 static void nvme_reset_ctrl_work(struct work_struct *work)
-- 
2.48.1


