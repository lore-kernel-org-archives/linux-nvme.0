Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB6CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cR362CI2z0JFRmjjtem9YeDWiFrPk831WNXum3dsQrc=; b=gNyeewq3qyyzaYCJ1yXI8mFr6w
	KV6EA+pd1xmf6Q9tIpxZo4DEPLbwt5eg1514APC/Z2w3gGXzOgtVQSFKpGZNcLuT3froarWDPtRM4
	aNLMARgRoX2+myqNDT4s4ZpnVVM6tOLciwaJEJIF80DTSzpNjXdIyZ891MlQkeh8fjYrbVP4HrNo1
	oHHS96fYhjuiJ8eihWkfpzvRz/n6f39DFE4iBPBBAb+8oNK7h8IM6n5ltYaRyJtmZns0YpyZ4T7BW
	82K2XOuzlXk0hZ3dUv90jVnyWpTfGJNVJPudxucnE7oerhLI+4UxVVwKyOgqkD8+43dokmtsGqUlJ
	Ark6cggw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyQG-0000000FyOC-3ZCP;
	Thu, 28 Mar 2024 22:40:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyQD-0000000FyMl-3oes
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:40:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 96591CE28EA;
	Thu, 28 Mar 2024 22:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC5C433C7;
	Thu, 28 Mar 2024 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665630;
	bh=L3X0Xnax9iVKs+XHjAefS7Akxvkh+AtFCIbY2t9uftA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CKL1pVNv0A3aoxvhFAwLxjSII9r1BAq1NXf2VJhqJgPS4bB/4SwZwsyp292zFMoRS
	 +VU3QnyxvzzfuyvhgL8Ys9gUU8A1idoqjJGNvt+ceyroEaJhuGOOJzX047JU0Wh53D
	 58glHIIfOhuc30qRTVc8aJBhJMQTeSLJ4gNV8/zxmaRlHVdSrMi+E9BQzrZ0ypgw1R
	 4r9/BBEu0SW/kd3TVl1jECIFiyYwpG5KFTazhN+EeXXP/p9VEI7CblsdKq5wqKvve+
	 J7bq+GQH+LTidg/pZwoKJvP70riymgYCBKbCXP4M7N1VFVEwAHLMYmCCulpq6I6i68
	 CS27Wwyt7jKmg==
Message-ID: <a8db1c86-945e-4155-8a57-0eb2d618adbd@kernel.org>
Date: Fri, 29 Mar 2024 07:40:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/30] block: Remember zone capacity when revalidating
 zones
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-8-dlemoal@kernel.org>
 <38575b90-7cd1-48f9-8c86-a77ef372900d@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <38575b90-7cd1-48f9-8c86-a77ef372900d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154034_167922_6D707915 
X-CRM114-Status: GOOD (  11.30  )
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

On 3/29/24 06:38, Bart Van Assche wrote:
> On 3/27/24 5:43 PM, Damien Le Moal wrote:
>> +		/*
>> +		 * Remember the capacity of the first sequential zone and check
>> +		 * if it is constant for all zones.
>> +		 */
>> +		if (!args->zone_capacity)
>> +			args->zone_capacity = zone->capacity;
>> +		if (zone->capacity != args->zone_capacity) {
>> +			pr_warn("%s: Invalid variable zone capacity\n",
>> +				disk->disk_name);
>> +			return -ENODEV;
>> +		}
> 
> SMR disks may have a smaller last zone. Does the above code handle such
> SMR disks correctly?

SMR drives known to have a smaller last zone have a smaller conventional zone,
not a sequential zone. But good point, I will handle that on the check for
conventional zones.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research


