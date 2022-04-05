Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E1AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7eSCNHxZKG+GFcxY7AOGv587rI9UycYsXnouOwwMe8=; b=KYFL/Wz9f1N+i0Akg3DCJ16MJ1
	SoapLVqrfnu6CapzyZtDY89ZwxEoKDtlDvFxfGph6IZuBtBLevRdeE07b774h7H3L1k8BPhOFUIX3
	MtnhFrkytT4vbuHE512zfAkPD2Wly2h/aRU/13uYjUmZmNhbATG4pIektC3DAREg+6PwuP+hyHBOZ
	FEIRcACykoVrpqfinnGl0y7RDjkMy/TbU5A65WceIbEET4R+M5XDrvCXJvhDOU6mTD5WaswDNN/On
	JKavSmtQMr1czvyPmpvNNcTcrgj3dzIOYO+9Xo/YrM70vmVr6CwbJww8+0bOKgKcKUjJuyJQ8f6y7
	JAx0v//Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbkg6-001aCa-MN; Tue, 05 Apr 2022 15:01:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc0k-00HBwj-JS
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:45:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 79DCE61500;
 Tue,  5 Apr 2022 05:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CB4C340EE;
 Tue,  5 Apr 2022 05:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649137547;
 bh=gRpdesPvnbIGSxebVlyaRkNxgcCbKC3Od+BYMZifZO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WD+JRYvskhSmVVBMnMJw0/1G3H6a+N1C9uZFgKiHbKzNPvqVuI6L5OyuaPIU/GcVK
 p9Ezd99EsWg7F8epR/6qh8MV6eq7SgFXhFUqUug1upndo/Efkq0axblWoZn9JvLHDk
 NmqZsxxMKxC5s07o7hS+Re7Ai9CVbL9JWXZ4WmIn3HtdqclK0tbR58xtxwCEaUuNp4
 liDxWU7q1LiJKHCoGIo3C9Tw7hPvCg+1fKCDf2CEB0PL71aw64iAmFgGZNBJf/OMw9
 DEbVdO/ONbCL1LJqtEdfTkuVGmfBovn1Bkd5w68OE6L/BH3NiohJZN9o1fac11yUrW
 lKSD3HWND6PnA==
Date: Tue, 5 Apr 2022 08:45:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>,
 Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christian Benvenuti <benve@cisco.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Bart Van Assche <bvanassche@acm.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steve French <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 target-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] RDMA: Split kernel-only global device caps from uvers
 device caps
Message-ID: <YkvXh28E3pLZSNTj@unreal>
References: <0-v1-47e161ac2db9+80f-kern_caps_jgg@nvidia.com>
 <20220405044331.GA22322@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405044331.GA22322@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224550_717513_E24CEB15 
X-CRM114-Status: GOOD (  16.51  )
X-Mailman-Approved-At: Tue, 05 Apr 2022 08:00:58 -0700
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

On Tue, Apr 05, 2022 at 06:43:31AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 01:18:00PM -0300, Jason Gunthorpe wrote:
> > Split ib_device::device_cap_flags into kernel_cap_flags that holds the
> > flags only used by the kernel.
> > 
> > This cleanly splits out the uverbs flags from the kernel flags to avoid
> > confusion in the flags bitmap.
> 
> > Followup from Xiao Yang's series
> 
> Can you point me to this series?

https://lore.kernel.org/all/20220331032419.313904-1-yangx.jy@fujitsu.com/
https://lore.kernel.org/all/20220331032419.313904-2-yangx.jy@fujitsu.com/

Thanks

