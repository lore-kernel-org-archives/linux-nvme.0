Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB5C8303F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZD4gIiVE+oiea/iPaNtJg3HPzJE3ocsAktrAH3EY2hQ=; b=PM1sgZwHdR3n6eyKwx5U4W3mJO
	bm/akobOReD2Tx/HYIy3pw6bjjFLTMLu1Lo3CsuDA6zq9LO8TZghImCradEa2K+k1XceKikq1fYfG
	eM0uHQHxKPeJkHA3q6wBlYxdOGHsQaElLnNhYlYpcQzzTSc00vp9S4eJJ01mJCyUQHHPK8kwDs9ie
	d1RQrrCQte0x5MP7B8b0vtByDJrJiFZNP8pMXx0U2HX1qhVuVpFhn3TH8MaNy/BealIZYVQiHXAAp
	Gv7AkU/6X9GLuXn+jAY2ji7CQaw4YMRqLIYVC68iPnxhcEGGk6FXvWMIa1oYn1fX849hZ8o9i8Vs9
	isRLncIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqfTt-00000009uz5-1Mbj;
	Mon, 25 Aug 2025 22:16:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqfR9-00000009uXf-0HQC;
	Mon, 25 Aug 2025 22:13:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A8FA5C6503;
	Mon, 25 Aug 2025 22:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115AC4CEED;
	Mon, 25 Aug 2025 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159988;
	bh=axR1PkwP3PCqOGhdZ8Q4aVIFEtqKvQk8HL5Bpa2psbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbVsfzrMFuOr+nJXmpVPp9JkyG99YFvsMrUil1SnQWkqErVIxmv4pUaZlOS8R57L3
	 hUTW3wANCZidwqn+wj6n5D4l9mHKR+K7FTEzhQAe/n7JSeNh4julMkVljOEcqP51FS
	 ImSvV82sPM6T+1ivGgsXbHspVdcxxcH1nh6OhH+jOLfSYJXe40v/DxPiMUhrgdU7O8
	 x5v6NIEiy3HC2rv0h0RDdDpZoOTVTSLMqzBAmTmkHmk7xuXPLy2lsxmdZcQ384XsE9
	 YNOQdSyQ45EhoLMwZBD5mIqY4GWO6VrQO1QJe9wCAe+91SrfU+sF2G99lDqWGGeYSB
	 UDK9HF00vP5/A==
Date: Mon, 25 Aug 2025 17:13:07 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250825221307.GA706481-robh@kernel.org>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
 <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_151311_146979_7111F903 
X-CRM114-Status: UNSURE (   8.71  )
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

On Mon, Aug 25, 2025 at 05:15:04PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

You forgot Krzysztof's Reviewed-by.


