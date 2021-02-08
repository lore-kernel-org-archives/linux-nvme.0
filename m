Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3033C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 19:05:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644B764E73
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 19:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644B764E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XM9YnwTcBNTPmPoJ1TZRUqt6YUE+Fy/yz62TTEKLNLg=; b=d+NLGYoJZR0y4Y1zb5AaREIYg
	TI6Sg9jIvfGyCyULwVwYAzfZjyG4Tlqeo0Sj1aMG1T4HqciPEiA1bSvX29ELjEwKWRAAV14MP0vBq
	CaLv743Y4Tct/UGi5Fw8mCgUrMISS/+BqcICHbTQE9sF1iW55HF1eaoAB/w4UaTZEouoEESOLfvII
	FJFLJ2872Aqz9XrvmPm5VSWGk39aq2v7XOu29h/NPdmJ1kKNwZt3BBov7pKmCTzMqdS9CRIbUJY3w
	5NaOVrwu6fB2HwYpi2ooeaK2m0OfJcyrkv6mXl9O2lUP7Cvu34yyzNhCvLKP2e+ZaKrrwBIOIaVoW
	zCuueg0cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9BqL-0002zh-9g; Mon, 08 Feb 2021 19:05:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9BqI-0002yi-2j
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 19:05:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B09F64E73;
 Mon,  8 Feb 2021 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612811101;
 bh=cDkUPWN95Pp9pK//ONE0XBghdZ00LH+nxwnv2rvTztc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iXQqhgAgZq5MME3pLss+JSOAadjWVGJGJeuHwLosE5Wnp81LGoIUwMNoTBGKacBrE
 lqX8kBL/HKscAJaT533ReJSfkRMldpb+gHtKHDBro1ZvdYYmpxhEwEaYAXASFaB86Q
 TE+gVgxGNgvbrAgu1ZTqBBm7SJbfsSdp4QT3TJpKfMHCUnRlGFUjF3Ommrr5Osyi+I
 lOW1ksEPdfVsG5aZj9muy+pvYLP/nvGL/SMJZqgiONKGrHrukOFRknerJEMROoGtBx
 lxciyZSSJo6TmX1v+2twVp5nJwDNui6DFRdGlyhoH8j7hh1//jlSmGUcq5NfLHq+5k
 h3Te+uGINKl0w==
Date: Tue, 9 Feb 2021 04:04:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
Message-ID: <20210208190458.GB17042@redsun51.ssa.fujisawa.hgst.com>
References: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <4608296a-6c45-a252-8b49-88cf25cd7365@grimberg.me>
 <SJ0PR19MB454412891E589E03EF8DB948F28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <c02ae0ac-ce0b-7081-9759-8c3751510ca7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c02ae0ac-ce0b-7081-9759-8c3751510ca7@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_140502_344976_BCA0E03C 
X-CRM114-Status: GOOD (  20.62  )
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
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 08, 2021 at 10:59:43AM -0800, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > 
> > Yes. The Discovery Controller currently allows it. The problem, however,
> > is that the DC seems to be expecting these values to be non-zero.
> > 
> > I tried setting IOCQES=0 and IOSQES=0, which the DC allows (i.e. Prop
> > Set return status=0). However, when I follow this by a "Property Get -
> > Controller Status", the Status now shows "Controller Fatal Status (CFS)"
> > (see Base specs - Figure 79).
> 
> Yes, the oversight extends to the target that expects it (shared code
> with I/O controllers).
> 
> Does this fix your issue?

Seems like the Identify Controller SQES and CQES fields ought to be
updated too, but the spec isn't clear on this. Feels like ECN
material...

> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 546a10407385..a7578c601727 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2443,6 +2443,11 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
> 
> +static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       return ctrl->opts && ctrl->opts->discovery_nqn;
> +}
> +
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  {
>         unsigned dev_page_min;
> @@ -2468,7 +2473,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>                 ctrl->ctrl_config = NVME_CC_CSS_NVM;
>         ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) <<
> NVME_CC_MPS_SHIFT;
>         ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> -       ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> +       if (!nvme_discovery_ctrl(ctrl))
> +               ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>         ctrl->ctrl_config |= NVME_CC_ENABLE;
> 
>         ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> @@ -2888,11 +2894,6 @@ static const struct attribute_group
> *nvme_subsys_attrs_groups[] = {
>         NULL,
>  };
> 
> -static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> -{
> -       return ctrl->opts && ctrl->opts->discovery_nqn;
> -}
> -
>  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>                 struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 8ce4d59cc9e7..baa26a65d83d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1107,9 +1107,14 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>  {
>         lockdep_assert_held(&ctrl->lock);
> 
> -       if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> -           nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
> -           nvmet_cc_mps(ctrl->cc) != 0 ||
> +       if (!ctrl->subsys->type == NVME_NQN_DISC &&
> +           (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> +            nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
> +               ctrl->csts = NVME_CSTS_CFS;
> +               return;
> +       }
> +
> +       if (nvmet_cc_mps(ctrl->cc) != 0 ||
>             nvmet_cc_ams(ctrl->cc) != 0 ||
>             nvmet_cc_css(ctrl->cc) != 0) {
>                 ctrl->csts = NVME_CSTS_CFS;
> --
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
