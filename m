Return-Path: <SRS0=/MW5=7H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 18:36:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1832071C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VSPjyGEk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BazwyORd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1832071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6RR7o8u9amUIGjB8Efp8g63i63ltn9e9wu0M0qPwJ0Q=; b=VSPjyGEkmrc648
	fC+8PMFjhfTnPDUq78679IOpHygBkgt/Yq/ChIaIdo4GlL5oTdqnmkxDUk0ow2ARgodqQ+QCioksn
	X1RCQEwzA5cozhgYo2nB786hasInjhwWoI2IH/3aC/XbVMi85PO7cZZSabMuqPp8dogMxxXDUJP2L
	XURV5hgFx/dAvgAI2lGKfI3P3zFvughRURjaj8ksaeajwS3SqtU1lg0DNhn49rhdyAR4e4ZgYXMxU
	PJYsUVvaAJzEDtC/lbXQKPlbk78mWEDY2VhE1Nnj8T8hEdy+r7yMK1CueW+A/AkYKVat7Kf3whIAm
	mvMxJ0FQijN2+PczTxMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdHy1-0004hW-0W; Mon, 25 May 2020 18:36:53 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdHxx-0004gb-Hx
 for linux-nvme@lists.infradead.org; Mon, 25 May 2020 18:36:50 +0000
Received: by mail-qt1-x841.google.com with SMTP id x29so1151913qtv.4
 for <linux-nvme@lists.infradead.org>; Mon, 25 May 2020 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dBNNLrsZGlwM47DpepdKHSQV4KNpjYEcR6uFWidIK+c=;
 b=BazwyORd4omrvh5DADt7N8mqLMzi+RYjBVK2kPihaadkNXr9Is/rLQDfJO5Q/VeMGZ
 XlvEE4bOuXysXlPGwIcRVecP4SnpQyeKRev18Y4ZkAs6lst+NPCglYJURCEfUqTCMD4v
 d4FIdKZ9pAdL4B9FUtyw2jBTjuhBqzHCChe8o3MkkhMvwBxi9Um4/ZVdmu0ggKu2vawk
 PNx/yPYZhnASgcRI+PifWTVuxkkGWBN4MejekhhBeeMm1LXgAmbElmSsr+OAJUwgROb1
 rBGLGAXggDbJcugNER9HW64w4P98g/cNUgxhKT2JupBZ8W1di28pdRIs+MTO7ToMN7BC
 cJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dBNNLrsZGlwM47DpepdKHSQV4KNpjYEcR6uFWidIK+c=;
 b=eWLUninsa6bDqMJr/StagyFQ/+ZEeutfg3vYC9n/bq69WfP1LSx6ubkTh40hfkta+D
 bqh309WQnXt+r5fGWolpn8utHAyg7cYJE51Wul4ZTYwiwix79y5ApnpyXGYZ5S31FFXT
 NMk5Lm7VKJHoKdPGngmdV2ruYoui+2S3YbghxJvRQmaUsG5MPfvr9XD3VZVN9/1eD0a6
 9/J1e1UCpDo0YWWzPHB6ZmqCnr7gK9DBZ9R/aEvBTskYkkhRNmzSEE2fxHSpjAZlgctB
 JxqCtK6Mdqy13gBxjoGNj5SSTE+cVhuyn4WEB7tgCHvUCtyOvDMIfGcN5UXZH3TCIjsH
 +L3Q==
X-Gm-Message-State: AOAM533T6AwJZX9X0uX8q+LyuIkcjtHxkmlU2VsmST6g+q52k5lUfQx1
 4PxmqjABnjKzHqstVIf2xVmmQw==
X-Google-Smtp-Source: ABdhPJyVBT1RicyN2xE8hyRL3aL4JQsSy+eeZY75U2lWdtzDSnJF2GO8I+QXxg6GJjkQa3bQjLScCA==
X-Received: by 2002:ac8:46d5:: with SMTP id h21mr28223881qto.91.1590431808437; 
 Mon, 25 May 2020 11:36:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id z14sm14322945qki.83.2020.05.25.11.36.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 May 2020 11:36:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jdHxv-0007Xl-9V; Mon, 25 May 2020 15:36:47 -0300
