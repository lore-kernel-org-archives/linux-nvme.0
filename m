Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CEC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDD56142C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDD56142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YgDxOalite6sQ9Ucfl3C9+zhpqlGOm0QWG9R0HFrxWk=; b=ZGpS7TujD+o0AQJ9hUpdw7PAgn
	r2uBtwXrxuqRmpVvgyj934l0Xc3UcQoILJ4EAlkjtu1j/h8DaEIl/h6+1HQRxcFmnU97QHP0g8nyI
	pumC3EQftvUSRBpHd2yaEk9lkAXlU8/CVimxy/p1n8w/WDDrXBjnX3HSKp+vAev1I7vOZkQGWEHeE
	cxhkVjT9r3HASF8dN7bz2tG+vEhQtioVpKxj7vqyXmEIFSZL/0DUG6vHafhDtTd/UtMYxJrhw7eF+
	xJJi1SN2Jn0O21o7mT/rmEJbLaO7pwXYWK+WTJHxdUAkkpo8hicAzrmxqLW6CxzQX3BtnAALhWg3/
	rNHHKmIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ7Y2-00Duvy-PX; Wed, 21 Apr 2021 07:45:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ7Xz-00Duvd-EV
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 07:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=GM8LBlFKX0ksVQcCHrAyswZ4e3elT6DHby3JlKJTMoQ=; b=QlJAbupAcSPZP6y7HuAOPa0TDg
 l7bF34rt7u/6EDW/myhOvYEm0rjIBdOXJwu8Vasx59t7Z6FC+9C2Arqmoc3p7QcVsl0/oK0hkRiqI
 s5G5gmFyddd4rKoMNSgJG/5Yqx+vkmLdtoa4PFpqnZbERkUgnGVxxVxrzlF7nDzkApAJl5ev8Db2U
 B5QheXCP3FmZ4CFyB8Fx0PBmxdRRHg3/t4OxyvWvFvLfhEq+KGSQFy5BM+oUo3sdRx6/IlZS0keMT
 EmJoJIX3wvCiwCZ4oRZLZjVK/1YjYvAXvRWYavS3sX9b1RAPfssich+yj58zH7mwU60gy1+fkpzoQ
 noZ6aNyA==;
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ7Xx-00CgM3-1V
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 07:45:18 +0000
Received: by mail-pg1-x529.google.com with SMTP id 31so13476406pgn.13
 for <linux-nvme@lists.infradead.org>; Wed, 21 Apr 2021 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GM8LBlFKX0ksVQcCHrAyswZ4e3elT6DHby3JlKJTMoQ=;
 b=ApOlUV1DcWWeXm2TOdB1H6tPSEgeOzARA16mRbs3+f4vgyOZ6Gi0WDrc5EwKmvCbwb
 Fy9ZHH7qf+Cra94eJLTryyAu34+l7C6d554roh7PHImaiFWlXmLxGxd7n+1nmz3gYrqL
 oy7Uyh5QPSrpxoQjuDOJeYTwcWapNIO4VGij37Nvcq6aeFMO//HiYe/YdGSYVwWEBl8F
 xLGV8xv8XxP7dUR3FC4IfAsDYjzxRRXZxOpg6a3HtWO032pKbbKh+6bsA6kIt/DzWCEQ
 z0Ipaj+LoJ6R6TOFoHy5UX/aSH5s3bplTAe+hm12/v7c/4c/SyzhJRtt3V8pvZnfaoWf
 AdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GM8LBlFKX0ksVQcCHrAyswZ4e3elT6DHby3JlKJTMoQ=;
 b=ivRwb8mVUc6q/8boQEftg0fUsTdQnrUsOpdpqzDNcB6pwvQswjpJzba/NuWMGCSd2k
 gXGjqh2/VHsiScb8rzCyTIbWIkZmsOuC55lHj2kh7KGQJkOMdE208Uz9ojLfrnQNu7HF
 beze7aft75ertRtWmSesXBRLyu0nYeNGowYFu0esDMohXvhMWtj3T5bv/Puj0mfSwvqV
 nfVylwYggqKI6bIIEKaGkHfWSIHJY8/XOYvy71ph3Nb8Avf6Au593nZWk0kJLbTHfG9i
 ZdH5W2M5+/A5Q/7mPdjRmZK8wO2k03RJUAbDf7f7t/9wvXA/LpGWc7X2aUVwTl39gaxK
 NQTw==
X-Gm-Message-State: AOAM532FUwK81Kf0YDoMpjaZUc4j+wNJT1Ye4q1odRtqccF5HDmDHuX9
 BClHRGSm/9ukG+CJHUtZqsEFZST3UeUYIg==
X-Google-Smtp-Source: ABdhPJwjp2Ox/KMxha/XHXwOXnCQKGgpYSafS//tGsuot7fDa4MoPGsB5gv7iiMRJ9SE8p92TqHCjQ==
X-Received: by 2002:a17:90a:5911:: with SMTP id
 k17mr3759414pji.73.1618991115318; 
 Wed, 21 Apr 2021 00:45:15 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id s5sm1021319pgp.7.2021.04.21.00.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 00:45:15 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V3 0/1] nvme generic per-namespace char device
Date: Wed, 21 Apr 2021 16:45:03 +0900
Message-Id: <20210421074504.57750-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_004517_122700_BC17EB99 
X-CRM114-Status: UNSURE (   9.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

This is third spin for supporting per-namespace generic character
device.  This version added support for admin commands through the
generic device just like the existing block device.

Thanks,

Since V2:
  - Add support for controller ioctl (admin commands) for the generic
    character device.

Minwoo Im (1):
  nvme: introduce generic per-namespace chardev

 drivers/nvme/host/core.c      | 87 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c     | 41 ++++++++++++++---
 drivers/nvme/host/multipath.c | 51 ++++++++++++++++++--
 drivers/nvme/host/nvme.h      | 13 ++++++
 4 files changed, 182 insertions(+), 10 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
