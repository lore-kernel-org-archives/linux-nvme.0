Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04653D1F9BC
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sb2xGsKMUQpHqTU6d6wbwOW9imPiiQCMhOD+8gvlZqM=; b=U8EmYBtyC61BadGjaz5c1TPUwe
	TtdXZngYtmn9MVsRqFQl+tVzcLyM9zvGpaqwqpm9v4xOSsBYeHLKGwyRcVNPBoj8S1EFqJ23BhR2B
	t/Icplsd8iw5U49kzgJUH+s65V3TV0A/xqEVqHSeYC0NfE5MDpsC9BaxflF/nEnmBAe3/Q3fPaCq7
	7RUeKvL6jJQtrHiYuoxt7DdjaUNjjBIiav8luxIXCYDmxVr4e5kawEbD00AQ7S8K2iy+ILxKh25Cx
	/MOAieeowmYZLs2XbbT/QjMapwLaTSsd1izYCPxlen93wqGfBYRDvti+lGsNrP7MwB+TUlsQ4WWnx
	IMGtozQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR7B8-00000007tez-1Ate;
	Thu, 04 Dec 2025 11:07:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR7B6-00000007tea-2Jww
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 11:07:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A036F68B05; Thu,  4 Dec 2025 12:07:09 +0100 (CET)
Date: Thu, 4 Dec 2025 12:07:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Message-ID: <20251204110709.GA22971@lst.de>
References: <cover.1763725387.git.asml.silence@gmail.com> <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com> <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_030716_756009_599FE2BA 
X-CRM114-Status: GOOD (  15.35  )
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

On Thu, Dec 04, 2025 at 11:46:45AM +0100, Christian König wrote:
> On 11/23/25 23:51, Pavel Begunkov wrote:
> > Add a file callback that maps a dmabuf for the given file and returns
> > an opaque token of type struct dma_token representing the mapping.
> 
> I'm really scratching my head what you mean with that?
> 
> And why the heck would we need to pass a DMA-buf to a struct file?

I find the naming pretty confusing a well.  But what this does is to
tell the file system/driver that it should expect a future
read_iter/write_iter operation that takes data from / puts data into
the dmabuf passed to this operation.


