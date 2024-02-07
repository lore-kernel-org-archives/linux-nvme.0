Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC81C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3HntlHFlixkLNbpSrETrWodL0vN3t9FqpdMu7WCdicA=; b=ubMkc5/+qGwMSVRJ3c4TxKKebt
	4OsjaRRgydAwIlh5Hj5aQ+LDM9UGeOvAsAdfFx1YFkr2KDE/UnZnGZ0NWXveUknUrp9rQFh/ivPF7
	pXrIi/tAUpz+D3bVIyilxsiAgHBonN9ouneGxZMc120XwAoys3NqJxz0Iqr++9/G5k2fZqTQgiJnE
	wJkfyUn0HVDNkVVfKz4RO/pkxRVQfHeHamma9HNKSSp8jL+3TPchZW6D27dszFgt1A7ZvfkEd78ys
	ofv9eEE0a122INA+7VbdqBqwqn6feKuCoWTRaGv0T3ZK9AiF/iB6Y0FPe4vr+rI++4hIkjFgP0MAM
	FsVQ0Y7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXrnW-0000000CGNA-3z4r;
	Wed, 07 Feb 2024 23:57:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXrnU-0000000CGMc-2AQn
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 23:57:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 63673CE1A32;
	Wed,  7 Feb 2024 23:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5296BC433C7;
	Wed,  7 Feb 2024 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707350260;
	bh=WsQ3bq2W7oIUo8zZTQZGs73bueFkghEJw/XJBCl1jLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBxd7UOXlrKVLCCIk8d4H0OpZyedQ4D/B0zn30/8p10Qx/9Zu/MwlI+YLXfrjmkeI
	 vSOs0nVXryJj6vCZfWwwWOrjLTYqcBkie6w3pUIBXBnFfsSFKuqvCrOddECSO3FtSG
	 hlmnblW8/7seYsd5hCxr9HigfmPuWD3MQvq9HcpTHxW7uTy70vjdJFzZfI9/CMHWaU
	 z6iZ/+4STyMZrPk71AWGs9za8JzehZ1ox5cnRikgIfZIL+luYWo4v38Jv7TTlC2awp
	 Y4Eywy+5T2wH1PXsRRLpwPLPfQyWZolpNlMnAPHUfxP8Zdui1G3hOxnTkrG0CuhWf+
	 TOjJL7gz0LPQA==
Date: Wed, 7 Feb 2024 15:57:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: francis.p@samsung.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, sathya.m@samsung.com,
	d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com
Subject: Re: [PATCH] nvme: use ns->head->pi_size instead of t10_pi_tuple
 structure size
Message-ID: <ZcQY8sBH68aEkc0e@kbusch-mbp>
References: <CGME20240207050232epcas5p4f6fcd56e72f6b25fe44123df4597a770@epcas5p4.samsung.com>
 <1707262457-20904-1-git-send-email-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707262457-20904-1-git-send-email-francis.p@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_155744_749526_943CCC0A 
X-CRM114-Status: UNSURE (   8.42  )
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

On Wed, Feb 07, 2024 at 05:04:17AM +0530, francis.p@samsung.com wrote:
> @@ -228,7 +228,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  	length = (io.nblocks + 1) << ns->head->lba_shift;
>  
>  	if ((io.control & NVME_RW_PRINFO_PRACT) &&
> -	    ns->head->ms == sizeof(struct t10_pi_tuple)) {
> +	    (ns->head->ms == ns->head->pi_size)) {

We could use 'nvme_ns_has_pi(ns->head)' instead. It's essentially the
same as this, so patch applied. Thanks.

