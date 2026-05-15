Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99060CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zcGEiB2I1HxukUYqORJO98xlX8
	02q6VZZEKHmTX3OZic3gHeK5wFBLY99JYu6HJltqFX4wIY6vU6HE+qD2LKdDlOeEFlntAmzLBFZ+y
	HEVj9sX8xpB4KHqyakdDbB8fg4UyVkHmp0xzLA9e+3d82AxaOSSi/SytgSEydQLWFF8p5+G3DVhSV
	L6QonrTFgHza1klrX8F5Kvkrn9nGeydH+4UflK3admc07Pe/aR4bI/DXpk7FTI0EnOtOJulOaCjyY
	M3troDhx347wv8DmJM4zeWLFdY2gySMKQc4K3fzBfy/+aeA98ywqDYKn8opF01/l2DPq6dL5xQAOJ
	Z0yQ2vKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkCH-00000007J9Y-0onx;
	Fri, 15 May 2026 04:30:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkCE-00000007J8n-13wZ
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:30:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28DBE6732A; Fri, 15 May 2026 06:30:43 +0200 (CEST)
Date: Fri, 15 May 2026 06:30:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH V5 3/7] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Message-ID: <20260515043042.GB3685@lst.de>
References: <20260514083255.41109-1-mlombard@redhat.com> <20260514083255.41109-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514083255.41109-4-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_213046_427613_0EC44D39 
X-CRM114-Status: UNSURE (   8.31  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

