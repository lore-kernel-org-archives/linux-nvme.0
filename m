Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B318C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GFq4dZdfahKHCv5AChJRsfZp0tEcex5LrlrY9Af7jw=; b=OBKBkY+3ppsX2Ks20RQW6i6arC
	ydRJqh1Ku+h/bMTxXZDN8PLpJ1iQXW6nxwM+49e7fe6/GOLEK4b8wVvOSPJK3ZuGjkd555V6WPd0f
	b+OcrlzcC0p4njVyVwk4a/0ECVyPUCPEARTLLebjNDtKMT837eW5koHwVA9V31SfzOLlqmSKAfPCH
	x2wMlJV6UTELsbvKkykR/cDwpiqSxcSujkb+ysoOAc9jrM9DJ6Z23kSSH/X9V5BOOiu0xanQxvVr7
	r9ykk1nbs1NHVxvZ5uACcZiiWrc3XofDp0pNIrgfk1AsIJFVZsj4viVOC+spEbagMtDlT4U5x8JuH
	yIHFuMOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8hk-008jSY-Nv; Wed, 02 Nov 2022 08:02:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8hi-008jRq-AZ
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:02:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C70167373; Wed,  2 Nov 2022 09:02:21 +0100 (CET)
Date: Wed, 2 Nov 2022 09:02:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme-auth: set DNR bit on non-retryable errors
Message-ID: <20221102080220.GA10816@lst.de>
References: <20221102075224.70869-1-hare@suse.de> <20221102075224.70869-6-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102075224.70869-6-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_010230_548636_2D37AED3 
X-CRM114-Status: GOOD (  15.59  )
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

On Wed, Nov 02, 2022 at 08:52:23AM +0100, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index b4af8661c988..6ca0c2bb06c0 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -151,7 +151,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
>  
>  	if (chap->buf_size < size) {
>  		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> -		return NVME_SC_INVALID_FIELD;
> +		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;

Any use of NVME_SC_ for error purely in host software are bogus.  This
should be using Linux error codes.

