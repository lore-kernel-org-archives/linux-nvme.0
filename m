Return-Path: <SRS0=Hg5O=7I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2058BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 05:50:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9AB2071A
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r8zakHKq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRJNuw2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9AB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ePLH8A1Yr4GZ92ALXftuZMVy/PhpzT0JBU3O0loKdEM=; b=r8zakHKqgoMF+y
	jhCOjTcxRKRDh6chi0ULho2c+RQbf2h/ekQhjQTmpOVLwLRpb1+OL1Bb7tcRzFqbM2d7RIs/w/9CK
	AP72Rx09pSudVNJskKMzooShWP97QQ7jPUjaTFk3SUY2WUOVFCG2VY/WyQBXKP2atcT7woRdeUfCd
	iJP3UYMX3InWUm27TXHOK6NF8D+pfAh+R+ppRGsCNBfA73zNag8owTuFunc6hdn4P+iJ5RLDuRDdq
	kaAi72vSUYM2qIQYTJpkuhjxcMfttGmC3f374JNbNlqTVZWHxWQEV5WTrdm4UwFBCNDpM9JFt1idC
	6O48Q9GsdrYSHW6nPk/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdSTR-0003Z9-Qt; Tue, 26 May 2020 05:50:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdSTP-0003YH-4g
 for linux-nvme@lists.infradead.org; Tue, 26 May 2020 05:50:00 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C532B20776;
 Tue, 26 May 2020 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590472197;
 bh=U88K5T1Zan4Jq/FR3aweJOo6lgnXrRGiQiUYK8qSWuY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rRJNuw2+b7VWIzP/J6gScT6Tv4ulqUEsQI+kD+X820P6QDx8gVU8cgvwsH+VHyYhl
 D+M2lo6nz517/zzthJX84a1owGlSbalvc+ayu+QzJchs88UWXR0s9gPCm6bp3L1lly
 dgfqmwmgROoDeqwe0kqNaNzLdg1tYK7K6qXPL7PQ=
Date: Tue, 26 May 2020 08:49:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-next v2 7/7] RDMA/cma: Provide ECE reject reason
Message-ID: <20200526054952.GO10591@unreal>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-8-leon@kernel.org>
 <20200525181417.GC24366@ziepe.ca> <20200525182242.GK10591@unreal>
 <20200525183647.GI744@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525183647.GI744@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200525_224959_228466_F7E8B01B 
X-CRM114-Status: GOOD (  19.57  )
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

On Mon, May 25, 2020 at 03:36:47PM -0300, Jason Gunthorpe wrote:
> On Mon, May 25, 2020 at 09:22:42PM +0300, Leon Romanovsky wrote:
> > On Mon, May 25, 2020 at 03:14:17PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 13, 2020 at 05:15:38PM +0300, Leon Romanovsky wrote:
> > > > @@ -4223,7 +4223,7 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
> > > >  EXPORT_SYMBOL(rdma_notify);
> > > >
> > > >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > > > -		u8 private_data_len)
> > > > +		u8 private_data_len, enum rdma_ucm_reject_reason reason)
> > > >  {
> > > >  	struct rdma_id_private *id_priv;
> > > >  	int ret;
> > > > @@ -4237,10 +4237,12 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > > >  			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
> > > >  						private_data, private_data_len);
> > > >  		} else {
> > > > +			enum ib_cm_rej_reason r =
> > > > +				(reason) ?: IB_CM_REJ_CONSUMER_DEFINED;
> > > > +
> > > >  			trace_cm_send_rej(id_priv);
> > > > -			ret = ib_send_cm_rej(id_priv->cm_id.ib,
> > > > -					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
> > > > -					     0, private_data, private_data_len);
> > > > +			ret = ib_send_cm_rej(id_priv->cm_id.ib, r, NULL, 0,
> > > > +					     private_data, private_data_len);
> > > >  		}
> > > >  	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
> > > >  		ret = iw_cm_reject(id_priv->cm_id.iw,
> > > > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > > > index d41598954cc4..99482dc5934b 100644
> > > > +++ b/drivers/infiniband/core/ucma.c
> > > > @@ -1178,12 +1178,17 @@ static ssize_t ucma_reject(struct ucma_file *file, const char __user *inbuf,
> > > >  	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> > > >  		return -EFAULT;
> > > >
> > > > +	if (cmd.reason &&
> > > > +	    cmd.reason != RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
> > > > +		return -EINVAL;
> > >
> > > It would be clearer to set cmd.reason to IB_CM_REJ_CONSUMER_DEFINED at
> > > this point..
> > >
> > > if (!cmd.reason)
> > >    cmd.reason = IB_CM_REJ_CONSUMER_DEFINED
> > >
> > > if (cmd.reason != IB_CM_REJ_CONSUMER_DEFINED && cmd.reason !=
> > >     RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED)
> > >    return -EINVAL
> > >
> > > Esaier to follow and no reason userspace shouldn't be able to
> > > explicitly specifiy the reason's that it is allowed to use.
> > >
> > >
> > > > index 8d961d8b7cdb..f8781b132f62 100644
> > > > +++ b/include/rdma/rdma_cm.h
> > > > @@ -324,11 +324,12 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> > > >   */
> > > >  int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event);
> > > >
> > > > +
> > > >  /**
> > >
> > > Extra hunk?
> > >
> > > >   * rdma_reject - Called to reject a connection request or response.
> > > >   */
> > > >  int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > > > -		u8 private_data_len);
> > > > +		u8 private_data_len, enum rdma_ucm_reject_reason reason);
> > > >
> > > >  /**
> > > >   * rdma_disconnect - This function disconnects the associated QP and
> > > > diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> > > > index c4ca1412bcf9..e545f2de1e13 100644
> > > > +++ b/include/uapi/rdma/rdma_user_cm.h
> > > > @@ -78,6 +78,10 @@ enum rdma_ucm_port_space {
> > > >  	RDMA_PS_UDP   = 0x0111,
> > > >  };
> > > >
> > > > +enum rdma_ucm_reject_reason {
> > > > +	RDMA_USER_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED = 35
> > > > +};
> > >
> > > not sure we need ABI defines for IBTA constants?
> >
> > Do you want to give an option to write any number?
> > Right now, I'm enforcing only allowed by IBTA reason
> > and which is used in user space.
>
> no, just the allowed numbers, just wondering if we need constants for
> fixed IBTA values ..

I will take a look.

Thanks

>
> Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
