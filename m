Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADCC44500
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ZuEu7/znTyQrw1X54jcDwYEYGPsiX3qbu8fEWMGJZw=; b=fiUnbnV8kLYP1c17or3Zwl3sPi
	lZ4FW4jUN9pkTLA+rUnuB4mzKw0DA4fKgdmFivPv56+Gz0kMToTiBPu9qHM8ChjeV2D55E4Ssd11S
	Y3uaikWSvwM1w1GV1RRKbH3mToJr2EfgvQE/V6dH+q50DfRihDKQWyxVJTS15LitdQ2HP9lMaIQpw
	QG/fVutSJENsrCKSJqd23sspiGvaAiz+qUNuGl84ai+hGpr2tLOi0iPngDBYXrZjIAQirs4M2EWva
	OM6RqG2SVCRlulucDah2NXT3IsSwiFUMqsCw0O2KZTnfCBfEREZAez3qWMzdQAxjYuuHfFWS84FVP
	vh409uzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgunB-0000000Dt4S-3Fp9;
	Tue, 07 Jul 2026 01:40:09 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgun8-0000000Dt41-2Mv5
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 01:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783388404; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2ZuEu7/znTyQrw1X54jcDwYEYGPsiX3qbu8fEWMGJZw=;
	b=nu+QHrqgBBkxI+dOXQcRGQiy2eNokdVGkCTqEiKxKCg5fDCi6svlkdUUcCXBGZHqXbjKaLFULqOcghmq9/vXdvAs+lmqnjv4l+sHvV6z1kty2sqtmNniqLV7BwSpD1K7Gvxz/345AjD8b4tbcNsJxrtO0xuUrf8X5CErzkOU1zY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6apjzx_1783388401;
Received: from 30.178.83.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6apjzx_1783388401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 09:40:02 +0800
Message-ID: <fb23530e-3b0c-4993-ac98-d7c1ba3f5986@linux.alibaba.com>
Date: Tue, 7 Jul 2026 09:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
 <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
 <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
 <7f5a765a-1f2b-4d67-b03d-f2cd7c73218c@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <7f5a765a-1f2b-4d67-b03d-f2cd7c73218c@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_184007_290406_BEADBB8A 
X-CRM114-Status: GOOD (  10.79  )
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



在 2026/7/6 19:55, Daniel Wagner 写道:
> On Mon, Jul 06, 2026 at 05:54:07PM +0800, Guixin Liu wrote:
>> 在 2026/7/6 15:50, Daniel Wagner 写道:
>>> On Mon, Jul 06, 2026 at 10:34:39AM +0800, Guixin Liu wrote:
>>>>    T:	git git://git.infradead.org/nvme.git
>>>> +F:	Documentation/ABI/testing/configfs-nvmet
>>>>    F:	drivers/nvme/target/
>>> Didn't catch this in the previous path, but why do think these API
>>> should be in testing section?
>> Some of these interfaces have been around for a long time,
>>
>> while others were only added in recent versions.
>>
>> I'm not sure what criteria to use for splitting them between stable and
>> testing,
>>
>> so I've put them all under the testing directory for now.
> The NVMe APIs are definitely not in the 'testing' section. The nvmet
> APIs are also not in 'testing', IMO. While they are used upstream
> predominantly by blktests, there are also people out there using them in
> production systems, if we like or not.
You mean we can put them all under stable directory?

Best Regards,
Guixin Liu



