Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63933C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 14:02:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2866A610E9
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2866A610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mi3nFRBuWVqnfLCIRb2tlspCK58yKUNTtj5T61pvtgM=; b=dtHKuPAyb6tbbc
	Lgaobt42UNhJ8ufdPEXfmcspbGsPGRSazF7WgsEy15XYPZuzS8fggsAoxo9MWAesCcHBvWfZAgWvz
	TWOj1qCtIXV2/04ZnBrbwTXzVy1PAMR5rENxc2rUP1I0l5bldorG3Yq8ATUziaBFv+D3bm9Q0KyG9
	0pl+0dVH1VT4npW/0y+v0sDnZFHbLfP+AtcGdyOBaDtUbM0zCBLYZ9I1+BzDTxVZhK2u+1Y9c/fhY
	LYVQ+hBzBMSRDuDJLquGOfg9EC0m73ptH6MPGvkEyeDDnmo2B7gcDHIt7rAKRfo9kg/XjpyfFEqR2
	6tpQc02tNS4XilSYWrBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQVUF-009GMf-3k; Wed, 15 Sep 2021 14:02:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVUC-009GM3-LC
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 14:02:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D34760FC0;
 Wed, 15 Sep 2021 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631714524;
 bh=/h9RIezQ+oq+jDISBf6N4M0fIWItJLyk8uAEy8Lp3/Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UBNEsp3KMRXkTD42n3CXGSB8OBCBNGQiSfFuu5F+rqklGWD8+1x0IL9Jtucnv9ZkZ
 pfU1u+79VSe+uHaY5DfIpx1YyPmkpHjHgRzD0mGqLGxUtsAxwN1QBk/fwa9IBJE/v1
 HS6svKxNddgfDpqY7XXLcqvijvd+b9eBdNqgHpNOzX8lJtXKbIoOVH3A3MPBghS5CF
 3X4CRkE+Y/+n0S1VJqnYYpj4DEbP0MiqqbBr1+iviLTR4nt2tkcI6ikpeP6RBZId3O
 10Nzgn/PDI90RCdFHCfv9onug6psThsRALgaP+/uHBMkmWHk1w4hKiAcZZ46tCTrd8
 a+L7sbiBAZ+Gw==
Date: Wed, 15 Sep 2021 07:02:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Message-ID: <20210915140202.GC3778445@dhcp-10-100-145-180.wdc.com>
References: <20210915072006.956307-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210915072006.956307-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_070204_755543_96F0D23F 
X-CRM114-Status: GOOD (  11.88  )
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

On Wed, Sep 15, 2021 at 09:20:06AM +0200, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The v1 looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
