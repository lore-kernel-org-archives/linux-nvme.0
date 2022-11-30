Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00435C4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ew+rmcqxH2n7lRVyzxgZ+S2EuF0zHGkt1auf+7rBZUw=; b=mO7MnEEad1N4hqIprFQvSlphv2
	SpYxcPtWxdqaZAH1Gq3VqmrjjnCMqBqmSEvcpNbTnISHjikaiBWoJjyk+R5nGNUa2IGx3+IFqRA11
	n92HI+NpxoPleGh0MxCrlYDIpA1TtDygaZ3w9k3SzHD7ggCFwl9a+9s7FnrXfW1Uh4CHlcQimEUJr
	BIGT+H+/GHCjMbaH/kkLRIsUY4w8kJae6fyKf510BJnnTA0fZguB2u7JGPDUN25JlFU+/4YY+5oMj
	dhfvBWueFqwtnUHi5CL8XBHSMnJW4nOh4Cujqe/pIwsFGyH6ior7FPmMnjmJtjMWpHhiHzP4Eh1Mi
	TTKWwR1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PWM-000F2T-HG; Wed, 30 Nov 2022 16:01:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Lbb-00Fw2b-NG
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 11:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669809021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ew+rmcqxH2n7lRVyzxgZ+S2EuF0zHGkt1auf+7rBZUw=;
	b=CPAy0fvM2lMnDi9ZODFapjUjdhzTO3J+3mLJzUciXOCStOQEbneEXCb9f3vUJC2KjWx0IO
	Zfkz7uyR88JCk6y6fH0c2pXGr6c+ogrFFmhr6Qtn/xqPWowYQvyuiZcCFKFZCHrVmaGLYL
	k5GoyKRcYUcRpLRijmsE2g2AgKO4auU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-zEXFTKXDOs6HOTG3Sj9T4g-1; Wed, 30 Nov 2022 06:48:40 -0500
X-MC-Unique: zEXFTKXDOs6HOTG3Sj9T4g-1
Received: by mail-wm1-f71.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso9293233wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 03:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew+rmcqxH2n7lRVyzxgZ+S2EuF0zHGkt1auf+7rBZUw=;
        b=v5eNDF7/dkwuLgaqET80gvSRjQYMGjHUVg522PpFqRv4kBq+Y2F0OSLf3Xrj04G3Y/
         6H5Gwtws0G0N17zo0/APLVj9cMjtelbeJMn8jOny3aZdmFM5R8JJrF6HVPL0e937925i
         9adb90gWqxCC9DLufAOorveqVJz4eBt4UlN8jYaeqAdkLFUUfIVE6f9avxJ2VXngym/i
         xU0h/b79AL6GtHl3pv6tUxyn6cO24C4JL7Uw4vTonv4tvt5RGELQo6/X3cZ3fS+vO7Hl
         vUz+8l1vN00LbePkxvc7FX3sqSY8xT7HtKWBwchWS64TfOoepqsKa82zB6i0FqxP0UTb
         eaDw==
X-Gm-Message-State: ANoB5pnj3SITOHionbAK7Nm1aIE6R26oVf98PDwtbOBPMC8fR42mA6Wi
	Wv4/svXl5pBbpREj38eSQ596AXd6A3POZ0SYAXL2Fi5jp/XgGiYByHkVrauKNCRoHLMvJbza70D
	IIvvyoHvqFJwDHhf6lOqDIehPzxQ=
X-Received: by 2002:a5d:5f04:0:b0:241:e9a6:fb3 with SMTP id cl4-20020a5d5f04000000b00241e9a60fb3mr22408090wrb.462.1669808919572;
        Wed, 30 Nov 2022 03:48:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71i1QvnhhrXaTwa+I+8EpX/qnDqrYR4GbrQTWzEGi7bUvVncNy/xc2a74B4erNgTJKDcQn3Q==
X-Received: by 2002:a5d:5f04:0:b0:241:e9a6:fb3 with SMTP id cl4-20020a5d5f04000000b00241e9a60fb3mr22408062wrb.462.1669808919318;
        Wed, 30 Nov 2022 03:48:39 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c22d000b003b497138093sm1620841wmg.47.2022.11.30.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:48:38 -0800 (PST)
Date: Wed, 30 Nov 2022 12:48:35 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Steve French <sfrench@samba.org>,
	Christine Caulfield <ccaulfie@redhat.com>,
	David Teigland <teigland@redhat.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, cluster-devel@redhat.com,
	ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Message-ID: <20221130114835.GA29316@pc-4.home>
References: <cover.1669036433.git.bcodding@redhat.com>
 <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
 <20221129140242.GA15747@lst.de>
MIME-Version: 1.0
In-Reply-To: <20221129140242.GA15747@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_035023_872832_228CC3DA 
X-CRM114-Status: GOOD (  13.68  )
X-Mailman-Approved-At: Wed, 30 Nov 2022 08:01:13 -0800
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

On Tue, Nov 29, 2022 at 03:02:42PM +0100, Christoph Hellwig wrote:
> Hmm.  Having to set a flag to not accidentally corrupt per-task
> state seems a bit fragile.  Wouldn't it make sense to find a way to opt
> into the feature only for sockets created from the syscall layer?

That's something I originally considered. But, as far as I can see, nbd
needs this flag _and_ uses sockets created in user space. So it'd still
need to opt out manually.


