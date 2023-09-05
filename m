Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48339C83F3E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OHLi2qmnEqxdXo0dmyyRk9mdZmoJazb1Jr2yP4Skz4=; b=uXMvFILRfeMcDp8RwQkV67tPG7
	B0Jw10ZBjlWR6Y+Fo562r6zoH2HpADEfi8d4398xsR0yYAr0CaJNuebuS4cokzFbCii3eEiesKeDB
	pX0sqXFW2xnVMfUD8xm6XmJs4iJQP8jj3r/x1zQYuJRAj1DMvQ1s+AEg2H7gFHsSTVGwK2bJl24Tu
	prvkQkopW4vkdExDQlgN25z/sZqm4oNTUb/vvRwtVqa6eRZ7PGoW/dX82TqxyXP0yNUfaSHxD6ZPj
	Ugc3af19Mm4o5QGg3fjooQ/49X+sGjAy0XcampHV+hwUErLzmzwrIFwf6995/bEWKFVLOGz2ChsvX
	DNYM0BXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPtv-005M9N-01;
	Tue, 05 Sep 2023 06:51:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPsK-005M5e-0q
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 06:49:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94C2E68B05; Tue,  5 Sep 2023 08:49:21 +0200 (CEST)
Date: Tue, 5 Sep 2023 08:49:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Message-ID: <20230905064921.GB19701@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091350.16156-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_234924_441613_859BF226 
X-CRM114-Status: GOOD (  17.18  )
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

On Tue, Aug 29, 2023 at 11:13:47AM +0200, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/target/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> index 6997bd7e45cf..9ba466b49613 100644
> --- a/drivers/nvme/target/trace.h
> +++ b/drivers/nvme/target/trace.h
> @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>  		return;
>  	}
>  
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy(name, req->ns->device_path,
> +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));

I'd just switch to snprintf instead, that the best way to ensure
termination..

