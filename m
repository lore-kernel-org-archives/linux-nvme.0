Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320CFC64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cvcqKOtDKWbLDm22+74tjChsOJ/IKSLIDCo8+IMdfA=; b=ztSTp7NNFsNtPTsGrTd4hr2aUI
	+uE/PWFp78y5EdaU1i4p1q8SaRBWD13Gj1eTyqsfw0Y4hcm0nC4zATQRWoWs9CS0JC9Nv9Cp0N1od
	WM0Z3mzEfj5X55loy+N0usd8AStHHPQ11ktnyS+R4Exp95Z1CmWQl942Gh9d+XPrGSJIBwHAyKtYK
	FJxiiDyIjjqUNSdXA2TVI1+JEspuYB/9b7iD14+J/VGapJFc2oquss5Bf/Yug1F8Rn5F72UbHt/hT
	Kx0QHdJ3c1N0BhDkQwxTEQnEiUjogF+o9FrTsnlHcDEGPOTzTaAJLp+cNc/CpAYphcd6Ls5EpZtb9
	wetuxO/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWfYq-00AE41-NK; Mon, 27 Feb 2023 15:37:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWfYo-00AE3O-A3
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 15:37:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E21F60EA4;
	Mon, 27 Feb 2023 15:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676FBC433D2;
	Mon, 27 Feb 2023 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677512221;
	bh=JtvDXJr6JCFZpQtQUIN5Kpyo+iuCLV+hEERrrcZ2oPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX0o+9MF5uv8Lck0IRJ/2RxBaar3mR+YhrHEhSGlMknJxWx99Eac7ZnxevaTUqOGJ
	 eUxW8vpLO0yCELbnWlbMB+0G2qzlIfC2zDtag4s6f5dQMLHocfrglhV1upqZBnR4nB
	 eY6imGjzJWLppDDtl+ugjBl5aGf7oLsP3kQKW+E9SRjX5zx8mk0bhfQDYbC9heduVy
	 Mr9XxbeOVZ3MOn7djHSzT1Dkd9UYTiqYY5LlyatnutOcPrhnAFNjDnY34UwgghLAF/
	 HoUe+UIB8Dp5ZvR5er7rJ0Yc08jTvirWu3fzmuy+ItbPDQDjD9Z653YFfcB0O6Y4Ud
	 IYkVnB7FXWdKA==
Date: Mon, 27 Feb 2023 08:36:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, nh@edgeless.systems
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Message-ID: <Y/zOGkhVwS9pFC/6@kbusch-mbp.dhcp.thefacebook.com>
References: <20230221222307.557935-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221222307.557935-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_073706_431552_4E52507A 
X-CRM114-Status: GOOD (  10.63  )
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

On Tue, Feb 21, 2023 at 02:23:07PM -0800, Christoph Hellwig wrote:
> Bring back the check of the Identify Namespace return value for the
> legacy NVMe 1.0-style sequential scanning.  While NVMe 1.0 does not
> support namespace management, there are "modern" cloud solutions like
> Google Cloud Platform that claim the obsolete 1.0 compliance for no
> good reason while supporting proprietary sideband namespace management.
> 
> Fixes: 1a893c2bfef4 ("nvme: refactor namespace probing")
> Reported-by: Nils Hanke <nh@edgeless.systems>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

