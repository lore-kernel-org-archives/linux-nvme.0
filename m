Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB26C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=amIBwcurHA/IB31GoJLXw8YYalrzwFRfV1FNlUywLyA=; b=WjOmplEpPn85r6/kKieM1mRZUA
	6YEH3vlyja+Vnw3mhDCWIUfip0QNZZu/cUSPlOH2uvZI28kPkjcct5mfXMf2rrFlNNS65DO3OkkIu
	QOWk7veLPPdXeRFLkIMtU1fVZg2APjwXP3Na6DJGjWACClEtK2pWG/fWxtD65LWcPv/gCszeH4NS+
	aDbmPiBfLM5mAiVSEbBx0LrJJ4iOjxR6HK0yUif65psasOyyhHuSmZpNfKj9104B20W8ep5o6/H27
	ZGdNzPoJ0D2KoCBrc0/a3KmLnPpEF86oWjzmLSk3OEk1CUD1ZYVcI8UBIXmBJ+bob2Ed/eiRC44d2
	NZLm4vpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncKeE-009Wt5-Fk; Thu, 07 Apr 2022 05:25:34 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncBmk-007mP0-IX
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 19:57:47 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 n6-20020a17090a670600b001caa71a9c4aso3879228pjj.1
 for <linux-nvme@lists.infradead.org>; Wed, 06 Apr 2022 12:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=amIBwcurHA/IB31GoJLXw8YYalrzwFRfV1FNlUywLyA=;
 b=vtffjyBKuaVAdd6rNmPA0S/Meug+k0V4gVtmJ1IFvIF/9fb2iKAZA1I8TJDZkiXoYV
 iKJpz87q01gMKVSyYPomAxRUmM60nuvVO2Xc4nWCY7MuSUpdRNH3++9tZq4BHGC8zZtN
 GXX0EDPqtxUqxzL7Jx/gnTsU0+l/aPgTVBlxIZl8c0k73NXCf1zBKblJZckqNIptuz1t
 YZWjyi5ksMZU2lII6N/LPG4v6UncRj9Z8TtRqfIGJj/pYUAtuEEURuyPNMa6l2P2qBXO
 KFvVfujY5yRaGBhKjIS26PwVA8aA0weoU7pSadi0HXE3ag5fJ9E3xUnyGWTUDY1ZUL72
 6+jQ==
X-Gm-Message-State: AOAM5323z9kYqyNoASj+o+h0JL/28TfmtMcXNNyWmcy+utJrCzkoquOx
 dKg3rV9jlQOQIvPTTcdiXz0=
X-Google-Smtp-Source: ABdhPJzPYf5xMo/3tiolm5zS6xnm4HQHpdPD7nFtjZCYwwxKplAg725myh8iIllXTcpGGAj31TN69Q==
X-Received: by 2002:a17:903:40c1:b0:156:f1cc:7d72 with SMTP id
 t1-20020a17090340c100b00156f1cc7d72mr3074987pld.70.1649275056484; 
 Wed, 06 Apr 2022 12:57:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a056a00081200b004faeae3a291sm20294259pfk.26.2022.04.06.12.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 12:57:35 -0700 (PDT)
Message-ID: <ca06d463-cf68-4b6f-8432-a86e34398bf0@acm.org>
Date: Wed, 6 Apr 2022 12:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] RDMA: Split kernel-only global device caps from uverbs
 device caps
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>,
 Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christian Benvenuti <benve@cisco.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Chuck Lever <chuck.lever@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Steve French
 <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 target-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_125746_655865_BC3265A0 
X-CRM114-Status: GOOD (  16.08  )
X-Mailman-Approved-At: Wed, 06 Apr 2022 22:25:17 -0700
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

On 4/6/22 12:27, Jason Gunthorpe wrote:
> +enum ib_kernel_cap_flags {
> +	/*
> +	 * This device supports a per-device lkey or stag that can be
> +	 * used without performing a memory registration for the local
> +	 * memory.  Note that ULPs should never check this flag, but
> +	 * instead of use the local_dma_lkey flag in the ib_pd structure,
> +	 * which will always contain a usable lkey.
> +	 */
> +	IBK_LOCAL_DMA_LKEY = 1 << 0,
> +	/* IB_QP_CREATE_INTEGRITY_EN is supported to implement T10-PI */
> +	IBK_INTEGRITY_HANDOVER = 1 << 1,
> +	/* IB_ACCESS_ON_DEMAND is supported during reg_user_mr() */
> +	IBK_ON_DEMAND_PAGING = 1 << 2,
> +	/* IB_MR_TYPE_SG_GAPS is supported */
> +	IBK_SG_GAPS_REG = 1 << 3,
> +	/* Driver supports RDMA_NLDEV_CMD_DELLINK */
> +	IBK_ALLOW_USER_UNREG = 1 << 4,
> +
> +	/* ipoib will use IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK */
> +	IBK_BLOCK_MULTICAST_LOOPBACK = 1 << 5,
> +	/* iopib will use IB_QP_CREATE_IPOIB_UD_LSO for its QPs */
> +	IBK_UD_TSO = 1 << 6,
> +	/* iopib will use the device ops:
> +	 *   get_vf_config
> +	 *   get_vf_guid
> +	 *   get_vf_stats
> +	 *   set_vf_guid
> +	 *   set_vf_link_state
> +	 */
> +	IBK_VIRTUAL_FUNCTION = 1 << 7,
> +	/* ipoib will use IB_QP_CREATE_NETDEV_USE for its QPs */
> +	IBK_RDMA_NETDEV_OPA = 1 << 8,
> +};

Has it been considered to use the kernel-doc syntax? This means moving 
all comments above "enum ib_kernel_cap_flags {".

Thanks,

Bart.

