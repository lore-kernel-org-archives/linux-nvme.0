Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C4C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kVHP1h0FhA8vh77DKQEGNILt5KJpnumqkzmu5LvDnek=; b=X6T4IoeVBS1CgDGLpdzrUA2rU2
	gtRipNJ4GEmS1WfYQvgHsDEpuuwZ/Fyf/RFcFIC/HjIbLqf78uORSN/OSC9ds7VAOrZ4TpmlYtcH7
	8/7V6OhT7mQxBo/NT5mL7WN9a4dloKdNgjM7OTEcF3hkjxX8XJerCsjeObuiEt+ayCoBQni5+Xb2+
	BgrFVKUrFMkOtQ2lnG08ZOB5eUzPUXzpnP1MW8KlK7r0IDqNRV6UsMBM7ig6Eld+P2iib7rZA92Xs
	dSGxmbcIs32Kq3ojEyWisJF76Qnw/VayUKIMJeb+KwDY2OL2X/ltFX73nQ2W3WNOtz3ltrzQVgKxj
	KDXw6iSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9o6Y-0000000AIxL-1QZM;
	Tue, 29 Apr 2025 16:46:46 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nzq-0000000AHkX-0Qnp
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 16:39:51 +0000
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-86135ac9542so897039f.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745944787; x=1746549587; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVHP1h0FhA8vh77DKQEGNILt5KJpnumqkzmu5LvDnek=;
        b=FceozPZIH02N+024WYSj0dSZzFuE7jvN14iCrFTkmRkwyhP+6Di1l/4FMjkxr+MZXq
         xPOHPp9tS5PUIzgQIbTA7ZgG1HZFX9WcEVVJQ27HOS7DWG3esYayHXmOgFVXFUZ+2Hea
         f4mb//7oE/jK2JDedQIlE7IjKKpdoBgF9GhUHLDubJmSUMalQEPuhp7mcyWQR/domWGw
         +PIROmZj6eI8Reqc1LZAtZ7axwWi53DQvFqYwOfnHEduVG6zREk41m/Imw1yvtAHd1af
         0sbMb3z4NMvwQ2HbhGryZIpGVgbVgRDds4TEkrDemUEFfTf8vbAlhzyc3pWtpYUUcZPV
         Ttrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944787; x=1746549587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVHP1h0FhA8vh77DKQEGNILt5KJpnumqkzmu5LvDnek=;
        b=S7OtqOWeIG95F23JeJyAog7LZgU+oB+6ozL51f44XylEMDXb/9s5SlWqc1QxApmE+n
         KF/2t2uERrRYty1v301s3TboQmFDz+LdCcBajyn/NPSt125obg2W6xnllV/2yzefwPmK
         0DzoXcn0gVWi/DS7EsVptJvnN4lIFzRrFFKBNo9dQ8TSJcpSTnq9YOOzlbP36wHgvzgd
         zY1afRAdaeXsK7Qri3buK5ztJjI80aR/kCO+RncNW/LIKHElYGx7pRZV+Vd3ZvgV66Q+
         vtI9kpvkMTZOvc7g8PE5heNew4acFLeXSWd05gR2XuQDatHtjvmVvPnhQcxrUiw0Pa9B
         phQA==
X-Forwarded-Encrypted: i=1; AJvYcCVnPVNKrj6saBI1WfyXyqGtT2ZDL0sMcMTAPeH20U2dG6cP4MSQdMiysdHc0BB+Fik7EszuDZDGHIuh@lists.infradead.org
X-Gm-Message-State: AOJu0YxtEgZjVKWSi43RWfi+LC9VKd2Hs+/oBy+9mt8lSPnfjcrnWbHL
	xWXQBeA/PZT2q1dk/3z8WhJE9VTRVdjagOCg+q8zeUQLsyQ3f0z6f5aKw5SRRCQ=
X-Gm-Gg: ASbGnctoXRekYviaw6kS4sKV6SeypJ9wIZTvL1IlujIdIQRG/idXn7MoeG8Pv9B7ibE
	03GAqqZUijmcygMckvCu4IXO8jxtE3IkYPwiHg5KNJHGoyVLseDJ5hgTjjHqnTn7E8AWwhvga7p
	K611AT62jzbaNt3QDsVHvT1lLKGqwkvLnlItK8T1RmgaPwsDvSM+IcB0lvJ9v1ekAocaET5KL8O
	+a8tAg+PUu8ViJgKowccVeyQEdnA2QOnzF7NpRoZKY2dREf2H35E5LmY764gH8Uai7h6b4Iv5zB
	x7XQVx1/23n+F5W+FYxowJA9r/cnJLcrSHy2WZ6XWqA3zwdo
X-Google-Smtp-Source: AGHT+IHIRuRCn5egZBsOPgCsa0klPEqz/M5zuoaBUYj+b9wi0hp8Qj7ANdB4KHlWZkpvOWGbx5p0cw==
X-Received: by 2002:a6b:e706:0:b0:85b:5c9a:a9ce with SMTP id ca18e2360f4ac-86489d5e7a0mr441239739f.6.1745944787611;
        Tue, 29 Apr 2025 09:39:47 -0700 (PDT)
Received: from purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f863149aacsm351917173.111.2025.04.29.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:39:47 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:39:44 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] nvme-tcp: fix possible data corruption caused by
 premature queue
Message-ID: <20250429163944.tvyrxt7z6c55abk2@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_093950_166521_6F8366C1 
X-CRM114-Status: UNSURE (   9.17  )
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

Changes in v4:
 - Change subject and add "Fixes" tag per suggestion;
 - Link to v3: https://lore.kernel.org/linux-nvme/20250424161438.g2fyo4ozvburf2rh@purestorage.com/

Michael Liang (1):
  nvme-tcp: fix possible data corruption caused by premature queue
    removal and I/O failover

 drivers/nvme/host/tcp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.34.1


