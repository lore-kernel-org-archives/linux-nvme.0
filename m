Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCE9C83F27
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=io7xnfs7ZwmTYZN/t/zWcB1a+2GG4fTJlMUwgJIzIWk=; b=4qdc1bx3MCBg/L0f/3A+ySxDdx
	2Ni0k8vmJYzR4mL4hpg+4CEFAQEocARSzcttxVSMGB6JN8sHfe6fYfMQjUniU8Wg6rrOJhCGfCfay
	UsxXTXwb8p4G7N3+fOR4viLv+wDlbdlhuaJhlOGPcvbWp1+qhYUvtcgplL75YnALk2c2awa6UI2sN
	DFfOqXs+jYnVED7gXXPX9nHWaskSDTUgE0NlVy2rzbRPqq+Tk4xS9PTAwcY8nLPhDgyJ9psqF6kLG
	SYrgNFJMSVtZLFiGN5x4kEwYURVx9XId0+uLDFwjE4T2XuKvdYWNq5GnA+4dfzP6DO+WuUyjVu06H
	l1g+OR4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0SB-00000007ZqQ-2h6N;
	Wed, 16 Jul 2025 11:37:39 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc06T-00000007X0v-0E4R
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 11:15:14 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso10823923a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 16 Jul 2025 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664511; x=1753269311; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=io7xnfs7ZwmTYZN/t/zWcB1a+2GG4fTJlMUwgJIzIWk=;
        b=ieCIhA8rbTBc2t/NEN1yb/6u+oLSTsDCM7Flnn3uQ50anCkfEEMEe9qXcgfxLR14zA
         IAwdPiwLWSI/DCtJs1r221S94wLNawz8VwsUGsZxeEf470t+c0FN8CS9suiIljCIjVBm
         4Y0rjbNwT/q28jd5Z5AiAvu0XpPHkxrauNZu7qmfL4hKRpyjq7KdW7tPpyL0h/mmqTQ1
         wHnVBSE/bf7bl7HsU5NGz0DkbBluv3b/qwgTk8cplVFkIdgOo+lMESn0ERafxrZ8s4iZ
         8QuUUtx4WLZoi8BMEoDaGWQOk+rjdOdcaITu2VxUC0SQaVoLglACknP8zmhaJMr5BROB
         LdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664511; x=1753269311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io7xnfs7ZwmTYZN/t/zWcB1a+2GG4fTJlMUwgJIzIWk=;
        b=p6gSbB4nVdAKpfsvNLvoYMAIX4ssurLvGiOkpH4oLHNA3CCZDRs3MFhTDRXp/IgUr5
         QC42Rv48tGLq01aZSRBz5RUuiUez1MV3BzOtn/s0I716OnkAd/CnLr3JRyhdlWUVZtdc
         e8kcs7kBZYGnVYxtZjN/ggVBn1Mu28VY4CC33EfdbLUvdT8OXOTxrP9czztyD6jKgQAz
         jrjL7d50E2yJESxFkmGyq8SqRhLafeRfqg7EfRn2niDYbqDvxhf0tCDPAcfeSXKVehnA
         DQmrRAxSGJ3RNeM+dAp6mIJzvDka4fv1GROCBp4dQn88RqC0iOa3zITiYmekWVNxK4o6
         kuBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWuhX/onbaQ1eqOiyxgNMVQRkSA7P8fb2Nrk6qHY3vqBqz6kxt+KungUCPCTIBgMhvQ94meLTcVPjc@lists.infradead.org
X-Gm-Message-State: AOJu0YzshK1K0IOGmZwc1QaV2nTtIpP4n437RrGZ9KkwYaDQa6AAASVk
	940louJA+wzlnDp2+93No8KJ/fxfdkkqgdYmoYoRI3TcLrpYX9YACUlDdK5B2FyW
X-Gm-Gg: ASbGnctdQl6KflzWIAvcZxEAybHXtEucIus2Bg9gFWh36jGJeZlNGYTsvh8gdJ7Mbfp
	rTKrOiR+7G+v6JPBeNxH6ZR7RoTmNSFtW04ouT1V+QnBYHEzczYrMDOYRT2h+Qmh8O3wNgzmUSQ
	sWy2ENxGnnftYOSdmYjaGeal6VGemHq7k1bqjj6mkbzYTFUyPVM/jkIn03XLyj067P0IiKKyb+r
	myfsvdEX5mUtLKOY5YbLyMGLWoLuASMak11xK/QEPGdmrIWBp07Fs5dwGBlvCUaNfY2oLS5Nxzu
	VyBEzGVUaDbPE/RoOkT3R+u9O7znrr2zrdWZFnIwnzObT6whA9v4AY2zmWh0QvWPI/ssre1ZNuh
	2WWBwfK1vLh1xw2boY4lFdMoqGW575Uf5lIFiCX4fOGsQ38I0
X-Google-Smtp-Source: AGHT+IGlmJIjo/68lHst/glRTYFQLAFf12jb+hMUf8o3uOa+2mrtHC9N9zXMrTgPAT+9voLRv5rVoA==
X-Received: by 2002:a17:907:6d11:b0:ae7:fc3:919d with SMTP id a640c23a62f3a-ae9cde595a2mr241914066b.25.1752664510574;
        Wed, 16 Jul 2025 04:15:10 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1175217766b.152.2025.07.16.04.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:15:10 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Wed, 16 Jul 2025 13:15:02 +0200
Message-Id: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_041513_096098_85A70263 
X-CRM114-Status: UNSURE (   7.81  )
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

Changes from v1 :

- Updated comment for nvmet_pci_epf_queue_response() per Damien's suggestion.
- Fixed typo in commit message.
- Added 3 tags in commit message:
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org

Best regards,
Rick

Rick Wertenbroek (1):
  nvmet: pci-epf: Do not complete commands twice if nvmet_req_init()
    fails

 drivers/nvme/target/pci-epf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.25.1