Date: Mon, 25 May 2020 15:36:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 7/7] RDMA/cma: Provide ECE reject reason
Message-ID: <20200525183647.GI744@ziepe.ca>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-8-leon@kernel.org>
 <20200525181417.GC24366@ziepe.ca> <20200525182242.GK10591@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525182242.GK10591@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200525_113649_600042_CBC59EBC 
X-CRM114-Status: GOOD (  18.35  )
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

On Mon, May 25, 2020 at 09:22:42PM +0300, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 03:14:17PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 13, 2020 at 05:15:38PM +0300, Leon Romanovsky wrote:
> > > @@ -4223,7 +4223,7 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
> > >  EXPORT_SYMBOL(rdma_notify);
> > >
> > >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > > -		u8 private_data_len)
> > > +		u8 private_data_len, enum rdma_ucm_reject_reason reason)
> > >  {
> > >  	struct rdma_id_private *id_priv;
> > >  	int ret;
> > > @@ -4237,10 +4237,12 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > >  			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
> > >  						private_data, private_data_len);
> > >  		} else {
> > > +			enum ib_cm_rej_reason r =
> > > +				(reason) ?: IB_CM_REJ_CONSUMER_DEFINED;
> > > +
> > >  			trace_cm_send_rej(id_priv);
> > > -			ret = ib_send_cm_rej(id_priv->cm_id.ib,
> > > -					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
> > > -					     0, private_data, private_data_len);
> > > +			ret = ib_send_cm_rej(id_priv->cm_id.ib, r, NULL, 0,
> > > +					     private_data, private_data_len);
> > >  		}
> > >  	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
> > >  		ret = iw_cm_reject(id_priv->cm_id.iw,
> > > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > > index d41598954cc4..99482dc5934b 100644
> > > +++ b/drivers/infiniband/core/ucma.c
> > > @@ -1178,12 +1178,17 @@ static ssize_t ucma_reject(struct ucma_file *file, const char __user *inbuf,
> > >  	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> > >  		return -EFAULT;
> > >
> > > +	if (cmd.reason &&
> > > +	    cmd.reason != RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
> > > +		return -EINVAL;
> >
> > It would be clearer to set cmd.reason to IB_CM_REJ_CONSUMER_DEFINED at
> > this point..
> >
> > if (!cmd.reason)
> >    cmd.reason = IB_CM_REJ_CONSUMER_DEFINED
> >
> > if (cmd.reason != IB_CM_REJ_CONSUMER_DEFINED && cmd.reason !=
> >     RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
> >    return -EINVAL
> >
> > Esaier to follow and no reason userspace shouldn't be able to
> > explicitly specifiy the reason's that it is allowed to use.
> >
> >
> > > index 8d961d8b7cdb..f8781b132f62 100644
> > > +++ b/include/rdma/rdma_cm.h
> > > @@ -324,11 +324,12 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> > >   */
> > >  int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event);
> > >
> > > +
> > >  /**
> >
> > Extra hunk?
> >
> > >   * rdma_reject - Called to reject a connection request or response.
> > >   */
> > >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > > -		u8 private_data_len);
> > > +		u8 private_data_len, enum rdma_ucm_reject_reason reason);
> > >
> > >  /**
> > >   * rdma_disconnect - This function disconnects the associated QP and
> > > diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> > > index c4ca1412bcf9..e545f2de1e13 100644
> > > +++ b/include/uapi/rdma/rdma_user_cm.h
> > > @@ -78,6 +78,10 @@ enum rdma_ucm_port_space {
> > >  	RDMA_PS_UDP   = 0x0111,
> > >  };
> > >
> > > +enum rdma_ucm_reject_reason {
> > > +	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
> > > +};
> >
> > not sure we need ABI defines for IBTA constants?
> 
> Do you want to give an option to write any number?
> Right now, I'm enforcing only allowed by IBTA reason
> and which is used in user space.

no, just the allowed numbers, just wondering if we need constants for
fixed IBTA values .. 

Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
