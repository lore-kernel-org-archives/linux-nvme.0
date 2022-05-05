Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CBBC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGjMxZ57zywOI5HZsX4hLcaGMOczO1dNkCbf3zEj4J4=; b=yYIdErsFIM5sPS+dwKItwiMQBk
	Vrzp9zEPRLClNLkAjpaDRlhdRGHX6zcL/Mp3c8+B9W+9gzUrob+t5umXZTOiVRuLRm92iQ1eBTLF7
	gnwECug2w/BNIEpiGeZv0Ka53jgEz9HWXMfEkizrSxf8LgBYoBQYIbRuQh39pK8sdj+vhX4GiHGmt
	qYLMnkOS1E3L9PLvDxzCIBy/UyWVhkIkj/nvpJ+sn5ga/bOAHCz5lcStnFae/CrV6tDfASFzdPdAl
	jDb9tiu/cjXHldn1xE8Posl2oIcEuGF9mx2WHZQbYHvb+xEieysLDty0aWCheXKRMeAiY0WqcwQr7
	CC0EjRHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbcH-00G3un-F4; Thu, 05 May 2022 13:34:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbcE-00G3th-Mw
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:34:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 88F9468AA6; Thu,  5 May 2022 15:33:54 +0200 (CEST)
Date: Thu, 5 May 2022 15:33:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220505133354.GC11853@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505060616.803816-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_063358_936912_02D61765 
X-CRM114-Status: GOOD (  11.83  )
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

Sorry a few ints while looking overthis again:

> +static void nvme_end_async_pt(struct request *req, blk_status_t err)

The naming here is a bit silly and doesn't match what we use elsewhere
in the code.  I'd suggest nvme_uring_cmd_end_io instead.
> +{
> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +
> +	/* to free bio on completion, as req->bio will be null at that time */
> +	pdu->bio = rq->bio;
> +	pdu->meta = nvme_meta_from_bio(rq->bio);
> +	pdu->meta_buffer = meta_buffer;
> +	pdu->meta_len = meta_len;
> +	rq->end_io_data = ioucmd;
> +}

And this really should be folded into the only caller.


