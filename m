Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9909EC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:32:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0F860FE5
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0F860FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9IvZXvoPdUVFfKc/vk0fZBHNFGiW9uVPy6n84XQiH18=; b=RA1aqsbEwSuBEDRdYy5Th8UmZ
	5cfzN/3uU/cZVmxfY2IP9lY2h6cB1f2OaUg+Y3ugVlWFMAS6DL1K1C0lAi7XElkAz4RASpaUa9LiV
	Qe2+R0z8FXmzIBpSK7668JSZTDU6ViuEk561m5flHX9185GXbg9/XToZeL/rO8BNqPZloru7q3lc6
	k6kTQIWZK/g+TPe5uArXorsM8DL2bH831IJQuXiDJBc555VPo9DJ+TYhnjzIvfHE09YTNHDs+eAJn
	7MduBrxrt7J4Ea5AcGr+q+k4COiHXInouubkRWzYskilVt5iFjAB0FoaPmJJfNLmlxwhI5wEL8jKf
	xHE2TBqqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb3DC-007yfn-VT; Mon, 26 Apr 2021 15:31:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb3D9-007yfb-0g
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 15:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ADtBDe9XrW6aLRoA/+UVxr21FhB+eonvFjvVi2Tz6jY=; b=ivZDbzmvA7oy060vDAEZHTTKAv
 OXbFo9Q1xpoavrlK9evyQJqNVGkQH97nHYqx+V/1SKb2omuKehcs3lUIUw3d2/ws7LygBRiXHn7Wd
 pBHH0Xg0pl5cQLzkSfJnpjkA3SuDKXcN7la7yDgTyKJT2LtTIj4aYp8qcTEJwkXUGFMyWk7KR5vJ6
 fiF9+5khWdAKrLJbx0e4m5K4jpKqRVaKPIvYtXbOITRit+tfR3IDlicEw9GVZdM8ovxO1XPwFbQP2
 L8EvKuhJuvKA0KpDbepBWX6/HRNZQ9Tyl/uajC1o/O5PnT9aAJrspGmrH9CDPRy9TQ/vIsDCvMSti
 q9c1BZKw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb3D6-00G35J-HS
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 15:31:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B02066112F;
 Mon, 26 Apr 2021 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619451104;
 bh=lqEmwzp+0H1LpedNpAHgdorvkzlXJHKyDX1+wpOsOTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SM+A0xygT1RCPtKnA8j9fomRXK24DWB+iS3/PqANs1YP2sY6cUdRIqEs+LOf6SlWw
 7ObTjgVZP0i4RE3MYvj9aSi+N1p188HiDAnFtsSCCVyiL20HHsbS7xt6DKaGDFm7ub
 8jcv4lIbgCdjvTK+9EJ7S/rzlFO/JvU+M2PqLMLLogLi4DgrgOHRWSB1oLhVJsmqxZ
 lUfU/V4nyGkS1rk+Anr7vb0U2sq5rl5PFxKA5ilco0/GVlouRiJrRthc7rA4c+pDSk
 thJa4wWkUfPJqyoOFWoMlWPBHFixt4+3nkg4YP+C/Q/kxzy1O2SjdwVo9qb+RUVxyA
 lCV9NpiK9Yoqg==
Date: Tue, 27 Apr 2021 00:31:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_083144_628524_C2CDF7B5 
X-CRM114-Status: GOOD (  17.87  )
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

On Tue, Apr 20, 2021 at 10:33:30PM -0700, Sagi Grimberg wrote:
> There might be a hidden assumption here that may cause this if multiple
> c2hdata pdus will come per request...
> 
> If that is the case, you can try the following (on top):

This patch is successful for clearing up the observed "no space" issues
observed during read tests.

There are still some issues with write tests that look a bit different.
I'll get more details on that for you today, but it's probably okay if
you want to make a formal patch for the receive data side.

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ff39d37e9793..aabec8e6810a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -773,19 +773,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                 req->data_recvd += recv_len;
>         }
> 
> -       if (!queue->data_remaining) {
> +       if (!queue->data_remaining)
> +               nvme_tcp_init_recv_ctx(queue);
> +
> +       if (req->data_recvd == req->data_len) {
>                 if (queue->data_digest) {
>                         nvme_tcp_ddgst_final(queue->rcv_hash,
> &queue->exp_ddgst);
>                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>                 } else {
> -                       BUG_ON(req->data_recvd != req->data_len);
>                         req->cmd_state = NVME_TCP_CMD_DATA_DONE;
>                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>                                 req->cmd_state = NVME_TCP_CMD_DONE;
>                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>                                 queue->nr_cqe++;
>                         }
> -                       nvme_tcp_init_recv_ctx(queue);
>                 }
>         }
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
