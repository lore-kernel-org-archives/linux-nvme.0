Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0779EC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qgu324w0HIHlwSK2I3DaMKCWs94NR4my1xNx4FGWhRc=; b=2y/Pmd9COHUFRKsNxpcURjTl64
	hrgafiBVTRuRHyF1HRlLUdOOIJ3XW9nbEov3dB2puUYOo7Tn1lMlUb7+jIywotoQ9GnufKHUhVNin
	ur+n1EP6vXgyjVOR+tiDK2MN7tCyk/bY8Bv/gdHJpeDyrvM2pBcWoqFl6mr6afxCI7uC0nBGJ4rV8
	0pOdaIr43b34fJfMPj/+rlXyRtZ3zu4W7J81PXMq+0WwK7pJWtHAwjDhfEybLOTfLiqDP2LskdKiv
	csrerDhD5114PRVJ93XOp+taU35rgmXCBW429zOA2ZyLnGZg05nfl8zGZ1CZa7fEe9R7eNB93/jjK
	rJm/tfpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZet-00000000lp2-08BX;
	Mon, 23 Feb 2026 17:23:47 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZeq-00000000lnt-0DHN
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:23:45 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-826c49b7628so2300448b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867423; x=1772472223; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgu324w0HIHlwSK2I3DaMKCWs94NR4my1xNx4FGWhRc=;
        b=c7vZY+mhA2o8mPh659Kbgrk3m6ksh9+WAVtY/C3Zwe9hUZWqenV2SR7NhtJplQ+OAG
         zSvDvE+zHwdQq1NyC3WWUTiR3aL7pKV9ySIicacPmLMbLd0BVyaMqXLF7hUkNc5QVvHU
         ufjf7+PifNA+zgBQWgVyUPiGn1KrZST962KvI5jlsXCd1mjydfJA22DMZyTzSRqnQS9f
         ZDVgGInTWC/xrasY7dfDkKvJGYaQbaKgJ7zxg+zM+1a6mQTtrNbbbwy8hxlGhYqTT9aK
         8vRGfXYOMlvxfnVE5G8wwrfBm+OuVqKkOGBXyfs67btAeEefJ+ZNi3szhBZHyosSFepE
         Qxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867423; x=1772472223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgu324w0HIHlwSK2I3DaMKCWs94NR4my1xNx4FGWhRc=;
        b=F+cUY05fT2ujFE5OsEUH3uf5kR3jNHXHJg1U2tvr2kiTveQ1B490Dqq5x1y31IKtyA
         wiBHqG5Ck+vPHL98FXyjaO2yuYmssb9erQ6k3SGs5m/uiu51VmJsRZIyByiVW76BSftI
         LZ3vNNB2/kQ0lpG+WAF6At/gzhkIMzuJ5y4edYnFaIjBm1wYuBgr4pEaQkvt9OxIdGul
         m3dVexF3j29YhcaC63cQ5h3W9YZb2FXo0z21FdoBaKHug/yItl1HBlrzu+2LPJvgjNbt
         siaiDZthe2njJL2gSu/y9uHrlyJ8ieQLmZuai9P11rz0OvSFalaD37IZrNXQ5QibnrgZ
         GnXQ==
X-Gm-Message-State: AOJu0Yz8j+kpJYXoLy7YsKXMdoD9GuHYi/VAQUHTuB0P8cJUdiIiVcQY
	wCwbk9kNiC8dn+41vO9jlyu8Xg975J6SHKGUR3ZDVy6lxvw6zPpNDXumB+/v7s93jV4=
X-Gm-Gg: AZuq6aK3JNtp1mt2Yl008HKe7rieLcn7Mta0UUfrFIrInRunoV4GWYlUS2cyG7NbqEk
	BIV6aiLLWFSs70FVh5pb5x9He06/EL+nKUrvyXRrxFtXbm2o2V3wPHfa2ta57LcWrE+2mLhWqNr
	LJ94Lr2Gv5ZL0JGAb8nfQEWPdtsNe1ruCttMOl6qWhvHGbGdBqqXPIwhqyriGthOQ04vPGicCRg
	Iah8+qrFM5JqeWxSMLaOQ6NmDmX75nufjWTBQQC6NW99YRHhk2yd4nSXlSIdDHcBYadUyDeCMy9
	Qj4UNGbK5NB5bgQ6k9DI5V04oIF/ShBhdDqab5cByLPhisZ7bX+brRHDTbXswCPJZtCjC0Y2OHd
	0bgW0pmt075qQjeQL7wy1VBLEZDlZWRDu8AHbTiv5X+OwSng3D3hL1FtM5iaXvnhgQAIyL9bd7S
	p3/H46cuZKqynPBfUMBG2oDQYmo9vDVW0=
X-Received: by 2002:a05:6a00:4f8f:b0:823:786:1990 with SMTP id d2e1a72fcca58-826da908495mr8069057b3a.21.1771867422928;
        Mon, 23 Feb 2026 09:23:42 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641313sm7876162b3a.1.2026.02.23.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:23:42 -0800 (PST)
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
Subject: [PATCH 5.15.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:53:30 +0530
Message-Id: <20260223172332.291881-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092344_091315_9B930590 
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
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.15.y
was incorrectly applied as commit 60ba31330faf.

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


