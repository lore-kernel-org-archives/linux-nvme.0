Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E6EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wx1ETBPrfZZVrxxt24FvjkAxC9Gt56NgyV700P1vzmk=; b=Systv9nc1SuYrJCanZ+/T/7h0b
	2yy5PiymFfvVD8DxImBAZUtOVe+6fPtd3/tBo8949pik2+emRcXR+J3R98pJp8IT4/ncDc40xoN2w
	Y1DxO5Wu2rnnIgeDCxFbcuXf86W55NPCfZ1jMUEGy4lHP1M+Xi97jgMs6F3/jpmTtrUp945tujigw
	Ct1Ad7Jisvyxv9wkYNGmt1eoruHoy9kmU0cNSNYZpVrzsU3/aPyVHf5nV9Jfi48N0Gx1SQhWUah0n
	bDJQlSfxmJsmuAfy5UysIfupJjITuBPamvb9mmMPVDqH4zFvI1nygKm+IJS1IN+hTup1SkoG9LLZO
	BkYUyK6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBJJB-009ACw-39;
	Mon, 19 Jun 2023 18:08:57 +0000
Received: from smtp-26.smtpout.orange.fr ([80.12.242.26] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBJJ5-009AB7-0K
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 18:08:53 +0000
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id BJIsqZyYl2I9nBJIsq55fS; Mon, 19 Jun 2023 20:08:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1687198120;
	bh=Wx1ETBPrfZZVrxxt24FvjkAxC9Gt56NgyV700P1vzmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aJvD697bFSvOXhI7gVn7ySiizq9VhYJ8/bcvjQhj6M/j47SVwIfZsOvhrUiSZncHc
	 lMPrrmczuoCUo4jKMIhrcB2MONWjI6lncvMK3TvohySRKeK9arszdNON0uH8fYIP0l
	 zbbvXwCLosHjwETZzsiqUhz0LvW9iMFna6X/KluIUVFr5qHJoRr3UWVn0TXcpK6emU
	 Wt3HMSaEF/1EL6bCU9X+hfMuuPhfbflNkfHUhZNyjBIl9hvd0KxUUZ8vKXQcmiYWaD
	 fKUo4Y3uCp2AKhqv8dMSrh2cZxRvhbGJNHCPoOAwvMaVYTaDfGdzB9YZBPFHs9L2py
	 8xIAA9TV9dxwA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Jun 2023 20:08:40 +0200
X-ME-IP: 86.243.2.178
Message-ID: <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
Date: Mon, 19 Jun 2023 20:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: fr, en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_110851_703716_7AAF25E5 
X-CRM114-Status: GOOD (  12.57  )
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

Le 28/04/2023 à 01:07, Chaitanya Kulkarni a écrit :
> On 4/27/23 16:01, Jens Axboe wrote:
>> On 4/27/23 4:59?PM, Chaitanya Kulkarni wrote:
>>> On 4/27/23 12:47, Christophe JAILLET wrote:
>>>> Group some variables based on their sizes to reduce holes.
>>>> On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
>>>> bytes.
>>>>
>>> Although this looks good, we at least need to document what
>>> happens on other arch(s) which are not mentioned in the
>>> commit log ? is there a possibility that someone might come
>>> up with the contradictory data in future for the arch(s) which
>>> arch that are not mentioned here ?
>> The change is certainly not going to make things _worse_ for any arch,
>> so I think that's somewhat of a pointless exercise and an unreasonable
>> ask for something that makes sense on 64-bit arm/x86 and saves half the
>> space.
>>
> 
> disregard my comment, looks good...
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> 

Hi,


All my other nvmet patches have reached -next today, but this one seems 
to be missing.

So this is a gentle reminder, in case it got lost somewhere.

CJ

