Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1B8C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 04:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4nTp6VBWFezuEVz29OJNqulnIfBztcue5Fph6w5gko=; b=sdGOsE7vctc3AL8spUFZgg0SYG
	Bv0tNoF5gHhFQIiFQI2jePGWdNviqY6bmQF8cmV7IFM4ljZBstNH4uEBq9BfOBRWwIyQcCwReYtOm
	F9AcYamuyi1jpoTtbFclVS6/5zYBgzRzmyFKqvp3yyG83JYP0WmX1vKAHxQHHtGS2YWeT9zTb5XY9
	lUCviWITbA3o+8LuNMyeBIQk/i7F2BaSenUKWGoi4X7dQzyGd4FQHaxcJhipjlO4C7wcQ9xdWt/dE
	b8zcJu+Q2fYbACuHfVjdF2bGFx2JAvRFDgWGuH6RmZ14the1dUg1xFJ4rhZxIl0h2P5Z6zrYZsXis
	8f6INY1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyR0T-004dhx-2K; Tue, 07 Jun 2022 04:39:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyR0P-004dej-D5
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 04:39:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B973A68AFE; Tue,  7 Jun 2022 06:39:40 +0200 (CEST)
Date: Tue, 7 Jun 2022 06:39:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, james.smart@broadcom.com
Subject: Re: [PATCH 3/6] nvme-core: remove qid parameter
Message-ID: <20220607043940.GA7847@lst.de>
References: <20220607011647.24105-1-kch@nvidia.com> <20220607011647.24105-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607011647.24105-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_213949_671954_A66E6AE5 
X-CRM114-Status: GOOD (  10.52  )
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

On Mon, Jun 06, 2022 at 06:16:44PM -0700, Chaitanya Kulkarni wrote:
> We can easily derive the qid value from the nvme_command parameter of
> the function __nvme_submit_sync_cmd() when its caller is
> nvmf_connect_io_queue().

This is a pretty horrible layering violation.  The low-level submit
helpers should no known about the contents of the payload.

