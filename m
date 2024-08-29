Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BDCC71151
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpJZWHmyEIsQ6TI9FwkpuWn+YivOyJx+KIxa4nxnciQ=; b=Xl+nvp2ObfZour27fGc6wfkBRX
	olGA7TWciAeYJrbvxS8GpRxQkKPstI17NU54+T+5ySWcxrsYQuFYSMwrYqrPXpFPd972PJJ0YqBmV
	xZ+Ft9dw2BdShbgoJRlIzyeCC4dwn30tL1kBXfaFFI2sgarMYaZDRWEZnSa348sAK54EICshWl4jO
	HRPb3Z2Ne9Ca6NnyPgA1AawZ0UhlJzYQQwdUHXDBym6QPuNCV6TjabtyPi9i/Fc2Z0MjJCcclg4Ym
	g8Bgc7F0yHhXtyglWoiIDYGqHkwKrl7P3jow7+0tt2ldWyyXI+FaJRE0WayU7fjdKjRri8JdwS23z
	HgKHhLAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjXlP-00000000bj4-3j3o;
	Thu, 29 Aug 2024 05:32:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjXku-00000000bdp-2l5B
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 05:31:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7ABC768AA6; Thu, 29 Aug 2024 07:31:29 +0200 (CEST)
Date: Thu, 29 Aug 2024 07:31:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, kbusch@meta.com
Subject: Re: [PATCH] nvmet: Identify-Active Namespace ID List command
 should reject invalid nsid
Message-ID: <20240829053129.GA5693@lst.de>
References: <20240828122129.10788-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828122129.10788-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_223136_861885_1D0DC2E1 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 28, 2024 at 02:21:29PM +0200, Maurizio Lombardi wrote:
> +	if (min_nsid >= NVME_NSID_ALL - 1) {

It would almost seem cleaner to check for the two magic constant.
Either way please put a comment in with the spec reference as the code
is rather non-obvious with out.


