Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC7FEEF49
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnvDNDECLtV9cJ2xS9pfpsWmx+pikZ1KyQlWWhEwOnA=; b=uzDx5F2JsrpUHVhsMXEG2K5YfY
	enF7B8qMfiNJeK9uSggJbaaN+CkQ4EXtyg4mWQdnbWaSZM0hWUiBJJynsuaEaZQcWlY1pVwnKWBW4
	+pCeqj/yQAg/xO0kP1LZ/u6y8Jvzc51k0JKCwtb4Db0CMr8T83RvuyO7H9qk8n89OCAqY1ioYTaGJ
	4Z58/O9QfVbMAvSWeIpm5o2hKpQO9lrY4ycWAJpcqst//JanKu77btzZNlUzvI/MPWo02IU36xE5j
	LYxkhC6m2NlwFjVFoDSfuiRU7ybK9NukPUbTd/JchSTj4dJhZpBrjx5vWBBCTYnfZfrYcs6NpJkEK
	r+u7zdSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7Nw-00000006bPN-0X9I;
	Tue, 07 Apr 2026 14:26:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7Nu-00000006bP3-2qYG
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 14:26:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADE6A600AC;
	Tue,  7 Apr 2026 14:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09303C116C6;
	Tue,  7 Apr 2026 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571989;
	bh=EhFq77p6m85VFTqG0hSw/4zClg54UdyRDL+EJp12GZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWGuN45i5bVT1TJ9nTGkOK8YLp/PqpuVr9H/1BembWdbnJYiSPBmGFZ8PuNM8RgFf
	 A7uIIlN66XZHLF9fIaFKcG5QApr7lsPiShDmLPHwnsnHpcY8b4klRa2WQNUoQ2qzKV
	 b4vzr70+734PNebqRTGX/WIdEWzWSQHjicuD6ApXcoQvYHHFbb9GEjTT6WLfXnU8Lx
	 W5UNr8gGZXNZj7AA0VFeSK9D8MhNzxtcQpAjcTpWrDNYgJLfWqDvEvSzP1pJJwuS0i
	 tvZnZYoYJJ2/M0+JX9K1eZNwIFq7QYKwd/0stdDdbSO6kS385YyqGzsAOkMjpjBrig
	 /biw/2nweUr/g==
Date: Tue, 7 Apr 2026 08:26:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>, gregkh@linuxfoundation.org,
	security@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in
 digest error path
Message-ID: <adUUE2Kj9vxs2yIT@kbusch-mbp>
References: <2026031827-carving-overdrawn-5b1f@gregkh>
 <20260318225658.1760759-1-kumar.shivam43666@gmail.com>
 <20260320074652.GA14485@lst.de>
 <CA+ysrS+Uht6pXJ3odiyGccZ7HrR+WvtrHexNkTB1Gvy=Uxw79w@mail.gmail.com>
 <20260407063139.GB7036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407063139.GB7036@lst.de>
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

On Tue, Apr 07, 2026 at 08:31:39AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 05, 2026 at 03:54:24PM -0400, Shivam Kumar wrote:
> > Hi all,
> > 
> > Just following up on this patch.
> > Please let me know if there are any concerns or if any changes are needed.
> 
> Well, if we can't get people more familiar with TCP to look over it
> there's not much we can do but include it.

Yep, let's just go forward with this. Patch applied to nvme-7.1. Thanks!

