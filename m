Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484F8C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=; b=1GECXHqgpylqAOsmeOQYp2pklu
	8SpfNgB5FngzLNeFTwJDYYo4b/Eei6kR1kxnvs0cnNYzSeHxtxNhIMgtOLIUW/OKcx8UEd0EK8ESD
	qIkYee+G6L7h/cUFTGskwPo07QH6JDYWyVQJcZvLwxmI9qbnTqWBASaMnmktFy1eHP9nTLWTbjOQU
	EWAuCDkQBNuo6B+7IsxQOGo8G5Dky3t29s7IYTSyl2MP+AVzlugETE6G7Y9Bi5VR5IaupEFDOeaMq
	UIJG6ZxoiM+m8GZrZ5l7HiFDwOmvdTC+linDEEzNYGLO7Lf5HkO6f97YewuhFA4sdbUV0UjjP9o35
	Yc1OZE5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q41qX-00EVrg-26;
	Tue, 30 May 2023 16:05:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q41qV-00EVr6-2O
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 16:05:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A89DF611CE;
	Tue, 30 May 2023 16:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1068C433D2;
	Tue, 30 May 2023 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685462714;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShgBWPIljj4Cdznri16BxvBNTVdb5d9+D0F7I5DpWjURu4SoEGgk/vx3bduTOml0n
	 tBlmh/UJVXV2LwY84cZuU6yZIULhnomuyVn4SUB8FkcYREMQFxWHTLBwl0F41e7GHv
	 KlhzlM4KBu4/x8r6DbjwtJDIFmKz63AbDMgnUN1LUj1FH05xZOQQuP3bNnhjqzrCJB
	 eRAxXCLO/eXXQGqgqaph0BFkBRFWaS/m9xXPHd9UENXf5qUrfDBzdJt1ru0oxxvZe2
	 6CFTbvD7sR4ACfbmcdHzbqoz4lUfhTcEFkcLHZrF+AQCkdoLMb9eeC8f/HW+t6fCCx
	 CfHi+h9dSDmhA==
Date: Tue, 30 May 2023 10:05:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: "min15.li" <min15.li@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix miss command type check
Message-ID: <ZHYet3BBJ+PQ0cxo@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b@epcas5p1.samsung.com>
 <20230526170656.55303-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526170656.55303-1-min15.li@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_090515_840152_69F284B0 
X-CRM114-Status: UNSURE (   7.31  )
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

Thanks, applied for nvme-6.4.

