Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A6DC64EC5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rIgTA2Xmbd7t9d8F++MfN6g4uGoF/RD+Mu3OeUMvfvg=; b=JeQsuc5XHrpiRr9NKnJwbstGE0
	zCxqmSYE0y4ji8F7KtaL3dCFcmgyDhLelxnqPaWULoaW90QemxkuUJWogUiBJb1ceJyM8/geobgkq
	SsC+grRnfH9DjQlR7WTbIv/ngF6P7FL3PEQlbyVJ59E+BKNb5reoDqqcOw1Fg9ZvRiU2nw6oJarZb
	tacriIK6ZGYhrqncz915yabi9Kmr8/9wLUnjg+J6gvzYaoCOXlQ9i/sWccSD4b4ZMjbGDMjJKJX4a
	derw2sH0k7qGUdaAFVtyJoKIal71KkReYiqbsl5QhkNT+w1ozWle4cNvdRlMcWivcCXFVQo9Vhl/t
	uI5fSeCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP2vh-008q4k-Q2; Mon, 06 Feb 2023 14:57:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP2ve-008q43-BQ
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 14:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675695427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rIgTA2Xmbd7t9d8F++MfN6g4uGoF/RD+Mu3OeUMvfvg=;
	b=YC1y7e8izYVLDmrklQrcKmiQOc4U4e34F86+45x69Kkdu9/HXpiwkRt4gz8qaB27ncorEA
	n/mc2wIxtDHI876Lzk9JvdysK6lwFwIrSn8ihXUU+cvLSGVLjpW99X/9OKAYw71DseFNWf
	Qxzi2rdKb2T2szxrF+rOs0iblnbGvIs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-YA7R7HUVMcuJT_P43ZblCA-1; Mon, 06 Feb 2023 09:57:05 -0500
X-MC-Unique: YA7R7HUVMcuJT_P43ZblCA-1
Received: by mail-qt1-f198.google.com with SMTP id g2-20020ac870c2000000b003b9c8ab53e9so6532293qtp.6
        for <linux-nvme@lists.infradead.org>; Mon, 06 Feb 2023 06:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIgTA2Xmbd7t9d8F++MfN6g4uGoF/RD+Mu3OeUMvfvg=;
        b=4wzrePlnYOS6DT1SlnHuf0Ys5F0NSWHDORqz+5Tt3EtReHPk+vqVwPSmqV82VV4Rth
         Dv+zksLW6853pRY42h3n9lqUPG1H1mxN7CpvgHJegqkngsHaI+nPOVwDIkosEAYKQ2UJ
         Jjv0gJ6oJKbsGw/iO5oPPC0rpWAm5gFaf6LVpTUD8RNBU6Z0vdc5qb64bmvctDKzc6Iw
         qwX/ioqYd2aS37TkItcsQDXgvqqQLno0UfK4VmDJ22LoZv2udyYfDgWOsN5TvudGNZqL
         Vw/3L98nE7DMdaegtW7cL25XqKp2U6Usy1y21TkdUEaZf8oMbIhsD2cidXavxHD0QQf2
         D9Ig==
X-Gm-Message-State: AO0yUKX93b3cgfhQXkPRlkwnc7lH9Lfq1QxrbqQgomzOYHTyo0a/0Y5J
	K7YHgKiX/zaofuPE0C1iM8WEBWpwrHZcSsqQ1wGMhFg+PKvBaT+v8g9kEFVj4Ue+ibLwLy5h0QY
	Hftwjg9IpMkRfFr1S3mlLD7VX4sE=
X-Received: by 2002:ac8:5ac6:0:b0:3b8:6a92:c8d6 with SMTP id d6-20020ac85ac6000000b003b86a92c8d6mr37832275qtd.60.1675695425194;
        Mon, 06 Feb 2023 06:57:05 -0800 (PST)
X-Google-Smtp-Source: AK7set92cIxYT5bIs41crQz1jVBZ7Rd6XKPaRwbA6dH+JROdrZzl5nc/0WhArHdGNyKIkJmZD6GDdA==
X-Received: by 2002:ac8:5ac6:0:b0:3b8:6a92:c8d6 with SMTP id d6-20020ac85ac6000000b003b86a92c8d6mr37832250qtd.60.1675695424964;
        Mon, 06 Feb 2023 06:57:04 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a0b4500b00731a76883basm4117666qkg.101.2023.02.06.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:57:04 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tom Rix <trix@redhat.com>
Subject: [PATCH] nvme-auth: set nvme_auth_wq storage-class-specifier to static
Date: Mon,  6 Feb 2023 06:57:00 -0800
Message-Id: <20230206145700.1798073-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_065710_502299_607C353A 
X-CRM114-Status: GOOD (  12.18  )
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

smatch reports
drivers/nvme/host/auth.c:48:25: warning: symbol 'nvme_auth_wq' was not declared. Should it be static?

nvme_auth_wq is only used in auth.c, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b57630d1d3b8..bdb97496ba2d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -45,7 +45,7 @@ struct nvme_dhchap_queue_context {
 	int sess_key_len;
 };
 
-struct workqueue_struct *nvme_auth_wq;
+static struct workqueue_struct *nvme_auth_wq;
 
 #define nvme_auth_flags_from_qid(qid) \
 	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
-- 
2.26.3


