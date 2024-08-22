Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC2C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZEgusTWJU2HXLnzHir15+nHfQOEL9J2dmjPlBk4gZ4=; b=Tp6xdF2xRyOmLVTaLUbfsZxS9u
	wzD4TxzrtQSfvBEEBpIskgzC2Fo7gkWugtlQl0UhxiceS3tyK+Dnqt3D2LM0Uto333j027CxmK4U2
	CiFLdEQV6SFNHaSpNVrvT81K5vOikkI6RHPALmGsGLfADghJaQrb+jX7ztRhwL5UACbTTxMLkJIZy
	ge6s0QNe21weoxiQMCCa7tEXRcUIGd7aOpcb50+KabnI0ys1BSc9q+N0JoRxbUnxHmQH9dgac06L0
	8DBTlZOIbxi2yaTq0pJ1Ze0TB994unpZ+3jYDvMMeO0j68ceJFgyev5uhCY9rC3KTWBlneLYb0dbP
	pBbfinfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDV0-0000000E67d-0GzX;
	Thu, 22 Aug 2024 19:29:34 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDUw-0000000E66h-0ikw
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 19:29:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WqYDT0MPfzlgVnK;
	Thu, 22 Aug 2024 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724354964; x=1726946965; bh=9ZEgusTWJU2HXLnzHir15+nH
	fQOEL9J2dmjPlBk4gZ4=; b=Q80JPWcPlkv2CO7rMQcOBV9cJQj4CxnH8yk4cRxO
	1nfR9UrEJAzCs41yxpGZg2MZWpK6InAbCRglO7WakUDR4dP6dMVqJMlaIINenVTD
	rGn+PuDbqf59N9yxrvJq0CyK9ZHs3XK2tYrmI9RKb70tVcS0t0cUwRx/dy1/rvZq
	Laar2dL9MOWAc4J5YUs/zfBnhh49UdXKCAIymaCND9Kba2legHFyDhYRbFUfCF4h
	c/w3qL6ZtGV7m5jA3NroU3bHhypV41Wshg8HYHB/+b1Ngm5XpizUduyPJgd2pz8W
	UNIB+/2P3SWRDWs+ITC9BqqXG0o0j1UgeU+KWsWuZTJ6yg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id itsm-lJJiOpf; Thu, 22 Aug 2024 19:29:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WqYDL0lXRzlgVnF;
	Thu, 22 Aug 2024 19:29:21 +0000 (UTC)
Message-ID: <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
Date: Thu, 22 Aug 2024 12:29:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
To: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240822183718.1234-1-mhklinux@outlook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_122930_283632_AFA28806 
X-CRM114-Status: UNSURE (   6.71  )
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

On 8/22/24 11:37 AM, mhkelley58@gmail.com wrote:
> Linux device drivers may make DMA map/unmap calls in contexts that
> cannot block, such as in an interrupt handler.

Although I really appreciate your work, what alternatives have been
considered? How many drivers perform DMA mapping from atomic context?
Would it be feasible to modify these drivers such that DMA mapping
always happens in a context in which sleeping is allowed?

Thanks,

Bart.

