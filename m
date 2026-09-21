Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81B7C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8orLWSwbF0Y5QdbRZbanElyiXWNNhr6rauUtOZgsNo=; b=RYIWN11VD74cuuwo1x/B3nbbme
	G0tC2Fga7QqUzo/iW/TGFaV0XXlEjdxbyRJIseu/2ERyCNpBZP42RxoINB7tMtfpLDNxudMnob7eC
	Qh6o0wcKvD2Mu0ocZ1jaRFcAD/eSCkQhmFZiMTjIu9+baHr8b4YkgD3nlxNXxrHWasB2ymyw8KjnC
	Vxg3kwljQItkFiScSm1cZDH9F3kDGYjl+epGtgK/E7hAFuyMOGP23d3hKydJw+cH0uWXGgFLw3dO3
	LUMatk/UO+jnT8BaOfnEzyyfW0j4k0WkNEFcYQZr45XU41kW7aGtMmIAKMGlrufmH+oJ2YVQr/Qns
	FdOEYq4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Ysq-00000001HKt-0zTA;
	Mon, 21 Sep 2026 07:56:16 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Ysm-00000001HGU-2Vxw
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789977367; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x8orLWSwbF0Y5QdbRZbanElyiXWNNhr6rauUtOZgsNo=;
	b=eErwbiVNHHgTAxOsQbvK8UyLkcXZW3SMLuTFy+Rs6ufbLsZmfWNWDli5HJg5Mhrl4Vzjvsom5YDz7mer+s6Cb+Bh+FavtSZPjlJ7cE4l6Ty47bV1gXXZvRABHE3hZDtGWpQ+GXXcSOK7smCjJa5/DHeDTO1QhOESFZoLCLzvCw0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBJzzA8_1789977365;
Received: from 30.178.84.79(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBJzzA8_1789977365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 15:56:06 +0800
Message-ID: <adc9165b-b7f2-453f-8e2d-781088f592d9@linux.alibaba.com>
Date: Mon, 21 Sep 2026 15:56:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs in
 Set Features 82h
To: Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
 <20260920033500.3209138-2-kanie@linux.alibaba.com>
 <baef058e-a502-4263-8d3d-1ad0a9550826@linux.ibm.com>
 <20260921065311.GC13667@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260921065311.GC13667@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005613_262131_D0F7E4D5 
X-CRM114-Status: GOOD (  13.14  )
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



在 2026/9/21 14:53, Christoph Hellwig 写道:
> On Sun, Sep 20, 2026 at 04:37:08PM +0530, Nilay Shroff wrote:
>> On 9/20/26 9:04 AM, Guixin Liu wrote:
>>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>>> index 0948a690a1c0..a36c732883d4 100644
>>> --- a/drivers/nvme/target/pr.c
>>> +++ b/drivers/nvme/target/pr.c
>>> @@ -51,6 +51,8 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
>>>     	if (nsid != U32_MAX) {
>>>   		status = nvmet_req_find_ns(req);
>>> +		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
>>> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>>   		if (status)
>>>   			return status;
>>>   		if (!req->ns->pr.enable)
>>> -- 
>> This looks good to me. However, to avoid hand-coding the same error
>> return code multiple times in the function and to make it a bit more
>> readable, how about modifying it as follows?
> I don't understand how that helps.  If we really want to refactor,
> we could add a version of nvmet_req_find_ns that does it, but
> that feels like a bit of overkill.
Agree.
>
>> 		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
> Still no need for the inner braces here in all versions.
Well, in C, the "==" operator has higher precedence than "|",
so the inner braces are required here.

Best Regards,
Guixin Liu


