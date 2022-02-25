Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87968C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LL12pz9DHBeR5ITGa6aenNDrzk
	CtxwDq/0xCdTEF3p/274qN2it6wMUIJcE7D9xhEy7McB5P8EHBV2xPSMha+pAnHdf0xXtFC9gfApt
	BgsHGCry9ku6qXdYBWd4vCmjsW4xe+ny1utPkxHHmm8cAKnjOlUT1k0vi/5rDaqtmqlpfSgpz8ZB/
	04P9RSzLGBUgW0fW0xFJvVI7IW7wrJ8sEIcP/AKRrHd3OK5itz12VxfAwlWnE2cc0B8MwGjm5of0F
	Av+0CkXUbDtpmOlIbpKmyprEjC0mi/gOukqfdTTVul6WshbC34RWtYhx7NkiPiK8vc+DGbecJZRRP
	eUv4kqxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNd2j-005mb0-Hs; Fri, 25 Feb 2022 16:02:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNd2f-005mYq-E5
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:02:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9CA7268AA6; Fri, 25 Feb 2022 17:01:55 +0100 (CET)
Date: Fri, 25 Feb 2022 17:01:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 01/10] block: support pi with extended metadata
Message-ID: <20220225160155.GA13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_080201_659484_B9F7B0DC 
X-CRM114-Status: UNSURE (   8.34  )
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

