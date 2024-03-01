Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE9C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+Bu5kAxj9vlYIIo3ynhhk1UvtK4Q195rKW/0UBBSAE=; b=pFzPsc5NABjwcT0sr1/3e5U2tb
	sM4ntSOOynASXgVxGXYhWFioK+jgJOpXkMPkOzfVzQ4lDXqQlRT7p0sh21IfzU7JHTH8tPr38BDPk
	t1HEN9s1Q+gwsym0QqSQQeitDhur18Z+RzC5ybbNWfgLMKI9XPWJB0mF5b+19edXDD8sutV7TCnAv
	PHAxQAySpoH5K69I8s+5Q1X/sXk1hmZXu9+uc25x2DQ2DBuV1/2pjWZ+0W14hF06v936BXQxemZRT
	fJYJOLPYAKH1HxiZ3Mt/LsoypckYXkixSZWQoWOypwAXtk2webSqCJ5rk+2U7GG1uXMbOdAHR41WS
	GrhelQ0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg33P-00000000VvV-09UK;
	Fri, 01 Mar 2024 13:35:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg2gR-00000000Kt1-3ePD
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 13:12:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5E9468CFE; Fri,  1 Mar 2024 14:12:08 +0100 (CET)
Date: Fri, 1 Mar 2024 14:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] nvme: authentication error are always non-retryable
Message-ID: <20240301131208.GA3586@lst.de>
References: <20240301112823.132570-1-hare@kernel.org> <20240301112823.132570-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112823.132570-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_051216_082912_B76219F4 
X-CRM114-Status: GOOD (  14.21  )
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

> -	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
> -		return AUTHENTICATE;
> -
>  	if (blk_noretry_request(req) ||
>  	    (nvme_req(req)->status & NVME_SC_DNR) ||
>  	    nvme_req(req)->retries >= nvme_max_retries)
>  		return COMPLETE;
>  
> +	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
> +		return AUTHENTICATE;

This part looks fine (although I'd word the commit message
differently for it).

> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>  			dev_warn(ctrl->device,
>  				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>  			goto out_free_data;
>  		}
>  		/* Authentication required */
> @@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  		if (ret) {
>  			dev_warn(ctrl->device,
>  				 "qid 0: authentication setup failed\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;


.. but the others should never use nvme status codes as they never
go out onto the wire.


