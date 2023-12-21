Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05EBC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LAI0jsh6SWrcabJF8hWdobV/wROal7owUXw1c/yxXi4=; b=ngH0YEflI4qnnqT7KKFEuPd4JG
	cdFIwRFqvwbZRLaKI0cGiDOwLpA2pjHX8Nb3DfFOjcbG21RE+zF3tKN2LuM6Dmp6FOAK4KOxVNkHP
	OcQAv+dHE7RWWn3OUakkB1pZzILGkHls7c3A6ua+hXzapoaPEsusdNXhdBD2OmEXWWc2upvegkEPq
	2RSAPx3srCL3MxiEccIHjTTQXPf9JfVXxtZyoVeGL/tM79T38Sx+rg2nOEOrtvYK+8W+BDbi7pi3m
	of7LAbEx91NE3KNyOI4td3+Zb8WIXgcU8tuyhc47XbxE3IhAW26bLUb/cSn4Af1kuFmNzRBptXY4H
	INu+/uvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlL-003dh9-0I;
	Thu, 21 Dec 2023 17:23:11 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlJ-003dft-1A
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:23:10 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6d89f278cc9so772138b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1703179385; x=1703784185; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAI0jsh6SWrcabJF8hWdobV/wROal7owUXw1c/yxXi4=;
        b=SyfsnvjDVnwH7CA7CyMUCqMfXpip0dMsOHmcJBFaAFlYqwsBZ0sYQp1sIpU2kOyp28
         mGWn7ynF4GZmRyWJq8/3UC9CWP5kIugGCFCiAv+UjJp6zuG7SfFKS5XrNxarovA0ACbz
         eiklrKXd4H7XCudWVKKh1iEckqHZZLL3rExvO5BghWvPIkqUzrt8NKFe5UZkPzPzXA/A
         L+UugU7dAENwaL2AbS6wmM7iVQ3+0xo0XAxdRzjOMGIvyHC4wz2mFPKp/vN07X5Zr7RT
         RkkYezVn9Z/mNDqwlCF76JgXnMlgq7K2kXrcAbMSQSQe8ohq24MIQ6ZnJ5WlpSMrl6Ob
         bpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179385; x=1703784185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAI0jsh6SWrcabJF8hWdobV/wROal7owUXw1c/yxXi4=;
        b=Tx+xDUkUcAmy6G3N7UjUFcUDow4rY8FRai14P28za+tB9W7YSqDm47UCIhdtbJAdxb
         yE4YnHP+vGa33CaSutXF5c74LV51rO9/d1L/5CjYf4lPgWs1FmtEJcS/hz/74u78ycfD
         wzXkeFZxbmQHsGaeFApuaGGmZXQYwmmWJE2rmUfWcS1tAFFojT6afkGQKBaWvSjz5VFx
         9l274nBgo38UQWf2RqwIc62teYd+f6X9OrnIuUMP/UvMAYhvSgqMThFxlkgZQ5HUtdyG
         9XDb81i4cYJRrbhKMHShYBouj10DFzK93EF80Wg7rbIpz/5CmzKkHnZHNc6bKUqedLQ5
         3NJg==
X-Gm-Message-State: AOJu0Yx384Gj7r47xQp3YNY8QKD/b0AtyUGccHPhHPnlPmCCWJxm+V0I
	FYoSUQbQWR8yACujTkD8gsNDoyFNWR/zqg==
X-Google-Smtp-Source: AGHT+IGh/skYKdciW8OQrP2rhVMUTL5Ejn+khPbzmTt1jl6yHnE3JR8rRIZA5IRNPpXSGk2qDZQt2A==
X-Received: by 2002:a05:6a00:1254:b0:6ce:e48f:139a with SMTP id u20-20020a056a00125400b006cee48f139amr1170366pfi.10.1703179385689;
        Thu, 21 Dec 2023 09:23:05 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b006d6b91c6eb6sm1990744pfb.13.2023.12.21.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:23:05 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
Subject: Make NVME shutdown two-pass - Version 3
Date: Thu, 21 Dec 2023 09:22:53 -0800
Message-Id: <20231221172257.2234320-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092309_404091_5DF08791 
X-CRM114-Status: UNSURE (   9.29  )
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

This is version 3 of a patchset originally written by
Tanjore Suresh <tansuresh@google.com> to make shutdown
of nvme devices two-pass.

Changes from version 2:

1). As requested by Christoph Hellwig, don't add shutdown_pre()
shutdown_post() methods, only add a shutdown_wait() method
to prevent clutter in the interfaces. Two pass shutdown
is only done if both shutdown() and shutdown_wait() methods
are defined.

2). As requested by Christoph Hellwig, split out the addition
of the 'enum shutdown_type' into a separate patch to make the
subsequent changes clearer.

3). Use 'two-pass' instead of async in the interface
documentation. This isn't truly async as there's no
notification on completion.

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



