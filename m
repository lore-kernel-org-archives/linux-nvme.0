Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C641EC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C36161426
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C36161426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/uJ31DPWSUOdfAyuLnB6eyA/9ZDrIhhzfNl8T7aE3us=; b=FLsH/zguO8ovg6XVMR66Pk5KOP
	CsFu+PPpuVAQXT4aaFCZ4c93CLgWwCbnThTEQQGyp5WTZ8fpR1INpOXzFoGDrfx7m/jd8EMlUkYPF
	oo3kJqhElftQWrW3lwO42Sfxn9/15CvxCpsARoDqioK4Zdcyu3lcECaS9la5URzmYMPHW4RrY6gld
	+UpKUl7FgJWfoA2Z4ENHKRn9gUjiDCW862LnoeYEqiMNeCF2q7h+fzrROzEjgvuty3WNu49qzzmZz
	3zpOpktQv6kISi+zeeoVTIcTlBmvBtfCUyT9Yr2Tl7mfkPica+WTiZbb83On8f66CGbmBv5m0VOx6
	lnVH79sQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZUJw-00GCNc-9h; Thu, 22 Apr 2021 08:04:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUJt-00GCN5-0Y
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 08:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=oJFQxprbLKMgFWq4QdqUk2o+hMB4RRIJ7ngWyHXLUbY=; b=LDy5PyXWLzJkl3sLZl8FYHjVEm
 zvptp9DA+wktqDMeDoIqp+5Rvjd90KrQWS9Cmd64aJ4wPbpR+pRNO+2jDkKIwvYl/A9N4fOIJ9xJC
 i/qpjl4uPrlWxpUq+0ihNOYruvwxpd9G0Rd1YF/X+eFBOBLCsxEZ4Jwj6WpoIZzgsy13PLrWii2qD
 zMZK6c4mPOPwDd4QNq2cfVktRwkUIfqdyT1lx1QraJRCnW6gLkFFVi957XrPzqToeYB8zz+7IGklb
 7F5vREqlYJEce0+eodh3Y0WgRIz6rxfHjynPYpE1/pg9OK95GnD5qCcbL4m/XBbjFE/24T8XBgRQK
 2eA8y0cg==;
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUJq-00DTTi-Ju
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 08:04:15 +0000
Received: by mail-pf1-x435.google.com with SMTP id h15so13437127pfv.2
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oJFQxprbLKMgFWq4QdqUk2o+hMB4RRIJ7ngWyHXLUbY=;
 b=QK7UEBIFSkZQxfb5aR9L6k9iXfmG0+Y1yecZPmL4pnOyMV/PnfqBoVVyiRqWrWG9QX
 xo088PqAEd+5sCMTQtOCHHah7YsekiMQICPk/5/6Eyeeg5rPGvzWBR3EMeFhTrn38lOj
 KhesYH36WRTzEE3LJ/XBGrWIYMvO1yNsETUUVRjKwyr1o0S/wfAxeG+GSnM/BtH3N7Hb
 i+EIL2dtPO2tCFvSRSXSflaAtRK6j6XbnGGO8HUkulYS67YWAMgpHW04WUP6GUK69G2h
 L8fIdPihvm5/3OeIxcHh4s9kxeY6+1FZrIDZbPwAWOYzx9aXYGl8x06II+QfbGkpmkWU
 jM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oJFQxprbLKMgFWq4QdqUk2o+hMB4RRIJ7ngWyHXLUbY=;
 b=DzTE3KKBxyLkuIOjdjlevPHCkSXtye5nF6CgsnmMacKrTJBl6xISEgGLwRExnkCC/i
 OI9XeLGOC7umfnQth0E5XsCR7sO3dMYmT5dtYjktO2gzb3D1TahK78jvttMJz/Z1yOjQ
 rnGK24wO1qZKmsKKHcaN4Vx8ouEYCqCRo8mAgv3pVBFNxe4vVgXJh1yaxnbNgaWIop01
 wnv2F1IwTjmC4nB5vzlEvNlIMcSwikhWGQ2zvB7UiV0V91xFJhrg4g+yy1Tju7bNXbZ1
 z+Q7NQ+6+xWgkUkOIQYlIxiKDQF7+MN5g051nhXeaGUM610W+MKtBFkUf5UVERlBX6yS
 R3Sg==
X-Gm-Message-State: AOAM530SBhc7fQjh9I8GOFL8oGamu0QUEbb2WxhfNcaUK6eXMFl1HSOZ
 E8j1biNohjRyUX8J77W/Z3w6KgnoZrLkHQ==
X-Google-Smtp-Source: ABdhPJxsiKGVFMKUbXcXxltPBxuxEwbfUsqYgppKLdW4Y+fGmZirFQBJ9Gx7zuU3Wu/xvy49bH6AgQ==
X-Received: by 2002:a62:7556:0:b029:255:f802:45f with SMTP id
 q83-20020a6275560000b0290255f802045fmr2220415pfc.56.1619078652507; 
 Thu, 22 Apr 2021 01:04:12 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id l35sm1447139pgm.10.2021.04.22.01.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 01:04:12 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V2 0/1] nvme: fix controller ioctl through ns_head
Date: Thu, 22 Apr 2021 17:04:06 +0900
Message-Id: <20210422080407.62999-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_010414_678472_88F048E2 
X-CRM114-Status: UNSURE (   9.97  )
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

This series is to fix controller ioctl through the ns_head block device
and the per-namespace generic device.  This patch is mostly manual
revert for the commit 3557a4409701 ("nvme: don't bother to look up a
namespace for controller ioctls") with few more updates to the generic
device.

Please review.

Thanks,

Since V1:
  - Manually revert 3557a4409701 ("nvme: don't bother to look up a
    namespace for controller ioctls").  (Christoph)
  - Updates nvme_ns_head_chr_ioctl() which has been newly added for
    generic per-namespace chardev.

Minwoo Im (1):
  nvme: fix controller ioctl through ns_head

 drivers/nvme/host/core.c  | 22 -------------
 drivers/nvme/host/ioctl.c | 65 ++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h  |  1 -
 3 files changed, 41 insertions(+), 47 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
