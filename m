Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7493C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yG370f8XmLOCe49T4erppPYQMbZzcFachdDds7SQ018=; b=kpqmbCptK2gUywPEJUbBQfXDmi
	PoocVm+tOG7zOBpNQSgv7jdbLD92KskgT3YTSBE5cQPUoBb9m7gajX6guBnB+lx/lOFC+Qu0I9l21
	PilEHd8qRZuQrIJZsIsCX49oreRMkgSIy9vIR3XoDIYvgjIRnfGfC9n++mr4R/MNgXfsNEd8pAJRB
	WFKCZZmMNnDmxymwKNh6VEIQaPn3nsX++DB1QQ8k8k4CA3ZqmV7Xo+EtRp4PkkU/l3JmfEtfjoIna
	z/ZkAhjPoP4dkvDIY9CMX8rxeQxL2FpIYKwvtFtJAqwlgaXFDCja9/dtzr761i2sZGIRti1RMKGSF
	jbxmv14g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU9Kh-009lHh-Fz; Tue, 15 Mar 2022 15:43:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU9Ke-009lGK-Jk
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:43:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3C39DB81186;
 Tue, 15 Mar 2022 15:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1668C340E8;
 Tue, 15 Mar 2022 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647359010;
 bh=yG370f8XmLOCe49T4erppPYQMbZzcFachdDds7SQ018=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HHvGGeSEeM54RWD1JA8ryrzDyd/t92HiCbFXBGOCr1bzeHr9SLgUjnBWH/BOPvHPk
 ieWQUKm5PXL2q8wjRcjM0EdngzQi6p/SFVaRNKo4LuTqCB4lw0Eo3qvSJxVlqyr23h
 Fc8QydtMpOC1oCQlC+1r+M2CWmZk6YKgaYnz2wPXLInzErhkdkoKAfLw3GqwKnZc5z
 nKC+05t8T3E8xu8ufVUQQM8e9NFX57XUec+lTr7m5phlbnkohQKUNRDfqtBOXm8Ne4
 oBc9KC0K5WIkey22qmDN5HQbJvDv8AzlBVgiDdc+N1Rea0YYelODZ+DIg09czlveSN
 KZLf86dLEHNHg==
Date: Tue, 15 Mar 2022 09:43:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove nvme_alloc_request and nvme_alloc_request_qid
Message-ID: <YjC0H8eFhWK/VnQ5@C02CK6Q3MD6M>
References: <20220315150222.2590959-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315150222.2590959-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_084332_830950_7C728FAF 
X-CRM114-Status: GOOD (  10.08  )
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

On Tue, Mar 15, 2022 at 04:02:22PM +0100, Christoph Hellwig wrote:
> Just open code the allocation + initialization in the callers.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

