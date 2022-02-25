Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66882C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBwki2z+S4KMQNnSlBdBtXXmGUIWl2Uap5EEOiQY2M0=; b=go3kFHd6GiWzjY7Jmnh/HqHBhm
	8BUENlMAjaSEUpXdxfJUkndPxYe644ouLs3BTZgyJYQUBQNC6wcsMyx30k+X+89ZDNMwEb/+5OVzw
	D8XEi7/jg03Ac+Q03G9tmnLRIzqcwBa0YbDdC/uy3gKVsUeSxO+9qX2nogkwdw4jEfveUypfpsLrv
	KaLlBGK5L+5ZEal1pAEWdXF61BBwdWe6whsyBAz9P5PIktMXD0i1IppwftMfnkIZXwK3DLhtENGkW
	tS+7Nt3dopWR6HlqFmq/8SjK3vI1JXoMzYvm5fj2vsJc9jubDbTn1FrQSTDFbOf/Su1WHS3E3p4EI
	0+y+QYvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNdHi-005rih-IL; Fri, 25 Feb 2022 16:17:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNdHf-005rhd-C8
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:17:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DD99468AA6; Fri, 25 Feb 2022 17:17:27 +0100 (CET)
Date: Fri, 25 Feb 2022 17:17:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de,
 Hannes Reinecke <hare@suse.de>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCHv3 09/10] nvme: add support for enhanced metadata
Message-ID: <20220225161727.GC13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-10-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-10-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_081731_580466_98CF5788 
X-CRM114-Status: GOOD (  11.68  )
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

On Tue, Feb 22, 2022 at 08:31:43AM -0800, Keith Busch wrote:
> @@ -918,6 +918,30 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>  	return BLK_STS_OK;
>  }
>  
> +static inline void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,

Overly long line. But I don't think this should be marked inline anyway.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I suspect eventually we'll need to lift the new Identify call into
the common revalidation once more fields get added there.

