Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856B5FF885C
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2026 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IJfkaLsXPP0uHZsbv1ggW6NsJIHsxgarvYmumurRB7M=; b=SR5y64soIfQwgJCCUzqADoC171
	+xjxkJSkdDtvGNeSOHphaumhr5rdI4Nqee5G+1s6c4Hzy5yA3ruCIdGv7C49lufWM7hv7BOxyCaSR
	6E6wjCQEXFpakT5RwR1LUDOqPeC9UPDYRk51ZxkqsMRQ3FrUQFwBo2nNDMy0mgtKMGrPR/PyIYm21
	b6/ALlLjJCWJOUBjT4GhN/1i8eSsadbaeJcINkkrbSPizVfz9hYwgDhrNzkR4iobezxdr9g8+i46B
	/QY2hnUCADgEvyxBYJHxrIceaAjmCaqKEXqpN0yafs+PGhFiGD+oWNVVY+Va5P9552vyxbYzl0lzl
	amPmmXbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcgV-0000000ESWx-2vrZ;
	Sat, 25 Apr 2026 13:04:35 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcgS-0000000ESWL-2paV
	for linux-nvme@lists.infradead.org;
	Sat, 25 Apr 2026 13:04:33 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so4436810b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 25 Apr 2026 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777122271; x=1777727071; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJfkaLsXPP0uHZsbv1ggW6NsJIHsxgarvYmumurRB7M=;
        b=X2OPGjb/Lw1fgZkeiAAtU6/na9ebG8otJsshifhVCRXXMovtrJnwEHWv1XlL6uuKC7
         08ZyA4TjMw8s1cc6AN+9bj0eJ5OM3XTu2xSbSHL/YURsVYHE3gxcG3r5yIOhHmnuKp/A
         aIqgUpOBJIO2N99viw+y1HNZ7ughpZApYJV1JMJyRrq07wKpowoNeY78RK+6bHc4nDaB
         95ZJI82xbFBQknRpUpuGb9UN9AoT8BCQQG+nkMu2Vk+ST2Pja31oIiVy4wBwOz4+abjq
         eB7Nf+kzAQc2d1/UbU3caHivA7dcztXmdg0lL6N+93Ng70kb78sPPdzth4xzk2oDH7T3
         LP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777122271; x=1777727071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJfkaLsXPP0uHZsbv1ggW6NsJIHsxgarvYmumurRB7M=;
        b=WGdOaeFhB0UHFnqcXP7L2CPhUjuNs2A+YpcQk3GD3N9KwUzVj/a5zFFhHb0hOC+ZQB
         UMTiAW/MFQXF0F/cv8CsJ4xnYST+PMN1J4mHU9E0lytf7OUBOGWWoI2dnUGMGgaUZEJz
         GgrhPA57BuG2Rl6DO3pk2X0p3X2NlDkZrlCThWvAPD5rSCz37rVLvNl4IhetthPQ5ypU
         zekyJP9yYXCURzS4U2pQTld6+en9AQCt0F4Rk2noJFK15dQxdWudb9ouZf3W2ZiqwmPA
         Y3AmJXhaUyNg5/AsTppUvdxTFhwAgO0iEPx0exiRLqFq4y3IyscuyG1SAYp5RPRU0k/i
         nxTw==
X-Gm-Message-State: AOJu0YyWLXK0d0CC/+DX/iD3b9DrTjPJTTrdj4QQb+gztzVkANhxwJ4j
	a1cK823l1OxqNyZeTvwkKZ6vS/oFmu5OUgCPUxQA2lTsC65oHcY8W7cH
X-Gm-Gg: AeBDieus8hAD2rlEzSKv/o2bVTu2kRxwDa1Hzsy4uJdgHxW/05KI7rjp2fb4JoeKJ2B
	vk8NgAM4em0/aFRATd8Ieq/aPeMedo7fn29HAP+E1JhDZbav4jKUniBfVF2pA/RVX3ucqafSWkK
	F7Eg4Ux9O2yu3FvCbu2yyZXzmtERSTA8rGwItIqgslJ3q+tFc0Cw5Q0Z61C7TpdyH4p4E/4C2iM
	h/XgqMPnCmUrMQCLjP8VH+F7+Xre7VVsLDIsPEqlNSnpusrDvH46d1hqAMB6fNM5R8BqKeREOYK
	5OC6hZqK153dW8lPjaMfHXtVb+uGvIQeS4A0tFvFg0pTw4DlXxylfOofSCeIL2+M3pkzhb9EZgn
	JVgp/S5QroZIoYKMcwLM1H9yolgSGVje5Wh5FjgZ9TGJ2HQ20ygXGLv9nOyj7oAKANo1+oC7x4j
	wQICEl0eaY365UVF6P4Xvch2Sae+zXhJe5lH+Kf2oOa4iKqGPW4LfRbeNYhQ==
X-Received: by 2002:a05:6a00:845:b0:82c:20ba:1570 with SMTP id d2e1a72fcca58-82f8c9024a2mr39558007b3a.29.1777122271346;
        Sat, 25 Apr 2026 06:04:31 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:6ec6:dcf2:7610:e61d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0a97esm32302802b3a.27.2026.04.25.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 06:04:30 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3 0/2] scan_work improvement
Date: Sat, 25 Apr 2026 22:04:11 +0900
Message-ID: <20260425130426.10061-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260425_060432_714985_C8D013A8 
X-CRM114-Status: UNSURE (   8.48  )
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

By the scan_work ns_list is scanned then updated to latest NS state.
For the ns_attach and ns_mgmt commands ns_list update needed always.
Then initialize known effects to set ns_mgmt NCC and ns_attach NIC.

Tokunori Ikegami (2):
  nvme: delete unnecessary empty lines
  nvme: initialize known effects to set ns_mgmt NCC and ns_attach NIC

 drivers/nvme/host/apple.c |  3 +--
 drivers/nvme/host/core.c  | 20 +++++++++++++++-----
 drivers/nvme/host/ioctl.c |  1 -
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.51.0


