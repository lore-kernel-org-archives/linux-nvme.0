Return-Path: <SRS0=/MW5=7H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9278EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 18:22:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B79120776
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BzKLcDj4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxaIn1ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B79120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccz6ZrC4tUbpd4awBqBVWphoiJe3xDBA3B5GVckSrMg=; b=BzKLcDj4bncNES
	uKnpHCGAZjzPpTj3F9q/ZrHx5r/Ll0KCoNXbas4E8NFrVzNrTfxymnn24sbiwIQx10n97fP9MbvaM
	lK3q8mMqBxBNIT5J3fxLf6EtiermXxzfanYauAarM4CB4QzcZeQzwUB7bxzWhyqcaHue3nkR2I9jo
	tARspeW1FV1fExfmUZNjufDZrTNui2nfPo79zJb5TM9NvP2hqKTIxRLaFFlfrFCTdhzyaIUog+W8H
	lHbFbs7Bm5AjFGO4CoDg1nG3jCBuocxrt/Bx4jJ8u4kf8ydhlpTYkkUY0sVhV7MDUmlqe0F4+gtNM
	dkh5YEliUGtOPT0NM6Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdHkS-0004O0-24; Mon, 25 May 2020 18:22:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdHkO-0004N0-LW
 for linux-nvme@lists.infradead.org; Mon, 25 May 2020 18:22:50 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2570020776;
 Mon, 25 May 2020 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590430966;
 bh=Gy7JN0egwXN2SgYVpE2AsuZLSDXEWOyY8sqXQWbsPBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MxaIn1llvFygsrrxXTuxW9cCaD+zV2lXlWmezhft4hiO6nXFpiT81GpUwi6JxOL0I
 wY0R1IFnzxEseNfaSkqYiUxtGQdcvbKLyvJASlKjO7J5u0YRd5DmwrRQ5trSykZT2V
 tDceJBtfBkBkm/0r3heLEBQjedD8bjS/cqLXN4gY=
Date: Mon, 25 May 2020 21:22:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-next v2 7/7] RDMA/cma: Provide ECE reject reason
Message-ID: <20200525182242.GK10591@unreal>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-8-leon@kernel.org>
 <20200525181417.GC24366@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525181417.GC24366@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200525_112248_745283_94DD40FF 
X-CRM114-Status: GOOD (  16.42  )
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
Cc: rds-devel@oss.oracle.com, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Doug Ledford <dledford@redhat.com>, target-devel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 25, 2020 at 03:14:17PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 05:15:38PM +0300, Leon Romanovsky wrote:
> > @@ -4223,7 +4223,7 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
> >  EXPORT_SYMBOL(rdma_notify);
> >
> >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > -		u8 private_data_len)
> > +		u8 private_data_len, enum rdma_ucm_reject_reason reason)
> >  {
> >  	struct rdma_id_private *id_priv;
> >  	int ret;
> > @@ -4237,10 +4237,12 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> >  			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
> >  						private_data, private_data_len);
> >  		} else {
> > +			enum ib_cm_rej_reason r =
> > +				(reason) ?: IB_CM_REJ_CONSUMER_DEFINED;
> > +
> >  			trace_cm_send_rej(id_priv);
> > -			ret = ib_send_cm_rej(id_priv->cm_id.ib,
> > -					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
> > -					     0, private_data, private_data_len);
> > +			ret = ib_send_cm_rej(id_priv->cm_id.ib, r, NULL, 0,
> > +					     private_data, private_data_len);
> >  		}
> >  	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
> >  		ret = iw_cm_reject(id_priv->cm_id.iw,
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index d41598954cc4..99482dc5934b 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1178,12 +1178,17 @@ static ssize_t ucma_reject(struct ucma_file *file, const char __user *inbuf,
> >  	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> >  		return -EFAULT;
> >
> > +	if (cmd.reason &&
> > +	    cmd.reason != RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
> > +		return -EINVAL;
>
> It would be clearer to set cmd.reason to IB_CM_REJ_CONSUMER_DEFINED at
> this point..
>
> if (!cmd.reason)
>    cmd.reason = IB_CM_REJ_CONSUMER_DEFINED
>
> if (cmd.reason != IB_CM_REJ_CONSUMER_DEFINED && cmd.reason !=
>     RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
>    return -EINVAL
>
> Esaier to follow and no reason userspace shouldn't be able to
> explicitly specifiy the reason's that it is allowed to use.
>
>
> > index 8d961d8b7cdb..f8781b132f62 100644
> > +++ b/include/rdma/rdma_cm.h
> > @@ -324,11 +324,12 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> >   */
> >  int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event);
> >
> > +
> >  /**
>
> Extra hunk?
>
> >   * rdma_reject - Called to reject a connection request or response.
> >   */
> >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > -		u8 private_data_len);
> > +		u8 private_data_len, enum rdma_ucm_reject_reason reason);
> >
> >  /**
> >   * rdma_disconnect - This function disconnects the associated QP and
> > diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> > index c4ca1412bcf9..e545f2de1e13 100644
> > +++ b/include/uapi/rdma/rdma_user_cm.h
> > @@ -78,6 +78,10 @@ enum rdma_ucm_port_space {
> >  	RDMA_PS_UDP   = 0x0111,
> >  };
> >
> > +enum rdma_ucm_reject_reason {
> > +	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
> > +};
>
> not sure we need ABI defines for IBTA constants?

Do you want to give an option to write any number?
Right now, I'm enforcing only allowed by IBTA reason
and which is used in user space.

Thanks

>
> Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
