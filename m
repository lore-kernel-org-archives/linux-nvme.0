Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BD9CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+apoXZAd6PTQuEu5dOZzXYX7VK6YP8dt1XmvCY6yGY=; b=Vhn6IRpD+lLQTujFguIN/hBuH4
	R4GIi5CrT0qIhNSJisl49gRElr4LM3Q+EudZSxBKRCGhgZFyO/7BpwQ0AEaufgQPoHMCnRBrYOq6E
	c+ZT/Jqh77bOBxDq37MVAFqH/Kx20zbQL120uwF7U2be1fdW2YuMHiLXeRvyjThC65BsLCSmSDMS+
	A3yFkrgMlfIy6DMWaaDJpK5/bLHCDp5zDB8ZffZC/K7U8uUfiROTgqMvd7uAyF5qNBdaniqlqodvk
	AWxefiyJKRAPrOSv2I/qNj0gUxGnz6ooVDGIHmKmPvepOLuAyr/r3Sf44vrYOxee0rPTtWpNMNZMP
	cu+lnAiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscwh-00000005Rms-0zXX;
	Fri, 05 Apr 2024 06:21:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscwe-00000005RmG-1Z2A
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:21:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C327168D07; Fri,  5 Apr 2024 08:20:55 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:20:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240405062055.GC3107@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_232100_795006_9DD5C3A0 
X-CRM114-Status: GOOD (  18.23  )
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

On Thu, Apr 04, 2024 at 05:44:58PM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> A failure in nvmet_setup_auth() does not mean that the NVMe
> authentication command failed, so we should rather return a
> protocol error with a 'failure1' response than an NVMe status.

Nit: try to use up the 73 characters available for commit logs, this
looks weirdly, um condensed.

> @@ -131,7 +131,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
>  	int ret = 0;
>  	struct nvmet_host_link *p;
>  	struct nvmet_host *host = NULL;
> -	const char *hash_name;
>  
>  	down_read(&nvmet_config_sem);
>  	if (nvmet_is_disc_subsys(ctrl->subsys))
> @@ -149,13 +148,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
>  	}
>  	if (!host) {
>  		pr_debug("host %s not found\n", ctrl->hostnqn);
> -		ret = -EPERM;
> +		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
>  		goto out_unlock;

This is now returning returning random on the wire fields that aren't
even the NVMe status codes from a function otherwise returning Linux
errno values.  I can't see how this works or is maintainable long term.


