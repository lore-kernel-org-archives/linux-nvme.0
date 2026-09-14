Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EB0C88E6F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTEB7jHCZIGb3s8n7cHMenylPff/cDh3KM7G/7WhDdM=; b=uKC+X+UToqGivuwwKqY7PqseAV
	lbxC7yMpaunuqoaLEGeUN1kHSzkbYiQGzbJoqYS+/E//k3P8NLFT0eA0mnjyQBPrC0XfuDq7aNsqS
	GDB213qmIOv9k4K86vVfavAszxE+EMWK0rRp9aelTyGPlyyNQaq/mlngJlVXJJzFJcpbrTNmM4a5f
	oQChLIQjqECtQoAM+tQwra81UXaYXW57AldgCxVsbjn0z0Na9MIDIUFIJMBqTkA2gakstlghM7a2K
	5J6YoZQrQGpH4Q0a1VShGvCaeWFP70N6Cons9Lmu1GPr0tyo6bdBFFZbB39Px97A9279oxn/zilZ8
	Un+KItTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Bkj-00000004UGf-3nab;
	Mon, 14 Sep 2026 18:50:05 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Bkh-00000004UFW-19S6
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 18:50:04 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 52494240104
	for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 20:49:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1789411795;
	bh=dTEB7jHCZIGb3s8n7cHMenylPff/cDh3KM7G/7WhDdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=NpPwfYsKZ2eKirQUZ6P7niHgYD6huYWFLQI0M2ujkVSfS+vIHwcRtDzjErF9D+Djr
	 4Q6Si9PuB578+inRuFc4Wq9GODJZG8EgXFkVpQ3vuYQo5dGhAWgqonI4fxwqV9usNB
	 IdLguSAXdmli2NjZpr0Id2Evfr4mD+S7gjEk5Mv9pJMQ9ObBuFMUVvAuzMT87ncb9x
	 MQC9B6bv85+b0XUCtRNFeLgQYU9PhRHqpJC6cLpZ5QwvKmAVg7Fbu+b1NJBp2AiPjL
	 Wue70igWxh2EUss41ThqbHAsINSmGlqPlIPKamjNfw8v7cAC6IOS49M+D5tRhErHwo
	 UhYWHq3kAGW8g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hkDjG26sFz6tsg;
	Mon, 14 Sep 2026 20:49:54 +0200 (CEST)
Message-ID: <cdd43477-ce5b-4c7f-aba5-1bc323c8172b@posteo.net>
Date: Mon, 14 Sep 2026 18:49:55 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: bump genctr when cancelling a request
To: Keith Busch <kbusch@kernel.org>,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260913124053.86565-1-mateusz.nowicki@posteo.net>
 <aqgHGefyCPcoNoB_@kbusch-mbp>
Content-Language: en-US
From: Mateusz Nowicki <nowicki@posteo.net>
In-Reply-To: <aqgHGefyCPcoNoB_@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_115003_472648_7D448DD2 
X-CRM114-Status: GOOD (  10.07  )
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

> The sequence you're describing is weird, though. Your controller
> has fatal status, the driver hasn't done anything yet to recover the
> device, so why were there no completions available the first go around,
> then completions became available on the second? The controller
> shouldn't have done anything in that time, nor should it have been able
> to since Bus Master Enable was off.

Thanks Keith for the feedback. You're right, vnvme (a virtual NVMe
endpoint I use to create corner cases that are hard to reproduce with
publicly available drives, like delayed completions) ignored BME, and
that is what produced the late completions.

I have seen firmware that ignores BME too. Unlikely in the field, but
the question is whether the driver wants to be resilient to that class
of firmware bug. If not, I'll drop this and can test the unconditional
nvme_disable_ctrl() variant you suggested instead.



