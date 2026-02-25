Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB01FD3776
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=52c0sIkII4GIrKP5Wfe+9YEXj2DRoukSzAbhR/EXkNg=; b=oFH9Ds1KVJchQHb/LbXDsO8vGv
	oDG7dOzzJ46v6OXxz2STkFAi2WB9y6OEe7xJcivo3PaSfo/iUFnOoMqQ6CJmss9wjAlacjhqOynrm
	Way04BHpDvzCrLS8us7oqB5s7upzIqNa5M2HvUEH/nZxppV1CF/UDGxBK9BD7h18AD+LM4+6GljI5
	xN26InUSzE0bfgjp7zJQwabGVmf7rY29AuCY/bdKD+vtaS5Zj6NxqoMSeyGx3jj8rajPa+Kn15Gid
	israWwoNK46GCWyKlzyGpx/czIIn89JTMQyp4G9kwC/B7klVocQMOFBNE3/t41+yjJdP60UxhNaid
	x+0GrvFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvIos-00000004fsF-0AkG;
	Wed, 25 Feb 2026 17:37:06 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvIoo-00000004fnp-42bK
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 17:37:04 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7DF8DAEEA;
	Wed, 25 Feb 2026 18:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1772041013; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=52c0sIkII4GIrKP5Wfe+9YEXj2DRoukSzAbhR/EXkNg=;
	b=V/xj/s5c6WpUcUtGg37g+zu1Zd6ycsKf05uKJxT6d9h4xgMWkR1xZ7w76AUVflMsByiFBo
	skYmibLPZTaJ4CbkA62b2LoE7YCVG/no0MGXqIpN44Foz9JAm0aOv5JcWJygPHiu58CAqb
	/MW2yxR0A+u3GQG10p/a+5X49V9iTBbG88wbEK3WKOSVxg/goVltuPF2KHWJU9hz88KEBV
	b6yNYFPlFkMtn6T6zCNPfXrqm7LnCllqxObwyJDLfIaFKbePNWNVylrJhwRi+hbqTPb9O3
	R2NcknXZccf+9u0RGau5vc2gyGxNSgsa0B9MsQ4P/comjWjaR9nOYOSmS2NngA==
Date: Wed, 25 Feb 2026 18:36:47 +0100
From: Daniel Wagner <wagi@monom.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org
Subject: nvme-tcp circular lockdep warning
Message-ID: <c43fcd3b-fa12-461c-9b97-be51b12a74d0@nitrogen.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_093703_282339_B42A65EC 
X-CRM114-Status: UNSURE (   6.80  )
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

Hi Chaitanya,

The nightly CI build for nvme-cli runs into the long standing circular
lockdep warning in nvme-tcp. I saw you were working on this, but it
looks like the work stalled. Is this correct? Do you need help to get
this pushed over the line?

https://lore.kernel.org/linux-nvme/c6e88bc3-8cc9-4503-a472-7692468ac218@linux.ibm.com/
https://lore.kernel.org/all/20251125005950.41046-1-ckulkarnilinux@gmail.com/
https://lore.kernel.org/all/a3159403-7344-4627-a413-f289a313c12a@nvidia.com/

Cheers,
Daniel

