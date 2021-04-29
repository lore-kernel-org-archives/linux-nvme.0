Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57849C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 03:34:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B761B61448
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 03:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B761B61448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DLZHHRC4usDlOlAb+25Nu49v5Rv2IVC0gZyCTPtcYus=; b=QCnuHyVw3SuFPX9zldefHhoAO
	dIeOHozqXUCcd7IzUWvv5cVMayB+DeP3Hs//JZ6Rf6q7SEep2F0J2Zgo4b7DTCXh1ty8lLMUkmgY1
	QTS75sWD7w9tnH0qpXUrPlTOQLMjYitzso4WeNwqflmNHA+QpqRPkVKGXyKfwIVX1aMFfneXNNA5B
	5dnyKHgKOn1t/T/wKswy+szxP5qhB3N9pXmWF7y/alYJtSPVe4xsG0Plw7i7v7KS2RosqtrN1217+
	URXyz5qUe4oC0huL+t5IcgwtOOONtGJlh8NWmaFWpQ3l+bxbeQzXN6SPvH74FbjPEp9x4umzccQEn
	po5a0+Gcg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbxRI-004mVl-SJ; Thu, 29 Apr 2021 03:34:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbxQo-004mRd-WB
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 03:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MKZxkR/DGf1wFWSgJotu0XGkMItRWTGfcOlhZbFPPKE=; b=pXxQ/2V3V5jJWawf8vmPHQnRwR
 b6j995GH/h+tdB786NqZvYsv3mU4l+pXfNN1RQW3NLqOKdouxTbWl4paeMeguu2OlUspTxgdOd7GC
 w/6K9zA5DJJhuJq1Gdoingpp3ObIMchnJs8X6YXiQdJJMg6SeXIjXa1ZPPoF7r7UiIyUWmAQ8i4sV
 DW44OxDqrF2ainrERXwB7s7dg0pLgFP6Xb/DyQsaHk86GCGVEFRWW+9srtSGYlgkHBYav82IeYQAy
 gOF6asex58nyFuclcejwzKwBiaWungJEkE2bWfOaPKJPBGaLzM/xczdLzTQpicIb3yDr2rB6hM1sb
 A6CNhvbw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbxQm-000LKl-Aj
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 03:33:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 254136144F;
 Thu, 29 Apr 2021 03:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619667214;
 bh=Qn8Sr7IUylJfGeV2Ja9FE9J0xtsFHFwXtMLjcHUXDVc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V0f1BxBfMwnb+pp4SHgP4AzlCWf7jEiZ3dLnJqkskpXYhikG+jaB+MN6e2NbXC5aW
 ggfx3Ce7UG5Nd9w4JOnwsABhIP8WO+nfR5v3uv87dE3xPKChouHkxccnqavLv5gUwN
 mmSWsIUF9Ag6XROOcZoayG85+F/Ilr+uHM14iihU2d8jrV1XG0rA4RBZ/qdkW0QoCN
 h4cZebSPtChJ0Bma4tx1bYao01+5n9b05ldYXeyYeCqIiyBgsLYnaQi64hKA0W02VM
 zJBcX/Y/39B1h3LXk4pDjDZQT52bWsyRrqBdc6Ds/Ilt8FLLJsmA3c78mQ7etfamoD
 Qj4i/3G9s06Rg==
Date: Thu, 29 Apr 2021 12:33:28 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
References: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_203336_433720_0D70D9A5 
X-CRM114-Status: GOOD (  19.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 28, 2021 at 04:06:12PM -0700, Sagi Grimberg wrote:
> 
> > > In tcp.c:
> > > --
> > > static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
> > >                  struct nvme_command *c, u32 data_len)
> > > {
> > >          struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > > 
> > >          sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
> > >          sg->length = cpu_to_le32(data_len);
> > >          sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
> > > }
> > > 
> > > static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
> > >                  u32 data_len)
> > > {
> > >          struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> > > 
> > >          sg->addr = 0;
> > >          sg->length = cpu_to_le32(data_len);
> > >          sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> > >                          NVME_SGL_FMT_TRANSPORT_A;
> > > }
> > > --
> > > 
> > > What is the sgl type you see in the traces? transport specific sgl
> > > (host-data i.e. non-incapsule) or inline?
> > 
> > The Sub Type is 0xA, Transport Specific.
> 
> Interesting, I don't see how the host is going to send data
> without it being in-capsule, and before receiving an r2t...

The driver tracepoints captured millions of IO's where everything
happened as expected, so I really think something got confused and
mucked with the wrong request. I've added more trace points to increase
visibility because I frankly didn't find how that could happen just from
code inspection. We will also incorporate your patch below for the next
recreate.
 
> Maybe add this one for a sanity check:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index eb1feaacd11a..6cb0e13024e5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -987,6 +987,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct
> nvme_tcp_request *req)
>         len -= ret;
>         if (!len) {
>                 if (inline_data) {
> +                       pr_err("no way... data_len %d queue_max_inline
> %ld\n",
> +                               req->data_len,
> nvme_tcp_inline_data_size(req->queue));
>                         req->state = NVME_TCP_SEND_DATA;
>                         if (queue->data_digest)
>                                 crypto_ahash_init(queue->snd_hash);
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
