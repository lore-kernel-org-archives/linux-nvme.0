Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Ysp5VigfvmbsLJcfDnpX2fwgTFJ542aNlBCwloMCp8=; b=QWxQV/sI7kYT21GJJF4dwrncU/
	fKhxavXU4e48GggNQ1NkmOtxfF9dp9DizeZjWeMwLCu3Xon5d2gw4ejQ27AGf8+2hdIv1NEkQKdGa
	Rfs7Gwp9ycQyVN9Q7t7UmbONIaPATgvB/ZKSrCyaBsGXnkM5xA0ifLxRj4ErfBjMLhel/5KdxaEoy
	lVZ5zTOBmYw7NHoRCMWZBKYbM/2aaeh9VOad4ulhoQK0xwD6vXkQvKQrd/Nc5AnOWA7zDMABpXnrO
	6i3K7hmQ7TI4WL/tjygqBD0H41gk3wMPCZY2FKtmx7HULUckW/SpzggEFY4kB96JmtE/0T8/J/bmB
	ECV9b1FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYYi-002r0Z-HG; Tue, 23 Nov 2021 16:22:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYYe-002qzH-VM
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:22:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C8BF68AFE; Tue, 23 Nov 2021 17:22:04 +0100 (CET)
Date: Tue, 23 Nov 2021 17:22:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Message-ID: <20211123162204.GB23957@lst.de>
References: <20211119083912.38260-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119083912.38260-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_082213_195982_006246F2 
X-CRM114-Status: GOOD (  13.44  )
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

The subject should use a nvme-fabrics prefix.

> +		const struct match_token *tok;
> +		int idx;
> +
> +		for (idx = 0; idx < ARRAY_SIZE(opt_tokens); idx++) {
> +			tok = &opt_tokens[idx];
> +			if (tok->token == NVMF_OPT_ERR)
> +				continue;
> +			if (idx)
> +				seq_puts(seq_file, ",");
> +			seq_puts(seq_file, tok->pattern);
> +		}
> +		seq_puts(seq_file, "\n");

A helper for this logic would be nice.  Also shouldn't be there
some kind of token to distinguish from the case where a controller
has already been created?

