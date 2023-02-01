Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5EAC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSWuUoc6/oCzv/xVoQnRyAZoGi1LPNJV0U4a+OcSqv4=; b=C9c37ocoItpgJCWdLDV3tTkaPn
	UoIs+3sCpT3CKLgvK+TIgoUrYSmSktD8//NXxRUVSc0AXehnIj3VVyZvyTPHvyUgkDmFXuNs9+zgn
	yaNDinFwETfv29wodyChnKsqKEojEX2zs4TnhKcM2YDHtLusgmY6j+hIUuV6+uH09kbeeZV2uLU3b
	lf3auxnizinRscqkpCASr9SdC7RGk0d1gJHrJW859jpIp9tfIHRNV0uIUu41zJ/7gSlHvLowD/7Qm
	V0BA6ee7XPZGrlBjuR8ROPp4rn56gF4d8yI0BD7hbi01Ol/PW4qgRs4xuHzRNSp12lDzi/YnU7K+6
	VY8b7Efg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNEjT-00Caci-Um; Wed, 01 Feb 2023 15:09:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNEjR-00Cab9-1o
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 15:09:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F3F41617C1;
	Wed,  1 Feb 2023 15:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A5C433D2;
	Wed,  1 Feb 2023 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675264143;
	bh=KBdDMjGdhwIQeRsBHMHZv7VqCll/GrxwDMhgl4bqjRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEv/q+k+mAOxB91EV9R7mS1JtyBa21Ot6dDC8HIqtEVNfc8ykUlGwF9E3PGJAZStb
	 0lxALRW0Honp1Ki4wJ6Rrpw31IZUs+y9X/nxpH5H91KMX8C1+ZfCwEkKRwAwvPl0V2
	 kLxy/TlEcZPCSEYhDYoqWBcZpVwO496YydzxegFYfKEaTio0A1Lh9WwEiCXsgcAEmn
	 P87C/WzCTAhLdnKP+wlCw5yxLhzEQXDDmdNJiPmn8k/1o3ZhQDN75m2+a6zq0L6psY
	 qz/wWCb5bB2xTZceTd2m6rGrtKyLP9T3F2SMB+Y8Qj6Lp1g9UqXBqAs8f0RAapSXX0
	 62sHEB3Sfgnnw==
Date: Wed, 1 Feb 2023 08:09:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [RESEND PATCHv3 0/2] nvme effects handling updates
Message-ID: <Y9qAjNXsa1swaSb2@kbusch-mbp.dhcp.thefacebook.com>
References: <20230127165620.3487918-1-kbusch@meta.com>
 <20230201132044.GA31561@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201132044.GA31561@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_070905_165626_129549B9 
X-CRM114-Status: UNSURE (   9.95  )
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

On Wed, Feb 01, 2023 at 02:20:44PM +0100, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.2.

Totally fine by me to put this in 6.2, though I assumed this was 6.3 material.
The Security Receive behavior this series addresses is a little annoying, but
not urgent. 

