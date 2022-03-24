Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19426C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4keTfPKcqev/iwB7fExvJBmFu7AxDMAcE2wIe3carc=; b=aix/27+Q4CMyKikjSiPJ86M07t
	/996acbUiIGxbxZpZaSww8dODCcGwr/PvIHhHTkIktfvpoVQUi5XmZaEMfnX+G3Bj5jfMMmsVzxPg
	maB6BVsC7fYtWPGU3vw5vi4y9PN0u6bA9+5fKiK3I5p/iKYGr3cjAXOPmGcXJ+XeEh6HFWYfsHuF3
	t8pKps1BdjUkLkhq3j9ZW54Cq4z8SxPwACiPv0Ogr0hJ14QMiz0/6H+zcRz+JR71p19sjdSiOJ7pM
	klyU+VWAz5fW2u3wFKp53Na3VpQIEC4wsOTjiJ8hcAfJ6quW77jiyN5J4DWoRaJ2mgCnX93ppfbLf
	z+ttlQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXSmR-0001dJ-Jy; Thu, 24 Mar 2022 19:05:55 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXSmO-0001c9-LT
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 19:05:53 +0000
Received: by mail-wm1-x332.google.com with SMTP id
 v130-20020a1cac88000000b00389d0a5c511so7763597wme.5
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S4keTfPKcqev/iwB7fExvJBmFu7AxDMAcE2wIe3carc=;
 b=Pp+WgOVYOG7mhOUVbNUdKs5cen5DgngGnmY4V7HIVERg7Esu+0iLSk8W6BWfrbqIDa
 wIZkQvtkOyn+RklMDreFNpEImgiCDSA/YJHYmISM+eUIOl3MSpgxDnB846BaUSEhcExB
 LGvRlXvGv4b4iToeb6ii4tvHnzDqQYVh60woe8qBulU/8J7cwDQSj3M+fbv3myBGFM9M
 Txc339RGpMxf/4aspm74YuQhAFTf0byXtyh8tPLcCqTM6zMMtsk4O9K6+RpogkfTwkx0
 7GCTM7l1kNEapVls5uLx7je3eiSbNm6Qk5OA2gJLqn+xonZKQKsA5zAy9Uk9I/CHZfRR
 FMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S4keTfPKcqev/iwB7fExvJBmFu7AxDMAcE2wIe3carc=;
 b=DH3DX/sfEeKvUBmWWNZ/Ku5RauVnNzcvwmGasAAtT2aPw2tmlJOZ/cm9oc0wa8JJVz
 A5jZuYXRroqJ5Xie9Gv0i7NH3AVeVOBeXJY476ot0NaCv2hvZgChf9aizkBktvb6vXhx
 7s7R44oDx7uIVVCdKL9azlJSpGmbJ+s2pwSx9nyeFApopESuwjhrvRGiehr+0QLqahSC
 hkUJDQWFFKIbNNfREkspbWaPELVJQLmex0ARXL6fuBAi8Sa36tdh6humWDzTqSno/PjG
 8VqCGs46GUYAiAlgvcoPhBc5Vws0NvBtm2SkdRb9EKIYKGOaSZ6mlzRPG7DcgjBTcINc
 Ie5w==
X-Gm-Message-State: AOAM5323Rt95lSIWK6THhLN0vLGxLDxzBjaVDZc9Yo6M0Caju1YsMbfH
 P1QPkJesWiAUA8/CfD4ruKxgdSJUv+elGg==
X-Google-Smtp-Source: ABdhPJwi9CFGwi3S5cAkXOl6jr9NbFfLAEL8LCoZ+/d4/WbYXx3+poe80yszpIblT1wKDTnVbjl60g==
X-Received: by 2002:a05:600c:252:b0:38c:cd19:fbff with SMTP id
 18-20020a05600c025200b0038ccd19fbffmr5256244wmj.65.1648148749269; 
 Thu, 24 Mar 2022 12:05:49 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 m3-20020a5d64a3000000b00203ed35b0aesm5516084wrp.108.2022.03.24.12.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 12:05:48 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v4 0/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Thu, 24 Mar 2022 13:05:10 -0600
Message-Id: <20220324190511.1659517-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323152212.GA325@lst.de>
References: <20220323152212.GA325@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_120552_729725_60033488 
X-CRM114-Status: UNSURE (   9.14  )
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

Fixed:
1) Build error with CONFIG_NVME_MULTIPATH=n
   - missing "static inline" for the nvme_mpath_update() stub.
2) Crash when CONFIG_NVME_MULTIPATH=y but
   either multipath is off or the ctrl is not ANA-enabled.

Anton Eidelman (1):
  nvme/mpath: fix hang when disk goes live over reconnect

 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.25.1


