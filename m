Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6737DC369D1
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Apr 2025 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGfvwG0lJjJnssDIjMncK4zxO5Uxbjv3u3y95m4bzb0=; b=cmYcn/JAitTTTPAh6UpOUtsb7e
	tnBl8vqIH5oaXFsEyGBmGEPbKG/tJWSQabp0f70vXLptOfd+5gmdR+lEp2f/aGlcEa86emHc9UQAi
	ZxPFU7R6PTmM3v5Nv8Fplru4qIZeFnepRIXj3FpPXEiJ1Iz9OZ1B+uRLtoE2K7iA02AqIJUJvRbj2
	b439kpUGjbYkLIbYQhQfjGI9dbLxk6xxzSVFvWgKDUuKaSx9QSI7Mc7xQeREpd//EHBqIz/XP5Qpm
	KhWKV/5m3AkeGsPRMf6M5TK8eZNs810YzKjQzkDB8AB+q7yEscW9WftZ74Ld81rtDXmoK1EHRwmey
	UCZAJaTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u95dt-00000003otv-3z0f;
	Sun, 27 Apr 2025 17:18:13 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u95ds-00000003ota-0Dl7
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 17:18:13 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-308702998fbso3286683a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Apr 2025 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745774291; x=1746379091; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGfvwG0lJjJnssDIjMncK4zxO5Uxbjv3u3y95m4bzb0=;
        b=B9TwYPxbN8u1OY1iaF2C5xd9vmRxY1wHB6CSSl+dajt05PWMIKxMt4iAhJyuJ8mmWv
         d//uV3Ggm9Da88z+r+DbuF7Dse1RL8zedcMx1ENj+OeY+gSCRxSagSGOejmxqgTrhtpO
         dnuWJzZek8DzYD1Pz8TGw9IR5U2+Auggx+TknSyrviqr2loXGnHZUA7OXeCfwKyyPeDK
         d0VYCdZIgsL1KRwIrBMK1ePzN++S6K4Us0yMhtjpuIsQAKEnZt3SuW3Y/EH8TItfYY2Y
         OpqZpBTwUvGlfFNifRt/lhHUNp3Z+Cj2HVWjhGH7VHhABW2XKHrvLGdKPvDzdOpQeNDC
         MsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745774291; x=1746379091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGfvwG0lJjJnssDIjMncK4zxO5Uxbjv3u3y95m4bzb0=;
        b=jz3l+w1FttnSmcBbBcjDRpPeqNZlFa6mWOHvc4oEsUaLA327O19mExtk6Zy8KxUiDR
         nPzu0S5SCU4UOSlwYjMTEL5KxAXzIVP3F6E5cat4ozetYPZ1pEQT3u6Dj1Vsw/BbG8hS
         S69hr/HF4DxRPD3c3rmnhdPdFkfB6vy2ZEntuN2mhQDv0AmGTgwk5t//3nEd758+Jf3l
         KUTtH/3VnFAiXCkdS9VwYpa86ZdFBhHuPk6aiuwitACxzgN40deUCUeEFn2Yo7R1gGFV
         2jjXLBioYNB1K6yjYrdIPOYtmKt0hVJUgg3r73+Z1vo7zhqE4BztDizzvOWQXOYcONeh
         6TGA==
X-Forwarded-Encrypted: i=1; AJvYcCXAzKFidKFy4xo1X4H6CptVm92ZlAFNTLmuBWg1AK5JlQUYiIbVEf2SDfV58fW/R7wLKld+Z6bTdo91@lists.infradead.org
X-Gm-Message-State: AOJu0YzibNrvYIekJJiCN7T1JAO0ar44LMKRTbyYf1n0czFim7JhJnzS
	TQJzgsnW/uzBRO9/hO82m9sH/s627ACN255qeuKxUSdWya0tch31Jbzh4e+n+g==
X-Gm-Gg: ASbGncvyIlBiYIwRLtwtp++muZDBh7pVgPLxgWC4M150zpWcUU5hIF8LIEXnw8TOywt
	i3Y7tw8gj1iBKvQ3yzveIhu+YQQ4KgkhpaE3kOSnSXc+tleALcwHk5zxAo7CSwbfMz3lZOLKLTb
	GuG1PlUtR9X8bZIv2l3oFzR9pSWoa6/BkwnhOMe8u3MTD6D4MO9jVeQQFg3inbCB/TnNI99q88+
	wonlPWy5JoycQCnrtDX8CQD1VD8dkhjTHtOC9RwQ0KNn0snLUC0xjfc/tvV2AtG7G/G4o038NNA
	2/JcOae5/ogotjoM6V0yddEDLzg3FWaLJyZ/iahXrHenepr2EEhS
X-Google-Smtp-Source: AGHT+IGEJGjOrAHuRlC8FW7W5k8PqHO+m0uDpo2VUIDPeTQamnBsMG6rTDTesDmrV+/O1+7KTWI9/w==
X-Received: by 2002:a17:90b:1f84:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30a013075b4mr8795318a91.13.1745774291083;
        Sun, 27 Apr 2025 10:18:11 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7741sm66038245ad.156.2025.04.27.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:18:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 0/2] PCI: endpoint: space allocation fixups
Date: Sun, 27 Apr 2025 22:47:55 +0530
Message-ID: <174577426298.86106.8309026357756060948.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_101812_105479_DC414083 
X-CRM114-Status: UNSURE (   8.62  )
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


On Thu, 24 Apr 2025 10:34:03 +0200, Jerome Brunet wrote:
> This patchset fixes problems while trying to allocate space for PCI
> endpoint function.
> 
> The problems, and related fixups, have been found while trying to link two
> renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
> function. This platform has 2 configurable BAR0 and BAR2, with an alignment
> of 1MB, and fairly small fixed BAR4 of 256B.
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: improve fixed_size bar handling when allocating space
      commit: df4b24b510c9ceac32aeb3ed5904fd93b06a51b8
[2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation
      commit: b47493ff0d43608257a24d65f5b26a4a6376ff9b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

