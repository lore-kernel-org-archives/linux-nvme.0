Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD6C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJCrX4zhQ98xLpz/QUJlin3vE8tkF/A/RAHhRJV7CKA=; b=tF97cQgLlKNWicgy8OOUMiSZ5M
	h908Jl9wz90eQ8b/ll87Lts0gwXivdv/sMnHn6ChsuW1AQ5mnato3uPUUKb4wczH5E9vaCbwNEDV/
	cJDLliwyE17xCvof3mXJiK5Vol8ZfJZHpj1/nUYmbfIcw5zLSrEHBk3ELYI2cWNc/MiLUrKx/Jarb
	TGQexz2+HCswAIh2eYmiW6gHr+u90NHmOR+P0e57k8u0rr66JNZGE+aYUSfqdveb5SZfVqJFgWakV
	ZjsIh0USVMeXDIxo8zwbwDVV8C6YjAMdDDJtg22NDk/SN9e/Uo3HXckjS3VcZ0U9lenZlHe8X9DOx
	4l3E0qbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaJ4-0000000Emj0-0q6q;
	Wed, 07 May 2025 08:39:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZNR-0000000EZHI-3B6r
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:39:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 517FD49DED;
	Wed,  7 May 2025 07:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2785CC4CEE7;
	Wed,  7 May 2025 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746603576;
	bh=Q9ksU+QSLple9Yd1/BFiRwHZUuMjSs3TiXVWu81BTho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dWujvydY/9TVsx6rRGnkQa32NBpw3wcBTxkP0mfunBQUdlQH0VpJx/hUWnFOmOvhj
	 F82TQBJhjc/MFkOcroTkJM6wYX2FaLeG3NAOBzpc5C1XEwBC8uxvA8Cg+czPZq8U+4
	 vkN1WCtb8kIBfKesmzZpCisTtT1zWGvyLX0TdkgdyXzHkBzM0n01RCJuRGQ8w9x0go
	 WEwg/TbNNW8VM2PQgJn3BNplx2mMJqeTqI7TFFFNdPTCVGZgU3q2ZgOIfO1DSFUZ95
	 hUif47OI+sc270gOafhdrhdyf1kpLMJ//pkD9vZNvd/KN4hicTAnMECSLY0W2ukDLd
	 wAtPvlpXtnR9A==
Message-ID: <fe2c74cf-a53c-4c91-b078-8eeac0943229@kernel.org>
Date: Wed, 7 May 2025 16:38:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, hch <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kch@nvidia.com" <kch@nvidia.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "cassel@kernel.org" <cassel@kernel.org>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-4-wilfred.opensource@gmail.com>
 <0db89443-9db7-4f39-8db1-eb374a9a3bcd@kernel.org>
 <00f483cee8a1ac6b076f62c4551b015867136050.camel@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <00f483cee8a1ac6b076f62c4551b015867136050.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003937_811891_F5C1E7FE 
X-CRM114-Status: GOOD (  11.00  )
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

On 5/7/25 4:34 PM, Wilfred Mallawa wrote:
>>> diff --git a/drivers/nvme/target/pci-epf.c
>>> b/drivers/nvme/target/pci-epf.c
>>> index 7fab7f3d79b7..7dda4156d86c 100644
>>> --- a/drivers/nvme/target/pci-epf.c
>>> +++ b/drivers/nvme/target/pci-epf.c
>>> @@ -1346,6 +1346,7 @@ static u16 nvmet_pci_epf_delete_cq(struct
>>> nvmet_ctrl *tctrl, u16 cqid)
>>>  	nvmet_pci_epf_drain_queue(cq);
>>>  	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
>>>  	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
>>> +	tctrl->cqs[cqid] = NULL;
>>
>> I do not think we need for this hunk in this patch as we are not yet
>> using the
>> cqs array, and patch 4 removes this line to change it with a call to
>> nvmet_cq_put().
>>
> Hey Damien,
> 
> This is added to undo the effects of `nvmet_cq_setup()`. If we don't,
> when a CQ is deleted and created (same id) it would incorrectly fail
> the `create && ctrl->cqs[cqid]` check in nvmet_check_cqid().

Oops. Yes, absolutely. Forgot that we already are calling nvmet_cq_setup().
Need more coffee :)

Sorry for the noise.

-- 
Damien Le Moal
Western Digital Research

