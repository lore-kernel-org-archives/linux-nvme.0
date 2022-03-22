Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D6AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSioTwgwF8HDp+VO6HZca5vKM56xLkJusTgGdE9xtlc=; b=m2fEUzfQ6VDf8f89RvJTFk15u7
	BB2TCwLcJBgCaRXlnhwQEkqNETGwHZDy5yEa6LfeIBGFOM4+Q9njiUamO21hw6PX0/mgK33jd5DCK
	vFaH92q4cdeou9cAh5aEVuLtRBUtEIUeWUgNp5K399EvMLyYWapo2yOhdUdmxNjCKHE88o/Cd/uT4
	6+5JsCNiC9WToF39UVZa1mHNwJ3Z8ZUhtJrgly6QR2wT8/91N+7IHRffnRPffrhbpdtx+gND5xcwn
	/CM9vt6TpNTmEfXvvinUfGwU0FNjbrk2HqMKfzT3vlUENYxrN+Ak1imvmiamcGk08iraJdw5S1l8Q
	dOOdptnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWiEn-00Big8-Cp; Tue, 22 Mar 2022 17:24:05 +0000
Received: from rosenzweig.io ([138.197.143.207])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWiEZ-00Bib1-Pc; Tue, 22 Mar 2022 17:23:53 +0000
Received: by rosenzweig.io (Postfix, from userid 1000)
 id 54B6341E2D; Tue, 22 Mar 2022 17:23:43 +0000 (UTC)
Date: Tue, 22 Mar 2022 17:23:43 +0000
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Message-ID: <YjoGH2JYd7cvx844@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_102351_948879_D5CE1D62 
X-CRM114-Status: GOOD (  11.60  )
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

> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
> +	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
> +	APPLE_RTKIT_PWR_STATE_GATED = 0x02,
> +	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
> +	APPLE_RTKIT_PWR_STATE_ON = 0x20,
> +};

It would be great to get comments added explaining what these states
are. It's not obvious how off/sleep/gated/quiesced differ, and it's not
obvious from the code (doesn't look like GATED is used here at all?).
Are these Apple names or r/e'd names or a mix?

> +	if (!rtk->syslog_buffer.size) {
> +		rtk_warn(
> +			"received syslog message but syslog_buffer.size is zero");
> +		goto done;
> +	}
> +	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
> +		rtk_warn("received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem");
> +		goto done;
> +	}

Nit: Wrapping is inconsistent between these two warns.

