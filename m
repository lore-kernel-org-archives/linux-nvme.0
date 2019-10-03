Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E4C32792
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0A8207FF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b0SaeA7O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="se77SjyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0A8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YsfrzJXFKLYzQE5CT4btAw4znhKbZe/UPWBtdh9xoWc=; b=b0SaeA7O2iACy0
	5POGoxmmo7POs0EakkbkxarW8z7Q6WWMHb5xPSerP//K7nr+ayVAnfDKGX/+yRlzlCS+SSshqedAH
	vL/EF3uk5fBa4DpkCaLPDHT/5XWf9uf4jh5oGQaMo7g2s527Y2iU9VWAfI/E7xwwpx7VOr6PY3912
	ykqs6q/sMvyoryUI4Me+M56FwnsrsFb5mztT+2h0AYoeMnzOMkyY4a9JTNOlyhfRQu68j/ATkbZlP
	84XCpfxw6viNMxYTHjE9kUZ2WYRqhM8vu80oPi9IrtthiyMe3BjtvuavrHgknDqnDexwuM2HeD854
	MDdIxbT9FMkl77KDcKTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iG6XG-0006Bz-Fi; Thu, 03 Oct 2019 19:13:10 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iG6XE-0006BR-Rl
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 19:13:10 +0000
Received: by mail-io1-xd42.google.com with SMTP id v2so8093573iob.10
 for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2019 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=kR8Zy1YrMRxTBtPohNQSd/AqP79mcgM2qqBmsukmkyI=;
 b=se77SjyVATxLFOZM67qjxeZ6JxrN0Fjp0aVCUA1pBKktbIzqSWVh1TFERJq6YKaGJC
 xg4VQFzjWMXBt84K4G4NL9GZ6Uujcw25j8eMYP5o/fOr8qR3VuSODEFu8IOndrfU0fUE
 JVl5yWlUmf10315yQLrSdtz7/3QtJLK8YNfoVIZvzNj4XckX8jqaVVHFbA0qIAy2k+s2
 Cp7BhycojGSNLdD8YwHpQL+R2UBF/HZ+MIM1Lk0fbeEeLCZc4K9XA008b/HIYOXUudtM
 LWfLEXL6b0UiR0bvuAjW1fDQjdE7hPpktN9fneHWgfI4lMORqVroCz/RuDmgNQavEHtq
 wFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=kR8Zy1YrMRxTBtPohNQSd/AqP79mcgM2qqBmsukmkyI=;
 b=O12Q4majIkOzQQ2hHBO7JZ8HTJTzKSLk6jZuEul7LimERK3iofOWfjuB76t8Bhy0OV
 2I6G6euYC53VCfka5RrDt0677LkjUuUWcsddyD9vVU55lIJx8ab/dANsAyT6O7J7e6k8
 XAWgflIVNHghg60hmKfSOnvsTSJezxO02FIWmQ4X8TFNiK5ssOPiNcXejrC1n7rxtA/3
 zsOmZuVGAYVDAPsrSKqG8Tb/dC/cqv1qOXhOSp5jnyjyXPOODtox1SI/O6faT0oB9zOF
 XdJGh34J4VfwUGS73ob80kREc65vDQ4Y5mXrRtQalz6fuSeC/bWSemaEnSuFOdbT70KH
 mexw==
X-Gm-Message-State: APjAAAVWERgaAg70/iWWsO5TP2ZBEZ41UMIRTT13CisyqVOFKL/vz3m2
 TY1m6O9TM8zJH7f5s9ZXfzg=
X-Google-Smtp-Source: APXvYqz6nPLd4RajPw+ZYmFpKrfqpnW6/OhBMwg45uYZm6lUpOatNTvPjK3Q4wBFqI1YNDjnz6MfJg==
X-Received: by 2002:a02:2a46:: with SMTP id w67mr11216914jaw.17.1570129987782; 
 Thu, 03 Oct 2019 12:13:07 -0700 (PDT)
Received: from Serenity ([104.129.159.212])
 by smtp.gmail.com with ESMTPSA id z10sm1203162iog.41.2019.10.03.12.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 12:13:07 -0700 (PDT)
Date: Thu, 3 Oct 2019 15:13:54 -0400
From: Tyler Ramer <tyaramer@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191003191354.GA4481@Serenity>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191003_121308_900885_549FAD26 
X-CRM114-Status: GOOD (  12.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Always shutdown the controller when nvme_remove_dead_controller is
reached.

It's possible for nvme_remove_dead_controller to be called as part of a
failed reset, when there is a bad NVME_CSTS. The controller won't
be comming back online, so we should shut it down rather than just
disabling.

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..c3f5ba22c625 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, true);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
