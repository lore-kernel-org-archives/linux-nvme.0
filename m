Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6356FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lIxjR3FPLX688QMW1cWlK5lmUuTks0cMHajAmnAY3e0=; b=1KyyFwapfFwSwDAcTc3buOPIO1
	aKz5YbubknwAUt+RBZTQELKlg+EPzGXpXDtM3SPCuiuqAJixQwGPwVQKvCNj9HluVKXWI0fZuaiIV
	OH25MRiCVMFrpBF6/AMCsUqoT5gWcNgPLuqSj46REo606Z4zJJZzl/7+Cql+ik1t7lECWcjeZD9ir
	YlxBkVH9W1ErMAuwWQFnGYp0zYKGE5Ytylw1/VYF8YkTgLZYRoFv7VLYijrJ3z8j/GCqyQdTn0O1Y
	xweSVaXnh0mbHvjcOaKqJTDD26B76ZlNi+OHulUffAsWnUsQ6KWD8D02Sbe0e8uJtpmcNByjNpM/m
	FCjIu4uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtGNR-00H3mc-UQ; Fri, 03 Dec 2021 21:45:57 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtGNP-00H3l1-0O
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 21:45:56 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so5961397pjj.0
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lIxjR3FPLX688QMW1cWlK5lmUuTks0cMHajAmnAY3e0=;
 b=2E2kBEtHQXlrmkm7xX1wGtqNhI27jIRUYTlp3ioRfomf96lCS7vS6Oda8KnhMPjR+q
 5OQ3zVxIT3ndZbkNsCD5TB5U5EMl/AfhoeUJ9z7GTogTz3zoPEAWm0AHcwLPPmhrqv6L
 INbHl10vLhIzAUu9iLxnfNGdLFCn8yiFxMnuP7ZcwAhwQvzMRwgxpR9GQadzMooUpBXU
 qPqGugKqb1XRy2+/QaPNzEWW4rvPI3p5Y9XpEp9H/NgXmBNsn5gl8SczSmKNej+xvcja
 P7dAiISqx4rdgPmOSMGp+wjjDmSxkGgF7ggO2Z4LuuET5d0jGjhJZVPvFbctew4XxhXs
 p6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lIxjR3FPLX688QMW1cWlK5lmUuTks0cMHajAmnAY3e0=;
 b=Ef2yMT7YLxotaBCBdy1u1qGPjrIHRQKcYFmawLePucimpqKAQK8fnbI37KA7L7sSRX
 YtRVGrNP8PTpA8oDcuS9+1UFC7HNRa+cp5i109AFnYyfNeG5n0C6RHOSOh48Vc82zJ5S
 tCyS7gyx9krZG+IRoagSnYUGhsOGIzS1qZA2WfPUYiHgRAF11Q2BpWDcjSLDYUyrcmOI
 UfXGusIRqAQUfoczJUzL4LapN10GJGdxYRa95GJNPQCggGw1wTYdfQDKcTAnb5WOPB/F
 OnG2nHmvNF+qCNeALJV/n9jr5G20uANDj1qHw9ToecbYT0jRA5wN9wkerzY0IQ6buM26
 E0og==
X-Gm-Message-State: AOAM533aHRpTVqiHAnqAbX6DgmTfvuSuARZWTFV1sUXllXRx5ik5m5fX
 ILRTPtWivJcdMaE81wPJfr5Lb//kahTI4I9s
X-Google-Smtp-Source: ABdhPJxUu/Evwa67mjOdElNgoK5Q8D7SfYw92iHnHsGeQr7go2JhNqDUUTLx29dne4Ti2IFMTiDiLg==
X-Received: by 2002:a17:90a:5b:: with SMTP id
 27mr17302729pjb.148.1638567953400; 
 Fri, 03 Dec 2021 13:45:53 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 13:45:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET v2 0/4] Add support for list issue
Date: Fri,  3 Dec 2021 14:45:40 -0700
Message-Id: <20211203214544.343460-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_134555_123205_EC3D35F1 
X-CRM114-Status: UNSURE (   8.12  )
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

Hi,

With the support in 5.16-rc1 for allocating and completing batches of
IO, the one missing piece is passing down a list of requests for issue.
Drivers can take advantage of this by defining an mq_ops->queue_rqs()
hook.

This implements it for NVMe, allowing copy of multiple commands in one
swoop.

This is good for around a 500K IOPS/core improvement in my testing,
which is around a 5-6% improvement in efficiency.

Changes since v1:

- Addressed review comments
- Rebase on top of Ming's hctx lock change
- Clean ups
- Bypass for shared tags

-- 
Jens Axboe



