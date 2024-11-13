Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CCD597BD
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbWN3ix1PiRbajwL48IQl/ALGDYN88rq2PX0Tvzs6zI=; b=JWbZYNfWcz1N2mheK48ld0aVwl
	uutgWH1Qg0Z5xkS7QDC6sWCnGStQ1Z+w9ve93FF7TGuwcrf9QR0PjjT16J5UIoNCaKUJgUhR8rYbp
	Tzx2rajaAdYu+kdDD2L9NgZWeEv0AmiMPW5h6NC3KJSVcZrOdUnPYIbCLsLlBOR/t0c30tvB/SgGJ
	r3knBvCOylPGFh6Pl/7tOXW1jnl4I481BW1MOwVuywrZfngJ2Ht3eTDVT0uLXu65hDD2HbRR03TWH
	WhfEjLDW0BALafLJPckOzv+03gvAfbLXlrpEWGkFzv7ftuknFcSFCUiqts9Tn1Kn3NYuTapPERSHy
	q96wiO2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGh5-00000007VvJ-3Hgl;
	Wed, 13 Nov 2024 16:58:15 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGh2-00000007Vuu-2yjf
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 16:58:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DC7B8A4052D;
	Wed, 13 Nov 2024 16:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D25BC4CEC3;
	Wed, 13 Nov 2024 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731517091;
	bh=stadwuKj1j4v4LKpIbqiH/dJ7UXxMNc3mkiFKOGOc0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oz11V9gfbIy7EHtNvZPy92wNHYdG5meMPZ0EcDAHoVg9DwoFXJW8AuJceJe9X4SCu
	 oYwt3mKDqCwi2h2Yuj168At8UtvfKSzwqv7PPYH6ybCANBP34hQTgshhcwJS0E2Jc5
	 N7GQw5QPZ79syeqbItscQqeLxW2Soa4i0fwixL2E+euqBDDwQTuywnrm6WoMn+fCXK
	 1NqUTLBWP+WEnhqNSjOZ+xfiCvP3L5i7F4EK6AvqQ/JK0i/3QCqhznQPXrSX5EyKeD
	 T5AcYNpuYp0RFQxe4SqxHLeEGRTODq+ZwDfMgqG0XjOGdg5vVQVIusJirpuSav5lJ7
	 tmiuc47zFB4lg==
Date: Wed, 13 Nov 2024 09:58:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] Add the tracing of reservation commands
Message-ID: <ZzTaobtFfTGLkVxy@kbusch-mbp>
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014101458.80491-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_085812_840771_548DC16D 
X-CRM114-Status: UNSURE (   8.72  )
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

On Mon, Oct 14, 2024 at 06:14:56PM +0800, Guixin Liu wrote:
> Host:
> - Parse the action and rtype to string.
> Target:
> - Add the tracing of reservation commands, and also parse actions
>  rtype to string.
> 
> Guixin Liu (2):
>   nvme: parse reservation commands's action and rtype to string
>   nvmet: add tracing of reservation commands

Thanks, applied to nvme-6.13.

