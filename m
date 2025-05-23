Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77A5C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PWKT9BG+lOtvl4QvvLndlFSfFz2NGYNjS1PlIS8vDlM=; b=adyQSykaqLy3RAz3Ys6lAGdXHP
	J3klS/HB5s0gbEpNSD0XUW7WcCmXs+NUsSls2v861B/IlPA5lqBw3M9lsOazosihVZWCL8/TmG1C2
	Gi0cii2wjtjqDPHzqj01K9xZ+iNJ5CiTrn8WkvHE34WoWNAeTHn6udPhFB/AgdqB5KLv4ybnh+EqR
	QSjz23AdHyckE71Rfl6YSIaF/GQ7bzWUaoPvzhtLQSLV/vYqgbsXvW2/fVxSztd8gAzZf3xzPC1ya
	aCaDpAkQ0nECbUjk6OiK1t8xOYl1JuOFEqy4rlAfLbQYoLgcWXFmL9TxYVo7quKpnUFPFEGjPzdgx
	fTj6rn1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITjQ-0000000491M-3Rwt;
	Fri, 23 May 2025 14:50:44 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISxI-000000042DZ-1Frm
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 14:01:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5412EA4F7EC;
	Fri, 23 May 2025 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A091FC4CEE9;
	Fri, 23 May 2025 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748008859;
	bh=PWKT9BG+lOtvl4QvvLndlFSfFz2NGYNjS1PlIS8vDlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNEc06yqdXJ/vMwreb8d+h1QOcGFlIUxaOGlQl5hkdUWEecTqo07MzRrBl8aTKCyo
	 utGfrhDEQhgsRwtIBSvw3HHp7pgh9ga18X5eGeriHBicjQ3sh4oTWlU0+vY5aCgyKI
	 YWEhv87psap40HIyDQgKIpLWoCcpj6H2jnXvfA2eFyux87nlk+DyYAUvB+kRM9ij7t
	 aSesbKUXoX8rMjik/XKWe8YYQieFJ3INwjUxiSvULGOWObN3M8OtY6LOiFnW6C09fz
	 0meP1qkyHOu2Y+rz7DtxS6TbVMy8nFIan2kBpNPxOF7GqwoZbDJQoQmxmZ+Nt8Pw82
	 mosvpYhoZeXaw==
Date: Fri, 23 May 2025 08:00:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDB_mIZ5YUG32sHx@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
 <aDB1p8XIhsauGFhc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB1p8XIhsauGFhc@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_070100_405630_AF461141 
X-CRM114-Status: GOOD (  10.72  )
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

On Fri, May 23, 2025 at 06:18:31AM -0700, Christoph Hellwig wrote:
> I need this additional bit so that the host code actually see the
> copy support:

Thanks! I think it just needs to be constrained to bdev backed targets
since I don't have file support for copy offload here. And less
important, but for spec compliance, I need to update the Command Effects
Log too.

