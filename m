Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D7C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 04:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3F6h4fXAmt3OuLveIiUg0PPpYLew78yIs692r/yRiMw=; b=Mo7QV9S1h5fUBUj87e1ZI/6N2x
	9ryRZ8+I9Zm+SF4H+VxNG+SWE2QUdU4oTPqeg4lcbg8KhUSibafl1LEB3tDHxgeY87flpAvsoFO4E
	7YSoIE2nMpyV0uFb1ox0RUYDGDIIcATR0oDTN/9Z+SA4WAPzeD3r6dFdDOXNye+anHKEd4G/fvsI6
	83A9EEqmlTsrwjEhDoiiDC6opfy/e1efp+uMWZSvzkjXV1D3UM2+EOqYcRU1e8bjuj9VlSDu3Asqf
	hQlX3nqqs/T51eyap+SY2vMH/5gwguScobst7j7KMR0f7j377LC77Mmynd+NxGBkGT5a0UiQftmwD
	qSmLWBHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lFC-004Lpx-1e;
	Wed, 07 Jun 2023 04:58:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lF9-004Lp6-0L
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 04:58:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DA3868AA6; Wed,  7 Jun 2023 06:57:49 +0200 (CEST)
Date: Wed, 7 Jun 2023 06:57:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH V2 3/4] nvmet-auth: use helper for auth send/recv cmd
 prep
Message-ID: <20230607045749.GA19819@lst.de>
References: <20230605064434.45233-1-kch@nvidia.com> <20230605064434.45233-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605064434.45233-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_215759_292442_C99F8A9E 
X-CRM114-Status: GOOD (  10.32  )
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

On Sun, Jun 04, 2023 at 11:44:33PM -0700, Chaitanya Kulkarni wrote:
> Add a common helper to factor out secp/spsp values check and transfer
> buffer allocation in nvmet_execute_auth_send() and
> nvmet_execute_auth_receive().

While the patch looks correct, I can't say I really like.  Having a
"common prep" function for just two unrelated things doesn't exactly
improve readability.  And it also doesn't remove all that much code.

