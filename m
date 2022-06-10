Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A077C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 06:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5kfsl5yNzgEsKB8lrEVRergSo1r47kHbryAP1YfWuzE=; b=P4xypZQ5DthuxnjdfLAIxPJ7Vr
	J6ATSRb1JBDx7umfezueIgHY1V1Kp7AhvH/PlQz89sVOT63q5RfO7sr58KuFBYJPwgE1Hg7vJdmEK
	QMUMmlddU2lB1I3mKqVfOdjro/hBjLeFX1J4/iubY4NjX4rKBQKubvY/9A52iF7c+kx5hA3c4AHwE
	7B9ZmBCk5ktT5KyyLKJ4kxeIZ3QVw3vKq5jElUMYZFRCDnujmtaaXgLkBAkUfYUih88mDaNSdBwTH
	IybwpIgFzk8H/zVWXLkpIRHZCPbbI3xIdz1gNo32RS3zxwNSApnGJiD5Kb6+JpBmnq+oveNiZpK+D
	uSB/EEVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzY7Y-0068wB-EV; Fri, 10 Jun 2022 06:27:48 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzY7U-0068uf-8D
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 06:27:47 +0000
Received: by mail-pl1-x631.google.com with SMTP id s14so22035432plk.8
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcfc-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=5kfsl5yNzgEsKB8lrEVRergSo1r47kHbryAP1YfWuzE=;
        b=zwkew2F4SlL8/JmJtjnOw38DlfrjGUec9fmc7qwV05V4ah5gKLi0wblVsX/f4fJCtD
         DOnhTOcioORAXaqFA1dOTjtR8r6Oo/8fa8+cEM1yLx0K26ZD9U/4ISjRJc2jrPgPjn94
         tUH4YLc+m3BY5JNx/m7u7DUoMu/nz/YCL0ESLglk1qFYDdEJdBHNpQ7PiLrEfOYi8w4j
         BmWZCb0QAaRfnGE2Pt2qXLH4kj+3rdIhEX4BFDE3BgmgRmQL4ymv/E2CQOjBWF5DUTVc
         Oss9j+9K3vC8okFWCO6jy6IWcTf7WaYza1+G7EY+AwIOhG3k/+674+63PYJ4hAZ/sJT6
         16lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=5kfsl5yNzgEsKB8lrEVRergSo1r47kHbryAP1YfWuzE=;
        b=DmKvCOI9kNqGkc4yEghRegQS0uJEEcketdU+5DzcG1VWRJcVTyOYPwvVueks9trgyh
         GqHXiuJA2dyv5M6lf4uTOZpetP58WtgU282VHaOg58ZrQ01K/xKkrsDZCbr8WvYg84Fm
         42x7QcUCX5PNpJRYmHiCjs+ynxNZVk20AyTVYQN4JMkoJvG/u9uOvJi4SgDeYF973vVq
         MUJLKSBi5wchqgfhNQu2duBMU2Q72ky/APN74lMzGnnSLl6OWBHDXqn0a1cd6VHQx3UR
         6S+XbzmmGdKuLQOWW3zDSS1ZPcpNYVkGIDJnQEYYbFWMQz0IAPGjl7Cr/P96mPcNzssN
         +QVw==
X-Gm-Message-State: AOAM533oNE02wQtrlkMOoSo2iNYGaRsutYDvrFmM/8Qc2vu+ip0PBajj
	XoiL1hFZVvXSyC7kSTQ+kxpWmQ==
X-Google-Smtp-Source: ABdhPJx22T5OfmZAnkxMIJDjdacbmwAap8w3dtTYNcjFvJ/f323WKCxDZalgmldjaySWp35H0D7LvQ==
X-Received: by 2002:a17:903:41d1:b0:166:3c6:f055 with SMTP id u17-20020a17090341d100b0016603c6f055mr43751375ple.112.1654842460793;
        Thu, 09 Jun 2022 23:27:40 -0700 (PDT)
Received: from rasheed-i7-P52.LCFutureCenter.com (211-23-25-187.hinet-ip.hinet.net. [211.23.25.187])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a578400b001dc37aef4ffsm817511pji.48.2022.06.09.23.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:27:40 -0700 (PDT)
From: "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Rasheed.Hsueh@lcfuturecenter.com,
	wuxy23@lenovo.com,
	gwendal@chromium.org,
	rasheed.yh@gmail.com,
	"rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [PATCH v1 0/1] nvme-pci: disable write zeros support on UMIC and Samsung SSDs
Date: Fri, 10 Jun 2022 14:27:33 +0800
Message-Id: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_232744_527321_0376DC7E 
X-CRM114-Status: UNSURE (   9.54  )
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

To Whom It May Concern:

The existing FW configuration of NVME storage and system operation will slow down and consume the life expectancy of the SSD.

After co-working with the NVME vendor to clarify, below is the root cause:
• NVME drive recorded there were write zero commands and took time to finish.
• Current FW implementation would handle write zero with low priority and in serial, thus inducing slower response.

Replacing the WRITE_ZEROES command by actually calling a write command with zeros, as proposed by the kernel patch will reduce the life expectancy of the SSD as the command ends up writing zeroes instead of just de-allocating the space and preparing it for future writes. WRITE_ZEROES is sent by the kernel with REQ_OP_WRITE_ZEROES/blkdev_issue_zeroout() when we do fallocate or use LVM thin layer that we are deploying on the new platform.

rasheed.hsueh (1):
  nvme-pci: disable write zeros support on UMIC and Samsung SSDs

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.17.1


