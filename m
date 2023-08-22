Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAECEE4993
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=; b=3bi+ma/JHhE0/Tuw/VjdAoCBsn
	qD7mUALzuxogwXzzGxx09GqtBHsQHbERKQcDzyYLzpdbXAirP0OsH0rhVDH+KK3pGDcWJhyByABmd
	YM4WnJHe38aSr/rfCvGQ3hrTDVLTvU4/9FvA1CkfBSmJ+Zw076BKbiHVkZc/hM0SSi0BxOGNSU8Pf
	+qHD+RMbFbSJGMFJuht2xAOeI92J49/iaHGrKhT59e6iyVfV9KREnZLxXRvzm2cZGUCBHa7wuOkbL
	vBASzJxj7l2ySv7lTpnxO4LMWkLy1Rsm5hB9rOhLhZ1k1SHf5rRqsyv/0QkZM7OCA59lUlp10lQEq
	f5g8jhEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTeW-00GP8E-30;
	Tue, 22 Aug 2023 15:50:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTeU-00GP7w-2f
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 15:50:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 51AF261EA2;
	Tue, 22 Aug 2023 15:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A91BC433C8;
	Tue, 22 Aug 2023 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692719441;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QA2lKo6W9gA4d98IcqZP/tE7frMp4yPwC8NMYmRoOcf+Zej7PBZG46kDNrpFF2e+G
	 5LWEq2SvoJ0ZZCZx3br2U3dIlHNVuHwKzaFJZX9S+GkRfrgqG+kj2kDYmEk5OiwTIL
	 GkcF+HfArDPTzicJYD0wrdqTE14/Vy/uYcPIA/S8bbtZP4Xa0fqB4j/nB85UxdrjGd
	 qbzbrLxcU2Ar2k0fwccBKw/KE6R5aTY4+1BBiXg2EDHqv3HPXR6entLtNQ84+Gzvk5
	 QoxKNP9njeKQ9y9aTT9WxpG9oxV7MEotdGgHFOqXp7QN6iBhwZS6grozacYa/B/Em/
	 2lulzhNJtQ3Qw==
Date: Tue, 22 Aug 2023 09:50:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <ZOTZT3aWUfuSdXeQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_085042_912103_4093E7E4 
X-CRM114-Status: UNSURE (   8.25  )
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

Thanks, applied for nvme-6.6.

