Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6EDC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wzGm1Qr/gFaEkVGxB2odqT2lhJFze14VDjj1mqsKFmo=; b=R/2AiX8MtI7ifaA9ms/zbOVVHX
	s6KoXR85qc2rWGoERUR6v2lGmmhBjWq33HC/smV2vwws/ztG3UV/aUp/S5JszhiLJkst9+xI7EKN2
	zpW94HSXOH9v6iQz1j5UDUQXep+E1xPuKSuMiRDnFef51ghVxcD1epxeDpGQut5JF1P3Z14fAut85
	2LN0yAH1W0P+DN8IgEkvvpzxFLm/SjaLuWaD8zqBgtikgOhph82fIKiEgtPWbRGvBf3qI2w3uTmLA
	o2LD3g57FGfdV9DbWpSVwaU2HUj0v2kFvLyQt0TwmV7rxeVqoJnALPDk5gVy/L70CFPBKPpKR9TY6
	201/77mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHbk-00A2uo-GW; Fri, 30 Sep 2022 15:07:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHbh-00A2st-7C
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:07:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC3062380;
	Fri, 30 Sep 2022 15:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394EDC433C1;
	Fri, 30 Sep 2022 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664550435;
	bh=TM6/IfpWfVF+nES59GsofumzDMygVAewv+TltrshnTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqaIArI2gw+7qGL39n0qwFsB6CPMSpscGNSaKvB78D3TkijKBFuUcaHECPXc0CIkg
	 MLyh9YpsNagUhca2MvYbb0jnBV2TIcr9KGmfWBLmbNdrNyHhFCqr4WK4dpwnOvMUqS
	 JWChEoshtDI7PU6hpf5VJJbJxh/IXD7P4db6/i3apeFJf+fsmszFTTZuJ0l3bKfwMt
	 PFBIZg8WvhdKNM2N2TX8mSAQDpmtpbswghEqu7gjGLhb0Xp6APokRz9DOH6U+ONLve
	 itGTlWdMIC9Ag3UHQPiUxBvW0NYfFE8lk7BU7Ob7Ob0VbZLg86K0b/66E+ke6xLPWC
	 mLRV8nK1YHyQw==
Date: Fri, 30 Sep 2022 09:07:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Neerav Kumar <me@nero.im>
Cc: linux-nvme@lists.infradead.org
Subject: Re: add NVME_QUIRK_BOGUS_NID for Intel P4608
Message-ID: <YzcGICHQRR3NPjed@kbusch-mbp.dhcp.thefacebook.com>
References: <CAF9DR03RxNagB37S=F__JUhOf0m=M8vwCJ=kv93mQYXDGTJN7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9DR03RxNagB37S=F__JUhOf0m=M8vwCJ=kv93mQYXDGTJN7Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_080717_344632_296B3AF6 
X-CRM114-Status: GOOD (  14.12  )
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

On Fri, Sep 30, 2022 at 09:58:36AM -0500, Neerav Kumar wrote:
> Intel P4608 reports bogus eui64 non-unique values so apply the
> namespace quirk to it too.

Is this specific to the 4608 with its broken "2x4" pretending to be a 1x8, or
are all the 0a54 device id's similarly affected?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9f6614f7dbeb..ed4002109122 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3432,7 +3432,8 @@ static const struct pci_device_id nvme_id_table[] = {
>      { PCI_VDEVICE(INTEL, 0x0a54),    /* Intel P4500/P4600 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES |
> -                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +                NVME_QUIRK_IGNORE_DEV_SUBNQN |
> +                NVME_QUIRK_BOGUS_NID, },
>      { PCI_VDEVICE(INTEL, 0x0a55),    /* Dell Express Flash P4600 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES, },
> 

