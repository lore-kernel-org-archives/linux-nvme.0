Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888AEC54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwaxYYyv5GcU/4LpclmChFlbuWnWG8JvsIrruFsZvRk=; b=guh3M4epy2M+nqSNQvhbNKpQRF
	AMIVhGfYBwTg3e5D0Sn0eOBiPe+3GkOUGBK3PA8xaHroCw6a/Qfkgada/dENR+GVBOZpOepGp7M2W
	8DdsIcOlobIlzkZNwGqpPJ/paJjkuBYneWk+zdXwi0c9LLHPSCd9K0Kx2jLNr1ZJ3ADPgJWXQ0nOI
	/CUeAjG3bEzz0usQwq9cClvOmXwiNKPDh4u0t2/6RpbGV5OU0p3VdFJkyDrQHj31kAqMPdz8FKadB
	Ppw3A8Ds3XRehKJJTyiu/e+cs7l4vVciUTjWY418VxTxA6LaTwpEEWylOHtSHNMhutmdmI3E8PsCd
	Ac9Nthww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxPP-00000006jJI-3XSD;
	Mon, 02 Jun 2025 05:08:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxPM-00000006jIo-2TH5
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 05:08:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2BB768D0D; Mon,  2 Jun 2025 07:08:17 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:08:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jaka@linux.ibm.com, jlayton@kernel.org, kbusch@kernel.org,
	kuba@kernel.org, kuniyu@amazon.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sfrench@samba.org, wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250602050817.GA21900@lst.de>
References: <20250526053227.GD11639@lst.de> <20250530025401.3211542-1-kuni1840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530025401.3211542-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_220824_771982_7A7BCB89 
X-CRM114-Status: GOOD (  12.40  )
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

On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> In the old days, sock_create_kern() did take a ref to netns,
> but an implicit change that avoids taking the ref has caused
> a lot of problems for people who used to the old semantics.
> 
> This series rather rolls back the change, so I think using
> the same name here is better than leaving the catchy
> sock_create_kern() error-prone.

Ok.


