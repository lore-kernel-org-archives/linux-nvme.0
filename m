Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC3CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Type:References:Content-Transfer-Encoding:Mime-Version:Subject:Cc:
	In-Reply-To:From:To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75zN7mSI/6DDgfWgyo8caYiYHedVezoArFhF9g22Y3g=; b=znJwtpzBPOoTqApqbclF88In9k
	B5qcS5FVGV6YpHFCLoix8DJ6edziNCvKFiWb5SULxsgrbVifu+MHNL3H/qGiwFzPyuHlpny5beXwY
	UzY0SKCsorbmMKzV9a2VJgJuvOdhVVfOzR4QcYzUhDxAQ7NMxjOcaoQOilATnXUZwYYpLNyMNYafM
	tzcJvwDwL/Yeu0lHNDtmakgK3JEDDehPm2DL4rc8RWbJgWHY5/AZuiv1AUIlLeTKErlePI+UAUZNN
	BjA6bZHnc3q7qD2TIG9f0+KLT2/3OWrg8DqsbfONhDS/tg5HNaBQCeFUzAmszFDW0sqbkTlmvyOyn
	RJMPqJYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPfXs-00000004VF1-0iNz;
	Wed, 20 May 2026 11:57:04 +0000
Received: from va-2-17.ptr.blmpb.com ([209.127.231.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPfXp-00000004VCG-3fWb
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 11:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779278213;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=75zN7mSI/6DDgfWgyo8caYiYHedVezoArFhF9g22Y3g=;
 b=gQn/enHlmQxZVPZMHtdeK1xF1mh+7P03sFljHKWFnDHgoJBK8ECVD7y7PAmQ4A5wdsHL4V
 dtcKC+fmdKQcgurAm7qe+YHqzAF2yDkpUgW9Il1/MGcP/Bc4HMCNFJo/STKQSohGBF6IW7
 DmSjVrs9WMfGgHxgFbnBTeXBlGb+S/spD1UeYFSe85IBmcl2xS60eAZhT0KNmBsSn22lDT
 so/pebXC24TTq/4n8Lg1HChoxtrvxNEY6zRPS6I9l7NFcpzp2jvDUziDidd/BGSAIUt6db
 bx1j6/TbrlM6AinQd+osZZW7t8vyxoTqeXXg8405Cf7VD4RPwnRGBoCgRSrLnQ==
To: "Chaitanya Kulkarni" <kch@nvidia.com>, <song@kernel.org>, 
	<yukuai@fnnas.com>, <linan122@huawei.com>, <kbusch@kernel.org>, 
	<axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Language: en-US
In-Reply-To: <20260416212633.72650-3-kch@nvidia.com>
User-Agent: Mozilla Thunderbird
Cc: <linux-raid@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<kmodukuri@nvidia.com>
Subject: Re: [PATCH V3 2/3] md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a0da183+6f6efb+lists.infradead.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
References: <20260416212633.72650-1-kch@nvidia.com> <20260416212633.72650-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 19:56:48 +0800
Message-Id: <c54cde9a-d76c-4e57-ac26-8f3e2248a7e9@fygo.io>
Received: from [192.168.1.104] ([39.182.0.188]) by smtp.feishu.cn with ESMTPS; Wed, 20 May 2026 19:56:50 +0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_045701_987148_5E9245FD 
X-CRM114-Status: UNSURE (   9.61  )
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
Reply-To: yukuai@fygo.io
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

=E5=9C=A8 2026/4/17 5:26, Chaitanya Kulkarni =E5=86=99=E9=81=93:

> From: Kiran Kumar Modukuri<kmodukuri@nvidia.com>
>
> MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
> the RAID device, preventing peer-to-peer DMA through the RAID layer even
> when all underlying devices support it.
>
> Enable BLK_FEAT_PCI_P2PDMA unconditionally in raid0, raid1 and raid10
> personalities during queue limits setup.  blk_stack_limits() clears it
> automatically if any member device lacks support, consistent with how
> BLK_FEAT_NOWAIT and BLK_FEAT_POLL are handled in the block core.
>
> Parity RAID personalities (raid4/5/6) are excluded because they require
> CPU access to data pages for parity computation, which is incompatible
> with P2P mappings.
>
> Tested with RAID0/1/10 arrays containing multiple NVMe devices with
> P2PDMA support, confirming that peer-to-peer transfers work correctly
> through the RAID layer.
>
> Signed-off-by: Kiran Kumar Modukuri<kmodukuri@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni<kch@nvidia.com>
> ---
>   drivers/md/raid0.c  | 1 +
>   drivers/md/raid1.c  | 1 +
>   drivers/md/raid10.c | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thansk,
Kuai

