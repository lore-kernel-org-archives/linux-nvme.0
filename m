Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E36C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z+F8OKBRVrHemtCNpIsdEIPWxBR11j2DpZpy5xKBJU=; b=vd71gW2CSkl50lM2xS+1IVXYUV
	JcV26GckDRD9/k9NisHNxyQF2kk9W19evjjTV9gwlybOwUQyJLQ7J1eFiv5e+iS8lNYd9zjzMz2o8
	qeTBN4O6wd99b5YGlNLZXdjKUWBWCzRaF4au4MsI4xw11mSHaFUYwPmPvGu8pRfhO7qjCHPEBfQ1O
	SniCKmIuxR1xl0jOKxkS33UxZXAUTB4ReThh4GnbDmlJbgYGnFp9lmpRFQ7YNOvpGpjUSbxfZkRoJ
	kjbxmvWCQ1frMdexTnlmLqP0zMK3KOgTqSttnem4sRNcx7IhMJf+b+VWapMjWtEWEdzHUIX7106Ap
	rihhE5Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7Bj-00GXoD-0q;
	Tue, 11 Apr 2023 06:09:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7Be-00GXn0-39
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:09:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5489268BFE; Tue, 11 Apr 2023 08:09:00 +0200 (CEST)
Date: Tue, 11 Apr 2023 08:09:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230411060900.GD18527@lst.de>
References: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_230903_165587_97A6A863 
X-CRM114-Status: UNSURE (   8.59  )
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

Thanks,

applied to nvme-6.4 with a trivial whitespace fix.

