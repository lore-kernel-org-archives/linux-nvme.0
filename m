Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B16CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1O7VHDRfnBO/Jp7C9ioC0b7HEmd3k2QEBKmqxWU1H0=; b=CGE6z0FhAAqqNx4TPDCc/uhxti
	+f+ZmM5wt+Cwh46RrYuid/ZQsCwccEUi5E0zI2X187xfl948ymGlw8UHoVxFtODe43hoCK6bnKLd9
	ux3xYlpgiLW6vP0zljbgvhiCYInr0GMn60iTLHPYKmv7+E/eVdbE11tlDFXFVNiIqdi2eMqNl7paV
	MHtCue5jJK4pYLBhE/2EgIXEP2x2AJK1LlefLRXlyhiHF10oadm5vPyuaxOev22FIXTog9rG4Elbv
	kGVaOfjjAlKDrjVUHYT23XP9qpG9uPjzFGdCJZrsNsW+tU5E02/ZdVgq66THsTgDwpd0X+3dUCm8/
	ZEPuvdSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLkh-000000086bV-3kLk;
	Wed, 10 Jun 2026 16:26:03 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLkf-000000086ac-1ClE
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:26:02 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbB3W0DV9zlfpM6;
	Wed, 10 Jun 2026 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781108755; x=1783700756; bh=V1O7VHDRfnBO/Jp7C9ioC0b7
	HEmd3k2QEBKmqxWU1H0=; b=D5Iii07c3sB43dQvud9a7PaAc1uQudM9O4C/opJ4
	BsvuOHuZIc/Yxa6V+Cytd7Z7VL6WOObSw5IVeGEyIAR3AVGwcDHwszb7IeMnCI9e
	ym2ht6mpSadvSSqbk6u1u1WYiSTFb+s4yVyMpEB7GJCX8IQjOJiEIDiDsHGwjoC8
	YwsLwgqQwo+8Mz4eSI5+NPNeKS0SGFZEemzOXX+xGLP1j4HGZ9Vjfa12TOhQSM0u
	okS0AckazM+Kzq1FLEOqlK5TPZRJN+XGywx3A8MwqLDPvgYhb3NgMEwwy57xgbnl
	44EZ9DxUkFWX4cAykVPfXkjypmkUS8UdjJLK/0WtoyfhLQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UF1JK3AKsMuR; Wed, 10 Jun 2026 16:25:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbB3N68JGzlfvpK;
	Wed, 10 Jun 2026 16:25:52 +0000 (UTC)
Message-ID: <0b3ab980-db78-4f21-8af7-f74961f5d648@acm.org>
Date: Wed, 10 Jun 2026 09:25:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] nvme: add Clang context annotations for
 nvme_ns_head::requeue_list
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610142743.115898-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_092601_347315_D6348106 
X-CRM114-Status: UNSURE (   9.22  )
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
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a275c03e7c59..985a8c693c6f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	struct queue_limits lim;
>   
>   	mutex_init(&head->lock);
> +	guard(spinlock_init)(&head->requeue_lock);
>   	bio_list_init(&head->requeue_list);
> -	spin_lock_init(&head->requeue_lock);
scoped_guard() is preferred over guard() because with scoped_guard() the
scope the guard applies to is explicit. When using guard(), if new code
is added, it may end up being covered by a guard() statement although it
shouldn't.

Thanks,

Bart.

