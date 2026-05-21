Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC14CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X0nk0X5ql1Aa+Eq592qHsNAZpmf5nSU6Z+1lKWyV7hY=; b=Qv/uXMigA6QfUOGs8ekZhei0yh
	Ucvu+/9E37dmOUousFkDSDP0NjYcub6wWlQ/EIHQUOLG4O35xGZuVjwdCF1+PiKRcq8FaTl0mqpv2
	yGtgNQCW6CsHfCNeInmHIfx1aIFUe8nSKIiJbcTgjpQkczmbVii+dWLYqkhp40hNl6t0tAWorI/a+
	7nEE49bqHPOdOh4KhADx3CMcD3gXzOg7GItEzY1xvhU7Bp4oG/NtBSUFeCoV1iXTCqrrAeRNs/tdY
	IclhQW0zPwOfNF5mjoKxL6OTfSnqEzOufqz7lJIsn4Y0vQTYqvt5atA+Zn+lVS0ULhLauzruQgUtb
	Oi8YCrFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPx8C-00000006r3a-47BS;
	Thu, 21 May 2026 06:43:44 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPx89-00000006r2q-38Qy
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 06:43:43 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4903974854dso1505035e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779345819; x=1779950619; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0nk0X5ql1Aa+Eq592qHsNAZpmf5nSU6Z+1lKWyV7hY=;
        b=FWIS+DbhFHH2vKQAkkP7jiPR5tIKRolCrsk3ccgnV2hBI1ShAtnYIkQskUG17jVxyL
         CyugnOHIHNhJCNzhNjFzEXPU5+0DhpIl6xNmJvhyjKNMfBeAJlYElYDp78vM91vkhIbi
         y0qVT56nbWd+CTQ+KUUDdmI+TopfjIEY9KM+RjotzdZ65TN9K6JefyySL5coQ88YrOus
         XPM1A5Ymq/MiE4vaOQxkjm6eTjGPUXUz54M+MWk1rpXf0sjD7Cmif4+srzY9ADROak9q
         eF5JapgYLiPho/zrc+2YpntD0orVlfVJXVtGmH1nqMyKYBT1AhlAWkpO9hqgcpAyGkDg
         6+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345819; x=1779950619;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0nk0X5ql1Aa+Eq592qHsNAZpmf5nSU6Z+1lKWyV7hY=;
        b=fdk8i4G/MbsayogZeOBTGN4a/THpk/C4Qj2ujKZFM6kyAFfvZ37boZJsapWKKwuDYd
         N5Pg3CsHZOgATpQX6KcfXgwUOAk9pJZQiADy8BHDDmNASU3OVb8jgD8I9r6fnyNIOHdP
         mD6BUi1UQSpEhLKgAE58Sy5gSVsm5+2B8O1tp5b61Oyx3Ej013wc9DVhUWzXNiOExk9D
         MF6tlfXc0ap0LF0OX3jeBMO0mGxAflqxRc1EflDaPrQeB6chYwJlq/IvESGTLEEFBQ3E
         hVUFNBWrH/HWmEFTRZ69EyE2kxDx1piLMEPBUNPsUB5hNQi6GuC3KKdfGJH5OTmCBS+s
         Xoww==
X-Forwarded-Encrypted: i=1; AFNElJ+MYR4HwMPB0YDuKY2RynfEPWO3yFLiPBvhLenxvie8e1LJTwaFNW155SaZ8RKpCqfgStB3P4fLMB2g@lists.infradead.org
X-Gm-Message-State: AOJu0YyFPsoTt7t/HGs/e2x0AKg5W2TioJfhZXijtXxhqBcqkwBLV/d3
	THlfwz5ZxsS7OMuf67kTCEZytxl6ug4BuVXpdoi3WmeCpjMFsDFUec/X
