Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD14C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znrTAOQkIkog0es1Yg/9vX2LmYDGtr+g7VxATtgtPyg=; b=xyL/Zb4lrb5tFEbFISZa2f2JRG
	6j+nph/v/LEB2tZq4uXk2VGrgle/T4vbcsRfvMyIimClehmf8EPYWnYvrm5qJ2kN2zFeRiFdEkTMu
	5PVBupuJNh9wBE7ZSvXI5SSgO2KBEIMFnGwk+qPdAJ8lZRAccGq6HnEFs0cjO0lkQsumbovR0SfZ6
	bC6r963nEMxCRWMyWnQMo0VcpnBQpsF6HNQNNHNFJ8z8YoBmJYGA80MOggSiWbzI0xnDpmoW0jIv5
	3J+0tpAIhJpXL5g+LBmPmIplLHLc+68gfGts7Q8HA2ZqyMGBLHxt2uFkgiIE7pdKyJQh7w4BOS2DN
	PFgglGOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtlys-0000000E3ST-3Tp5;
	Tue, 11 Aug 2026 12:53:22 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtlyq-0000000E3RS-0Fgf
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 12:53:21 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2174311a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786452798; x=1787057598; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=znrTAOQkIkog0es1Yg/9vX2LmYDGtr+g7VxATtgtPyg=;
        b=iHvkO6iaoWswG9H35xI2NZSyR++WLuTb0Qo3420qFE3V/gvKDnSMBYP+RN8zM/cFLu
         c4UQ4nKonfbumzq/qC2q+kpi46h8HuoRX1ez7qBRgqgjS1/zCJ8xVo+0+2dFN2qfJ2jz
         GYlicV1KMuofqjxTbYcFjuNTyMHFAnjUNfVdqvf7FcsWaKFshQoHLUtY1UHYXAkWutVb
         d8z/efYEebdpfcVFKPFEEdlqnz6THm3NKhxhJL/ZmUDujK4VJzod+Q69UK6fEJTt7/uZ
         keeavu9NjRhGK1PvcEasRbzibGWrPg+oWY0oSeecx0y78sqcYBpi4+5iGSe7U4y4yzFZ
         ziFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452798; x=1787057598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=znrTAOQkIkog0es1Yg/9vX2LmYDGtr+g7VxATtgtPyg=;
        b=WGpc8x1Lf99QnnFAXWWMMqWUPcbOwk/rGRw7DgA2Jtc9rXP52/BSS209Vn3dxkJ7jg
         5ymAblL5j7090QOpl9dyLizpPvbxOPD3EjNjtafMGybtPvXQfwLjV/2xLGTWj44Stc/K
         VkdgYryotK1cLVBKhYsHFWwO2SFbZ+yrXMPyMLx0lHQ50e9Sv/j49mA6b+2DVCqxDZBq
         LIQwFMfwF6QqT0xkDu3QUAB2HkWLCFJLxopAsnthayhSPnLUYn0Lxf0MpB5cwxVJErjI
         l7D7C5nVPNXgy2ksGH82jSSJP+NBJePnaBZ5TjEsFsmh+OVn1gx09YJ6S9MXqKke8gh+
         pWhw==
X-Forwarded-Encrypted: i=1; AHgh+RpkWRPOURcS+1AVNzLWB1Sz9YufWxtIVWLJ5CFjKN/+3avBVxNiOPWQSvaHaYvYe9+3FTBYzfnWPz7+@lists.infradead.org
X-Gm-Message-State: AOJu0Yz797yUOWkJosceANE6YnWNQHPANmsOJoN7NobY6gaWw9KH0RFU
	7TWWlrWJbeuaNcWrPbt6YheKo8CYRQhTAmdDyBw0vXSs+QpuMPJ5rGrp
X-Gm-Gg: AR+sD12i95JWLkoAGGFQ1jjBHnPwf+nXOGL17MbofuPk54pbceCIgZDKf9SZtjhrCAZ
	QAjRzepwYihOZ2/xrQkYOGuPS768jtMFT14rODQXjoNqZK36auRvuWFW7RbLt7mcfAR8F0KFMec
	JGjsdpfusbxvQBdLy+DdOgU5Qg0u3Z2srmaF0r56Rc0AoEibuN1mI9Me5/EiYByW1PlHG0+GTD4
	29bGleguAbeFrutNjYFMyJaDQcRiOLAg/ucCbvFxduYF6rM1XwlC1BDLHtqKLP4eKhckYLenIQN
	TpCfo8AIsVPty3ce7SATnEBdfm7cJMr31EkVePNO7hg4Ad50oIFB9lBPMjnMVW39kthPvnSGXMW
	DyS5m5xz7rmDV7MJsskUCZtVQPTWhGMwYKn68TEF43Hx+QUETXYvqHW0ej7XOlTW3mRugFyxlR/
	3OgRm3qBTIsP7S+aY3ArTJlIea/yiiMoi3u9gDi3HKnrCl4Jt7T/OXMJOJ
X-Received: by 2002:a17:90b:39cb:b0:38e:5ab7:ce9b with SMTP id 98e67ed59e1d1-392ec786ca1mr3147819a91.21.1786452798037;
        Tue, 11 Aug 2026 05:53:18 -0700 (PDT)
Received: from ubuntu.. ([122.43.203.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5195a4dsm4127732a91.4.2026.08.11.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:53:17 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Tue, 11 Aug 2026 21:53:10 +0900
Message-ID: <20260811125310.165487-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a7a83ac.01d0871a.3a0d52.00bb.GAE@google.com>
References: <6a7a83ac.01d0871a.3a0d52.00bb.GAE@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_055320_121957_D6E118E8 
X-CRM114-Status: GOOD (  12.65  )
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

nvmf_create_ctrl() frees opts when ->create_ctrl() returns an error, so
a transport must not free it on its own error paths.  nvme_fc_ctrl_free()
therefore only calls nvmf_free_options() while ctrl->ctrl.opts is still
set, and nvme_fc_init_ctrl() clears that pointer before its last put.

It only does so on the fail_ctrl: path, though.  When nvme_add_ctrl()
fails, nvme_fc_init_ctrl() jumps to out_put_ctrl: instead, so
nvme_fc_ctrl_free() still sees ctrl->ctrl.opts set and frees opts, and
nvmf_create_ctrl() frees it again.

Reproduced with nvme-fcloop and failslab by failing the kvasprintf() in
dev_set_name(), called from nvme_add_ctrl():

  BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190
   nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
   nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
  Freed by task 5534:
   nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
   nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605

Without KASAN opts is simply freed twice.

nvme-tcp and nvme-rdma reach the same error path, but their free_ctrl
only frees opts once the controller is on the global list, so they are
not affected.

Clear ctrl->ctrl.opts on the out_put_ctrl: path as well.  The same
injection then returns -EIO without a report.

Fixes: 1a9e218195a5 ("nvme: split device add from initialization")
Cc: stable@vger.kernel.org
Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
Assisted-by: Claude:claude-opus-5
Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
---
 drivers/nvme/host/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..e4d0eeccd846 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3601,6 +3601,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
 out_put_ctrl:
+	/* nvme_add_ctrl() failures skip the clear in fail_ctrl: above */
+	ctrl->ctrl.opts = NULL;
+
 	/* Remove core ctrl ref. */
 	nvme_put_ctrl(&ctrl->ctrl);
 

base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
-- 
2.43.0


