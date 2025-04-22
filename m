Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87319C369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gG9ubyGdNF+k3tFycmy59fjgpr52bVfS4Acl0aGZAog=; b=DmSTL1FJ+cIgJL
	NaqywaA759dSvc5wNZHr0gS+omNUyoG9BhevF5V8rj2blKHz9/V56uvMxMT7Fk5xTmzH6aq1ugcFt
	vaNGTOB9hCVC7oJL1acvF4/HFgJd/JvA4DrGUvmAJWaepdMtXpwPsgUBUcb87CcHNQ0x3CzDEcl7f
	UP+a0MYESohlJXI7QjMkG4yMeYGOnPD0TdETNJJCyNjiBnZXOOnpYH7y33VzyuWuMTDPHKtsjqIBt
	kzew52j6IdY3IaeO8r3o2/MYeSPp6NTfBhtOiTH+g/G8oOL1budwS3q0hYiDQfXCHFVntfGtbRayw
	yN/eCzpUA8DjJCCRUQag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GYl-00000007vKA-1IVn;
	Tue, 22 Apr 2025 16:33:23 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7F1A-00000007a4A-1ZYg
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:54:38 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-39c1efc4577so2806448f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745333674; x=1745938474; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG9ubyGdNF+k3tFycmy59fjgpr52bVfS4Acl0aGZAog=;
        b=dBMaQzbrffIKNJTvkL5W8DL5SWf7Oqt9M3XkQZZG3zdaDZWQ/krE0qG/XgAj3oYdne
         9UfVIw0uP9Wpg0AD0aejo7pOjxW96aSqM9Aif8jW6LiiBJdMXLphx4uijh7DG7wQvpGa
         euVqOHLi/FKGB8dmMggnpxsTDtolynd8V6F3N7dyaid/KBbVtlp+MPiqQ8qXQ3HREaDD
         nquKBGCYR7BIREWBpj1UXRVKWsMhWXhzZRbyKMo8HCbDkkuTMRdVWKGkg317jTU98rLi
         pjxi5m+NknmvBxm/BhJLQexU16rGK3yyAfyCcyuTFCpS+eRPAQtvwRbm36vX75G5iQTi
         EgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333674; x=1745938474;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG9ubyGdNF+k3tFycmy59fjgpr52bVfS4Acl0aGZAog=;
        b=u2rby+Bfch56p4EMZ87opzgHRTDm70COgTAVnwmr+/FLc9EpUFt54s9vkqMCq8l84O
         eIGH5OH+z4THkDSF2wwiwXtxJoepvZK55AowmGlhNoNaNCzKMsZqxmx3IobIeGxPLDAP
         ry9moSNxPLjh5w9vFuVOtFvEqYcxAOgNta3ilfv4KWhqH0JVT67Agbuy4vAif3FGlMYE
         G1cR6OJbIi+fAy00LwVM6OpAxffb2kDe9TqJC4Kwo01X4waGsPga6ZlxznWPHXtmmU8s
         U+aIQ4iZKJsBpYsZH5FgyCTnr5wDhlGxsPl2dPmdtFvBdWN5geCOda68K4H3Q++pLbHW
         BoEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5KIJgmLPbOLlXJ2xl2Et6DqVRWJ2aHgzOCN86+o4jtWbjGbb1f7Go8nS9YuhcdrgoD2rgaBv32Rdg@lists.infradead.org
X-Gm-Message-State: AOJu0Yzsh8fe8sHLv+3AwmOd4LjbVK7lTdjk9CI46rJJum+gF+D+azfV
	IN9ulhRQ2oPbfqtrBmnl8BpAkvQmp8OMPufQ0BJ/R5J/fGKUi1ZNbNmkW8onry8=
X-Gm-Gg: ASbGnctgw+pqJ+KogCyubOUJxL2SNDZDl//pV9V1CbxCDz6K7Yxrs2amsAWoczWQlxZ
	+KYaNGNfnNt+ceSUirQbCxl8ZE45rWoCar3vKjIPSye0N6TqXf5MrUcS5Akvke5IwzGyTM7xMhJ
	lcKFhU86/GcYBS258LMwCwK4QJeMCiyq4vJYgLHX02lwEdlhRWVap9DtZyEbmBoO9VrEXwxBzsa
	o0aunBc6SVoyTvNBR5lmxfhPKU9YW77pfChORTrxYp8IB5dlYehozOKRwDNabWL78826CZUHeRl
	l5FYtulb56lTsvoZxUb4EPtKweCQaZMQDAvQy0K43YhIDGL3/SutBkz2FfK3GdMmCw==
