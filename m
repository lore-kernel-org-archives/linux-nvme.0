Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFAC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4030120772
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXQ++uyX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ijFfWtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4030120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=egGD1HcuwL2ofjP0uqKbt2Vxfn17+QBasoqgYEWdJtY=; b=qXQ++uyX3GIeJVLsmn4joVaja
	kkKgKtRGFrd9A2R/HqHDjRKzqxtKkVtncvBfJ97S5DoOqaCmpgIOBDRWJVVScDTj1Pg5g1dYZVcJu
	YzYdc+Aj41AQBJDyWhe9NEUfhCrXifB6E5j8L2B0jQelPfZs+A5qjl/Qv+LspGPfpzk/ANwy0W+fD
	1QNjOtOitPOToXNK9nWvwLtZZE0XVuqN3UW5SqkZdqOTTnhVgPKai9NCNL7acbSRB9m8qq000sJbR
	7XWJ8NHcmctOFDFozFTv20Skzvg/30m2J67x8kPbDxzpyLP6F1gd8s88SUFDqp+pA7Po0Dlipt+YQ
	TdGXr9RSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtIWl-0002l5-Mb; Wed, 08 Jul 2020 22:26:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtIWi-0002k2-NC
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 22:26:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9299220775;
 Wed,  8 Jul 2020 22:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594247211;
 bh=lM5lPKX1Bd3jLgErnNN1jz2kuESYkO0CxYdVVW6uDVU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2ijFfWtpgn2wz4tpI2n/dqDZMHM9quzl4mzWtHEOFF8BPfWvDLCTx0Wv2S7Mfh6/c
 REpS3cxWzV4tT0pIVfVIUbWVeK+NRRpF1ldX5abX9BIjzkNbqEvrkwwptVA6HlbJP3
 u3WCRAlqT6HwFAf3ZazhUZH3T7onlLZAupUViG88=
Date: Wed, 8 Jul 2020 15:26:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 3/4] nvme-pci: use max of PRP or SGL for iod size
Message-ID: <20200708222649.GB2288916@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
 <20200708005831.10013-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708005831.10013-4-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_182652_858655_F9890603 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 07, 2020 at 05:58:30PM -0700, Chaitanya Kulkarni wrote:
>  static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
> -		unsigned int size, unsigned int nseg, bool use_sgl)
> +		unsigned int size, unsigned int nseg)
>  {
> -	size_t alloc_size;
> +	size_t npages_sgl = nvme_pci_npages_sgl(nseg);
> +	size_t npages = nvme_npages(size, dev);
> +	size_t alloc_size = sizeof(__le64 *);
>  
> -	if (use_sgl)
> -		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
> -	else
> -		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
> +	alloc_size *= (npages_sgl > npages ? npages_sgl : npages);

This would look better as:

	alloc_size *= max(npages, npages_sgl);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
