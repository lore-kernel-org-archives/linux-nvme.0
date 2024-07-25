Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA41C3DA61
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:References:In-Reply-To:Cc:Subject:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PNGLdY5lCrVALpZvf9y5pOMR1z62Wrz29AhFgjwVIYs=; b=4pe+KeGPfZSNj8blOuyxPoXN92
	ygGaK4IaI0m4aOMBbm8XwL0f0rBsUNI0pqTR1Z4mcyCmMrJRqUwN9DPBTfdXIeAJ7J6eX5FpMIn7H
	7dIAwCpuSYvLC3L9/Ag37N17rjw88NgP7o9Nu60HRRkf9uLYTghMWt6CRF98OBmlomfQGWk7s2Koq
	aVoaFzLLSqFEb7vlxbGAiy+5hGO2EWOSfFi3rwoNOpNS0onYAm4hQupmPIIKXQBFLI55b0y1raz6+
	Z3+VWEVD6DhVyKApcWnWS69hddAWPttF8trsYpzTD/7igLYG9rt8KGV2jcUy7e3dVbcUNNu6p573Q
	BlYsO//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWniN-0000000H3aF-1HIt;
	Thu, 25 Jul 2024 01:56:19 +0000
Received: from out28-78.mail.aliyun.com ([115.124.28.78])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWniJ-0000000H3Xq-0Nsr
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 01:56:17 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5778216|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0250876-0.00301791-0.971895;FP=430380305957573910|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021158;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.YYza402_1721872566;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.YYza402_1721872566)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 09:56:07 +0800
Date: Thu, 25 Jul 2024 09:56:08 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
References: <20240724123052.49185-1-wangyugui@e16-tech.com> <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
Message-Id: <20240725095607.0A4A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_185615_326040_87D04273 
X-CRM114-Status: UNSURE (   8.44  )
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

> On 7/24/24 21:30, Wang Yugui wrote:
> > Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> > We firstly add Rotational media(RMEDIA) support to nvme host, then we can add
> > the support to nvme target later if the backstore is a Rotational media(RMEDIA)
> > block device.
> 
> Why not do that now in another patch, at least for the loop target ? Given that
> they are not that many NVMe-HDD out there, that would be nice to have to test this.

Just because yet not enough skill/time now.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/07/25




