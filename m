Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC87C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03AC207F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YpFpqKbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03AC207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmI+gD+b4SX3kIxdFhanDT9+68wqVfBnHfX9oGefUbM=; b=YpFpqKbtkfsV1xGOFzNu+VLdOC
	WIyY14DiPASmqkQR5yerigfQ2NIyMopDZMrn9wmiT0VSOmSmasbcaFTbl2G7H7Pbc8fLTUCrx2Bqu
	7cNVd/MTMQQx5nbq/pywCqzoXv8ojAEPNAZzdtGQBjsqnPn0V/iv55l553sS2e6msrHeLrXU+PJ1T
	dmmEMoRO03aiB035tx1WsG/didUY30oguQF4t8nr6yIob3X02CHlrhkmKiEUrtc3hcSiifHkaloi0
	dXIWP3KoPY/gqsDlGwdR+774fkd/EwGlrnInsbQmP5JFfaSFcNC17lCJQoRSXfVrV0rbPjDdEEqbv
	Wh4+tbsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvBYA-0006Mo-3L; Tue, 14 Jul 2020 03:24:10 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvBY5-0006Lu-8j
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 03:24:09 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U2gNrnC_1594697032; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U2gNrnC_1594697032) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Jul 2020 11:23:52 +0800
Date: Tue, 14 Jul 2020 11:23:52 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Message-ID: <20200714032352.GA111285@VM20190228-100.tbsite.net>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
 <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_232405_620489_F7D732AD 
X-CRM114-Status: GOOD (  16.51  )
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 13, 2020 at 11:58:18PM +0000, Chaitanya Kulkarni wrote:
> On 7/12/20 23:31, Baolin Wang wrote:
> > We've already validated the 'kato' in nvme_start_keep_alive(), thus no
> > need to validate it again in nvme_start_ctrl(). Remove it.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >   drivers/nvme/host/core.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 3d00ea4..a95e26e 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4313,8 +4313,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   
> >   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> >   {
> > -	if (ctrl->kato)
> > -		nvme_start_keep_alive(ctrl);
> > +	nvme_start_keep_alive(ctrl);
> >   
> >   	nvme_enable_aen(ctrl);
> >   
> > 
> 
> Since start keep alive is so small to make a function call how about we 
> in-line the call ? untested patch :-

I am Okay about your suggestion. Will send v2 with your suggested-by tag
if no other objection. Thanks.

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 09abf2ca33f5..c7289c23658a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4311,8 +4311,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> +       /* if ctrl keep alive time out is set start keep alive */
>          if (ctrl->kato)
> -               nvme_start_keep_alive(ctrl);
> +               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
> HZ);
> 
>          nvme_enable_aen(ctrl);
> 
> root@iouring nvme (xarray) # git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 09abf2ca33f5..08e1a6826b08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1031,14 +1031,6 @@ static void nvme_keep_alive_work(struct 
> work_struct *work)
>          }
>   }
> 
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> -{
> -       if (unlikely(ctrl->kato == 0))
> -               return;
> -
> -       queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
> -}
> -
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
>          if (unlikely(ctrl->kato == 0))
> @@ -4311,8 +4303,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> +       /* if ctrl keep alive time out is set start keep alive */
>          if (ctrl->kato)
> -               nvme_start_keep_alive(ctrl);
> +               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
> HZ);
> 
>          nvme_enable_aen(ctrl);
> 
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
