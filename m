Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE90C54EBE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pybulX86uwd5jC0enLRAqQ+YQIjsBCbipMoi4rOxdLM=; b=Tnklu8pfO+lG92kqCLhIGKB9u2
	AT/i6xfX1H+gLQuw/bwOq6axWUTIU4enj6lGYM+CHAmVMT495AXT/m99eBMClEhNXN9K3yPnHepGX
	GUqJNlWi3VIez7zh9xtolBa4pZBuJ0CGFc9++SeRzJACE9cjl7gWmknJAuOmnMlvv9y8Rn7/aZsVU
	/aootncsTmD4HJ+6Bachg5Dm+LHfuKfBig4E03oXkTSoD7K7VA/3fMbI/PDBwwvHGKvoZ0d6TxdrS
	RYghNcVGlhlVzuS4v/MGGgQHHfkh94RZ2M0BerhnHPXlaJvGn6jZ+GWJS5MwIF2x27pXUnfRCjqDw
	PCFp+slg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaJM-00FAbC-Dc; Sun, 08 Jan 2023 18:22:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaJJ-00FAZi-Rt
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 18:22:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C9C468D06; Sun,  8 Jan 2023 19:22:19 +0100 (CET)
Date: Sun, 8 Jan 2023 19:22:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] nvme patches for 6.3
Message-ID: <20230108182219.GD25544@lst.de>
References: <20230105202833.3225645-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105202833.3225645-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_102222_187665_1CEA4F4E 
X-CRM114-Status: UNSURE (   8.10  )
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

Thanks,

I've applied patches 1-3 to nvme-6.3, holding on on the last one for
a bit.

