Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F95AC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMeDNnFf40OhdMjxU0exFK355hXB6817HlOWlu7vFZM=; b=nxaBGjsgctnL6Ea/CPfxOV94qU
	X0NYnqxmbXOv8OSA1sFJwaWpYjC2JOOr2aMTTbRcy89zb8o+DHgDPENn6lvceDeC8qkkbEsPFVlAo
	yFXEsOp6NCxw/lgYRv2hd+U0q4zosmcIA6rVgiGnXMyND7b0zW1EFbacgY7Y5zuFZXD2MKk3d3WJs
	FBjtDygdH0MWE6gpZIXGrygu+pbAcnR/HqcXAGSdDXEvnfw7c96LhMe+WMHbvFa09fX/q+0PnGXKg
	relQ01qukRJ89bCvWYWZRaRo3tPtwNcQNInh2UkzWVTd+cyRNUd9/Uwf1b8jUWyU5WqQrJJT6bAIx
	ho09X9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwEi-00000001Vb3-2RtQ;
	Wed, 19 Jun 2024 14:24:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJqGw-00000000JdX-1Dal
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 08:02:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B204868AFE; Wed, 19 Jun 2024 10:02:18 +0200 (CEST)
Date: Wed, 19 Jun 2024 10:02:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v8 05/10] block: Add core atomic write support
Message-ID: <20240619080218.GA4437@lst.de>
References: <20240610104329.3555488-1-john.g.garry@oracle.com> <20240610104329.3555488-6-john.g.garry@oracle.com> <ZnCGwYomCC9kKIBY@kbusch-mbp.dhcp.thefacebook.com> <20240618065112.GB29009@lst.de> <91e9bbe3-75cf-4874-9d64-0785f7ea21d9@oracle.com> <ZnHDCYiRA9EvuLTc@kbusch-mbp.dhcp.thefacebook.com> <24b58c63-95c9-43d4-a5cb-78754c94cbfb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b58c63-95c9-43d4-a5cb-78754c94cbfb@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_010226_505620_9A7FD2DF 
X-CRM114-Status: GOOD (  15.30  )
X-Mailman-Approved-At: Wed, 19 Jun 2024 07:24:29 -0700
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

On Wed, Jun 19, 2024 at 08:59:33AM +0100, John Garry wrote:
> In this case, I would expect NOIOB >= atomic write boundary.
>
> Would it be sane to have a NOIOB < atomic write boundary in some other 
> config?
>
> I can support these possibilities, but the code will just get more complex.

I'd be tempted to simply not support the case where NOIOB is not a
multiple of the atomic write boundary for now and disable atomic writes
with a big fat warning (and a good comment in the soure code).  If users
show up with a device that hits this and want to use atomic writes we
can resolved it.


