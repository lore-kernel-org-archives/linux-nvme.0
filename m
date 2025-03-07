Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26FFC282DE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJ88qoK2pu5bY//T7NWZev8BRO3SJBb4qLc8Ys8maJY=; b=MWTFAvdAYk7uF4Xklu8G/1a826
	g2wMxmyAeXNj6jOYUx+I+++kALJL+I/Zggs51TKirB+/jcxdIeGNeNIzPiWu5uZfyKfXpeB5vGOQm
	cgRZrGEzYeFOiaCCN6tJYhP0nJ88rh+xv6yb/UJZNmF/m+SNtvyy5vENhZmp+x93rqOxlA99/slXu
	adaWmxgI1qjPv275HnVDtYLGZ9Qg+X0TGLECodg65oMMxGVt+ZNvOogdei+fWeKTyMmNx0T7Vw2ox
	0z07Eid2SbqmbXImGbkomRdPLVdmo6Jq0V2HhG7+pBxglzo2p0xa2WpfV0ANzky7xkgYrAy46TmN8
	uyv5oXnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXSF-0000000EGma-0IHG;
	Fri, 07 Mar 2025 13:09:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXHp-0000000EFMX-1HtW
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 12:58:46 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527CS22w009104;
	Fri, 7 Mar 2025 12:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vJ88qo
	K2pu5bY//T7NWZev8BRO3SJBb4qLc8Ys8maJY=; b=jowYPAGyOzKJO5Lbf2/xSn
	NgD9issnr4y+UBFhbQUhzdZPRMhKb0xIPmQsoBoYdZmDJUODhyY5ZNYRPAsny4dj
	I5wUugkRNg7aCmUpBF4mBzv7mjVFr78FSUH9R4BKLqkGmKuvgH9g9b6tW+wHuIio
	6qBl+8ZkTtRAAJWYCOGFf1tKB+Hl8rKqWCGsRMWdD4d7ANhNs/giSAnvE2qKAbxa
	ihELbdjae6VKVCvBuX2dOG0yIr7zgrGLZ8tYCJPx/3mep7oIy/pZgvKK7IkSiJfs
	tZsRsfkEhvVXRxpdPtskvqmh2f+TBOvNUF2Wj9ciL6pQ3f7XafNCKxlih/kgq76Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4580u2r476-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 12:58:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527BuhFf032219;
	Fri, 7 Mar 2025 12:58:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjtf44a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 12:58:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527CwVGC28639872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 12:58:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6950958043;
	Fri,  7 Mar 2025 12:58:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19A258059;
	Fri,  7 Mar 2025 12:58:29 +0000 (GMT)
Received: from [9.61.11.159] (unknown [9.61.11.159])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 12:58:29 +0000 (GMT)
Message-ID: <46617499-17ea-44b9-9ed0-1fb5d238f54f@linux.ibm.com>
Date: Fri, 7 Mar 2025 18:28:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: fix stuck reset on concurrent DPC and HP
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20250307002424.3655342-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250307002424.3655342-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dbNR5uj6kINdrhltG6RfHSFyHVVF3fpD
X-Proofpoint-GUID: dbNR5uj6kINdrhltG6RfHSFyHVVF3fpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_045845_360540_A335A726 
X-CRM114-Status: GOOD (  28.41  )
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



On 3/7/25 5:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The PCIe DPC handling has the nvme driver quiesce the device, attempt to
> restart it, then wait for that restart to complete.
> 
> The DPC event also toggles the PCIe link. If the slot doesn't have
> out-of-band presence detection, this will trigger a pciehp
> re-enumeration.
> 
> The DPC's error handling that calls nvme_error_resume is holding the
> device lock while this happens. This lock prevents pciehp's request to
> disconnect the driver from proceeding.
> 
> Meanwhile the nvme's reset can't make forward progress because its
> device isn't there anymore withoutstanding IO, and the timeout handler
> won't do anything to fix it because the device is undergoing error
> handling.
> 
> End result: deadlocked.
> 
> Fix this by having the timeout handler short cut the disabling for a
> disconnected PCIe device. The downside is that we're relying on an IO
> timeout to clean up this mess, which could be a minute by default.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 640590b217282..5963a5f6da940 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1412,16 +1412,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	struct request *abort_req;
>  	struct nvme_command cmd = { };
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	u8 opcode;
>  
> -	if (nvme_state_terminal(&dev->ctrl))
> +	if (nvme_state_terminal(&dev->ctrl) || pci_dev_is_disconnected(pdev))
>  		goto disable;
>  
>  	/* If PCI error recovery process is happening, we cannot reset or
>  	 * the recovery mechanism will surely fail.
>  	 */
>  	mb();
> -	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +	if (pci_channel_offline(pdev))
>  		return BLK_EH_RESET_TIMER;
>  
>  	/*
> @@ -1522,9 +1523,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  
>  disable:
>  	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -		if (nvme_state_terminal(&dev->ctrl))
> +		if (nvme_state_terminal(&dev->ctrl) ||
> +		    pci_dev_is_disconnected(pdev)) {
>  			nvme_dev_disable(dev, true);
> -		return BLK_EH_DONE;
> +			return BLK_EH_DONE;
> +		}
> +		return BLK_EH_RESET_TIMER;
>  	}
>  
>  	nvme_dev_disable(dev, false);


This looks good. I have also tested this patch on PPC however as PPC doesn't support 
AER/DPC, I tested it with concurrent  errinjct/EEH tool and hotplug while IO is running.

Though one question: IMO, the DPC error handler shall invoke nvme_error_detected() prior
to nvme_error_resume(). And we already disable the device (and cancel in-flight IO) in 
nvme_error_detected() and so wouldn't that help? 

Thanks,
--Nilay


