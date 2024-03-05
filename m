Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AB0C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sd1X9NjohTIT8JPXMT+kvr22Da/qRcIF6fgOwaI9i0U=; b=rr8EuS7OTr6XpN/insdX9mIboU
	BiXZuGyffQTYfUrUEuVNxqhhgYJwx+xStM1+NyQP77VtWlRk9jyOO0lVpinoEEo9TXwpaeb4reoZX
	9Frg8iXzMrBa7OLMZ7xvj1B2pfb5kBbdNgwBFfYe9bxURVH6WSTIWYCteGCV96EBQyIUi+UuJNieo
	v6J79Z/cbRUtfHGKMvkAGjP3AJF2D040TK2A7QgjCdEh116iTYtRinbqWx9JjUZBE0MJYEhmVJDCN
	vXFmRMH63eLr2aZ2RxVTAqDCPqZsaVlpLOGs5Y9mWxDq58W2KgqE4aLLRPE5DaWqPFAU+cASl38n8
	ts5xWiLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXFh-0000000EObc-4Bei;
	Tue, 05 Mar 2024 16:02:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXFa-0000000EOW7-0Iro
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 16:02:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F1A54CE1877;
	Tue,  5 Mar 2024 16:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB0C433F1;
	Tue,  5 Mar 2024 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709654558;
	bh=sd1X9NjohTIT8JPXMT+kvr22Da/qRcIF6fgOwaI9i0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMzYXEXLSD+QMgT1DW6CavkNZW0DoWPB/mA3YbWCYj4DKD+opHhPrk2jRRkZ8joiz
	 LwjMKRe5BVIlOL+EQOpq9IFuZNKEDiuoYKKzV5UIBmWhjQO+GSmd4yPZy2UJgTSZKD
	 Movnm0jcwvTbIIrDtSGdBZEg7lSimABLUbKBl+vp7f3abnTbgvtwJhm0RkdwuVH2nv
	 iLBccu8fF3m8OsOnk/3R57l+sHaSLzmN62qY4soNQGXbyJzfwl8Yf2fiopLhnOW3eS
	 1Z7R69p0uHVDcpYI5F1i/LBElN7XOyqmh15rNhe3T+EqnzKFqoXJVp5KO+io0BvLHg
	 +xSMmnePpIjDg==
Date: Tue, 5 Mar 2024 09:02:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305135125.GA2802@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_080244_864644_D7CDD77A 
X-CRM114-Status: UNSURE (   8.86  )
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

Thanks, applied to nvme-6.9.

For some reason this series didn't arrive to my inbox. I got the patches
from lore, but I probably wouldn't have noticed this series if Christoph
hadn't replied.

