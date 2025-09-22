Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DCECA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8habqmvmsA1EN8lQJixzRXgPxQweZxNF9poLhP9xYw=; b=sY1xG3MskdwmT6qYusjI6EmOGp
	7PLkwzUV35t8znic57RA1ioLBONuh18AZLIV8axLn1wfhr4kulYN8KQRWLCF+Xu19fyIc8VHpn/jU
	dszEYrFEtJOq+lB8TQ/6FBAeYQNrdADGtVwEwp+IWVdDP/PeRTTMdb5uFnRXM2D9HvE0TCDn2rQqX
	unxAkdIkDRxJi6bd7gaU/NJFqtFBdwRy8KLFqXo9gNAjDu3cIXTTE48yn6QX+/IUXB/5lC9S3Rr9x
	MCOFi/FzMNw0Ex1Zb9+U06EEgTKKA3wcR1ko4UJ8UPT52BpKNl7Au0BY3euEw7NDVcW4g2Ey2iFx7
	TbRCca1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kAN-0000000B5b3-1Vw0;
	Mon, 22 Sep 2025 17:17:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kAM-0000000B5aY-1LBa
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:17:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 809FD601AA;
	Mon, 22 Sep 2025 17:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A81C4CEF0;
	Mon, 22 Sep 2025 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561449;
	bh=Iql0RAdGuLgdTcukEakyzja8ODezCb1CDentcxdN01A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjNSWRSAQqV23lIQNpDD1GXkooqnFS85z1bC8mYEyumOZ9dQ9PclxEl75ZJvddEns
	 m7yHLG0aktN43CRxhJ8dAGUCR1nPRDUPbf2XbcQKuqFBMvFq95rscYq7W9Io84I6QO
	 YgV08FlanOw39rmTzC4jzGqcy8IhoNpMPWNP6kN4ZiKcmBkTzMMCRU2oGHr3ERnk8/
	 jnVOHSyJ1y38GmRuNMyWtKfgxUxI/OP8YWpJKCmUbJptxS09Xv1z/eYYSUAVe/MwGo
	 40TDgkTMYLjH9Kig9cJnedhyGa1G4kGt87FnFaJD6EWofN11EMbZT1shlxIklNYL0U
	 +ZYw22w27MPwg==
Date: Mon, 22 Sep 2025 11:17:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Engel, Amit" <Amit.Engel@dell.com>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH] nvmet: set sq_id to zero in NVMe-oF CQE
Message-ID: <aNGEp4KGtDOSdlXo@kbusch-mbp>
References: <CO1PR19MB4885E6CA8A98DEBE649A4D89EE13A@CO1PR19MB4885.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR19MB4885E6CA8A98DEBE649A4D89EE13A@CO1PR19MB4885.namprd19.prod.outlook.com>
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

On Sun, Sep 21, 2025 at 05:06:01PM +0000, Engel, Amit wrote:
> @@ -741,7 +741,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>  
>  	if (!req->sq->sqhd_disabled)
>  		nvmet_update_sq_head(req);
> -	req->cqe->sq_id = cpu_to_le16(req->sq->qid);
> +	/* sq_id is reserved for NVMe-oF */
> +	req->cqe->sq_id = 0;

What's the point of doing this per-io? No one ever sets the sq_id to a
non-zero value, and it looks like everyone has the memory cleared when
it's allocated. Is this actually fixing anything?

