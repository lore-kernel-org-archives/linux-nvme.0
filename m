Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2C9C369D3
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHCPdZfLsw/llruNUQBXdorSFQmZ2bV5FNd+8scUOgk=; b=xa1/Ee5y9cf5YxoSy8slFy075V
	DMMjl04Pqno+DoWY1qaROFFRJGBfmJ2k8XDnE+2alTxKA5BFWk83ksltf5VjIVWmMyvBcr0d/Fc0O
	ofGTyMuWCOzA6kArn7BiumLfYeyhWRdGyu2iGoigtUkAxFhgpDLNS9dGyJJqI/Cxp6of4pvp81mvN
	ehj1CFWbGQETyNXzDwwfyfZQCZwoB+8+KoXdou55sPAKL5MOiO2GfXOV734iKbIi+dSpTMiUc1/2H
	kg0kyuiyIJ5DvEHvbH/e9vGRhytfWdkn/HoMw3VuhWC5uHhXTdXKKOW5Vg4FghAQ6kiVW2Hi5bWWc
	gpppyF8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8CXp-0000000G4KP-1ebr;
	Fri, 25 Apr 2025 06:28:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8CXo-0000000G4Jw-0KIJ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 06:28:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 079B468465;
	Fri, 25 Apr 2025 06:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08813C4CEE4;
	Fri, 25 Apr 2025 06:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745562494;
	bh=3a4SD5XyhdVKey2Uc6alS6E+HQVONu3b+XtXoLyz5cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NqNNH+UPh3GOpd6Hkpw9xbRtYUCakDvdNlcg4N5zhJ2ikmcIZsI3S5Nedgomy4WLQ
	 gDC4ERHcjeyC8hP3WYExUzzNEQBxlsGPpBr/+wPAgvemgTiwcQlXKT/+4Ovzjx5sJw
	 2s41f7KEf+cfrUNW7KzAwbocRj8JUPCfE0LCAxGqINp0CyvPeKbi+YxB0Quxr63znd
	 EI2BT3O6c9CwXlNN18n8vcQ/yn5yUaZYLPJkfjUN60e8nyju92uYlqrxEJkYGlV6Rd
	 hYoFhNyjTXvk3AfAMZx46UdRX/7B51tV0MFqG/vFm04n8d2g5D4KWlXC1/hgvUtW3N
	 WA/oJytLTw8kw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: linux-nvme@lists.infradead.org, Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, leitao@debian.org, kch@nvidia.com, 
 sagi@grimberg.me, hch@lst.de, upstream+nvme@sigma-star.at
In-Reply-To: <20250420104726.2963750-1-richard@nod.at>
References: <20250420104726.2963750-1-richard@nod.at>
Subject: Re: [PATCH 1/2] configfs: Add CONFIGFS_ATTR_PERM helper
Message-Id: <174556246303.541073.9476765068827917682.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 08:27:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
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


On Sun, 20 Apr 2025 12:47:25 +0200, Richard Weinberger wrote:
> This new helper allows creating rw files with custom
> permissions.
> 
> 

Applied, thanks!

[1/2] configfs: Add CONFIGFS_ATTR_PERM helper
      commit: 052ddfe405efcad262278301abf809e31f08605c

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



