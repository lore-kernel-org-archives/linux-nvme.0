Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F99C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YKhoWn3BYpg74BkNf6OiAJg1ncFj3zV3RH9kbQDYls=; b=TaGnfJ5FeIjvMlECeCMurdnhYC
	Tzhu3OMp/RLoKrFK8g7G+nqGJidfHz91q1F7NZecpLncvDjI0bzwvjM/T7M9HEpP+YALS8oeJxWW0
	RbQryIe3iaIxf88+nV5rVe+nw0GD7KfiTwlWJ6KHKcpeYDVFyXxzrhoKnqsJDe/6LA/p2e1yxBRCI
	8oWpce+GjA8x58/JRPpmmWFatdkgzyfP6UAa3JR59UXmTZLpi1RdUCQaEusW/UeaNYq5wHIJPlmjR
	8nVuES2sXP3Jfyc7baiAi1mrzsKo7n0nGnbE0ebrG1JB5QHkOsAQtmgupxrCDlzFadk1Fn8n3NcUf
	3ep8p1FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxOc-00CjKm-01;
	Tue, 28 Mar 2023 00:41:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxOZ-00CjKM-0M
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:41:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B45BE68AA6; Tue, 28 Mar 2023 02:40:53 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:40:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH V2 1/8] nvme-core: remove unnecessary else
Message-ID: <20230328004053.GA21054@lst.de>
References: <20230327060418.86655-1-kch@nvidia.com> <20230327060418.86655-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327060418.86655-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_174103_300088_17814522 
X-CRM114-Status: GOOD (  13.06  )
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

On Sun, Mar 26, 2023 at 11:04:11PM -0700, Chaitanya Kulkarni wrote:
> By returning early we can safely remove the unnecessary else part
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

.. and add a line while creating churn?

