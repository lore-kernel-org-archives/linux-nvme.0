Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE50CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UthKItBJ0Ql3cn29kL0xm6tTxzbT73HKtBpGrowaudw=; b=CJvef/V6P0Txpdln094f+kOLLU
	8BO6vvjMJ8qju97K5+fRcZzgWYDl6hGY34bY8JGsGybmdVl8L8Eio8M+0UGUrluaLe3xMdpyTkmmQ
	8q9dn/fXENYxpCkbhXhvy05+8E4AHoQgJpdHlk8lRhdPirS2yIOISLGfwiewK8hKFKDlche6hllbs
	1kpONIaj/svF2zchRisDvM9Osl8+JDVSJQnDU3HX+IoahTVEPCHRcbTTVreiWyu5CxmU2yp5lnxzf
	m4m4ckzFlt9lW38evL3ZlU8cOnkJ1FumbsiKzQFiacgQaGKkCH/BqiBAvs71q7YA3whqO6WMg4mPU
	xnU0oM1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLsP-000000087WF-2QYY;
	Wed, 10 Jun 2026 16:34:01 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLsM-000000087VY-45VS
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:34:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbBDk4fX9z1XLyhV;
	Wed, 10 Jun 2026 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781109234; x=1783701235; bh=UthKItBJ0Ql3cn29kL0xm6tT
	xzbT73HKtBpGrowaudw=; b=Yd6IkihqfgbY1xTmZdd2FjYZ2ujZmuvHUBWw5K//
	SkWdO7QPOCuv6MTSLWC7SsZa2u1JtIXLlcR+8bdQok9SuIzyuF0IrIVdDNwEewxs
	Ww/qPi2TUG5Vt4CoYXM3ezUSnHS1rewCZjA5405N6eM8gHx+lXI2hpFDqoLPUovc
	mEXtB7SQMl2hSNsQOCMI7iQVO1YltlGFszkW2mblWexRAIgOZutBP/yHy9LeccNb
	yJnJMKD01uzi0LsBkvNkDzefTJuWEj4kBRWuwLIi/eFbaHNcIvzH0elDtpH2rtPS
	rURryuprhWYEep2o2yo7u3CPpmn/2gZdWJ/LCuMq00Cjhg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 88Jsxw2s0YNG; Wed, 10 Jun 2026 16:33:54 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBDc0cnmz1XLyhT;
	Wed, 10 Jun 2026 16:33:51 +0000 (UTC)
Message-ID: <78da28e4-97c1-405e-8edc-707e62577b51@acm.org>
Date: Wed, 10 Jun 2026 09:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] nvme: add Clang context annotations for
 nvme_queue::sq_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-12-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610142743.115898-12-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_093359_036975_5AB92027 
X-CRM114-Status: UNSURE (   8.78  )
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

On 6/10/26 7:27 AM, Nilay Shroff wrote:
>   static void nvme_free_queue(struct nvme_queue *nvmeq)
> +	__context_unsafe(/* frees queue which is no longer in use */)
>   {
>   	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
>   				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
> @@ -2176,6 +2182,7 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
>   }
>   
>   static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
> +	__context_unsafe(/* safe to init queue without any protection */)
>   {
>   	struct nvme_dev *dev = nvmeq->dev;

__context_unsafe() is a big hammer that disables context analysis
for the entire function body. Has it been considered to use
guard(..._init)(...) instead?

Thanks,

Bart.


