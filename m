Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E0CD6E60
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=; b=1zsFidSwFT0aaXHFc+98yD14Np
	tLX+L2P6W62RZfJGbTmUbDK2X+nE7nxNf3a7pQ29+12zCPgV8Bp7Vt3iN+n9lS1olpPLIU9vAcY5z
	hN1sdGvedRvrYoe3hcXtFsibM+pvXgPTMn7OamaBz5VhPWgb6jcgA0r+EDmhmgn0Q+fLZlxUddL8c
	DcU0ENRdF+6qyA9XzAsEel9HxZLtE08Z2RbgP8kBSY6Au4v+KqffHvQNmowY6p/25opiC9y+8jYPU
	RRxhGotADV4VTO/kNqm12IVHC4bv1STkGm26WSt3+1g28dzaVKyMyepj0XPG3wfDsEkifdXUGCVP5
	ZEs+PfMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQgX-0000000DFSB-38iy;
	Tue, 02 Jun 2026 15:05:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUNNH-0000000Csx2-3ZMl
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Jun 2026 11:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=; b=bvnIMDkdlZjosyRAsHH9vJT+Dh
	s/4F3AoHCLpF9TuGwnXFgkwUUPBoGY0lXJfezYCMfsDtDQEAEDUoO+hGnAScJuqZM5ewqVxaCWzZT
	lOB0Dbak+6KMWcDCGNbP4VtQ1oWpxjhAF6a3G7OMb457CMZyh8GriOOOoXgilnTB8vthIOa7XpxVy
	80cd1ZX9R1b5D4DUAltfXAGd2s23vFH/8YT2MJr0NTDozQME5JPFHGFhmNPQxPElKBUaCNOIdB0ZC
	HnjaYK1FG3qorEN4Uow5yYHvkKHghdulNMny16cGJ4cdv9ozG/aDBmKMOI5dkkx03wK+CeJIEsZNe
	9E3Sxr/Q==;
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUNND-00000009GT7-3eiM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 11:33:34 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so539515e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400010; x=1781004810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=;
        b=hl0vnyb8xXW41/3T8reX5ew68G0KSjlcGr5kj66U4UMvMVda5Btqk5r50kVQ5lzL3g
         Sq6ER23Fj8QgG8kRNBPoXdWxg3EpKFoKJEqpqnmd+SUem/YgvEhBVynUUnDl596+Piik
         F+70Ja7sa991N/ULwdQbrDrdDP3u8iNwHx2NUn5UKSOGhltdIEK181GQsE9hLD+FvYKd
         ozQDoU4i1K2XYrT95l2KYgDVdklnUmnA+nxn0TbbaVfS2zEYU/zVXWc83stAJM5ch9lS
         9rzHyuOWP4ffvZEeJ3f264IObWv6e1fKiqPeyfeQM0x3iaN2wEQesVAGNuPAQvVKog4N
         5p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400010; x=1781004810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02j8GeA8u5NvaXQGdjmKGOU30h5jH73JVyZTDUDQ5Iw=;
        b=mq5azFERtuBoNb1ZzuVzD/0R/LdKz/9f3dBHRAwBXMEbt8GF53RxnmCiNatGpb9GT5
         BeVdW4dPH/hEdNCH8XUrwycPj6FWU85l0no5f4SOn9nmCd6YxLLvxuG6IJ9zrzUOHXDb
         qqxzQAR35JOmjIj0CFJ66+1kdlxxUTAxPD6ZE7zOnwwCFtZdG2uDHA3S74DTntzOyExa
         1gHeCfjU8BwM2/9ZfQcKGdBufk/ujIbFq8Z4DkSbt9hjR1/JYrWxv/G2885NHNvnoYMB
         r09IW8lmsfZTnvPCA2o+z9KB3QLE4y3/2yf8/qhO8ntV5dHIArCVYisAfc6H9ZJvMEQV
         OOcg==
X-Forwarded-Encrypted: i=1; AFNElJ9q8vHau0ty07DrJv9882K0ZSHCKaSElz79wmo5+3TUwpruQBCkQZKT2YxIonElST7z4yHdWEoJNc0W@lists.infradead.org
X-Gm-Message-State: AOJu0YyXQcDPuFJUixwNXNur5I1pEMNTG9311fGg5i57Nn7jT5tlqWXi
	eultDZSxsXOV2Istq2Pr4hXGgiTDj46DWZpFyKuTWxxqfMu1alDCVj3P
X-Gm-Gg: Acq92OFZwEPvH68LyAVoa+1QHUN4W6rnwzPqYUh6KVzHvFN237PDVd018hyw71xoXam
	OSI95zswR2BOVXzGXGoRpn/R6pPlyCdm9tK1ZJxFfnrEokV0LSqLiUtuTNWUYUi3NDih6Sc7lMZ
	0IrKQxOltLpkZaI0OeXwCAKrbp6of14T1NFgKXa/eOY2XJ939uSacSmUQiCt9UKCy5JlMJeLNLI
	TzXN3NxU/mF7I7+nigDxJL50AYsJ8+ttr4CEt2s5v5HqGSWg0iP7zTsMRHA3j75zjbnB6O2ssqh
	U/erfgtfOneXC2wi/xHs4MNGG4P3EAIpwtxT26iohJDSccVpgM+2imwyu7FU/5+6k++srskn/QX
	WQl9wKPDvCGG6+T5reM1gyzybnmqBagyNnqegk13VQMA3xPRVocOIRX/maB1Iur+8pdW9GssvSM
	afblJ3zkcM/yf2L6KeULFFumJAcl6r0hCZIJZ1EYdnV2IIJOjcbRHsoF5uK86xmO1O03qD5Oo=
X-Received: by 2002:a05:600c:2d47:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490a2961e9dmr177750195e9.30.1780400009734;
        Tue, 02 Jun 2026 04:33:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm31629370f8f.21.2026.06.02.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:33:29 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:33:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, andriy.shevchenko@linux.intel.com,
 ebadger@purestorage.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260602123327.35aa286a@pumpkin>
In-Reply-To: <20260601092534.1764560-1-ernis@linux.microsoft.com>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_123331_929309_3FEA5E83 
X-CRM114-Status: GOOD (  18.16  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:05:35 -0700
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon,  1 Jun 2026 02:25:15 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
...
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 6482ad859bd1..852213365ecd 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1731,7 +1731,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
>  		 * All receive and all send (each requiring invalidate)
>  		 * + 2 for drain and heartbeat
>  		 */
> -		max_send_wr = min_t(int, wr_limit,
> +		max_send_wr = min_t(u32, wr_limit,
>  				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);

That should compile as min().
(The constant is known to be non-negative.)

...
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index e6e2c3f9afdf..fd6923198ec1 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
...
> @@ -1553,8 +1554,8 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
>  
>  	param.rnr_retry_count = 7;
>  	param.flow_control = 1;
> -	param.initiator_depth = min_t(u8, p->initiator_depth,
> -		queue->dev->device->attrs.max_qp_init_rd_atom);
> +	param.initiator_depth = (u8)min_t(u32, p->initiator_depth,
> +		min_t(u32, U8_MAX, queue->dev->device->attrs.max_qp_init_rd_atom));

I think you've change one of those to min_3().
Nesting min() is a good way to bloat the pre-processor output.
You don't need any of the casts.
	
	param.initiator_depth = min_3(p->initiator_depth,
		queue->dev->device->attrs.max_qp_init_rd_atom, U8_MAX);
should be fine - if a bit long.

There are also (u32)U8_MAX casts lurking - pointless.

-- David


