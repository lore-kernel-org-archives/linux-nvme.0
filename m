Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721ADC28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 05:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/rHRxf4F0jxH5KpLZ+al1TqYfHzckrKco/BgOA4EBec=; b=f58T5kEqcZRUafdWFNvz+io3a1
	Ril2gnoZaivM8u8XAhW458HcQO1qUcn63c9hHuMOx0mmEV4oeL2ajWZE/8MGo1uMBx1oQpkA1Bu+T
	xA6eqoQbuhIRMkAOGH0KL5gIZGCnNCCsM1KyAhhT/8BC5EswVN+SjodBwtGrBsH43TMBELqqsVt3H
	Fol8U0WTegI8CKMCqAH3i6kft2fi5OiZI17tmnL/gPs0iEFsMjv5ti0AWtLnW2Z3A9y6by3+l09ME
	tfBRuAopqsvYwPnk4SQg8NrcGEnuPLtimV/TnPqMwd2gnT0OytHUks6HqIn5LkQPYBpipMG9bNgXQ
	wCB5JvVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEKX-00000007UlU-0rDM;
	Wed, 12 Mar 2025 05:08:33 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEKT-00000007Ukb-2tO0
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 05:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741756072;
	bh=/rHRxf4F0jxH5KpLZ+al1TqYfHzckrKco/BgOA4EBec=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Y9KvdYaALty+lB/bad1VaAdv6iPwaL3qOFhu++FDX37HDLy3dxwtmYiBSZpMrDQ4v
	 viUU+VryBZQ8gK3FVHmh1bNasZr6OyVeeBpNm3IN+fU65A1n6zdqtTvMrcYGl6eOH3
	 0+9bwSB7j47nVJvDfhcJLixiM4kpdnvq542aE6uU=
X-QQ-mid: bizesmtpip3t1741756022tjbalwy
X-QQ-Originating-IP: Rm4w8WqZOyXkt8U5rimcg269hBvjvb9n1X8dE5ImDgI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 13:07:00 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5519647041609310355
From: WangYuli <wangyuli@uniontech.com>
To: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com,
	jthumshirn@suse.de,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] nvmet-fc: Remove unused functions
Date: Wed, 12 Mar 2025 13:06:50 +0800
Message-ID: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYKBs1ZFv2UbvSCasQ1w3NBm1VvM64bQONYckMm+2ApRJhYlnBOVpk4o
	us+IKBBWTCjrz56XBY9JJmbGkOUPlMg6nFdLBHMvVJL5Fbmeoh1r59e0s0LouWsXMQ/gnz1
	oI9cx0PeP58+hbz2X1vCaX1Gj2Z6jZyyb05/nIH4MOLcaVSOF5bBrgXQz6uc0E0LrP2gHha
	yqljBJlH+2tULFJaIcew/r8fN+B3FFHyyjqpGvJYoKM7L/hdOJ/om63VMokf0cDshOFeIYg
	6vc43FtqQk6TDCyxHrd6e9xk+lNGAEENF58ZBHva15oGpsdOXEn0B+q7hPKi3vieN2Yg1tT
	dV7IOJsPLwJ6nohIGrOYpIqWN6uMUd4SCWuVvGLIy2Us2xbzwcYzQfSENvMQhw7MC8EAMXV
	9NCIhN/0OeDXdfBPdI9Ls/rMVVs7/z3RxzqCll3p1aP6Vy8bLlbT/8r2UG7xq4N6zWPETmS
	zTN/WvGwxP5rrkEd+u5PrgURmw6poKIJ1HUlKEYxJwSTYltPcTsMr+veWbXlsM/UHor2SXb
	Oj5CanTMuX7HG9W7kASlEqlz6mFLdqYQ5SScuTs1p8HfpUugnsORSIyvV2dWBAuSf9EfD0+
	Jh4wjOYyQ2NuhYRYqp4JFeqYqjAUCimd7O+I61T0Dpn8oZjjNvxLXpEonpISyI+4F4ztDi3
	mTLUFBoL5/mtiDXNADljy18hvR4m7ks5eAP3VsxZYjcwrxw6aTxq3ZWtnKG9H7kLgAiyjzj
	VKniLYGOkXWCDUEV4PC6EnNewn0c9RrNjGKR9TPP372pbghdweWLNdPZsyG1PsvEHyuP2v9
	LAcRsAgwRsPQtkaubb3JNHgpismYzmnHecrXqwkaZ0F0JWJYP/lXZ0qMqEP1NJuvn+3bdDq
	d9WU0RkSJqRprpCm978a81axg2WMAkPMeSGb5MVnR0qjhsofFT6ngrn2lbq1ELP9y5PWTWs
	d5yK+dZDTFsf/4HJAUspD31sCGOD/XBCo9HnfTM0NEVLlPjee3wYUylBMiNsHNRPk0HSI5R
	2jvIpbuj9T5HClxkSG
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_220830_582173_138F4379 
X-CRM114-Status: UNSURE (   8.73  )
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

The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
unutilized.

Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
transport"), which introduced these two functions, they have not been
used at all in practice.

Remove them to resolve the compiler warnings.

Fix follow errors with clang-19 when W=1e:
  drivers/nvme/target/fc.c:177:1: error: unused function 'nvmet_fc_iodnum' [-Werror,-Wunused-function]
    177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
        | ^~~~~~~~~~~~~~~
  drivers/nvme/target/fc.c:183:1: error: unused function 'nvmet_fc_fodnum' [-Werror,-Wunused-function]
    183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
        | ^~~~~~~~~~~~~~~
  2 errors generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/nvme/target/fc.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/nvme/target] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/nvme] Error 2
  make[6]: *** Waiting for unfinished jobs....

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde32..7318b736d414 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.47.2