X-Gm-Gg: Acq92OGGgbbc06vZoi1RwLq1P9WawnwiTvXSnO4C5B99pwDpEBp6inGit19YsEObqL3
	jpqoC/K51012Gp2MX3XfXWmOr83Dsffk8vZ+0RBhl2/jjV8adKpKXBXdfQnsAi2Mnr+48LhqjAY
	W+s0fkZIe7zdMLM2nu5IQfcblDnT8TnkjvVK/vgvaEoXZCPGBl9f5xvip2Am1ZPaPrnyQ/RwGGC
	TSqnce4kc8+EsayFkBHWtpf5Sv3fFNcuM6igLJtIcdyh5fozLJsFmcpNxznx9OhURcytgNrr1GJ
	Uw/4uE2nTWwzxTudizpZcMV6ctMz11Kwee6XdJUWPvlzR9/jxN1bn9BAP7axA4HH9LY34kCkJa0
	IexfxXP2OzClJlW8tPrKiIqDJN1q6MHMqyVprPucAYsmLe8akCpdRxXuGjyKyxbaFT3sJuk1FAa
	2tSFqgMda/Y0xwgw2ffrbAcKuzu1ugw2XFTg==
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id 5b1f17b1804b1-490360340e5mr16868235e9.1.1779345819287;
        Wed, 20 May 2026 23:43:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e25bsm45607445e9.11.2026.05.20.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 23:43:38 -0700 (PDT)
Date: Thu, 21 May 2026 09:43:35 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Maurizio Lombardi <mlombard@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-7.2 2/7] drivers/nvme/host/core.c:5259
 nvme_wait_freeze_timeout() warn: 'timeout' unsigned <= 0
Message-ID: <202605211257.STzj2Ujv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_234341_801570_D48ED08D 
X-CRM114-Status: UNSURE (   8.80  )
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

tree:   git://git.infradead.org/nvme.git nvme-7.2
head:   00d7b33351aac0ea55d17167561e12bbeca73138
commit: 23b6d2cbf75ff15647efbb7c0e5c03bd7ed1fe1a [2/7] nvme: remove redundant timeout argument from nvme_wait_freeze_timeout
config: s390-randconfig-r073-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211257.STzj2Ujv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
smatch: v0.5.0-9185-gbcc58b9c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202605211257.STzj2Ujv-lkp@intel.com/

smatch warnings:
drivers/nvme/host/core.c:5259 nvme_wait_freeze_timeout() warn: 'timeout' unsigned <= 0

vim +/timeout +5259 drivers/nvme/host/core.c

23b6d2cbf75ff15 Maurizio Lombardi 2026-05-14  5249  int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
302ad8cc09339ea Keith Busch       2017-03-01  5250  {
23b6d2cbf75ff15 Maurizio Lombardi 2026-05-14  5251  	unsigned long timeout = NVME_IO_TIMEOUT;
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is unsigned.  NVME_IO_TIMEOUT is 30 * HZ.  Can the &ctrl->namespaces
list ever be empty?

302ad8cc09339ea Keith Busch       2017-03-01  5252  	struct nvme_ns *ns;
be647e2c76b27f4 Keith Busch       2024-05-21  5253  	int srcu_idx;
302ad8cc09339ea Keith Busch       2017-03-01  5254  
be647e2c76b27f4 Keith Busch       2024-05-21  5255  	srcu_idx = srcu_read_lock(&ctrl->srcu);
6d1c69945ce63a9 Breno Leitao      2024-11-04  5256  	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
6d1c69945ce63a9 Breno Leitao      2024-11-04  5257  				 srcu_read_lock_held(&ctrl->srcu)) {
302ad8cc09339ea Keith Busch       2017-03-01  5258  		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
302ad8cc09339ea Keith Busch       2017-03-01 @5259  		if (timeout <= 0)

blk_mq_freeze_queue_wait_timeout() returns 0 on timeout and >= 1 on
success.

302ad8cc09339ea Keith Busch       2017-03-01  5260  			break;
302ad8cc09339ea Keith Busch       2017-03-01  5261  	}
be647e2c76b27f4 Keith Busch       2024-05-21  5262  	srcu_read_unlock(&ctrl->srcu, srcu_idx);
7cf0d7c0f3c3b02 Sagi Grimberg     2020-07-30  5263  	return timeout;

This returns is nonsense.  ;)  >= 1 on success or empty.  0 on timeout.

302ad8cc09339ea Keith Busch       2017-03-01  5264  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


