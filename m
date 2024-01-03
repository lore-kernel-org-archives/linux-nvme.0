Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8518C47073
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uRJYGntAZzd0MynqzCR6yiO3mhgUEJ3DnwvWNNhxg20=; b=3zpOVpZWQs7y763iMg3V3i2vf1
	6dTtDOxNB8TuErvEihgAxIBWYnOdYVn3xUa70EkkNo/zK59HVRx25juWYHqCTG9Yc3gAvEGz/Iija
	3J4qi/cs5Ef9+OC+QNnTFJtKZ3Yml0I3x08vZmlN3i+3bzEsSbp67MDS37E2LVf3dpIpeVaJ7D4r2
	lggVpbMqaG2k1JZDsZLPKOY0pO76Hr5uIJv1RYokjRG7wBtbqn7DmjqyY3zLIbw2+L1FlHIoLxAZA
	aJZJjONW7aktCpLuLUeY5jym0f8/VJ21CsKMgw3kZk71JQVz5Tpo/2FaUy6j4aQivcFO1PQZYVISb
	ejUiE2fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PS-00C6nL-0x;
	Wed, 03 Jan 2024 21:04:18 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PO-00C6mD-2L
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 21:04:15 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso5998315ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 13:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704315853; x=1704920653; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRJYGntAZzd0MynqzCR6yiO3mhgUEJ3DnwvWNNhxg20=;
        b=j/E4P/R6s8cJRhkxB2eeG4N70bhba1KybspXyqcnHL2LEtiCq/tm7EK17/q3DTqrVa
         aQOUlI3yngxfb/l8QcT0nhtcDQOWPQvsH+gVW5os5dn/uj7+milcM9rYM40X89l13340
         sH4uAzA1T3GATQiX42y6qC3Ihu/e5TIYH8nMJ/qLd78aq9D6WKV+ukH0BzLtdQDF52Wx
         peVAWU0AvVPVXk9+ceviFbdFEpa0XUeGJOMd2raB+qR8SPXRARUMum0VJrFAp+1lUCWt
         e/B6/j9GRwJejhnoTcMhH4fjgFoxgNFn31J0F8G92lXSEi9wQhzB5iJFJaB821YwP05F
         67aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315853; x=1704920653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRJYGntAZzd0MynqzCR6yiO3mhgUEJ3DnwvWNNhxg20=;
        b=KQTdwSRDxtE3Se/H7lITPpzjK785VHiqiZAjvLbttT0TyVk9jJIzcACCuftUppRx4f
         wsd8/6tqBD8cyAjlmqFICKyHjvNgKrqZJtZUHv5NeYfqTiq7lTWu0VLtppFRFqvzw3Os
         vhv9To6mlbVQVCvbaLl/fq5acKiKcmW+xZyFu3cF5KYirLEGGSpuvc4oCZXRzRiMU97F
         5ryrvX5jSPgTi4/Ysw6GQyeoe0cNOFogX6t3pD7jcebMUO/XSHC8DyaC4tm5p0uabz+s
         P+0nj+7gmlCToR5HQtUcAIcVcc30vismccZjNkrovz3B694APvbuXs/H4gRlyb19v++J
         qUgQ==
X-Gm-Message-State: AOJu0YxfWV9VA9CeGk2ZNIN5bNo/jHc7h7DvBgPjuWxLh5O157tEcCNV
	n+GNY7heCJRJA/cfE1hcJleDnStEsmq1+6+sQLcVJFsDAto=
X-Google-Smtp-Source: AGHT+IFjXDJzvACNcLMWGZOBmbLzE0sucsEs7TSYoJsn1wwTBkDEx84EZQVRSkkwpzXPb9hd7DAsXA==
X-Received: by 2002:a17:902:e54f:b0:1d4:ca30:63e1 with SMTP id n15-20020a170902e54f00b001d4ca3063e1mr2127563plf.1.1704315853402;
        Wed, 03 Jan 2024 13:04:13 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d414a00fd9sm22505837plb.29.2024.01.03.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:04:13 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: Make NVME shutdown two-pass - Version 4
Date: Wed,  3 Jan 2024 13:04:00 -0800
Message-Id: <20240103210405.3593499-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_130414_791407_9B766AA8 
X-CRM114-Status: UNSURE (   8.11  )
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

This is version 4 of a patchset originally written by
Tanjore Suresh <tansuresh@google.com> to make shutdown
of nvme devices two-pass.

Changes from version 3:

1). Removed duplicate setting of ctrl->ctrl_config in
nvme completion function. Noticed by Sagi Grimberg <sagi@grimberg.me>

2). Removed intermediate function nvme_wait_for_shutdown_cmpl(),
folded this code directly into nvme_shutdown_wait() by
exporting nvme_wait_ready() from drivers/nvme/host/core.c.
Requested by Sagi Grimberg <sagi@grimberg.me>

-------------------------------------------------------------
Currently the Linux nvme driver shutdown code steps
through each connected drive, sets the NVME_CC_SHN_NORMAL
(normal shutdown) flag and then polls the given drive
waiting for the response NVME_CSTS_SHST_CMPLT flag
(shutdown complete).

Each drive is taking around 13 seconds to respond to this.

The customer has 20+ drives on the box so this time adds
up on shutdown when the nvme driver is being shut down.

This patchset changes shutdown to proceed in parallel,
so the NVME_CC_SHN_NORMAL (normal shutdown) flag is
sent to all drives first, and then it polls waiting
for the NVME_CSTS_SHST_CMPLT flag (shutdown complete)
for all drives.

In the specific customer case it reduces the NVME
shutdown time from over 300 seconds to around 15
seconds.
-------------------------------------------------------------

Thanks for your consideration,

Jeremy Allison.
CIQ / Samba Team.



