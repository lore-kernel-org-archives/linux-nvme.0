Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93EFCD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CzpOn/vnwhVqBK82tea3EwQywjpBoBgwUkewtYnNrAw=; b=c7h7OCeavVd1bHxZK/XZBLrSsJ
	6sr+q+jUGSMvxFCVu0VXLTeNH/9lwAT+yZ7zw3lfIgowg1jc7zFBQlbmRlJ5ctu3SDdqauXYrPVEp
	A1cwwV4+jczaEHVdCpDKFlkKi9tmDW2KcUGrgcCecRFo8Bb/JNEf70KAJAO1Y+a2QNeolwMTypd2w
	LeCrNCeMwm9GoAe+wVC3rk0BEKnM04n34E2actx/TANZ0964emmyLhkR1LF4AjoeCK5ONTgkLdmQK
	66C3CAWqYWXrHekA6OBoIcJmdg6mClQ4tbE7ob9ivcfb9rJf98NmyhwgRKDPKfWXdcK0Rq0XVX5y7
	On1Jsokw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKAD-00000007wM8-2zd0;
	Wed, 10 Jun 2026 14:44:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKAD-00000007wM1-06gu
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:44:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BDA8442F3;
	Wed, 10 Jun 2026 14:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA51A1F00893;
	Wed, 10 Jun 2026 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102656;
	bh=CzpOn/vnwhVqBK82tea3EwQywjpBoBgwUkewtYnNrAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X3NmxFadAqcgwkw+SRXv8eNX+AUDM/Gs/rUuiilkfyMlhfw7k26da4J2+cXdqgFFP
	 dgKTNGV9OdEtUiRISczL6GO2aER3JmdM1ldMsRu2ETkqwdLTuFXsaZZZNyjnMAAjA7
	 x6pikG1o7kEhFj8x3lTrl6mS1jkIIf4OMWH+8mw0kpYlRbzFiuuz6MfTpp/0aLJIaR
	 6DwxFgBhp9IXmidgVGR97IZB6ieYa4YkVr1rklWxNSIPNj1nC8yfm7zuHvpsCuSA19
	 9lnTsC7weOYgrLFTYBTLYO6AKIED/ClgUbsnY2gllMDMtsH4vLmjdd8qIqlEyLscjX
	 OxMSk5nh50I3w==
Date: Wed, 10 Jun 2026 08:44:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-auth: reject short AUTH_RECEIVE buffers
Message-ID: <ail4PgdFd3Xljugs@kbusch-mbp>
References: <20260609182431.2437882-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609182431.2437882-1-michael.bommarito@gmail.com>
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

On Tue, Jun 09, 2026 at 02:24:31PM -0400, Michael Bommarito wrote:
> nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
> after checking only that it is nonzero and matches the transfer length.
> In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
> initiator reach the fixed-size DH-HMAC-CHAP response builders with a
> kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
> nvmet_auth_failure1() write past the allocation; both only WARN_ON the
> short length and then format the message anyway.

Thanks, applied to nvme-7.2.

