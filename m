Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF516C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 00:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7408B613BD
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 00:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7408B613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RdmvQ0bW3ikHCL718cwnOQxZNdqXqLG7RfbLlwXvw1c=; b=S1yf0nX4/9eDWp
	WKM2YZlkS4FqicJ8tCc1wTe2pZTrEmkb4fgyI1PZ0edJBP81qPNTqYKshKdgB9rGTcUpaokyH8pbt
	I0Wy5qqqPJq1+9QUAZQLfigw7oJRKTmF3wIteB2+/BeDRqhh31W8rVxw6raP63UksCJEb+OKXfrGG
	nDhiKq+m6nDh6+dCpgm1gHWJVVa3YGmXWnxpehZuoPsTZKwdkOjTKlvL95lqm5Dj/OAcYvnCemzP6
	GF9AoZOvvw+esSAlRtqPmm7lKtjhUAoqrOjQG1jqFz8gOn0ykAh3vmxZl05DrlHxVJtA13rVsJ2SX
	edGpwN9syWG3eJK3MDsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVNOQ-009V5y-25; Wed, 29 Sep 2021 00:24:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVNOM-009V5a-9T
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 00:24:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9836C613CF;
 Wed, 29 Sep 2021 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632875050;
 bh=QyEIN7uIP0EVn37bhVVJ2z5IpG+HJ+wMRwyd2tpyZAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L2s4aU9qxRtgzP4kI79tZdctbn2DyNMGXFubatqr+St0ayqcoOnxiuSxNXFaE9VGj
 BVEjiGfuxcqHtRcodwnGBFErIv3S/WHB6veS766fV6hj2wd680t6cpd9oHmog44wmO
 /K2LdYkvT2mubpWSJD54vY7R9VdbT9evfQLxOIjXl++0EEbCeC9qN2dGiiHtemdzt4
 7wQWmxZCRAkT075zf4/p5KPwtkBzIwJ1LxjWs3JxHx7sXGVlHF0Jvnx6g+fS77iaze
 97HpzgkI5aHNzWNqF4teHGMJTlHC1cnF1l/IBger2a3bKnCx00Ei2LO4qeIkcKgimc
 F8wH3IYs3np6Q==
Date: Tue, 28 Sep 2021 17:24:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210929002407.GB390773@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
 <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_172410_407595_05A16509 
X-CRM114-Status: GOOD (  36.93  )
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

On Wed, Sep 29, 2021 at 12:00:20AM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/28/21 11:40 PM, Keith Busch wrote:
> > On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
> > > When the controller sends us multiple r2t PDUs in a single
> > > request we need to account for it correctly as our send/recv
> > > context run concurrently (i.e. we get a new r2t with r2t_offset
> > > before we updated our iterator and req->data_sent marker). This
> > > can cause wrong offsets to be sent to the controller.
> > > 
> > > To fix that, we will first know that this may happen only in
> > > the send sequence of the last page, hence we will take
> > > the r2t_offset to the h2c PDU data_offset, and in
> > > nvme_tcp_try_send_data loop, we make sure to increment
> > > the request markers also when we completed a PDU but
> > > we are expecting more r2t PDUs as we still did not send
> > > the entire data of the request.
> > > 
> > > Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
> > > Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> > > Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > > - Keith, can you ask the WD team to test this as well?
> > 
> > I finally have some feedback on testing, and it looks like this patch
> > has created a regression. The testers are observing:
> > 
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: req 3 r2t len 8192 exceeded data len 8192 (4096 sent)
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: receive failed:  -71
> >    [Tue Sep 28 02:12:55 2021] nvme nvme6: starting error recovery
> > 
> > Which we had seen before, and you fixed with commit:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=825619b09ad351894d2c6fb6705f5b3711d145c7
> > 
> > I only just recently heard about this, so I haven't looked into any
> > additional possible cause for this regression yet, but just wanted to
> > let you know earlier.
> 
> Yes I definitely see the bug... Damn it..
> 
> The issue here is that we peek at req->data_sent and req->data_len
> after the last send, but by then the request may have completed
> and these members were overwritten by a new execution of the
> request.
> 
> We really should make sure that we record these before we perform
> the network send to avoid this race.
> 
> Can you guys check that this restores the correct behavior?

We'll give this a spin (I had to fix it up so it applies and compiles;
no biggie)

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3c1c29dd3020..6d63129adccc 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -926,15 +926,17 @@ static void nvme_tcp_fail_request(struct
> nvme_tcp_request *req)
>  static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  {
>         struct nvme_tcp_queue *queue = req->queue;
> +       int req_data_len = req->data_len;
> 
>         while (true) {
>                 struct page *page = nvme_tcp_req_cur_page(req);
>                 size_t offset = nvme_tcp_req_cur_offset(req);
>                 size_t len = nvme_tcp_req_cur_length(req);
> -               bool last = nvme_tcp_pdu_last_send(req, len);
> +               bool pdu_last = nvme_tcp_pdu_last_send(req, len);
> +               bool req_data_sent = req->data_sent;
>                 int ret, flags = MSG_DONTWAIT;
> 
> -               if (last && !queue->data_digest &&
> !nvme_tcp_queue_more(queue))
> +               if (pdu_last && !queue->data_digest &&
> !nvme_tcp_queue_more(queue))
>                         flags |= MSG_EOR;
>                 else
>                         flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> @@ -958,7 +960,7 @@ static int nvme_tcp_try_send_data(struct
> nvme_tcp_request *req)
>                  * in the request where we don't want to modify it as we may
>                  * compete with the RX path completing the request.
>                  */
> -               if (req->data_sent + ret < req->data_len)
> +               if (req_data_sent + ret < req_data_len)
>                         nvme_tcp_advance_req(req, ret);
> 
>                 /* fully successful last send in current PDU */
>                                 nvme_tcp_ddgst_final(queue->snd_hash,
>                                         &req->ddgst);
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
