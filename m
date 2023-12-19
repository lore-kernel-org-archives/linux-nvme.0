Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7990AC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fr/3XLyjK3prTZsSkmfK87KUCl14mi8DOoR8ElVlj5E=; b=iQqcqCW2CC1xoUroLEf8GFMqby
	RJ0O7X20abgUc6PE3VsPagcOV121Zoxylp7xA9vgRX9kGvs8OWdlgkVsceZjK7MpPt1Ws4YsxSDJ2
	4r1UHI9kAgerve1LotjBJp126ZP8BmrwiA8QYfi6ydNuMicRolgoqO09gVnHv69Mfqv29sKyB77bk
	sgJci+rQqWd3Xz/ITddzQYZLYcL55HiKv7V7vNqMUs/hqvGa+D6MinJtl5Oznej0qSyhZhrQ54lcp
	QC4+gpWmnqgy8fDn3gA3edzwsuoK31CszoSto9Y5sJb/2UW7yMz2D9DBJ81Fd/PD0QoJwI0B0wB8M
	wK2dwWlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRqC-00CoRK-01;
	Tue, 19 Dec 2023 04:36:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRqA-00CoQh-0e
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:36:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FD8168AFE; Tue, 19 Dec 2023 05:36:19 +0100 (CET)
Date: Tue, 19 Dec 2023 05:36:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 07/16] nvmet-fc: Release reference on target port
Message-ID: <20231219043619.GH30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-8-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-8-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_203622_378479_6FCBF357 
X-CRM114-Status: GOOD (  12.79  )
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

On Mon, Dec 18, 2023 at 04:30:55PM +0100, Daniel Wagner wrote:
> @@ -360,6 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
>  
>  	if (!lsop->req_queued) {
>  		spin_unlock_irqrestore(&tgtport->lock, flags);
> +		nvmet_fc_tgtport_put(tgtport);
>  		return;

Adding an out_put label and jumping to it would be nice here to keep
the cleanup path common.

