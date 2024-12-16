Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6578E77183
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sz1vsX3tez7NaMmywwnTMbPcosDgdD+BnlYLC8y3gQ4=; b=Njdai+b8+p2yiHjlQV9fZc3e9k
	ro+Oa1P2qNtGZP1qDvfLtx3Aygocf9cF18wPCwAN+NZktp/2aBRGLYj7qdVYjMmNOssdOmQgCFKQc
	GFzOeKYszdo+b400W/NnFRD/onAIGfmOtIh2AqQZaYicT8RWBzi0zToErMr1OBFlDiaom1pcd8OnE
	zo/s/N3SsgHaNx7hqA5QG9jfjvkVSvHw12v7N+aN8oLqJOKqo1nokXgONIcncnwoHdX91RED4YtC7
	ZkMQwc/rjy7LKL2rEqHJI1PT7g5SVI+QYykt0dGHNFaJcbNBn2CTQ+pJ1C9BO1ukS2FUPAMlYxQU5
	Y+Rm8rmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNAuI-0000000A4Ly-3puq;
	Mon, 16 Dec 2024 13:13:06 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNAoL-0000000A32I-3aRw
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 13:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sz1vsX3tez7NaMmywwnTMbPcosDgdD+BnlYLC8y3gQ4=;
  b=SK4Ht0HDoAk8x64Jl6C4YL18d9en3O0hBMHjoGwuDqxJMGZngZtVmQ96
   JAg0xMecHRcL0QXxhSiPSOhmMyACI04Gv7GU+7Vx3y9faNMKd/+n8XgYi
   uTyCuf2EmeWaTklSCqZTZXMyP4vkENZMTWbAErjxdAeFarMNdD1fcJXge
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,238,1728943200"; 
   d="scan'208";a="104444927"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 14:06:51 +0100
Message-ID: <d0b96f78-7538-4bf9-acec-711e3b0b912d@inria.fr>
Date: Mon, 16 Dec 2024 14:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Allocate memory for xa_store in advance in
 nvme_get_effects_log
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241202124239.49894-1-keisuke.nishimura@inria.fr>
 <20241212062749.GA5718@lst.de>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <20241212062749.GA5718@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_050658_373684_6998D7BA 
X-CRM114-Status: GOOD (  13.68  )
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

Hello,

On 12/12/2024 07:27, Christoph Hellwig wrote:
> On Mon, Dec 02, 2024 at 01:42:40PM +0100, Keisuke Nishimura wrote:
>> +	ret = xa_reserve(&ctrl->cels, csi, GFP_KERNEL);
>> +	if (ret) {
>> +		kfree(cel);
>> +		return ret;
>> +	}
>> +
>>   	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
>>   			cel, sizeof(*cel), 0);
> 
> There isn't really any point in doing a xa_reserve here vs simply
> handling the xa_store error a bit below.
> 

Thank you for your reply.

Without this xa_reserve(), if xa_store() fails, we cannot store cel after 
calling nvme_get_log() which can have side effects. My intention is to ensure 
xa_store() succeeds first and, if not, return early before invoking nvme_get_log().

But I am not very familiar with this code. If it is okay to check after the 
nvme_get_log(), I will send the patch soon.

best,
Keisuke

