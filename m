Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1176CFB446
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nue/bNgamwJslzuIxJbgdmXsOTE6BCCJFGyxSESw7i8=; b=CbLwqQSMOkywAis9O26/wF+pC/
	Xa4FngGLYUq3VcI8309e0HNCJeFaY736vCxRcfufZuEWX4tMv0vvWDZ37arn+cobyeD45gn9vY54C
	CdGebeFUUMKCU7yMGUxJdh2H0219wV8oJfCTJ9I/P1yCCfW22s8ixnj56+KZoPQCBPLMSVciAotkj
	4rMi8onXrehkpCF3SF3qkG/jrbtwZL8L9urrbLOmaem5KcUWbckqoaqgfVDceDC0yDiuHG2iYelWh
	mWVmzXngVww5YiMb+e9n7WXEyBcOiVuelj6A/mtsCBsDncpqI6WqUFvOrheRnW9l4KKGJ3uBtAUJh
	L4D4Jctw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpMv-00000002sqy-2GwA;
	Mon, 07 Oct 2024 15:09:53 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpIz-00000002rfT-1Pp8
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 15:05:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 722A4A4168D;
	Mon,  7 Oct 2024 15:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25522C4CEC6;
	Mon,  7 Oct 2024 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728313547;
	bh=ajiWvVJbykSj8/WDLqZv+JZ6N1/4GSNP6vPDJiqBCig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIzmnkLaSoMkpU5fKY2jpBYFtULuWTkjcUIxHBEu+pWoq7C/SlI+hLZrEoW5HR2EJ
	 GTbhwU5WjeTQPGeJWi7uZLCKRkSuZfVueSedyaymfRwlse1UxnKpKl/inTYVdy8U75
	 1Wv4y/aj4cIJt5uR5QOoUvJOkDSGl1ICkWMaV5WmyLXxOoVd605QEVS3P3W7s3DCXG
	 buaybVhpxeO6cAMsiMCrJ+hetQUh8O0DBKdctZkshsg1qIAuJ/FYTSud5EYMs2qE5F
	 e2AupQtoRgiFdNY2FM/2yKlRVluIFJ8ImamD1O4D61+pt90f2mwPGcs7C8M+15q8sX
	 nMOKd3v86gwwQ==
Date: Mon, 7 Oct 2024 09:05:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <ZwP4yJXOSTJVLTwX@kbusch-mbp>
References: <20241007145958.7933-1-gjoyce@linux.ibm.com>
 <20241007145958.7933-2-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007145958.7933-2-gjoyce@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_080549_467987_74761DE2 
X-CRM114-Status: GOOD (  11.39  )
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

On Mon, Oct 07, 2024 at 09:59:58AM -0500, gjoyce@linux.ibm.com wrote:
> @@ -2458,8 +2458,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	else
>  		ctrl->ctrl_config = NVME_CC_CSS_NVM;
>  
> -	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
> -		ctrl->ctrl_config |= NVME_CC_CRIME;
> +	/*
> +	 * Setting CRIME results in CSTS.RDY before the media is ready. This
> +	 * make it possible for media related commands to return the error
> +	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
> +	 * structured to handle retries, disable CC.CRIME.
> +	 */
> +	ctrl->ctrl_config &= ~NVME_CC_CRIME;

A little further down in this function, there's a check from CC_CRIME to
know which ready timeout value to use. You can remove that check with
this change.

