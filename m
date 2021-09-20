Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB20C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 15:05:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D303E60F46
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 15:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D303E60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QTBgSzymacdgL7fctrHiPvQuIiOD7lmnqAIWcpNa01c=; b=LgxzmNdY6EJSU1
	Bd2wcNiB0Nu6Z73U2tWvjW2w6zguHovzACX0UjI/85kvNccAgWzm93DDYwW0FMKm4l41HD54Vfstl
	48+2qXPL3/zQeVEYxY624ssnhgPzJhZEelvTQ3jDpcNdY3wxjNyvQfXcT9HFGjXHKqpSpSU5MssKy
	oty5fgmny6Z/Wpo0oiXCFxIH9B/WAgKS4MS+H4bgt+l3qFSaAlY7helJ9+gBehtjKRvui0W6dJiPW
	0XBaDSET4YbTWCVYtcg7DJ/86tJT7SJxu/gULEwBEG76y8K34CnOgfXIS1l4cIYaMZkmTU9WvfxDg
	6Gz3qqnpwhkPUkLP4X4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSKqu-0028TL-2r; Mon, 20 Sep 2021 15:05:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSKqo-0028RN-53
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 15:05:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C363760F93;
 Mon, 20 Sep 2021 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632150297;
 bh=2feuLQ4/6bh6dldM72UetUfylhIA1SmnqccEDgPYT5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZnJpHshwnWtKjOuE7tKj27q+TlTGD5DCF+FukB/QSdYySgpawrQEkwbkvAmWTEKCW
 k5wFY35rmGRmZwxeAzd4CFc+CTVXaw4DjqF1HtthZSw9OFiMNNx2pWR5ZiaQs4sUVo
 Zem8rtWO9ZqjGmELVPH4ywJ5TTZTZkDNh7jw7WSBoYetnK7Bwa64WJKAYy2DgvA1ug
 wa6Kp3s2veNhdfhBKxAQtLc5gofT6JQv8GIs7VYpEXjN+/BtBuDUMwm5uCPdjSs0T2
 Fuc/E3K9dqmGDrAJFVNKUNj6vnY0DQSWQD+/XkvKMVCcoUbEHTqFLbBc7JFmZoSuF8
 bX2sazrZJeHQA==
Date: Mon, 20 Sep 2021 08:04:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210920150454.GA108731@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210916164559.GB3908552@dhcp-10-100-145-180.wdc.com>
 <a006947f-8494-4e8a-1ab6-72372018b4e0@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a006947f-8494-4e8a-1ab6-72372018b4e0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_080458_282368_B30C6D48 
X-CRM114-Status: GOOD (  26.40  )
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

On Sun, Sep 19, 2021 at 10:12:21AM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/16/21 7:45 PM, Keith Busch wrote:
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
> > > 
> > >   drivers/nvme/host/tcp.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index 645025620154..87b73eb94041 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -607,7 +607,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
> > >   		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
> > >   	data->ttag = pdu->ttag;
> > >   	data->command_id = nvme_cid(rq);
> > > -	data->data_offset = cpu_to_le32(req->data_sent);
> > > +	data->data_offset = pdu->r2t_offset;
> > 
> > Shouldn't this be "le32_to_cpu(pdu->r2t_offset)"?
> 
> No, data is a wire payload, so it is le32

Oh, of course. Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

The WDC group has not gotten to test this yet, just fyi, but I think
this patch is fine anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
