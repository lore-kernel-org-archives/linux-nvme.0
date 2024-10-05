Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE8CF8862
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=; b=gFiu8mrMoFYiQcYiG438ZQKM8h
	wiEAwMxK7SFnC4Q0rUNaY6oBPY4Dlp6NfWJAyJA5FXK8niwIW+PQeSbPlT7OjD4tJNQCSXumfMrzQ
	njvaWodhJQ7rMhsqRW+E929pSXO6ykWIZqxZty1wXJAPNgaUCt57mxvxoAknqiMXkTFKESORhcl/Y
	cEteAbpY56hFL45QtjOoleOaZd/oP3v0MTenw3iD1lpNophwtPUToW3DKyUrVAtWxFeDcL80/cVA7
	ezRF2jjFlb64g/ZdfckL22HlXp31y0jymU/Fy9ac5v9IeZ8QM09u3PUODLKyBnRIG4oL3qGPZjpjL
	fndlhrpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2wB-0000000FGtK-31q7;
	Sat, 05 Oct 2024 11:27:03 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2w8-0000000FGsg-27WH
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 11:27:01 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-71def18fe1cso719593b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Oct 2024 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728127619; x=1728732419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=;
        b=GUMjXOrO/fB0CcA0RsZ0NYsl/EQlyVAHeZ5sZVxcAmc+BWdhL6hDb3VGN5UkdkSZke
         9gnS5dfPZAnlYMyhYbQzpGInzM+ONgpzBIhOP4qn17PMWFhDlBQ17usLqirGCL9A7biv
         kV4i+2G7pzmycYZynzFn3h/esDzwWyOLIIFxDHTN4IMb8/MA3HqOM+f241kvzN1L+IUj
         aHX8RDnGIgzdP84FKTPkFdZhIpOI/12l/wlYOVOs7/8nllfz2STWJQWRr5sKuwBKsZWS
         PmQsqAS59azqCTWGTNt2OG3l4SXDM54TIWdeRzjh1btUlTqB0GnLSNLyZTz+aifnPHXo
         j1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127619; x=1728732419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=;
        b=cR6US9gdHBj8WCHAhmNp1xP9C7o3TFC5/JSap4yf9vJ/i6YRbNgHULxiDyPAXvQdd9
         A/Rjy1z/vyTHCDGBTlZ6YP5Magw/oA/3noEjPV6qiWRwHEJJ7XBfcpQ7dmp83c2vOcv8
         zuMEsq7clduf+kaxKuRgpkZlzTDEWYkAu3o5/uG0YgbqNUuIcSlMTcX49CLfyGpzq1pb
         zIDa0zGSDaIpNP8VQajNnXf4x+HBX8Lofidy0RaNlU2GoPXoeaL+LiGmsAAlCdBMN7n0
         MON0WQ99zZqWF610V/kzCnxHPedrPtLrhippD0wdgYiJ9QYLBsrNSMgqGwt4vycp30R6
         aHoQ==
X-Gm-Message-State: AOJu0Yyek8Lyu/Z5d2W95YhO9nGfrFjV7CYdhpWOiqTyBGf6H8qizzMj
	/DGW2MVPW9HpjKMdOvj8m92EZGb+7tAdBuXvW0hDOc0LVK3qRPKuboVuMA==
X-Google-Smtp-Source: AGHT+IF1GKFS9ihjEsWBn7NhFOFEIUzNPTcdTd/c0K94sl7JO3AvSQZ/Yl8A/uLLk9XdnGxg5QSIlw==
X-Received: by 2002:a05:6a21:3942:b0:1c0:ef24:4125 with SMTP id adf61e73a8af0-1d6dfa40613mr9253972637.26.1728127619214;
        Sat, 05 Oct 2024 04:26:59 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:475c:a654:1ae:2a0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb93sm1317187b3a.55.2024.10.05.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 04:26:58 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: delete unnecesasry fallthru comment
Date: Sat,  5 Oct 2024 20:26:48 +0900
Message-ID: <20241005112654.11881-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_042700_566274_BAAB700B 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 48e7a8906d01..bad1620fbbfc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -431,7 +431,6 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
-			/* fallthru */
 			return true;
 		default:
 			break;
-- 
2.43.0


