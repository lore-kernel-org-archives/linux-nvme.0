Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80610C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ct2f4r0RU7UsX9JmLM1N9Zs7OgQ22KwT1yJ+bgJBd4k=; b=oEEM+plStZTdLyyM0S3vsdxt1L
	4+aa0cWblpv++cU31Yrsw7VUyYMmG87y8AYpoDDW4BzYQNuAPYrP0oPVSZu7DkEf1cHxnIwzmUxTV
	ovdKLyQKml3dYf4fAQ9sezYsuXYMAmP1ljsXU3JpSPKjiVRt0orMQTKbAXvp7KBpVweNjqmumILpQ
	ZamM588hV8cNb5YNj2xRcciSikgZ48E61ZTY+jZbMWEwvV39yyVaswGabUqStHfOpkrwWtbqUF7S8
	1PHXSSvNCaW0EdWQShD2Y8nsTsc08Jg25BSIsmEp0kzGtdNb+K8gtJRs2TROtBF15XtmQ6YYXFhD5
	GqQiz4+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Nip-00DeKZ-Nw; Thu, 22 Dec 2022 15:43:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Ne9-00DbQb-1s
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 15:38:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5F89E61C33;
	Thu, 22 Dec 2022 15:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D764C433D2;
	Thu, 22 Dec 2022 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671723491;
	bh=C1ucTAhVEx8VstdTH5ZqCC92CYcfpgii3WA9b1KBBDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkihI9w1azgo+d6uzqW6QnBUQ9Fn11LIRG7sKyANKOH9Dl0CCwGwxDvx01WyArwFF
	 FSQKMEWpmAz+vNVZtdzMm7kbHb6bPBicYBFVW4JRktqfaC+/OARiU4oML/Sjel4WyF
	 jXCrsV/KwnPVGO37YR8HPTOLe1WMNhWtXmYvFB9EaJqRmPxFK2wAjvFeZ+tb+2b2uv
	 xcxHepa3yTNiAArg+7r0/HSVw/SoSr5G9Vt8WeoQB0ZSeC/UGqOCsgpfv7VSozit/t
	 Ssxq+/qJutN3JYytnP7/JskpufCfRApoO5Bie3EuOFh0zXeKDAZB10kY4alRINupk/
	 QH3qTRTsYdV1Q==
Date: Thu, 22 Dec 2022 08:38:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <Y6R54M2/wQWK5Htf@kbusch-mbp.dhcp.thefacebook.com>
References: <20221221101050.759606-1-hch@lst.de>
 <20221221101050.759606-6-hch@lst.de>
 <Y6N913AdRwkbyuAD@kbusch-mbp.dhcp.thefacebook.com>
 <20221222085737.GA13174@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222085737.GA13174@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_073813_170506_3E256F48 
X-CRM114-Status: GOOD (  14.38  )
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

On Thu, Dec 22, 2022 at 09:57:37AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 21, 2022 at 02:42:47PM -0700, Keith Busch wrote:
> > Just noticed we need to mask out the CSE value for IO commands in case
> > some crazy controller sets it. If the driver were to see that value as
> > non-zero, it will freeze the IO queue the ioctl requires to to submit
> > its own IO request.
> 
> I'd rather reject passthrough of I/O commands with that effect
> entirely, does that sound reasonable?

Sounds good to me.

