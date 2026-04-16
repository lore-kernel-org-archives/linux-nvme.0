Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B5F8DFCC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDuiyqtYf9H2vTd2p1zOKi6h1vITGxjuSg9O2IQ5J9E=; b=CifObW6LeoCNroDbuqvWyZTB1z
	cM7+qI3U6BJ5vaS7M3A8eBGNl1BJwrUi2UvFw25hKpKEInvo/ZGalqjaWElY3RCeUgHhQWZ9l1G4/
	AJKesG5ILQ0efS2HS7upwlXt2bFb1jf/arMViwkJ0au5w+2nUctBSTUhpgQvB5cBENc6xMSn086K4
	rDrROBQIRFKrvcbFjn7Uh6nQAanhvHaqonUbT+CmH8wm9Y0vkCl8NTh07HmfGoPtu14VCGL8jP7+C
	XaIad7EGXepX8sb9Jvmd3vu+SpU1V6Fn8LnZKIyZR+eTl/pAL1rsLpYQlf+1kF3DdLVvM3f+WhkYh
	LK3vPIDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUl2-000000037MQ-3V19;
	Thu, 16 Apr 2026 22:00:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUl1-000000037M2-1vvr
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 22:00:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E36E26012A;
	Thu, 16 Apr 2026 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F86BC2BCAF;
	Thu, 16 Apr 2026 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776376818;
	bh=nDuiyqtYf9H2vTd2p1zOKi6h1vITGxjuSg9O2IQ5J9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8UvAMzqA70xQkzxDdxGE2SF/a8aQr6zEzAELVM+QjKuLkW1TFX7IXv/J8V3EBMqM
	 VlEBWcqenREpG58O4Mj8wUuroa6s7d8946OvGaBMubaSNSbAZIxdFuy0lCHL6+hQzc
	 NmaysNm3grohN9WoFmCigvdOpPwJmA6lVRJLk10aydJ0uzOGtyAXdj3QCLZv9T1g6n
	 tnbN4Qvfa9jRBhzZZYuNsm6Xbw+BbS+LeGgFShYmAYxMrp3qEAAsRxBSXfSuESeDIy
	 gZ5utEQQ+xb2C9D/1Q94lF07qowis2dUDMeQ5wVnciKU0bp+aH7/U6ECWs0wFybwE+
	 uDZ9x4bS+/KGA==
Date: Thu, 16 Apr 2026 16:00:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
Message-ID: <aeFb8Ao83MTy9jUq@kbusch-mbp>
References: <CGME20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
 <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
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

On Thu, Apr 16, 2026 at 10:07:13AM +0900, 전민식 wrote:
> Co-authored-by: Beomsoo Kim <beomsooo.kim@samsung.com>
> Co-authored-by: Eunsoo Lee <euns212.lee@samsung.com>
> Co-authored-by: Steven Seungcheol Lee <sc108.lee@samsung.com>

...

> -void nvme_complete_rq(struct request *req)
> +void __nvme_complete_rq(struct request *req)

You're missing the "static" declaration, which was present in the
original suggestion:

https://lore.kernel.org/linux-nvme/acVCnozG1WKPkq1L@kbusch-mbp/

Should I just apply my local copy? I think it's an original patch from
me at this point.

