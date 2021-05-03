Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED98C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 14:29:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D19461139
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 14:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D19461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wlVQ8dvuQEIlLJGpZKkQciD6ITqwgCSG49oUp0s+oU0=; b=cnPv4VvLv5b6NPWAHmFMJ//pr
	hBKuBVPYkf6IRHt+8KqHUTx9Ek8DNn+LiRRh9fLvZ73OKyGdFbFDDR4FPK3015O70hz8BHHOF+kaJ
	yIK8qVCbqcl+9ar93PSQuAypyIUX3403PelgEUIskQuqANMtHj7WzXlslQZHBDGwbfY0a+RXSvS7t
	G5MvsGamdo7Lt+se9ene76CL7Kn5/v+0hcjL67aJqvtdQOkP5sc0Og3aaOuDyseFNZsEFDT9Xn4TW
	X+xbuea20GY/MTtW+Ik3ubhLoq+98rJl8+2mdUJ9qKn89+alF6dX/9+CLbDeqzKmmUAMiCuJ0nSYP
	2oRZob6qQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldZZD-00E3z2-Pd; Mon, 03 May 2021 14:28:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldZZA-00E3ye-1q
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 14:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=yALi/6dm5mCSxZXI0oOkkpbESIgxQU2SARqg/W3vQlQ=; b=Dj+YBSPyIddL/4DN1+eaKyaot8
 PcZLJVyhiqzbAWFtGdM8INh31rJDR1cGdAE9yu6bca/MkdOGPcPp7pIylBK2w3isFc+Ww99Gw5MNA
 Yp8Kb4wXOec1pJbXxDY3LESil3byXqD5XSw6m/ZcKXU/BfkpbWHqeSmGVpFfGcCz2kmcHKs0uihia
 oKD1Rmgqr4rNjkX2vuH7X91WDU/JQrc3AoRuQJ+8ggUPBavZa04drs4ir/ACcHFGCO0zlVVV0Au2f
 cKmjwh7Wae1kEeuw8UlysUPDL00WvWUb/Kw1hNV+JvlwHtq3BLXmFN8Pev32fkFLmJ0KyMYko+dVN
 6JZSEd7g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldZZ7-0037qs-JT
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 14:28:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BD061139;
 Mon,  3 May 2021 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620052132;
 bh=Mii7/eeaJog/lkDihMk5k9jP60cTsSe1F0pmm3rrgZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s2FneFZCSrbv1X25AZZubrKFHuL9JMWALbW6ZmdLKtOmCiz9bC38Ep2i9WObQcyK0
 TmhcCt3jdA65bF6lepf6fhlsoOlx7XDVu48OqkgL/UQ+O5bLiFW+L1KLRGqhciQjXq
 JdGJw8+TcWvcSAjDqDZLozvpeDYE+w73+LJ58ntXktmCJGhEGgleG7+OxAV/4lYkS1
 6ZQVWl5yWeabQpmBSsfgh877iA4FOXIISA0Glylk8Oh1ZUtegMQZWCwpvCqjLqpz4M
 AnMUuWaNPxQ16/bVQ3vXtwS5bgEqaaCf4ZuwOMd/OvUwxA9WC+deZFKWuw33WQmFq/
 dcCy25FfYkv1w==
Date: Mon, 3 May 2021 07:28:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
References: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_072853_701119_5C626032 
X-CRM114-Status: GOOD (  18.55  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 30, 2021 at 04:42:14PM -0700, Sagi Grimberg wrote:
> =

> > You are exactly right, I think this should do the trick:
> =

> Hey Keith,
> =

> Did this resolve the issues?

We're unfortunately still observing data digest issues even with this.
Most of the testing has shifted to the r2t error, so I don't have any
additional details on the data digest problem.

On the r2t issue, I'm just waiting for the weekend test results to see
what happened with running your most recent test suggestion.
 =

> > -- =

> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 8e55d8bc0c50..eb1feaacd11a 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -55,6 +55,7 @@ struct nvme_tcp_request {
> >  =A0=A0=A0=A0=A0=A0=A0 /* send state */
> >  =A0=A0=A0=A0=A0=A0=A0 size_t=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 offset;
> >  =A0=A0=A0=A0=A0=A0=A0 size_t=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 data_sent;
> > +=A0=A0=A0=A0=A0=A0 size_t=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 data_received;
> >  =A0=A0=A0=A0=A0=A0=A0 enum nvme_tcp_send_state state;
> >  =A0};
> > =

> > @@ -751,9 +752,12 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> > *queue, struct sk_buff *skb,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *len -=3D recv_len;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *offset +=3D recv_len;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 queue->data_remaining -=
=3D recv_len;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 req->data_received +=3D rec=
v_len;
> >  =A0=A0=A0=A0=A0=A0=A0 }
> > =

> >  =A0=A0=A0=A0=A0=A0=A0 if (!queue->data_remaining) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (req->data_received < re=
q->data_len)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn 0;
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (queue->data_digest) {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
nvme_tcp_ddgst_final(queue->rcv_hash,
> > &queue->exp_ddgst);
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
queue->ddgst_remaining =3D NVME_TCP_DIGEST_LENGTH;
> > @@ -2274,6 +2278,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct
> > nvme_ns *ns,
> >  =A0=A0=A0=A0=A0=A0=A0 req->state =3D NVME_TCP_SEND_CMD_PDU;
> >  =A0=A0=A0=A0=A0=A0=A0 req->offset =3D 0;
> >  =A0=A0=A0=A0=A0=A0=A0 req->data_sent =3D 0;
> > +=A0=A0=A0=A0=A0=A0 req->data_received =3D 0;
> >  =A0=A0=A0=A0=A0=A0=A0 req->pdu_len =3D 0;
> >  =A0=A0=A0=A0=A0=A0=A0 req->pdu_sent =3D 0;
> >  =A0=A0=A0=A0=A0=A0=A0 req->data_len =3D blk_rq_nr_phys_segments(rq) ?
> > -- =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
