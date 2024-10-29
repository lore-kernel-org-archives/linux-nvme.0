Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C9FD3A679
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWxA2MoqlYM7QZbbvu93a6SsGPq/fk680PMkDpoUNZk=; b=tgVWQ5BW8viEjCOe+qB86iJAx6
	/o4DpxIkJiSFMTe00YCk8GmoIwCuX4pNVZcupETIMrfna7HvfQ6wk6Pare22Yltcs+aFRzJVUxHOz
	PzCnboXGt9PAcVmzA3gl3qeE5KvP0UN0Ksk4Y5lSjvTfNZqfnZ4i9jAeBgc7jc3NtM875lLHxiheu
	kOZNjMW3Q/My6M11yU6cwtlYX3LAwvGTevN8flCeo45FQ6MHthAWy5oO3rVeqvjSwGQbgb2rKQ/jm
	5f81erTDAot9uKGkYqQbFAwusFQnfK2FCJEs1Uz1JFBJ01qa5AwjfzusqrTXSpwHMHGTd8R7fL5uK
	8HpsYhPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qPn-0000000FOi1-3kxm;
	Tue, 29 Oct 2024 17:53:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pus-0000000FEgU-2u8C
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Oct 2024 17:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kWxA2MoqlYM7QZbbvu93a6SsGPq/fk680PMkDpoUNZk=; b=BoLciEnysZHgZNoM+18MU0gYAX
	t9C3GP/MVZdkBB8dAyiaoC6OuYSYWm+k2V/E6L6z3WbAMup8o7+wn7d0SHTdNQUSxwG33VElP9qTI
	Z6D/xK3OfbMiw3zls53YfINmUFrpbLT+wNTiwMQOx2Bu90R9+kAzqMdsVx2cSEliu4bwbD/bi7PO/
	PhtHV7xrqFBl5ngGN3E0p8l/B2VMdvnxmAu3CY7dfCVLsJpKLevjtIwsqF4d4QVHhp/PXrQaoj/aU
	J3hBz4NMFnRllqTCB62gaZYqqbW8ourwOhWer0j2N6PnIZRwWG24Su5YNmDkEmbWhNfbuvtGvJKNt
	2DU8HRdw==;
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pup-00000009xmK-2caK
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:22:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XdH9h4kpqzlgMVd;
	Tue, 29 Oct 2024 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730222502; x=1732814503; bh=kWxA2MoqlYM7QZbbvu93a6Ss
	GPq/fk680PMkDpoUNZk=; b=Mr8om1zCYZlXfFJPZLFZ5EPYfgfjGUA2eC9iCLsQ
	/V7XgRPhQEyix0foLSFomx85RWH/3vOoU7W54KqWeLerOC2IZL2+KIHV4Mecty99
	8JRZIgNngzLcEIXc5ViZZHHfBS53Efsb8/Ffj5yr6sOPvV++hTKA+K8WcUwMwcWp
	ZVflG1VMAaNGkU8QZLm3sk4wtmg+khMsXY6k11FKYUZ7ZcgDhRd0sDMmQPWznD3F
	TYmby0JwZ5KXtP4+UMhhlFFsKeKBCujcr3c747l3lt0mn1goj0Lata0GZe5UjmyL
	7f6+dbO52tPRhFN4fNevdgH5puplxRaN+Yc8TUeXWNOfxQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lALfxPIoeMd6; Tue, 29 Oct 2024 17:21:42 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XdH9b4nprzlgMVY;
	Tue, 29 Oct 2024 17:21:38 +0000 (UTC)
Message-ID: <88b530fc-e5ca-487c-9af5-75f225d321de@acm.org>
Date: Tue, 29 Oct 2024 10:21:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 1/9] block: use generic u16 for write hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241029151922.459139-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_172200_004995_B86403AA 
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

On 10/29/24 8:19 AM, Keith Busch wrote:
> This is still backwards compatible with lifetime hints. It just doesn't
> constrain the hints to that definition. Using this type doesn't change
> the size of either bio or request.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


