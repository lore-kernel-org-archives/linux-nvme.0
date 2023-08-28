Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F0C83F12
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MpUVCP0OV0sLnEablIVjSVUDcke4StntdiRhkz5eyG4=; b=X0GAR75C/9pMR8EoEoQkvp6hMk
	9sEia2UFBbYVjH4FyLXxs5/WJytbPLcQCEF0xvu6Y9AhzUG96vUuPQasYcNd3n5+p4VIwkP7ZvxPN
	2syOHd6fyXCrfpU7T+lnGuXchKIaRM0ZG3hGraYAhkC8ksTK7c95uV7Suw4xIbonSALHOuXwjv7qA
	uCmDZ1aD3pfqVKUrAAtsexnkNEJZ5HOIIP/qxqbWNwtC8PTinVz2KGZhmfME6ntVQAvfh6tQ0KOzj
	xVLRMCw7R9u9OWBmq0RMMo2yRajZKdK4JeN6ChfmqyL4E4q8DJFE+G4yWNrcG0qZT2L7+BMxH5pQk
	dTd1R00Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYOl-009DFq-25;
	Mon, 28 Aug 2023 09:19:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYOi-009DF7-1A
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 09:19:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AD756732D; Mon, 28 Aug 2023 11:18:50 +0200 (CEST)
Date: Mon, 28 Aug 2023 11:18:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <20230828091850.GA30603@lst.de>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss> <20230726131643.GA16186@lst.de> <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_021900_547093_ABE46DF2 
X-CRM114-Status: GOOD (  13.97  )
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

On Mon, Aug 21, 2023 at 03:37:55PM +0200, Daniel Wagner wrote:
>    --- a/drivers/nvme/host/core.c
>    +++ b/drivers/nvme/host/core.c
>    @@ -1871,7 +1871,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>                    blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>            }
>            blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
>    -       blk_queue_dma_alignment(q, 3);
>            blk_queue_write_cache(q, vwc, vwc);
>    }
> 

> So what's the best way forward from here? Introduce a quirk and always
> use bounce buffer?

Add a quirk for the device so that we require 512 byte alignment for it.
I suspect the same one will apply to this whole family of buggy MAXIO
devices..

