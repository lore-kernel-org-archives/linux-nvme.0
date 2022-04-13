Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b99kjEtSVTsTUhfxTFpakM+ZH2nDfwPyKq6I0vlCjGY=; b=dNC5CqCz3GAizJJfPOe2Vh7XjG
	2tauuK8SlG2X55zsZdPJQWz/Jo9yR6szjNyXgYVtpkCOYr56fiXS5imf09iKRjegqh/E2ATXliR3p
	4HyUoU/PdVUphZf4SPvzGY+PArlRGJBMb5XubbeMpi0b30POpKugRXd2wuO3wwoZHdnEYBKtef3iY
	+3SO365dlG8RvYVDWhvQ6+m5KnPMZbGjFU5G6EFgdQV3XCJ+c1k5kps4oSeKU14HDroEtP/EeQ4eP
	s1gN205kdL4YnyZOsTHU1WbmyVQ9RdHzAlMV1o8jYzayn8kvuFL8UosNuLSqVHF1f8NF9s8Hj9AAm
	Z/we8W7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negKU-001qh0-HU; Wed, 13 Apr 2022 16:58:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negKQ-001qfu-7i
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 16:58:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 93BBC61E7D;
 Wed, 13 Apr 2022 16:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E7FC385A3;
 Wed, 13 Apr 2022 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649869129;
 bh=b99kjEtSVTsTUhfxTFpakM+ZH2nDfwPyKq6I0vlCjGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EsfwkHFLQjpIOdztE9cEeW8KMoP8XvfN8DfRWRTl1ntRZwSwCuGYtuJb5TK0vmOXA
 0S/U/VCxwur/YscIl9zbk+Cmmx0oQ8T2tFWHKNro1AsF7q1jHfaFLYOs4z1FD1bU5I
 if7Ff3Z9vtPzB22M3fYW2eUPYvPpUY/aZtOMr4MA/saJinjX9+TR/JxZiMx7/5v/tv
 0UM+eOoWmFvHqYOGXhTB41nDx2k15cCVFcEnCcO9WekpdxUXqNigtoEUxmBSLFqltC
 bC/TIWzh1KRNkJtoOOa+Bw8UrskeC76HR6V/A/geMgIj4c+zfm68BXjuM+EIbBpZU0
 XEVv3WziiZWVQ==
Date: Wed, 13 Apr 2022 10:58:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Message-ID: <YlcBRhH3h4vZht9Z@kbusch-mbp.dhcp.thefacebook.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_095850_362520_97090E17 
X-CRM114-Status: UNSURE (   9.42  )
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

On Sun, Apr 10, 2022 at 08:12:49PM -0700, Chaitanya Kulkarni wrote:
> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().

The subject should say RQF_QUIET instead of REQ_, but otherwise this looks good
to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

