Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA65C54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s57bJoApfhN3Ugu1fprM3k8LddcH5gXboy5RHzbmk3w=; b=kRKUOyVCTPoyO3OGp0YSVMdj1p
	F0MDBCniUkUwuevx0x25pXtKSPbHEGtWAWIlV62FrDzRG/RikFtn1oKBj8KPDcT3q1FfQei1RdJhz
	uH2HogXxMJeWCrzuCqO8Dye9MxWlnpCZbsXWecsqp1aD2Rbn1IXY1FtsI2nIDVASps8wYkKILYgEQ
	VdwrrrjzNFSVh+EZpL03yTSgNZFTQS9DGa30lDjKTvNhceBgf/tQEKGfAVS8vW8KV3qo3gsZtxM0M
	+XwLcPPUnjKc41dUyyqR6O/dLZRGTeBEP/DMcXaEw3aini6erzLuxrJ1PWsyzq7JAk6UgMhVwjaVC
	dj4Y8zWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8lv-00000001Z0c-04cX;
	Thu, 22 May 2025 16:27:55 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8Dn-00000001V8R-1eJH
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 15:52:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b3CV21XVYzm0pJx;
	Thu, 22 May 2025 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747929145; x=1750521146; bh=s57bJoApfhN3Ugu1fprM3k8L
	ddcH5gXboy5RHzbmk3w=; b=zIPvQfffDLXzignnpTgcui+HwohxixkQAyrYl7t7
	wnRaRV1H3b7t8n1lmF3CRcsYpA6i3BOqbl+wc663y1DGASJcKLL39uOTtWZ0fAnq
	MxbW2UQiwzW0/85Vhi2dTOqMYQiSU+zpEZHhsgO+ul2/CbiJoW2LFgChBcQU6ZUm
	mhtEK9yvTE4BAJtOx8yl6llNV73fZ19PC27T38cGwSHPimXStA7/wi64VkzAArms
	sbWGyBGr5Qf8zk13oM8OBI64zcJCtdzw7+3S2U/e1e5V1mABI9aYk9fqVDqO0yP2
	oywOiMViD11VR9S8f8ZHP57tN5iuYfnDDKKYwdXCXGkpSQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msTfILHaveXp; Thu, 22 May 2025 15:52:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b3CTx5RT1zm0yQZ;
	Thu, 22 May 2025 15:52:20 +0000 (UTC)
Message-ID: <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
Date: Thu, 22 May 2025 08:52:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] block: another block copy offload
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_085239_494012_D243F5AE 
X-CRM114-Status: GOOD (  19.60  )
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

On 5/21/25 3:31 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I was never happy with previous block copy offload attempts, so I had to
> take a stab at it. And I was recently asked to take a look at this, so
> here goes.
> 
> Some key implementation differences from previous approaches:
> 
>    1. Only one bio is needed to describe a copy request, so no plugging
>       or dispatch tricks required. Like read and write requests, these
>       can be artbitrarily large and will be split as needed based on the
>       request_queue's limits. The bio's are mergeable with other copy
>       commands on adjacent destination sectors.
> 
>    2. You can describe as many source sectors as you want in a vector in
>       a single bio. This aligns with the nvme protocol's Copy implementation,
>       which can be used to efficiently defragment scattered blocks into a
>       contiguous destination with a single command.
> 
> Oh, and the nvme-target support was included with this patchset too, so
> there's a purely in-kernel way to test out the code paths if you don't
> have otherwise capable hardware. I also used qemu since that nvme device
> supports copy offload too.

Before any copy offloading code is merged in the upstream kernel, a plan
should be presented for how this partial implementation will evolve into
a generic solution. As Hannes already pointed out, support for
copying between block devices is missing. SCSI support is missing.
Device mapper support is missing. What is the plan for evolving this
patch series into a generic solution? Is it even possible to evolve this
patch series into a generic solution?

Thanks,

Bart.


