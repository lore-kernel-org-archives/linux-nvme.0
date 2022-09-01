Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D84ECAAD2
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rfsc9cuS38+eZMsArKgbRqvaboPWMn5Sb1iOWK1dEG0=; b=JGU/ejppWvstdBFUTh786WmJtQ
	KPXMr7UvPGO4L97xCqOA+t+Iv5s3RUVoIrqF55FM3syPEXV0BPezm2YwMIlLUIZ6Prs8P5MhlWtGx
	77Tdvp3VK+i/ctKnsCiMc5JNOYg4tSGNZhPPd5p4v2645vx4HwdnuGcsHBwpNB4scspUf11kw+olc
	L4oNy1kxLETgczUg84yo6yNHUJ4/nzdXTKwrOSINZVB9K89T1tu3jT5VN8t2zkqxgtubxvfzil4R5
	CzG7E1fphDGhGbsywS/DptkK6J1aK0TProoA0fZBaEkARZJc0/Goko2pE+DzzgOBQk2w4RSQjM9Xn
	HYqvomxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTdTU-00A0Ff-Pc; Thu, 01 Sep 2022 06:14:48 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTdTR-00A0E4-Dk
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 06:14:47 +0000
Received: by mail-pj1-x102c.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso1437348pjh.5
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rfsc9cuS38+eZMsArKgbRqvaboPWMn5Sb1iOWK1dEG0=;
        b=OHeKchS5mkrLxzRiKenDSGUGNVkF7TxBWk+PdfKk0XY0sFxy0a5+WgWwxH8IFtpvGA
         kfkKh20BMxQrxG1Qw1Tjmj9v2mi3Y1EE/sJzq41YuMr4kwCvPX8G+yekzPfMvs+mGbXk
         6YUaLkftoNjQ1ekcaVKx13JXWBnMdY4jWxkGNEk0qda8BLv5QpmK81eWzRXqV29hOBO7
         sTIk9HB/mPcjLNTcrdYafcDYZjFS4EISTFTH0sWcVIsCqkUAgyVurb/ZlGKIwQ67BO5Q
         vON8RYWQbO6VWHqgcLI1XrS5B9efrLbiJSSOwuWE6gjAfg0UGsJilVQnJW50ErP1LlVB
         eqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rfsc9cuS38+eZMsArKgbRqvaboPWMn5Sb1iOWK1dEG0=;
        b=PiSvSQ4lcsWR+Fiy8JJocigVpLma9QTc9klohUF04RzSZLNdKt+UzijXCyqoj7newm
         BKU18NDvlL7izZTGypGzmtjVPdBpr7U8QmWBJY1gW6YRypGpR4sx/4Vb0j+1XRuK2dcw
         jZxEUFTIaCrXjv0hSWtZ0+opLcaccelAJX1hanA2a/16QGodk3IC4ERMFD5FvKfrNuO3
         vi7YwRjydFwp8P+0kw+poMF6+iGNAglxocWbHcaIfW3iqPRf26HomWopSC0+qNhQhbMx
         0WgysQpBZPZ0PY2NxJn46bez5gKvXmLQyD9C1YHjsLL8m6SZtBS3wOBtahv1S+tuETwy
         i47A==
X-Gm-Message-State: ACgBeo1kkKxhe2IcV/GT4eFRGe27dNGOAWLyV6YKmGUDXM9U1gFBQMln
	VcsXWFXsUVyu7lQhFOKGsIcG+A==
X-Google-Smtp-Source: AA6agR5B/y+efKOwgbEi3ycXd7ry2ucRy8Ouz6Ur5ou+RBv9emB4J98Caq2hrdc4K1+LrVFgcIyyYw==
X-Received: by 2002:a17:903:189:b0:175:4643:f862 with SMTP id z9-20020a170903018900b001754643f862mr5641658plg.5.1662012882145;
        Wed, 31 Aug 2022 23:14:42 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id k26-20020a63ff1a000000b004307ac80cacsm581497pgi.54.2022.08.31.23.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:14:41 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Thu,  1 Sep 2022 14:14:08 +0800
Message-Id: <20220901061409.545456-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_231445_710083_31F2D12B 
X-CRM114-Status: UNSURE (   8.13  )
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

v2 -> v3:
- Keep original function name as nvmet_tcp_uninit_data_in_cmds()
- Add new function nvmet_tcp_free_cmd_data_in_buffers() to free CMD buffers
- Rework against http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.0
- Move nvmet_tcp_free_cmd_data_in_buffers() after cancel_work_sync(&queue->io_work).
  Hi @Sagi, if you still prefer to clear the commands that are still waiting for
  data from the wire, please let me know.

v1 -> v2:
- Separate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.20.1


