Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95836C4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 17:53:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDD2250EB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 17:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDD2250EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0g8+PDwEZq9ZunHK/Qnbhl+qOGbd8mTgdRqyz6H7/vY=; b=KZc5wQSkh6buwDtjFGBJtvCSi
	wjgEEDvWar/sjS4wH+vAlpUIxpdkpikFLEBQpBZGxmcWz+Bi1zyFuvIi3NlVeMz71SBPMNVbemnxR
	KJPSvK1OFARJKS4NNSHY4+BsvjdoJRIKnYx3HQnnVXDKwACXXvbfSdQVpGVaQpVl+QMwf8r7TFDFV
	R+T2MbldRe97m+au7KAyOWJU0jAFCUVC3lIfLftDcQCTuKrUbMuGrmVcyZpeuHDnqNYm++JpuWVoY
	xczEJ41QBn6yiZjsAy59RCwIzMZkd1QbD8awdywsGw5SCcaoKrSx8xnfL6AzKtDrCNPGR6xxmUeM1
	+Ww5NgVFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpazJ-0003eR-Ae; Wed, 16 Dec 2020 17:53:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpazH-0003e3-80
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 17:53:19 +0000
Date: Thu, 17 Dec 2020 02:53:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608141198;
 bh=beZ5zvgm3d5FYRbXyTriclz2nvDJTTxcL1ZTuOmT20I=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=O8P7X2x0eAlzehcyaTwmWmatE0Itfm3bR91mpg65ceMW94S9B7KRb+z2KUiJU1TgK
 0OdoFm2JSjTFHQTco8lCEOsQj6jbPGgfRdDFFeXGDJ1rY9uacfyXoniAgnmg9UV0+A
 5/YrSlS/+Ou2b5LQFKPqhZkmL1osKdcz6KOhUEQg8+u1RFTtm2COX/BIrfxm8R938h
 eT1gTs+7jLf0U99QET+Zn9zn1Xgv+68OV23PjhMz1wIbynaZuJQMG/lAIxRXfBFU5l
 puzpLquA5ILxDb5/DeASTy3Ql0sGLKkNrxCCx2dPQg+dF3l4397fB60Co5ip/ywF+N
 Lqn1XbsXOZQNg==
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
 <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
 <20201216174322.v2ahfdhvgix536gd@unifi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216174322.v2ahfdhvgix536gd@unifi>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_125319_378381_99EC6886 
X-CRM114-Status: UNSURE (   7.42  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, minwoo.im.dev@gmail.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 16, 2020 at 06:43:22PM +0100, Javier Gonz=E1lez wrote:
> Thanks Keith. I will send a new version today.
> =

> Regarding nvme-cli: what are your thoughts?

I was thinking we could add a column for these with the '--verbose'
option in the namespace section.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
