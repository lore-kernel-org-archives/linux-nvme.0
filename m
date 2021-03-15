Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F233C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 15:35:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDD564E22
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 15:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDD564E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cFfFD/Wu9U2KOtUDkUkrBcL1+TkEwpZEYI6CXRVdWsM=; b=jaLOEdMq4aALYIjXtpIl0EmYu
	a96O9FvgP//uLC8fa5CtmahA7GbyjXSz8PHkfNdUgdBVq+uYLZnrPbua11zSHrzHi4eUZ82CrhgNV
	pqfGHfcNyfUgIYMFeF8s7dbwRPFP4btRttOf1LfQ5qpRcadwKgY4RgvkZwTKVH3B+WF0TSfMkejzZ
	7vWbC2o5eUbwbjJPmBtx0YAo7L/fAuse2hf0n4Z78YGJmZVPhq6wgu1sAR60s9BEf8Ebx3BV1ucqX
	NmZQfIXlfkhM6+UQofv2BnIjpkOVHQwzz34RxRF6ApQa+hrVuSjpxCx3K8PmzQ1GXNxXxdw427rP6
	omHUubnHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLpF5-00GH5i-Fp; Mon, 15 Mar 2021 15:34:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLpEz-00GH58-OX
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 15:34:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 166F964E22;
 Mon, 15 Mar 2021 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615822482;
 bh=h7Bz2LtLFlI3s/sr9NkoTiWEdmMMj/K9l2L2MGXsCEQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fFMqkQ2qJPnlMDVcEKm6P43hWrnRfuzPJFpPGEL3eJ+85PUJqrczCCbfSELE449vD
 U365D4T4ma/KhQaQs13AEiQ1y38i6wMTNWBfvlQSwTtqtBN2MKUdzhVDlLVvLYjT9w
 w8KLcq0j5Q1pvRsWEfQ//jUhDbpzSLIIs3dsIf0rPhrO2w153vFscDVynduYUaOWcO
 kk2OZcxlJSvcy0I1b7S3C1t0rnOB2USMzKA+IkW+gfddd3MwusyNYb+KLe0suiP5Kp
 T4erLtP6/TURouFNZ2qih513vgI12TdzNr7OaGTYD1CRg3eognm3/olJUivQWeLC2b
 hj9MrfT9XuL2Q==
Date: Tue, 16 Mar 2021 00:34:36 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@wdc.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
Message-ID: <20210315153436.GA17369@redsun51.ssa.fujisawa.hgst.com>
References: <20210315093438.66082-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210315093438.66082-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_153446_046718_133D27E5 
X-CRM114-Status: GOOD (  10.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 15, 2021 at 10:34:38AM +0100, Christoph Hellwig wrote:
> We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
> the hardware, but currently get the units wrong, so fix that.
> 
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
