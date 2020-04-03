Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDEC43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3004720757
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G941rJDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3004720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kVN8L3bGg6TE+jIdacYy+vrgRyffFrLX24+PSIovwxA=; b=G941rJDslKiVgT
	2cNx/7n9+vNxChkznNIx+JzjXRhoMj+M2T6FiUuvLmQv4xiuLM0GNxbV3z4ak4FUW4alKtFcwW7ME
	E9vqegYgvknFUAMOy8fCK1jpEUFgDglnfFZs6u+m4wZJw3JcaauCqQUDkJrV/HRgIt2OdTnGMhJ6+
	qyragUVvU6MMAZ4FM1kpOD4DqrXMinGEqL9Gdnlu6ExiN1l7ZRE49h55QF56SGVuD8tLTq2jRJpKT
	UxAHA9XaQv4CiyTlAbNQrDfkcqyQzLE+jpfPNwL5YHgIs9vpjbYxvin7/DWSBnYesCujvqYLh1dS2
	HvQXNe8YbrkNbYc80nGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKFvS-0006xk-QS; Fri, 03 Apr 2020 06:35:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKFvP-0006x3-Qg
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 06:35:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB83F68B05; Fri,  3 Apr 2020 08:35:28 +0200 (CEST)
Date: Fri, 3 Apr 2020 08:35:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: revert controller references on lldd module
Message-ID: <20200403063528.GA23224@lst.de>
References: <20200402190312.88868-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200402190312.88868-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_233532_017204_9BE935CA 
X-CRM114-Status: GOOD (  15.56  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, stable@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 02, 2020 at 12:03:12PM -0700, James Smart wrote:
> This patch partially reverts the commit for
>   nvme_fc: add module to ops template to allow module references
> 
> The original patch:
>   Added an ops parameter of "module" to be set by the lldd, and the
>     lldds were updated to provide their value.
>   Used the parameter to take module references when a controller was
>     created or terminated.
> 
> The original patch was to resolve the lldd being able to be unloaded
> while being used to talk to the boot device of the system. However, the
> end result of the original patch is that any driver unload while a nvme
> controller is live via the lldd is not being prohibited. Given the module
> reference, the module teardown routine can't be called, thus there's no
> way, other than manual actions to terminate the controllers.
> 
> This patch reverts the portion of the patch that takes module references
> on controller creation. It leaves the module parameter so that it could
> be used in the future.

Please remove it entirely - we don't want to keep dead code around.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
