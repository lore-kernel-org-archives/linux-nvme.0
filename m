Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C66EE57EB
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 23:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NjvU40YJYLy+gfrHTlysVhGW2S+gbVGxGXBw1Ao8E5o=; b=E3YmrpmHAwj7Jd6quTFWiPPiue
	QRyBRsWBkwHcVDZhEYYHMDjDy253LoQ1KB9hKkhfC6Ufs/rE7K/aGL+65zzMwSh5M7q86HBciIXvc
	jeTXYG1i1cQQAYnvZL+55zutn5NDEU4uxPKY00MQjMwWXyDAPlQraIzsaHy5PcXb4odFof+hTuX7D
	bIsEKN8SGKXX78TICvtzh8gocR8UzO7/B9YGxPSVxW3l/fEJbU7njL+cPNLbM2w5R4YMbl+O4tY1/
	FyZmuBP0JaWYx7d4FL5cmaYQUFOqGGzvzzfYupseiDBenim1npv+g8h1O/GwGRruHtdSzvj3rnfAf
	Dh2VYm/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soWgQ-0000000BL4b-2IPz;
	Wed, 11 Sep 2024 23:23:34 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soWgN-0000000BL46-2h5M
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 23:23:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 22E22A413F3;
	Wed, 11 Sep 2024 23:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3828C4CEC0;
	Wed, 11 Sep 2024 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726097009;
	bh=fzeEecEtUpF8stRcCeg34tBgDLIrgkBerDWOvGLlTAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBp+8AGoYbgHyz5jGnBrKs+2Ckxn4y4gmUkpdURkvV/lxEPM8hysSxVND8MA2vhZ1
	 E6HxkFfKeF6dkQzXG7N4jVYmqZXJ+EdmM6inpuLc2NckAX9UBeH0Md73b/0NXfj4LB
	 qEnN24Ih5tJ2R8uDzGhSzvpHN1juoN2l1hIRhNumLyrgnUf2zH1QqBLvJ2ULbky4If
	 DWwhU/io570CA5Gj0zKSMlMj5N5KT5widyClG8rXLsTyLONfAL3aUvg0BIQdBLlK6v
	 hVRRn2PJ3805hIBUAksczDuW8+EoGUSYyX1WeBD1IXzM54plBsRt15J3OiVWoSYTy/
	 q47/6rrM++Akg==
Date: Wed, 11 Sep 2024 17:23:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv4 10/10] blk-integrity: improved sg segment mapping
Message-ID: <ZuImbgYqqZzLZkho@kbusch-mbp.dhcp.thefacebook.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
 <20240911201240.3982856-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-11-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_162331_766422_5E96C8A4 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 11, 2024 at 01:12:40PM -0700, Keith Busch wrote:
> @@ -102,6 +103,12 @@ int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
> +	 */
> +	BUG_ON(segments > blk_rq_nr_phys_segments(rq));

Doh, this was mixed up with the copy from blk_rq_map_sg. It should say:

	BUG_ON(segments > blk_rq_nr_integrity_segments(rq));

Question though, blk_rq_map_sg uses WARN and scsi used BUG for this
check. But if the condition is true, a buffer overrun occured. So BUG,
right?

