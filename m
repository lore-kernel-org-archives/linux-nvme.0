Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B2C61DD3
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2026 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N79wN7YPixkdJkvEQMksfAjXEw5uADOn6KxuHnfXdP4=; b=b1zoG1WPhyySSb3L2qfQzU2KC/
	KoXd1tvbgJfCptix0RrdBTvfCEK4JEgwdvZg21iOSrOZDwM3Z21/wRS94yNR+DTr/fxAsBbvVSYnf
	j6kEXkQwHfGtVol0fYSXu7YZZVcrNUv4XaVFkrKK2Ghr0d6ITOD4+QohqzFwR8ZM/qjRa/Qvujr7w
	+XuoPcp/LXb2hD8ovFa0MfbXDs436axS11WwQ6OhaVbrbH2mwrxeuLFpmLsZ8WymmZMUwv1Z3Y65R
	adanQS11TIK9/tgkWlGAvYFeN6KC9KxezgymzWXzkHsJF3Ptae6/qJPx7mzvUBlw+OvFoLBrFY6xi
	Ehk8iRbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09qG-00000006fxr-20Ih;
	Sat, 29 Aug 2026 03:34:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09qC-00000006fxH-3don
	for linux-nvme@lists.infradead.org;
	Sat, 29 Aug 2026 03:34:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F5AE401BE;
	Sat, 29 Aug 2026 03:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C9B1F000E9;
	Sat, 29 Aug 2026 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974488;
	bh=N79wN7YPixkdJkvEQMksfAjXEw5uADOn6KxuHnfXdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuH3aafQFcKm+Kd86TKeHQGnFTuZove8+IfrZhksPMFKsiH6MXlI0Oy9Zo8gHpJfz
	 LaIS4JJeRjjrsrbnO2qrBAHjlV0dvg1dxuakdQ+yQMQWWE8Fsl9fu5nzlqKyhLJ+sI
	 j1fr2mwfdslUtctKQwe/mTvqj/XGsUAE6PF52FU+3AtecepW6Mea1YyEsau1JUy4KR
	 KmYkMAqTHWrOXwpGI1H6FPLclATsUNRcQo30KNwUO0jR810LyyNq+MrkUySEjHLmHw
	 N6ldSoAPtH//h/MvG3sMV6qShNfoIkqeMFtTBjFZXyjLNMEKTHZ7Q/nKiK9zYv56TX
	 SZjeurQUlcR7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: Re: [PATCH 7.1.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:34 -0400
Message-ID: <20260828-stable-daily-0003-nvme-tcp-7-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222024.45443-1-carlos.bilbao@kernel.org>
References: <20260827222024.45443-1-carlos.bilbao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.
>
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.

Queued for 7.1 and 7.2.

-- 
Thanks,
Sasha

