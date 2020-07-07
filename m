Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999CC433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 19:01:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18B720720
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMG0mqtS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx0gQyHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18B720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LSb96QzT9MeWtXAjY4DGLyciQxutlRy+YZDsdNg6b7s=; b=BMG0mqtSXhP4TWFAPDYemW5ZP
	egzvsurKCQzsebR1uCc8gd3z5NrfXY9Wu/Th8OUh3O2J1W3e3ap/dt2e3YqSRCiOO44DagGCPCgKw
	mIv2EYT0sMCtArohzOt5pdMWc4/fN1We4akwrQ23+jdbT51gybIKrIqLD1wO2mw0iUqTQFGDRborT
	mrYzfu34oDQIGwTy9DzSGsRag2jL0WqqBP2oNCvz73soyvJ3bhl7hOrUhfiy0uaXKbnuPDQ5UFlSR
	EOA3wwY2srX0VlAsA08cTwN+/2o1C7cldkIgAnhHscfcZ6x9vzBWhCtEh5rVAzufdVl6LoU2uJerN
	TwGOFlNpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jssqT-0007dd-RI; Tue, 07 Jul 2020 19:01:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jssqN-0007ag-ID
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 19:01:29 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D677206CD;
 Tue,  7 Jul 2020 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594148485;
 bh=yTAxqihv430USW9Qh1Hfg9Wp4VIfe9iWsjLd10DcD4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cx0gQyHstH9QznqMz6bmbgO+S4FeDt1zsNIW/PBoaBvg4/EfZmfApfEHxNPOj4r8u
 heL7RXkJMZXbxqNcDH55IQUMgGuFkgak+A5qVJWtsc7LaG3nYz8n7IE+5IyfI4yUHs
 KnuLhYV4Lg1mZ7wt0k4uoLJFgahZVwDzjMVagdm8=
Date: Tue, 7 Jul 2020 12:01:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Message-ID: <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_150127_704396_C95AEE09 
X-CRM114-Status: GOOD (  10.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 03, 2020 at 10:49:24AM +0800, Baolin Wang wrote:
>  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
> @@ -844,7 +844,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  	if (dma_mapping_error(dev->dev, iod->meta_dma))
>  		return BLK_STS_IOERR;
>  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> -	return 0;
> +	return BLK_STS_OK;
>  }

This is fine, though it takes knowing that this value is 0 for the
subsequent 'if (!ret)' check to make sense. Maybe those should change to
'if (ret != BLK_STS_OK)' so the check uses the same symbol as the
return, and will always work in the unlikely event that the defines
are reordered.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
