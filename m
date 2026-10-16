Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93634CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRmZ44uuoB5Cl7zEcgd+V00VLZ/bcrxBYaKkqBwThX0=; b=onHXJPvF7IbG/gyI/KWxj21Z5n
	AeQ3DCwR+qi5ZBDGqwxTFw5IM0tW8AoYBgkSXNRuXXsImq7kJZ1oJqJIMGe9V9V+UbfiXaO6krlKB
	ydkHWkWnEdm5tuU1HSu4XtPrjKZ00YvCcALu2M17Z9/i6BuWfVsINUchF1MT0tJosAonFY+FL/1u7
	kwRSFz/kPVKRSjRsfnUGuIQSEMWhrJOAESAtJQya3DULsDZw/qxHVzRRaWjntFGLTyW3kf2sy9DPP
	9CD/3fTAd9ZKKGAumh2IlfdHpXWdhaQi2GBev5Ej26xC8X/putrMqfRjnMz4eAf1y6vLTQhRN0m4r
	avrlkjrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkSE-00000003OGQ-2U9o;
	Fri, 16 Oct 2026 16:06:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkSD-00000003OF4-0etV
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:06:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 85D75417C4;
	Fri, 16 Oct 2026 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1226F1F000C5;
	Fri, 16 Oct 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166804;
	bh=dRmZ44uuoB5Cl7zEcgd+V00VLZ/bcrxBYaKkqBwThX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DasD90LyT+BMeYDYdf0IxsNcmsatLiD6vTOvzCyv2scluPKVaCBGjujVfUXHlnXpg
	 8ROtgL9TPEklV3vD7lOYE4sx+rw9rul58CN2C7QVlsBCWVzR9/bmWpRJluQQqLsXrc
	 AOZmnYGzxu0PiW5kPs72ErwxJJVzZIzHiOSThD3zgJPLhJSo91dc8jbtufEv+g4GHW
	 7nCCAJC90oCB+MF7l4/8xVWBQF54tTCCSoQ9yLP22NO9EzndSFds1G7JsI8ovM9aeE
	 xDU1K9NMXVPGM38vCoh0XHt3mYFLM4wElyA7ydQPTc17YSliW1AbJI06BGZTH8aumX
	 e/CvhvzoFlyrg==
Date: Fri, 16 Oct 2026 10:06:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nguyen Duy Nhat Anh <neganhat@gmail.com>
Cc: paul.ely@broadcom.com, nareshgottumukkala83@gmail.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nvmet-fc: skip port entry rebinding if already bound
 to a target port
Message-ID: <atJLkogz_looz_I7@kbusch-mbp>
References: <20261016155947.11018-1-neganhat@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016155947.11018-1-neganhat@gmail.com>
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

On Fri, Oct 16, 2026 at 10:59:47PM +0700, Nguyen Duy Nhat Anh wrote:
> v1 -> v2:
> - Move pe->tgtport check before nvmet_fc_tgtport_get() to avoid refcount leak.

You may want to double check before posting new versions because this v2
is identical to v1.

