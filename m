Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F11EC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsDwENkZPp7gesKWKxdqMvOgQQ6S2v0QzfLg0W5yjN8=; b=Ejy48YiVPGMC2tb/xF5Di403nI
	A9BrwmUfiJmGVe78OZDrQ/EvO9p8EkfU0/agJdQEjh/i+W3LXYXBNc5nTTOuKQFSWGrP8POXlOrnW
	+Ve6FGyu3IIfr5bjrjlFG3JqAeRDpBPaiKpyR7PdqzTCdyjsj1+WDBl4z1Qnhob/oYDCG29j+t4Qn
	pwqEwt/RDnIb6nIoGIAirqwlAvgYZuQJsV+1ENX2ewkvklYXtRtd9XGS45UPyuu+flIchmwwgGNQT
	srwCzJiIiglCZ7Juutk4p5hoADIcZ0yAK+mbjnEzoA5Kq6PoLyrUQRdUkcJpZTACXy5o/HSML2aEF
	e38yuP5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVhh-0000000Gdtq-28FN;
	Tue, 30 Jun 2026 10:28:33 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVhf-0000000Gdsb-2JrK
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 10:28:33 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9B0B7240029
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 12:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782815305; bh=XsDwENkZPp7gesKWKxdqMvOgQQ6S2v0QzfLg0W5yjN8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=hEwz/D750f7Uux3EBZkn4E/rcx49FnNKs6vKlUvltjTxdWZfZ/VdtKW24Ixj8TnRh
	 8PVL73MJFND29et4yrLfQaFuLAyVCM6tB4p2yvOXtVpKuRzxBCiAQOPCOD/fUiQ1nx
	 YhBl9NDVlRtLzaK8WH7hUGAMwQ/MZxzFIw8DpQLnK4KqbAuOBcpuFmqx/BboEkkL1I
	 8b/1qCfEOK8gARP5mf5As49JQB9UWGGM7N4cOw+mgS0YTK8aZA0ks2yBafezV09CZ5
	 tPT6luwHOVXtR9MqKlaVBbIbwlpQj5EbMS9MFoKHqMiFRnueHDzefgb2Am0Wow2v0u
	 rFgzu/3FP9gag==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqK9h3NYkz9rxF;
	Tue, 30 Jun 2026 12:28:24 +0200 (CEST)
Message-ID: <432bc10c-89fd-4ffe-8442-51bab825bf0c@posteo.net>
Date: Tue, 30 Jun 2026 10:28:25 +0000
MIME-Version: 1.0
To: john.g.garry@oracle.com
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
References: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
Subject: Re: nvme/039 intermittent failure
Content-Language: en-US
From: Mateusz Nowicki <nowicki@posteo.net>
In-Reply-To: <0f6beb6f-3d3e-4408-be8d-5ed36cdc2c56@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_032831_755772_4C2388B2 
X-CRM114-Status: UNSURE (   7.21  )
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

On Jun 29, 2026 / 15:30, John Garry wrote:
>I have noticed nvme/039 for passthru error logging intermittently 
>failing on v7.2-rc1
>
>For failures, passthrough kernel logs are missing sometimes.
>
>I had not noticed this on older kernels.
>
>I do note that the passthru error logging kernel code uses 
>pr_err_ratelimited(), so this can hardly ever be a reliable test.
>
>Is this a known issue?

Hard to tell without failing logs but nvme/039 is quite unstable on my setup.
I've proposed a fix: https://lore.kernel.org/linux-block/20260630101936.2371-1-mateusz.nowicki@posteo.net/T/#u

Can you give it a try?


