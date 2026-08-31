Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DC3C624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNUOYDPt61vaxXUbZr9IM7CvwCmMyj37FRBTp9CvSG0=; b=sdfYgS/z2q+j5a8UB81IAM/2nO
	MqKsLaVkjV3iHSInHH+ka4nJNTfRiFqYWlZK2ZxHNYYtIccFDCv2qnl/vcGqEaqwd7V3rlU2BjzIp
	4JeEuUa9jSM4ZggG/BY6gXf0L/1t2AwuLeXP7oaqWpdf59R5cWVtiJCTR/mfAUwBiYXGL0Kkd9V4v
	BZnXw6Hq7ewBFLWGlsEvqdtWVwDrukl8ediKP9v5iGLtshGPUk5klIKLw9/UjbFV1fUXSJnvSJw+8
	WvTsTnr6ATlJX15Soh8STP3OI8iUadHjhIm0w3jsZmMXshiAsQrz/1JbkL/zF0+Usunn0asZbDsXF
	GiitDZnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBm-00000008h2j-2OjY;
	Mon, 31 Aug 2026 07:12:18 +0000
Received: from smtpbgau2.qq.com ([54.206.34.216])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wBj-00000008gxt-2dzf
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 07:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788160303;
	bh=GNUOYDPt61vaxXUbZr9IM7CvwCmMyj37FRBTp9CvSG0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ChQaPjtwFWh2TlbFyP4ijCsFp27PMQygWnUtIsfr/Wk2785OXE/3ouOHdIPYPj8hv
	 n7hlqAXoLC+CaDm2205wbzLCZEWDjnjwQp2EfRf6G5J+qENiqyXe9EsZEyvIu+geKJ
	 uS6Fl6b/Q9jgeTZqHU4ESqu9ohWCegzn8OmLzZGw=
X-QQ-mid: esmtpsz18t1788160286t12ae2ff9
X-QQ-Originating-IP: /DNoQEQZBErUbZ+nn4f0QYgSknwCoEqN8vvAz7018ww=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:11:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18264328242113777515
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: raoxu@uniontech.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH nvme-7.3 v3 3/4] nvme-fabrics: reuse string helper for subsystem NQN
Date: Mon, 31 Aug 2026 15:11:22 +0800
Message-ID: <090DFCAF26D6ECA1+20260831071122.638486-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OLustoS+DIJrdL0qqtdYHm2bJkT0kzxcSjf6n/Is5xMuFslcD21l4KWF
	YiRGpNbMw8U0q/jBSnOaPBF/bdAOHO3gOS20tcVFL7NAFgvZ+5TuqrXwvRVzY/AvC8vM+MA
	By2474E8vbfFSLUVzFlSHTS1xUDvUvsEQvyKyiAH+2vzgEXrU8uPnleV6AqDgCH6daRKxWP
	KCDMgsZZDUWjMOLhUyza83sIfiYQi/1oXyWoXQEqXTkfs0JxrkJCD12NZD5RHWP3A+Js9n0
	XDmQwoY3uCtQYCx7ccPaBgMFxiGRzoY/tWT33sF8BCjdtN7x6WYe2s4xZRJwIZdmHeMunvW
	UAEauTHvXLEOYSyBAeRMgBtPAV1nwB8GWWt5jLxxga5U6flpKZ4LMOfHILikIaY+ncx/2xJ
	pZQ09hUsSPq5Q0hYmqa2wG3F+h4ovn94HMBScgdZPakpoclN2ZeZTgQjPyqVGG/P7DPeqPb
	qDLn7at7ngVEUwnMDlnMZoCiI3mGZ5OjbKdSGrLpHGP4C1r+L1fizZLqz//61BMVJNZQ9ZY
	fhfc+8DY0Beq2caxwr9V2eLL7xl0KXGHKhecYG9o2c+2nooR8iFANdChE1rLMBwvME1iPvY
	a8D+J92AtQvCiaBzBvAd4YyTNhSnZK06o8ov5TzEqoEdU5LollKQRRd9hbo8UEuFC02tdoY
	N5j1rIghtbRrNNdsUBu47bSriqNfffaBiiZeK0FBXrDReY1zTBa9EUVMf0uN3G3LN08seOD
	uF8eGBPFUsF2Gj44teUAy+Tx5m4wLgGWHbCZPtif0ezgPIoguiMr90irlEsZ/4Og+utGbCC
	edruo4lKm01N5IpuLCIm4DEfLS8NVlliLrC5M4XoaRs4+Dl8ZiZFtciJyqWne2xAUIracls
	LTCYLW39JPWMaYvHtO6gWWT5U2feWT6Js9CW6UKZBEhKiLCqm3z6TNSpVJLk9bZP88veB6H
	D03n9oEcEhr/kS7FyZThzZxfDSYTbcu0rOrQeOyyWF/pyK2MmT9Bc+XmlQeeFF2WJW0XSez
	YBk6LIuDrKhwg71Y2m5s1AZ5wmMhjcxQNTSffoE0PuPy5GuBkjX766Z0TeCRA=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_001216_047779_F5D21835 
X-CRM114-Status: GOOD (  12.16  )
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

From: Xu Rao <raoxu@uniontech.com>

The subsystem NQN starts with the same owned-string replacement sequence
as the direct string options handled by nvmf_parse_string_option():
duplicate the matched value, free the previously stored string, and
transfer ownership of the new allocation.

Reuse nvmf_parse_string_option() for that replacement only.  Leave the
existing NQN length validation and discovery-NQN update unchanged.  The
hostnqn and hostid parsing paths are also left untouched.

This removes another copy of the match_strdup(), free and
ownership-transfer sequence without introducing a dedicated helper or
changing option-specific logic.

No functional change is intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aab3fd279d0e..24385e777307 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -773,13 +773,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			break;
 		case NVMF_OPT_NQN:
-			p = match_strdup(args);
-			if (!p) {
-				ret = -ENOMEM;
+			ret = nvmf_parse_string_option(args, &opts->subsysnqn);
+			if (ret)
 				goto out;
-			}
-			kfree(opts->subsysnqn);
-			opts->subsysnqn = p;
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
 				pr_err("%s needs to be < %d bytes\n",
-- 
2.50.1


