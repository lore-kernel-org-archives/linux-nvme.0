Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04509C678D4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4AqwyhsogAdfB7Yjm5ZST+aFqwS9AWOEAodjAAj1F0=; b=wV4IRMnsNaA8yQdpYbdAuzFVjD
	W/sOO/mOrRUrPMi7BglTMVwA3Y99uhxNVqJQlOtBR4yAIeukHVKgjDoGjVjEI0IMwZIGadWbOKvbP
	EwRvkXG2fQ9+K64xchwKAlb2PeCf0JOhoTlasRn7BfEXItLVxeHsntkNrxuiPvzBeZXTjm/9zoFQp
	X1x5JgOGskq+X/mJ8qeYQWuz4cIw9Xv54nvnBo/FwHCJvWF5eJcT7Z/HVlXPdhTU0/b2yROSszQEE
	On0twWoTliNQi3aDtHE9/PSAWXQ2Cy6wY/WLAAJlP98mGow7t+ysy8TWx26aNAIO9CXwUU61UcQfU
	B6yPxzkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZVfK-00HVXF-It; Tue, 07 Mar 2023 11:39:34 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZVfI-00HVWI-9l
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 11:39:33 +0000
Received: by mail-wr1-f43.google.com with SMTP id t15so11782499wrz.7
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 03:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4AqwyhsogAdfB7Yjm5ZST+aFqwS9AWOEAodjAAj1F0=;
        b=HpOzGMCkj99bNDuIuy6BSyTQIoYdVCurDcMbCNpNYILbSXG8fggScCF0yufIUmTqGO
         bgllVeNWJdNAXwjpvQPQ9DFerI5cU+8RfN5PRutcv56pNGx+z1eGh0xoORHc7ixuPqIN
         s5u6M8ti50llGtpBvKoNOIzAxBYePaXieQ+YatJTmiE33eYQU/vQrmJosk6F4W7mM+lG
         wvkxHzepPeBwUdgxFS9dc0tP1TE7nX4yOM1Iy4NfhFbNJLdoWIy5KW5Ciu7rPPsBYEjg
         3uIW4ZmzLUFUdu2Ezun5sfl0WHq9YJRhigNFCth3JdHP09yll98zsAJow5SJt1PtrEHK
         ykbQ==
X-Gm-Message-State: AO0yUKXOBUQu+rD+frNaHxyXckhZ6MP70OqsN2bfwrIWJN4PuDeUjF4d
	C2LTXP2h55QpInV4nLkwH1w=
X-Google-Smtp-Source: AK7set8eJVSEc0/8WKaRaPkWBnGkf/MjXS+9QcfOSwlNwtAmO08KHIPwyo5i2Ffin4dQV64YxUH3YQ==
X-Received: by 2002:adf:d4c6:0:b0:2c8:207d:c10e with SMTP id w6-20020adfd4c6000000b002c8207dc10emr7925212wrk.1.1678189169592;
        Tue, 07 Mar 2023 03:39:29 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id x8-20020adff648000000b002c3dc4131f5sm12467949wrp.18.2023.03.07.03.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:39:29 -0800 (PST)
Message-ID: <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
Date: Tue, 7 Mar 2023 13:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_033932_373070_31444AFB 
X-CRM114-Status: GOOD (  18.73  )
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



On 3/6/23 23:49, Ming Lei wrote:
> On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 3/4/23 01:13, Ming Lei wrote:
>>> When investigating one customer report on warning in nvme_setup_discard,
>>> we observed the controller(nvme/tcp) actually exposes
>>> queue_max_discard_segments(req->q) == 1.
>>>
>>> Obviously the current code can't handle this situation, since contiguity
>>> merge like normal RW request is taken.
>>>
>>> Fix the issue by building range from request sector/nr_sectors directly.
>>>
>>> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>>>    1 file changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index c2730b116dc6..d4be525f8100 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>>>    		range = page_address(ns->ctrl->discard_page);
>>>    	}
>>> -	__rq_for_each_bio(bio, req) {
>>> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> -
>>> -		if (n < segments) {
>>> -			range[n].cattr = cpu_to_le32(0);
>>> -			range[n].nlb = cpu_to_le32(nlb);
>>> -			range[n].slba = cpu_to_le64(slba);
>>> +	if (queue_max_discard_segments(req->q) == 1) {
>>> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
>>> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
>>> +
>>> +		range[0].cattr = cpu_to_le32(0);
>>> +		range[0].nlb = cpu_to_le32(nlb);
>>> +		range[0].slba = cpu_to_le64(slba);
>>> +		n = 1;
>>> +	} else {
>>> +		__rq_for_each_bio(bio, req) {
>>> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> +
>>> +			if (n < segments) {
>>> +				range[n].cattr = cpu_to_le32(0);
>>> +				range[n].nlb = cpu_to_le32(nlb);
>>> +				range[n].slba = cpu_to_le64(slba);
>>> +			}
>>> +			n++;
>>>    		}
>>> -		n++;
>>>    	}
>>>    	if (WARN_ON_ONCE(n != segments)) {
>>
>>
>> Maybe just set segments to min(blk_rq_nr_discard_segments(req),
>> queue_max_discard_segments(req->q)) and let the existing code do
>> its thing?
> 
> What is the existing code for applying min()?

Was referring to this:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3345f866178e..dbc402587431 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct 
nvme_ns *ns, struct request *req,
                 range = page_address(ns->ctrl->discard_page);
         }

+       segments = min(segments, queue_max_discard_segments(req->q));
         __rq_for_each_bio(bio, req) {
                 u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
                 u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
--

