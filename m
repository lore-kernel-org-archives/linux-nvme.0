Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA91FF8855
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9rq/gt7jTQSNkH3pS+PXwXybu4Hfj14xh+X9jz7Z1kI=; b=lJ4cjPsxcod4cHH5r8myC6qqbM
	myvOrke0zoSNRxtafbeb3C72lbFKgIvN7qA/NCYNtwsxhEWMbte5PvvUGPh2is/jqWm+Ld8/HUwhg
	uEtr57v6ktoTegE6unQ/hXTVEaoX4Y2gzIB6Jq2wAjM26i3j2aDcxEymeo4XqgLcn5bEKeCc3Z9/3
	+0BYezO3fxmltY/+AvrfbjB2QxSfK1U62dQNTDW5wuKCkmW9vS90YJbfPglUTqAzDhnwUQdFrqAf6
	dcm6KIwyV5sAJMvNAI0tDVIU042Eo0i+RegalSx7DApOLghLAL9RJ0ujinpjPcIxJvktchWR8GPeH
	fkYgFsgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKcKE-00000000trw-0CPt;
	Wed, 06 May 2026 13:30:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKcKD-00000000trO-0XJQ
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 13:30:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 386A1434E7;
	Wed,  6 May 2026 13:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D7C2BCB8;
	Wed,  6 May 2026 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074204;
	bh=t96etMCjFzF33a8DP/chRrMboJUFwj4GHuCugvcMAag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0iiHT7SZ1JHut4IkL6xfwWyY4bl/7WsKqLqHuHEEBWDgTBslhBdQuNLgVUnT/czG
	 y/NuXBQCZhXqHFww0VFyjPgvkWJ+f6HxgcgaDWg4qVly+blS3OUQpYUD92bGP+4Nk+
	 OUC/GvxCkDBAeGPINvOZVUfXgC1+PNAijeYEZmGwd0sGQIKl4Qner+Au72rB21qpjk
	 8dRRMbBgxYJBUxgBV2jQ2nSJHmePj/agyt+f51hnVo4mi9zixJkNoTvySzn2UdCL6H
	 GibAeeEhxpx8SbQlzp18cBrGPlBDZOWGShEIXNq5A4sDBIhXWtAz9IxYfClmHGxqCi
	 VLiT0rKq97KEg==
Date: Wed, 6 May 2026 15:29:59 +0200
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bean Huo <beanhuo@iokpp.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] nvme: skip I/O Command Set specific Identify Controller
 on pre-2.0 devices
Message-ID: <aftCV3rDk3yeWA1d@kbusch-mbp>
References: <20260503200243.2968366-1-beanhuo@iokpp.de>
 <20260504043655.GA9013@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504043655.GA9013@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_063005_190272_A5CB88B6 
X-CRM114-Status: UNSURE (   8.70  )
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

On Mon, May 04, 2026 at 06:36:55AM +0200, Christoph Hellwig wrote:
> No.  NVMe allow TPs to be implemented on devices claiming earlier
> compliance.  We've had this patch and this answer probably half a
> dozen times now.

The proper solution is that vendors need to have their controllers stop
logging pointless errors that don't help anything.

