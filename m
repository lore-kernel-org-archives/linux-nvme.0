Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45269C27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRIYdy7Cw8WjP83tVRIkaBNCw93lHm89f0CKTl2PtMo=; b=XHfUcg+XUYbK/EKkxljWRO3T/9
	QO+1iMUomn0ZmJu7OYX6V+zlRmQnCZSFKJjOVbW9w7iABmsvIN5joo8RkLxKqTZupMSZM5SxLG/Oi
	xd8baI7mslXXKmYlFq2HxZPMF+eoK/Rb6ie3tBvUCrwjdZ1mto2WOgDp58v6ZG0/qVS7dlrs561Bg
	fCFJ1gLbsFzRizKirTJ56elxXg4MyLTWgzdM3LZqEi1lQzM8FJvfFbJU0q5yvtutd9uFbWJb8guvw
	cRj0vdZ9ZNMAJ2pXxHAkn5pmkek/OhyHR0sRy/zDnsulKWsCUGfhkB+QbYUWI8fV2TDAs61nb5gEH
	hLbowcyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElsq-00000005AaO-0OIw;
	Wed, 05 Jun 2024 08:20:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElsn-00000005AYo-1ffJ
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:20:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3369B67373; Wed,  5 Jun 2024 10:20:29 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:20:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240605082028.GC18688@lst.de>
References: <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org> <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org> <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com> <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de> <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org> <20240604044042.GA29094@lst.de> <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_012033_611681_1A74B943 
X-CRM114-Status: GOOD (  19.08  )
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

On Tue, Jun 04, 2024 at 04:44:34AM -0700, Bart Van Assche wrote:
> On 6/3/24 21:40, Christoph Hellwig wrote:
>> There is no requirement to process them synchronously, there is just
>> a requirement to preserve the order.  Note that my suggestion a few
>> arounds ago also included a copy id to match them up.  If we don't
>> need that I'm happy to leave it away.  If need it it to make stacking
>> drivers' lifes easier that suggestion still stands.
>
> Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations sounds
> much better to me than abusing the merge infrastructure for combining
> these two operations into a single request. With the ID-based approach
> stacking drivers are allowed to process copy bios asynchronously and it
> is no longer necessary to activate merging for copy operations if
> merging is disabled (QUEUE_FLAG_NOMERGES).

Again, we can decided on QUEUE_FLAG_NOMERGES per request type.  In fact
I think we should not use it for discards as that just like copy
is a very different kind of "merge".

I'm in fact much more happy about avoiding the copy_id IFF we can.  It
it a fair amout of extra overhead, so we should only add it if there
is a real need for it