X-Google-Smtp-Source: AGHT+IFiry1aEcsv4RSjsJlDXhIh520EjsJLXwPy2Ze0MY+e/aA2sn5B9Azs+BhIspTbKr+bPv5+Ag==
X-Received: by 2002:a05:6000:2281:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-39efba6dcb8mr14706176f8f.31.1745333674270;
        Tue, 22 Apr 2025 07:54:34 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5f77:7d42:6228:3358])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9de9sm177304635e9.6.2025.04.22.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v4 0/2] PCI: endpoint: space allocation fixups
Date: Tue, 22 Apr 2025 16:54:18 +0200
Message-Id: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqtB2gC/4XNTQ6CMBCG4auYrq0phcLgynsYF20ZYRL+0pJGN
 NzdwkZjNC7fL5lnHsyjI/TsuHswh4E8DX2MbL9jttF9jZyq2EwKqUQqgY+WOI7c0x25bqnuO+w
 nXlagjAQDQgkWb0eHV7pt7vkSuyE/DW7e3oRkXf+JIeGCIypTgEmULvXJ6Lkl4/Bgh46taJAvK
 BPZL0hGyKZaVCazV6uKL1D6DhW/oDRCkCsoAHOwFj6gZVmey+3KfU8BAAA=
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=5jwVtzCgD4uNjqyYTuvqwhiQR8nTsDDM1aNFemeBRzg=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoB62msl/2CkXYLO9zyFLv1uQ0Yj/jKbC/61ZS3
 7z19ghgj7yJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAetpgAKCRDm/A8cN/La
 heIoEACzFnt6rpj7masrbEMu1F8A9oCj4q9PQWn5yJSbzp9ySmczV8yUCf4bW5FDI4pMN2BRRQT
 BeyfH72Up79X20K+hWqCaX4m/eE7C2F0elheS5MNiShHsS7TzDzP6sytfMyYnv308uOB03JaCh0
 6jNw0ETb3brLlGAlNwV15cGhGZLtzTEClDHPwOj3OtoVXlmEaRJR//5vMR+SeP5xwJSo57Eoiwk
 bfdIQ7QXz47zR8wFC46oc/EvnSW5YYy/LvHsfffRIuavC/e/6gJOlgV+npmzDI3xrcJ6lMx1rh1
 T+WwfNdlSBy09hhpCQLMOmUfAL20Tyes2v64SbkSc3TST3ybbhzH6tO2N/3kuOtfmuAow/GQAOJ
 28eJUpx/tt0IQ/XXfs63Qd3lJH3fqLjhENN4FHVX94LhcAlcv1vbH07SbLXAQi9NyBONqr5vXVy
 Z8ebnH5+QLPfmU57CWaYEWIXnzZue1kWCiTZuQMJZ3iwc9qo2Qfhdtt7NkEpqCWWYZT0dfbImwj
 Y3vNxPzyRXEuLNxWx2oofbHn/B8bC8pi/7voKoqR3Wm/eqNhGxIEl5+1OXiVVVeacKw2HLsxeye
 xvMZ8a/IypQ20/VrSTxJhgvxmZkAzOYU4v+MpidhrkAksGFJVLjDsCa9CsTLb/NUlM5deHvYRJm
 67VQCvd59/k2aqw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_075436_681115_BE225D1A 
X-CRM114-Status: GOOD (  14.72  )
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

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Changes in v4:
- Drop patch 1 of v3 and add new .aligned_size in struct pci_epf_bar
  instead re-computing the aligned size on the path freeing the memory
- Link to v3: https://lore.kernel.org/r/20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com

Changes in v3:
- Rebased on v6.15-rc1
- Fix build issue with newly introduced nvme endpoint function
- Link to v2: https://lore.kernel.org/r/20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com

Changes in v2:
- Allocate space that match the iATU alignment requirement, as previously
  done.
- Chose not to add a new member in struct pci_epf_bar, as initially
  discussed. After reworking the code, that did not seem necessary.
- Make sure SPAD registers are 4 bytes aligned in the vNTB endpoint function
- Link to v1: https://lore.kernel.org/r/20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 drivers/pci/endpoint/pci-epf-core.c           | 21 ++++++++++++++-------
 include/linux/pci-epf.h                       |  3 +++
 3 files changed, 20 insertions(+), 30 deletions(-)
---
base-commit: 92713f0ea620bbe923eb4e7bda408e5c79597cd4
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome


