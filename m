Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B2AC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnhlRlntuCOOQ0ioYwE6+BbEmASXZbGplo3IMB2V950=; b=zjFTygG09sRX6+/Uo3P40vrMq2
	K03+avq7Lt33Z0kmlRXh8AF1hl6zlRakA2z18KDeBDQ46kV0bEYNO+1uXhebUkgXHiBe2st9W0lLg
	64l5rwHbpBtFzXTJMltnWZjvZnOKC5fope4Vt25E3fJWFutnTqOep6ANPaE43YjQEUykxYggyC+7W
	ejueGKCWpIaxCBcuF7kypjoDFfRmKUWwhTa4Pef4laMJ/kSBB+5ygxmUSiqIGFm5fP/iROaXMCI5f
	MSevSr6/dADeqMBgTujshdYkoHtJRiWaqVyw8as8Awtjlr1Pfjk8xeYQdyz/U0wnBn/mQBiXgWq1J
	Z4p/iUjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90Sv-00000005VTS-2Unb;
	Tue, 22 Sep 2026 13:23:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90MC-00000005UKI-2wNq
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:16:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A774668C4E; Tue, 22 Sep 2026 15:16:11 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:16:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
Message-ID: <20260922131610.GA30468@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_061624_895639_A8948894 
X-CRM114-Status: GOOD (  13.10  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 06:23:21 -0700
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

On Mon, Sep 21, 2026 at 02:38:48PM +0100, Pavel Begunkov wrote:
> Premapped buffers don't require a generic bio_vec since these have
> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf

s/strore/store/

Can you please expland on the splitting considerations a bit?  Preferably
both in a comment for the details, and in the commit log for how we
arrived at them and why they are fine for now?

Otherwise looks good.


