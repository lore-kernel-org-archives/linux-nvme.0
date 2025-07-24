Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31FDC87FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OtN7kun+/v8bL+X/qBJAQbJt6E5IsBweEEjq/w2Oe8=; b=mc9fZiQnNmmdCj45NXCfnGnBC7
	IEbonLS9Q9dLXMeJqlNpFmeZWQyAKkZrITGQi7Kn7GUPY55yEq85ev/fG0w4ul5JVOWe/bWjLSeCT
	/PLLs4dF6s8+yV1YsNepQ/YQLC1UZlkB4Wrrsvd575DOZinGUpWRfCq0KHsimsa6yTU9IS5oIlh1b
	6xxYAga3GR+fj7VNrLUWJm0+bbjQTGZekro9o+r2zEBks5hOwzymKRvqNnsO89PEzR2WJgIlQMBlQ
	6lHP1xo0Y6F4lhG5Bys5y0Nu0atw3gyseP0vC/jFRZ/vYgIbmIQliLBVBtyzUMeO6XSieOYk1hWPK
	xgZALILA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf0oF-00000008E3O-2g55;
	Thu, 24 Jul 2025 18:36:51 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueyTs-00000007xan-2HEr
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 16:07:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bnwrV2qCBzlfdh7;
	Thu, 24 Jul 2025 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753373256; x=1755965257; bh=+OtN7kun+/v8bL+X/qBJAQbJ
	t6E5IsBweEEjq/w2Oe8=; b=Rm6elYeiBKN1FpRIaH0OA5AOMQIOPaobQ2z+D00T
	WmInGS3THNeEIeASaggWC81hVJgIs2Zo4+HTU4OjIjKo6B2ifbVSqAdkHdjAgOLs
	vKOxtwsjxaGMdPTjgWCgwMLKQyESEvmBaMJhqM4JqNCCDZ9qk+72Ny22LHhFlTWx
	VQY1ZQ5bFQ1+UJn2UyYsLaf+goHCwQ1WRtiBqJPSSfKdJ2/aWhVE3bwofdGIJd2W
	VeBsUaO3ytms8gcnP9juQWI1BDtuPJgA0FP7gHSYyuPCeuthG6upQPTjYx83NeJy
	IFBpgcDKyZWCRPAUYRdOuF7WGJgR2J+tNU/oOcD3s55fvQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BQDbTJaqtjWL; Thu, 24 Jul 2025 16:07:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bnwrM51CwzlgqVY;
	Thu, 24 Jul 2025 16:07:30 +0000 (UTC)
Message-ID: <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Date: Thu, 24 Jul 2025 09:07:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection
 issue of nvme devices
To: likunyu10 <likunyu10@163.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 likunyu15 <likunyu15@jd.com>
References: <20250720185154.138391-1-likunyu10@163.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250720185154.138391-1-likunyu10@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_090740_666976_308F0D82 
X-CRM114-Status: UNSURE (   8.14  )
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

On 7/20/25 11:51 AM, likunyu10 wrote:
> PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
> on important devices. For example, if a server has two or more nvme disk
> devices, it can cause disk loading disorder, which can also have a
> certain impact on actual production environments.

That's intentional. Please fix your user space code that uses hard-coded
NVMe block device names or introduce a mechanism in user space for block
devices that is similar to the predictable network interface names
mechanism. See also https://systemd.io/PREDICTABLE_INTERFACE_NAMES/.

Bart.

