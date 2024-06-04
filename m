Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673ACC25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSZ4kM1baM0Yr1n8F14QDY/zsEWU3JniU8UtUk1QePc=; b=wEH9byfqFj7xZ3+FFJbXYg85a/
	es1ShEu6/0iefk8feHi/Sz4NU2oMYWGW+XPCXZ6zn9CobEr90PB4gpUZ/VQ66uv1qIU2801EqKU5q
	9pKeU7JTxEC8x8J5natcmctR2LUKb1x864zgxtI6h7i/y255e0j2UDZLo9h5vCkxUI3weEPYOxE/X
	8wMG//iJICCc6pebM4yyKVB53nxgBNlvxQpy8MawEa8fmgssbFZZwf5wLC72v2ovM6s7RGnalu6Qz
	QTmAa1jZAlSb6KMTpPuLYE4r9IEzWXJ1xjL9vleStVeOfl++VqwsSy4IYySQQrYw6T2EhXXCLX0NB
	yNhw2MKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELyb-00000001C3J-0jei;
	Tue, 04 Jun 2024 04:40:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELyZ-00000001C2w-0LH2
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:40:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAF7068D12; Tue,  4 Jun 2024 06:40:42 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:40:42 +0200
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
Message-ID: <20240604044042.GA29094@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com> <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org> <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org> <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com> <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de> <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_214047_402963_FE66C598 
X-CRM114-Status: GOOD (  18.89  )
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

On Mon, Jun 03, 2024 at 10:12:48AM -0700, Bart Van Assche wrote:
> Consider the following use case:
> * Task A calls blk_start_plug()
> * Task B calls blk_start_plug()
> * Task A submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
> * Task B submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
> * The stacking driver to which all REQ_OP_COPY_* operations have been
>   submitted processes bios asynchronusly.
> * Task A calls blk_finish_plug()
> * Task B calls blk_finish_plug()
> * The REQ_OP_COPY_DST bio from task A and the REQ_OP_COPY_SRC bio from
>   task B are combined into a single request.
> * The REQ_OP_COPY_DST bio from task B and the REQ_OP_COPY_SRC bio from
>   task A are combined into a single request.
>
> This results in silent and hard-to-debug data corruption. Do you agree
> that we should not restrict copy offloading to stacking drivers that
> process bios synchronously and also that this kind of data corruption
> should be prevented?

There is no requirement to process them synchronously, there is just
a requirement to preserve the order.  Note that my suggestion a few
arounds ago also included a copy id to match them up.  If we don't
need that I'm happy to leave it away.  If need it it to make stacking
drivers' lifes easier that suggestion still stands.

>
> Thanks,
>
> Bart.
---end quoted text---

