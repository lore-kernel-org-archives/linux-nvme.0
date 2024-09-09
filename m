Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736EBECE587
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XF5+qiqDiKQFsBWRRA9xBf5qeeLlXYgufgEO4/vQZmc=; b=wAvbT2pqzDZRXMnQ0lv/41wV1E
	1yxMV6cAA1RUMZlb/ganqMx8nZs2lmlYuEmVt4yVY2OyPG3sPv39NOInvMFdNBEqX/YCfY7R58SV7
	nfdWQGyyLYCnVwOhBDW1xeg7Ii18ukQbgqwZeyhzVaqYTsTkNUnNWFIKGa6unsxDxnk/kk7SX0k6w
	nFKxBivRCzsO6xsW5ILAVpDun/fRO67ugrobYcwSWO54fWv5l65at3Ntcaso4fJ7FhfOEWHAQyB5d
	c0kpPGt6zbnTIPJDpNB79sHEi7h2up852SRAgK5ZK7yeUxHHBL+AQh6Le1JSfAk6rmOKvpFQZOPvB
	XNafbByA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snkni-00000003C96-2Bia;
	Mon, 09 Sep 2024 20:15:54 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snknf-00000003C8B-20jt
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 20:15:52 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 72BA84188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725912946; bh=XF5+qiqDiKQFsBWRRA9xBf5qeeLlXYgufgEO4/vQZmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JanhGMzk/8/zKfpNu4Ja1MFiPTyV8umxI15SBUsbmfF4QJvvg2V3kydaLHS7HMNbx
	 lfriljO0VTh49cJbmEEdXcSD9+ykDKrvEG7VD7p1B0hzjAL5YJzfHEfl8Xx0h3IiLQ
	 X6DXiYgFzrP9nt0LrKLtO+PwHbi+9tBhHWC/ShPQzSiMRmggkP39xWN5I+v+Q+5GAC
	 ZTCBKx+hZL5xVO6h5LC+g6vI7ieM9mddfrmUvkRacFTK/eJrWKpBiswbsq8egbX/P9
	 +aR3vEVQZH8FUOylBDkIt5xPnGo3i+l1fpNWd0gFVhsnooiRp585RDzGctkWMRTlbP
	 gxg0/xPwCmFMA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 72BA84188F;
	Mon,  9 Sep 2024 20:15:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: cvam <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cvam
 <cvam0000@gmail.com>
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
In-Reply-To: <20240909200253.19818-1-cvam0000@gmail.com>
References: <20240909200253.19818-1-cvam0000@gmail.com>
Date: Mon, 09 Sep 2024 14:15:45 -0600
Message-ID: <8734m8h9ce.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_131551_548092_8C6D665E 
X-CRM114-Status: GOOD (  14.19  )
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

Thanks for working to improve our documentation.  Some notes...

cvam <cvam0000@gmail.com> writes:

> location: 'Documentation/nvme/feature-and-quirk-policy.rst'
> tested: Not breaking anything.

I don't stress a lot over changelogs for simple tweaks like this, but
you could still try to write something in our normal imperative style.

> Signed-off-by: cvam <cvam0000@gmail.com>

There needs to be a blank line before the signed-off-by, and it should
have a full name in it please.

> ---
>  Documentation/nvme/feature-and-quirk-policy.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
> index c01d836d8e41..b5461aa303a4 100644
> --- a/Documentation/nvme/feature-and-quirk-policy.rst
> +++ b/Documentation/nvme/feature-and-quirk-policy.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =======================================
> -Linux NVMe feature and and quirk policy
> +Linux NVMe feature and quirk policy
>  =======================================

A nice touch would be to adjust the width of the "====" lines to match.

Thanks,

jon

