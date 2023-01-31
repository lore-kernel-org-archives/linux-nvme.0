Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952FBC636CD
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9VhNAncouGPghsLCtxdhrn+26s29dRN0H0czKp2bTE=; b=xxBbUWFRluxV1yr1zNxnKNnmvZ
	Xtq03Gzh38gHzmbb3a02JTLKd7fx50YIYwDNQ3uAUuyzW1sWFvcWy0oQggyGiTF0XF+IufpPhAAEd
	AMMGS525SWDJNWZv6M0iAROT4joz4UZkhIkoq8iCsoT+bohPK5dnq9l3oe6oszqaDQjPhzjTHJF6D
	BQXEm9VElth/tDxoQYYJTcPLFQshtE/4XGxAdanQwu6U1as+Xnhxox2pxMxpHWvDUjd+G20hnCSMG
	EqPNFqLcrHQOhNpIvr1dRLhI8p9aXU2uCn6vgquOBXQl02nDtIdtKyehe78QAMGzzZnA98dHEPAnM
	/NH+3Q4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjkJ-006Ng9-Fn; Tue, 31 Jan 2023 06:03:55 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMgTW-00664H-Tc
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 02:34:24 +0000
Received: by mail-pj1-x102a.google.com with SMTP id pj3so79598pjb.1
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jan 2023 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9VhNAncouGPghsLCtxdhrn+26s29dRN0H0czKp2bTE=;
        b=ADZjED2w0momUtfafOuSNuN7ZxxrP0KeUDW1RTHuQc80r3inyDTwQ1MXq8KQQCJPA1
         2IjPoFNw6EOC1H2jGbZ0sNPpCmiE0a1bmED2KiD/tXvqcCixj5NIzO02aStn2z3ovwP6
         3Z5APDKQvCBsotmTrQZGzddlPRda1HIIj6Rto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9VhNAncouGPghsLCtxdhrn+26s29dRN0H0czKp2bTE=;
        b=jkUhmjL71JRORRCc+6Xi+LKFdLj79e7BhfGmbxudUld4luJy8XUddkjAuU0XlPGLFk
         c7UB32Pc8CVsMJ8eh1TfOLXiQGZPrLHDleAAA7M2NogLHoEHF5jVGjMFi2EzfxQtXXix
         RbhiObOMP2l9UWmOE9rRwr2klqG28VWxofyBBi04xwfnYAmF5IgHhrT3ZHADocKsQpaT
         hJJFLLDvYZUz2td4xDV6ywpxmw+w6TAhV4r6AJuZE0sE2I1Nw5GK/avaN+EtdOlvhnFf
         OaqzOnavDAggKP2sAp9tNNJk8j4F51z2q3YeweOmG8apd0kcMJXrbqW9Qpk7Zq7A9OKJ
         RZoQ==
X-Gm-Message-State: AFqh2kpXJFWAzfn3UDJMM9/Mq1WTtQTdWhfD8FiKLdEz+Z7KkTuL9YhB
	8bNP+bD2WtT+rwjRyhQOCRJbYg==
X-Google-Smtp-Source: AMrXdXsnmC1gw3eG1rPepfp90wWItWSXAPyy0WFX0PxqmtkL6j5e8V5dnOtluVb8V5qnNkoyExcM+g==
X-Received: by 2002:a17:902:ba85:b0:194:828d:62b0 with SMTP id k5-20020a170902ba8500b00194828d62b0mr38778219pls.48.1675132459197;
        Mon, 30 Jan 2023 18:34:19 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b00186c5e8a8d7sm3404428pll.171.2023.01.30.18.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:34:18 -0800 (PST)
Date: Tue, 31 Jan 2023 11:34:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 10/23] zram: use bvec_set_page to initialize bvecs
Message-ID: <Y9h+ILaGkNOhYJC5@google.com>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130092157.1759539-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_183423_037285_8F4CCC65 
X-CRM114-Status: GOOD (  10.77  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On (23/01/30 10:21), Christoph Hellwig wrote:
> Use the bvec_set_page helper to initialize bvecs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

