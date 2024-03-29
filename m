Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B98CD1283
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWd4mKvBTfHIVdJ4XtrugL3TfCRZQd98PpL66KZWPK0=; b=rR8glbquBWDK1vc4wLKBofqi51
	X/iL4ghLV2INQl9DEHpz7TqS+Xf/axYu3g04Eh5bzRW66/EK8yt6EPblSJwtsOV6X3KBlg2dXonT/
	syQd7TpVB6rG5KnVBCOmNoV7yVG2FcE41aolfn5WlCOk2yrzpCowrc7devVRs0TmNJzIFQUZzfi5V
	FoTYk69xXU1faGqMoR8EtWOkXnyWlScStdQV8bWKo842SRAprfFQ+j7OJBj9W3tHDbEZSlBT3dxhW
	6zWXpiSHlhmsCsEuooUBVnDE0ZPG/EWLty/X51C91LNG0DrPTb7XSCSmjYJbSTt3wJFMbRrFzU/Bc
	+sd6EhsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqGqp-00000001adc-2ijD;
	Fri, 29 Mar 2024 18:21:15 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqGqk-00000001aci-2s8e
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 18:21:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5pcz3t92zlgTGW;
	Fri, 29 Mar 2024 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711736464; x=1714328465; bh=oWd4mKvBTfHIVdJ4XtrugL3T
	fCRZQd98PpL66KZWPK0=; b=4P5rAMbbzABVDZwOK+CHiFKZhkTEmN/S0+pJT6Ol
	GtbQhk5zaXO0QOt+nUoepPnvpBK0GVK8XuBUcMKlTHwL+wsKsfNgBCKuWJirpxNo
	TPQ8DfnCfBJCgePs+2Ft8yWtPWc8pSv0VdTt9PPCK0xzUAPXiYwOmblN9AONmiA5
	iIdvFh52Q2QozPqSVGJRv4hP8YoWn9xkwEJ1yT31mHyKCSpMj1WXixfm0dz7CI3K
	92vCDLxlH465cgNF6Nu/5EyXQoGiPq7C35T/Qfe2bCiGmZVVOM9tqoz2/+n5712u
	+GOsye2JpFffvjG+x6fUfkBqqTUUiT7m1660D2m2f2i6ww==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SOWuDXWEU5aM; Fri, 29 Mar 2024 18:21:04 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5pcs5YCJzlgTHp;
	Fri, 29 Mar 2024 18:21:01 +0000 (UTC)
Message-ID: <e36aac15-1090-4e3c-a402-cff56b4d1961@acm.org>
Date: Fri, 29 Mar 2024 11:20:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/30] block: Introduce zone write plugging
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-9-dlemoal@kernel.org>
 <688607d9-6dfe-4c37-81e8-4fea91ec8da8@acm.org>
 <caf50c25-8f3d-4eb1-85bc-cc3499d5b107@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <caf50c25-8f3d-4eb1-85bc-cc3499d5b107@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_112110_799473_46987CEF 
X-CRM114-Status: GOOD (  13.97  )
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

On 3/28/24 3:38 PM, Damien Le Moal wrote:
> On 3/29/24 07:20, Bart Van Assche wrote:
>>> +	/* Wait for the zone write plugs to be RCU-freed. */
>>> +	rcu_barrier();
>>> +}
>>
>> It is not clear to me why the above rcu_barrier() call is necessary? I'm
>> not aware of any other kernel code where kfree_rcu() is followed by an
>> rcu_barrier() call.
> 
> Right after that, the mempool (in v4, free list here) is destroyed. So the
> rcu_barrier() is needed to ensure that the grace period is past and that all
> plugs are back in the pool/freelist. Without this, I saw problems/crashes when
> removing devices.

This patch would be easier to read if the rcu_barrier() call would be
moved out of disk_free_zone_wplugs() and into its caller.

Thanks,

Bart.


