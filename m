Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25818C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3/WRsw9XzlOlYbCHFeAYuzqExGHoRv9EucddWZ4SnQ=; b=GppRIMKQzKnqaCWUIfvR4ADikc
	hIXFi7zskNqZSK9HDCklOadviq4kSydD3nMWjFyKq7YjsLc2L+cm7uca4/uk55pHo0nG8zg7bXw66
	xdp5ZO+X4z9dco1jxv6/52tvsylwriFRi20EqvuuU/YeHHtMVe0JeVA2/JJ3SR64vkTKQ+MV+nH3l
	WNmdBfhEM9QLuhp2Ylavziki78FSlTUT861ggKTHe5hotiT7xNFqoak4KmsaIuqBsQOZIcoTPYpKG
	GFiS63cWag86p/KZaS9/CBkdtZ7nAxaCTZ8dJeq68w0ZHAvnrfiXCn32VS6e+UzrZq1lTAB9Z8x7b
	sOKyC5Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRjV-00CnCy-1P;
	Tue, 19 Dec 2023 04:29:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRjR-00CnBj-0q
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:29:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25DD168AFE; Tue, 19 Dec 2023 05:29:22 +0100 (CET)
Date: Tue, 19 Dec 2023 05:29:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 03/16] nvmet-trace: avoid dereferencing pointer too
 early
Message-ID: <20231219042921.GD30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_202925_440029_263543DB 
X-CRM114-Status: GOOD (  13.08  )
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

On Mon, Dec 18, 2023 at 04:30:51PM +0100, Daniel Wagner wrote:
>  #ifndef TRACE_HEADER_MULTI_READ
> -static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
> +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
>  {
> -	return req->sq->ctrl;
> +	/*
> +	 * The queue and controller pointer are not valid until an association
> +	 * has been established.

s/pointer/pointers/ ?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

