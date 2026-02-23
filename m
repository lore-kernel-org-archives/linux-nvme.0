Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDEAEC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8Zl7Z+OaO89snmKUAHrxKVDI5oM0jK/483ZZ+xANRJw=; b=wNbLVDYEF37bztsYa82agsL3Un
	XeCzY2CMozf7MSTVvjuCXZP3O/oFkr1HTHmoQG7YaYhfDn5GmOUW4hq5Qf+WEkLq4qvejLOI3kDSO
	z1F2UTLC+rPljz8QAxgZG0O0htE3JzFLm32BET3L8uO6E2LiZFdtYcrbr6sqdtABuCwqR1ooQD/1W
	ECX2G91meXlBSBokReNky/vGOZyqZbcPCUnfJnn2POIU72KE//NBu38zi5DsL/XnA5xDvpOi8lW/v
	r+rB7K/o6CSsE8N4MkTIeymujafhcl1zrLmdlMy4sRoyfEyvXFiZ2DOJp6i49N0cmFVodxz9mwmls
	Rfq+YCSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZe1-00000000lZT-2wkq;
	Mon, 23 Feb 2026 17:22:53 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZdz-00000000lYr-28vb
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:22:52 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2457946b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867370; x=1772472170; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zl7Z+OaO89snmKUAHrxKVDI5oM0jK/483ZZ+xANRJw=;
        b=IQSIYz1qYjnO9PV3cmysNIQGhdrYMcZiKAUnSh7hTGwUmbU0cBmzb8P2+KRdgxaztF
         YKDt2/ik9fmIZfXMfQXyTTKbruFvf/H5R6CGs9a1jLdDda80xpVhGKaxe7C86uK8N52Z
         0RkaRW6fu7KS5Uc3iT0DpL/su9TAiXPqOFgZVTrdS/VFAi1mjtDcE1RIQcZr4DRAhNmT
         z9xKZLRih1iwjon0d8qhKVXRtBh3UoHa8ikT2KDMYZrXQGCwM6kG8JorTzc0NPHoP+/a
         ss8qhbvQE9GWld8T/lCUNlwOFxoEWLCFI+iOcI0v/fReGVRuxa6ep8KhE8eVebSZpcOn
         6/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867370; x=1772472170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zl7Z+OaO89snmKUAHrxKVDI5oM0jK/483ZZ+xANRJw=;
        b=aUc3y5W8YCQT4tSOH5v2hX5MRsQOahmNfjQ9KDimebwCjtoDRtZPq/ig9AmAeSNmPX
         ZUZwlsiF89/raQRDiPo56pP/V5qhKmo3+l86zbrRgEpBSgcznLph/sVqCg5ZRtHubiPK
         OuI/SanZVZLXvD+2ZM51hq9g0IDfzXWqKEhT4GcdL2JlExeduWwNOkZlOfjVPd+Xqt2X
         imEf9ELsRZRg+K50MgtQC06ANQxznZYq7qsVDi0W0Ly9tmd7EwdLR81YsR2sNQQenKSz
         M4Sm1z+PPIPCQf6Bu8PLAPpitI310S3wqNtlJPvRo6M8gA9TLeH7Vq+DJPDl2vkFVLwI
         5+6w==
X-Gm-Message-State: AOJu0Yy1dkgeAWPjnWEn+sMXqKw2q3cqNjaRsx3ZphqjSD5/SCQ4QxDj
	BSHclEaTack8qcgiAYxjfaMiSiAmlIXLCVvdOaXqGKbtAcwNKy/bSK2z9k3X+dy6fdHcxVCuPGI
	YxFf4
X-Gm-Gg: AZuq6aLSK5RTWNGqI53a1sHVNBTXHoaSvlZV6Fl1NSIGIiPjEl/OtQWGhEG8NbEEt8F
	5ONgWEZ9c1PZYIuJWRKdg83hCJajLl4ifNcBsBQ4XieN8OOguyafbKsFksBv8KWAkgXTzsCQmGl
	GbWMOba9UGhwJK5ttLs2rJqRLT53jMM4QFvM9SoZXkX29oFB1dP7w+O6jlbfXAB3Do1ptlgdjt3
	4M2pGLe5zkPSH0OgwtrAVnTJHkngYXV5bAQ0XfMcj/Ms5s1bNrawzz5czGe6f4A+sUEBNmZkUeU
	kXiC3qV40EZBhsiaRpQXPiug9ecyjEI5LaENvIlSu2aABNDZpjnC6z1/a8aGYWurh+mOWIO8KHw
	IpELuZQ2j0ZTVroviiZimEUiATIvH0J9w4FUtFPMwA0q3sU1l6oJLUUkY+Lm+X22EOEr5VFmbRE
	zZe/QMDdOIxoPKHUjaIyUSpx+Dt3X6cpo=
X-Received: by 2002:a05:6a21:512:b0:38b:e750:bc31 with SMTP id adf61e73a8af0-39545eeb17fmr7900675637.32.1771867369604;
        Mon, 23 Feb 2026 09:22:49 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7269771sm7942918a12.30.2026.02.23.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:22:49 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:52:39 +0530
Message-Id: <20260223172241.291649-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092251_563208_4F11B84B 
X-CRM114-Status: UNSURE (   9.83  )
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

The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.10.y
was incorrectly applied as commit 3d78e8e01251.

The original upstream fix moves the cancel_work_sync(&ctrl->ioerr_work)
call within nvme_fc_delete_ctrl() to after nvme_fc_delete_association(),
so that ->ioerr_work is not running when the nvme_fc_ctrl object is
freed. However, the stable backport mistakenly placed the
cancel_work_sync() call in nvme_fc_reset_ctrl_work() instead of
nvme_fc_delete_ctrl(), leaving the original bug unfixed while
introducing an unnecessary change to the reset path.

This series reverts the broken backport and then applies the fix
correctly.

Jaskaran Singh (2):
  Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.7


