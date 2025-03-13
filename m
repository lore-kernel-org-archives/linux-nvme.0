Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11FC282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVpdaddui9rsGkcTBOnTDvJg55Cnrxs6qFl5qqVG/JM=; b=mtrg+bpqxnxRD+uwqPLesDZynj
	KA+eBr500JmD0QxzJRS1lWKQ2ccWnEV6rS0FdJovIDfvZi/DcLOypsy0TX5JzGSdFiFyUbJmZdhhX
	wjdjIpMvyoKS1slcJqv7cKNUrlGSMRgDKVidY9TGyCf1VyntQ3ZydxeVLE6K6HN0CjYO8X8kx1t9i
	JA/4L6E6+oqSixRLlK2h+rUOUyCJtRB8Xkpchrj0Leq7wehAB12QwOAXpIaCfXo0LpJPBtzPSG6qT
	pwTAYL03PH0eiLquwapuFFmjRO6Kn+MfZmtAti4+lNLduWCVONeUrfdGFVHSsLN3Win52OT4xaIVI
	lupInL2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscAW-0000000AEMo-3y9d;
	Thu, 13 Mar 2025 06:35:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscAT-0000000AEMT-3Wrd
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:35:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3CD0C5C4C06;
	Thu, 13 Mar 2025 06:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27469C4CEDD;
	Thu, 13 Mar 2025 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741847744;
	bh=gJ+l1OkHmVJy4qqXoozbnlcomMIn+oEwL7Gr4PiVCrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q3qzhaAaItsAsbTXwVOFtlEFsKeV0D+2DY7K27YOC13V4bLorUnmWSA5zt1H6WX3G
	 eW2HB10YlhuRHJgP6jciwNEl9qXNoUt8HMnxN8jXkZcd5fipmfJ3xmU6wHeIp5wwHg
	 b8fcces+kAXq2pUyM9O94bEzNJD0DxyYtsQQBdKK3DXlw9U6GHH0d33TBaLIR+2et2
	 aRv4g9ITZRdwskWtyun3Y4+bJGO5zCHujgd/ch7X+IQKyn32OA5zSpcGKRNC9jPXye
	 kaXpmbpLW9BNzpb5IX8PHUy7k6x8mONMtTcbDAJ3TNEHuWLXnFd4SVeeYvls19VCGg
	 OBRd4prHD3pyw==
Message-ID: <94b54717-3b28-4fb0-b576-881025243a8f@kernel.org>
Date: Thu, 13 Mar 2025 15:35:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Keep completion queues mapped
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20250313011206.1410530-1-dlemoal@kernel.org>
 <20250313063216.GB9840@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313063216.GB9840@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_233545_977643_AE0D9B6B 
X-CRM114-Status: GOOD (  13.73  )
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

On 3/13/25 15:32, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 10:12:06AM +0900, Damien Le Moal wrote:
>> Instead of mapping and unmapping the completion queues memory to the
>> host PCI address space whenever nvmet_pci_epf_cq_work() is called, map
>> a completion queue to the host PCI address space when the completion
>> queue is created with nvmet_pci_epf_create_cq() and unmap it when the
>> completion queue is deleted with nvmet_pci_epf_delete_cq().
> 
> Yeah, that sounds much more sensible..
> 
>> +
>> +static inline void nvmet_pci_epf_unmap_queue(struct nvmet_pci_epf_ctrl *ctrl,
>> +					     struct nvmet_pci_epf_queue *queue)
>> +{
>> +	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &queue->pci_map);
>> +}
> 
> Is there much of a point in having this wrapper?

Maybe not anymore. It was used also for SQs in earlier versions. I will send a
patch to remove it. nvmet_pci_epf_map_queue() is also used in one place only, so
it can be open coded too.

> 
> With or without it the change looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


-- 
Damien Le Moal
Western Digital Research

