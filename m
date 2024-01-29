Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0EC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bfmAPpL/xwg2h0wQSdY/T3vExu3s0QeWwjOyAWmsjK0=; b=xj/v5K4XmrRfvJgSy3fWuyd1q1
	U6DOMzZkfDhwVo04Z5qbUJ1FnBrk59G9z16QRSWuL8CU/Wh4Y4YC3kc/ikVAhGnOv3p9ccFencpBv
	a3JrGKh90V5DPOTDN2AOCAm0XUA3kGgSitABoK/llUxr/GptaXtZhi+ajA/qX64lONlDaF27qxjrA
	NZB04SHzq62sxP1dFFf/jszxxAzcd11RyW0Kb79UvRHgFmhPjhGKGBYK2NP89Uxnhum3MrOCgqwYS
	OjyR5jrbVd1Ajh7AgbKJ0a/53lMaGypFQRYlWs4QPvBGJ3W6EuVOXCfLo2pMpoOOXj2eq81dqOI70
	6RHKQMDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEl-0000000DuQv-01cH;
	Mon, 29 Jan 2024 18:20:03 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEi-0000000DuPl-2RTM
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:01 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso2411737b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552399; x=1707157199; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfmAPpL/xwg2h0wQSdY/T3vExu3s0QeWwjOyAWmsjK0=;
        b=KwVLvX+V5mVFAb8Vs4yPwtoGQIt0sB4TMribLSiv5dL91IJlyNyk+i/v3MjG8Obzgf
         +YGlD6AxgFEblk3ACnNwE1nXnwaxKSo5BeJD2vGUwJ3hPXuHmOuBDOQ8JlFRx3dCYizW
         ZUv9hlnfH38bIU0hqAxQICdnnCGiZJpe8S8X4tV1XQq+zyje7hZQM3tmipTLKRLhP1Od
         EwhiEzoGOLXx0toWzCcXjY1Xj2lK4bZ2Ng6mUsf9WTz6C4IVrSz7iXJubOTry1m4BoHY
         bHOklA1RZvk6juGI4O4DOtdxSYF2sk5eJbL8AilciYgVvgGErs/DgHbccPcuYkM9tlea
         zDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552399; x=1707157199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfmAPpL/xwg2h0wQSdY/T3vExu3s0QeWwjOyAWmsjK0=;
        b=peDdGO9hc/r8dpT4M/0ZcRiFl06L5pyB1RakE1BflgVZZKMRsyzTOTfErSGE9/COdC
         0DYQdGA4+jF3XkwqarBaYo69vKohxx8YNQKxPcoIVXDr5nVREgu75vTkLP9H4XtaHJs+
         0KpAU/8BEWTsfQsAgCLwpwp9ihSASevdS77v+pgpql2hROXfru2EZe7s2ZEToQnC/drK
         wDZaouQRFxwD63JTw+j7X5agJT6cly2UNBwhpSq0lYtoOS69k/ylcRxQaTG4QIVFfUcB
         KD2zaEgxJBJulFPURAw8whTOthYvsLaVZ5o6D7TQqDjGnmAkkFFA/685e0xoEzLJmJRQ
         4e6w==
X-Gm-Message-State: AOJu0Yx55mztacmJEBJfomlOvbysLaH/NLxUwii5KWPPEoe7D6itKc7q
	FaolNadYWpqUw2wCbHLq/ucssx7kWnveXdcV4ae7O5BbKRO/TGpFYpEfkmYyhzE=
X-Google-Smtp-Source: AGHT+IHYRdC5E5G3g2MqHF/pKQIrb0sjkHGDqEcofWVOOBI2LMH7ApFg+VgLJO08E5VAK0qn1I4d9Q==
X-Received: by 2002:a05:6a21:2d8c:b0:19c:a0d4:bc93 with SMTP id ty12-20020a056a212d8c00b0019ca0d4bc93mr4123792pzb.31.1706552399427;
        Mon, 29 Jan 2024 10:19:59 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:19:59 -0800 (PST)
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
Subject: Make NVME shutdown two-pass - Version 5
Date: Mon, 29 Jan 2024 10:19:48 -0800
Message-Id: <20240129181953.1183084-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102000_655875_2863752A 
X-CRM114-Status: UNSURE (   8.98  )
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

This is version 5 of a patchset originally written by
Tanjore Suresh <tansuresh@google.com> to make shutdown
of nvme devices two-pass.

Changes from version 4:

1). Isolated 'enum shutdown_type' change into
drivers/nvme/host/pci.c only.

2). Added a new function: nvme_request_shutdown()
that requests shutdown but doesn't wait for completion,
called from within nvme_dev_disable() when shutdown_type
is NVME_PCI_DISABLE_SHUTDOWN_TWOPASS.

I didn't get feedback on my 'bool or enum' request,
so decided to go with the enum as it reduced the amount
of code changes and makes things cleaner (IMHO).

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



