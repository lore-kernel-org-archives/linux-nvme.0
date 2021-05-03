Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7CC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:44:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5684161075
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5684161075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mBvveh66AbwGDOdT3gZ6LvFgiJwpl/8LIlUk0tFl35E=; b=gkblrNMKWZYCARk1qqBSif8Du
	kHYSv0PGSx58ngLqENn1ny7StEk+iuyduQn/t7/YNtnh5IhiCR+kUV9kMvGKYbVbxOfHRaELi1KVZ
	ZklC93ovKLGnbFVmps/03gAeQ83bC/UJfTmja+NPJYe0GhAzeCX1l5Au5Olidnl4F9/YRYTm/pL8+
	0KdEl247pmpf2aaKcoWPGV640pbvWqZ7upGtjsUvreVuXcDMptEzT0QJL27q/bmGrT0Axh2ccev/H
	vTZYXDw731I1chDaOv8++3TsfJDbv3fJCcSlkAx5u744Q6VoeIisTapkf6z/am/dLS/UU0KKD43Wy
	+WdjuTrBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldeUG-00EkWP-Sw; Mon, 03 May 2021 19:44:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeUF-00EkWB-0A
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 19:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ph+BAHfC0jqFeWr4aTOcVhrwdOGQGmzPp8VftZ6iEJ0=; b=iCk96Xhp5bJ9FcOiHGISJ+ylyd
 xM8albqtn1gYtmqr29TvNXS3xd/oqGkqnrBqgbTdTvw0xK172L5LLcmOAgMtnSrRziCtTKUg6lCBq
 W15dAiQZ2d5MpKS+DSARzP/elrUS5yjcAaBv/mCsFVW1gijDmsFiiq41vfdRSU91+tpLV/FsZFXiE
 eSvneMfD++qWaSdIkW83DYXQaQ6TsYFJtcvx5u3j+OizQWRIKVAHD4YhZY8bTyDE8PwtMJ2akk/Lu
 b0VWJHYLA2sV9xlyhag9GSRQoKnGvgWAkBhymBQhrqQwkBUMT49fqXLNIEv0wZYhJTkmgg6DoABSW
 IkRdFs1g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeUC-003RRs-Ej
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 19:44:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C68C61075;
 Mon,  3 May 2021 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620071046;
 bh=DpUCkKuO8PUt3cMneEBsvDpIFTsCq/Lck8OiIVuLwYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c5yLyRl6r0p3DnoiOUpjf7kH50F5YlRAr7YyBp/xR3IlV5D4ga/y/XHHxs30AAR9E
 nN6kc1LqpzY+4ayEVlLaeuO9/iLtmAfjh84ji/lYJ4BqxNzaUeb2LwSt15OpP2SB7v
 wylZfETC2J1oM1MFgLBz3QMkw34m9pwlJpLenAyyufNCEtwdtoQBz2VFcPBYAVo1gF
 ICYpa0lJP9NYEup4VbSzgyrc/+/LF+aElID9IxlkZGa4qGfxvr+ecRZ3VrvVSwv1TT
 NdfDCs1YhIi9hiHlDTw58R2fH7blsliopfff3Vq49/orfzfKCSAFnSr0Dmos0lOEh3
 gF0lWzhuDYXFA==
Date: Mon, 3 May 2021 12:44:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
References: <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_124408_575480_893B889B 
X-CRM114-Status: GOOD (  24.96  )
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

On Mon, May 03, 2021 at 12:38:39PM -0700, Sagi Grimberg wrote:
> 
> > > > Hey Keith,
> > > > 
> > > > Did this resolve the issues?
> > > 
> > > We're unfortunately still observing data digest issues even with this.
> > > Most of the testing has shifted to the r2t error, so I don't have any
> > > additional details on the data digest problem.
> > 
> > I've looked again at the code, and I'm not convinced that the patch
> > is needed at all anymore, I'm now surprised that it actually changed
> > anything (disregarding data digest).
> > 
> > The driver does not track the received bytes by definition, it relies
> > on the controller to send it a completion, or set the success flag in
> > the _last_ c2hdata pdu. Does your target set
> > NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?
> 
> Perhaps you can also run this patch instead?

Thanks, will give this a shot.

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6bd5b281c818..a848b5b7f77b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -55,6 +55,7 @@ struct nvme_tcp_request {
>         /* send state */
>         size_t                  offset;
>         size_t                  data_sent;
> +       size_t                  data_received;
>         enum nvme_tcp_send_state state;
>  };
> 
> @@ -751,6 +752,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                 *len -= recv_len;
>                 *offset += recv_len;
>                 queue->data_remaining -= recv_len;
> +               req->data_received += recv_len;
>         }
> 
>         if (!queue->data_remaining) {
> @@ -759,6 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>                 } else {
>                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> +                               BUG_ON(req->data_received != req->data_len);
>                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>                                 queue->nr_cqe++;
>                         }
> @@ -2274,6 +2277,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct
> nvme_ns *ns,
>         req->state = NVME_TCP_SEND_CMD_PDU;
>         req->offset = 0;
>         req->data_sent = 0;
> +       req->data_received = 0;
>         req->pdu_len = 0;
>         req->pdu_sent = 0;
>         req->data_len = blk_rq_nr_phys_segments(rq) ?
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
