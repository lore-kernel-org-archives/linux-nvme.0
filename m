Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1BC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Sep 2022 01:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uMQxC4XnWQGdaQBPEGIZBPNsJecw6so3J5h+1Fai3ks=; b=CiZ5GJrgUGE6nBh9cAlMLct237
	UcDLXr8+WqEIsc0N+rcnrcEeFg8/xlAOVbagG4/fZ7J089BiTsK5ar0yEdbZFZenPiA6DrtVIiLlN
	/IpozZhffejA3mhrLWqEN9rue7s3PBd4wWspjazqg3Zp5Q69YD0muxZHlbUIiyVBiIhj/PIydPh0z
	PmaEsWzR95unWpzhg56d/V7Yw42beGO6SYixe4WPT3W9/DvhJz6RtZS0kCzidQDwx6AEb/JrPYJPW
	v8566h7toTQeIGJq1+0tJ7PwwAOGlnLJrmGeiPMYGSyhi14UUNlD8mc+hqt9YCjqVpfIVekxE2vKn
	9UxoM75w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXuxc-00HOoS-0W; Tue, 13 Sep 2022 01:43:36 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXuxY-00HOlJ-9D
	for linux-nvme@lists.infradead.org; Tue, 13 Sep 2022 01:43:34 +0000
Received: by mail-pl1-x634.google.com with SMTP id p18so10294411plr.8
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uMQxC4XnWQGdaQBPEGIZBPNsJecw6so3J5h+1Fai3ks=;
        b=YjssLJx6G4+PiPct4xK2j4ANPn8pj9lsfmoxzttZjxxY3ZoJr/AXi4bZhtU/DVnydp
         gcFTJq38fj6+XHBAnjnVP73T50I1FBWXhJda9GD2EoSzfv8HMmx7so4ohVi744EBiFqK
         I2I0IhIW09v/Onf+NT5EgtCPn+4UzKg0cYqaEdleGqhhYIcfMYv9UFwHh9ezhD4C31iv
         b4j9eX5iqhReVkZiKg+CL1w7VsF2oYvgmDPn2+fJ9bqvEY6a8Ff2XXEzHuMVIdRG5San
         XJqA8g6y/fhtAcyuSuZnx4oB7O5dlu7zFwEzba4sAMSQz1o7aaWcM5x5hF0ULQYCmpZ6
         90yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uMQxC4XnWQGdaQBPEGIZBPNsJecw6so3J5h+1Fai3ks=;
        b=HhLwa1rjgGTzrxRb2+PZvGG8mxsJ5NO5qKL0xqkU85k0m0NPDvpU6mUoNoe9S78mIv
         aDAvBZDLmnlSZ/cFmVMQhIHxVU9/d/mijKz9c84AXvT5Gn9zi71hSrc4HLnQaBQJ4+ly
         PgyPRHpt4ZYf1ZWXEl1rxpc9lsw+NUFWoODOWBJ0wTX8FPGMl3Pt6RTDlCUeXkMglT1V
         /ZhkAqAhS34l03bc4kTuctrjbSTqIKUu6fSyXVd14NL6ojEtOwf/LpDLiRFJwv87hXSe
         AbowSr8syl5y9vcyLOmfs7nLtd8WfLF9MSNwTZRXqdl+oPVX3LUCw5h8wGWNh3gbsbBW
         E5Mg==
X-Gm-Message-State: ACgBeo0A7qkf3TzViB2zdoUi+bJCZaGcCfP9/TKMeAAHInaBGUBHxscG
	fGF35VtWiFPjwa68tWKmFtsuAA==
X-Google-Smtp-Source: AA6agR7mVYa43GyZuyICIpciot8SN89+kRGZ1KjtDkzgD58VeH3OR7XUXEmtBwRJJm1W1zarxLuYfA==
X-Received: by 2002:a17:902:d40c:b0:178:4439:69f9 with SMTP id b12-20020a170902d40c00b00178443969f9mr2117859ple.118.1663033409457;
        Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id pg2-20020a17090b1e0200b001fd7fe7d369sm5885452pjb.54.2022.09.12.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	fmdefrancesco@gmail.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Tue, 13 Sep 2022 09:42:52 +0800
Message-Id: <20220913014253.931724-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_184332_569501_466ABBEC 
X-CRM114-Status: UNSURE (   9.79  )
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

Hi, Sagi
I notice that this series "nvmet-tcp: Don't map pages which can't come from HIGHMEM"
has no reply for two weeks. Is it possible to fix this critical issue firstly?
Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>

v3 -> v4:
- free CMD buffers only nvmet_tcp_need_data_in().

v2 -> v3:
- Keep original function name as nvmet_tcp_uninit_data_in_cmds()
- Add new function nvmet_tcp_free_cmd_data_in_buffers() to free CMD buffers
- Rework against http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.0
- Move nvmet_tcp_free_cmd_data_in_buffers() after cancel_work_sync(&queue->io_work).
  Hi @Sagi, if you still prefer to clear the commands that are still waiting for
  data from the wire, please let me know.

v1 -> v2:
- Separate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.20.1


