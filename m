Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49695C55184
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2026 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAVsXQKignswruDB3eFb2Lv1ILob6unanCeDty+AJYo=; b=HE6gp9Nqx3YU7/TIOOXJzq8pZ+
	ShDMOHGjyQzUksISz6igEFg3RZcdjR3wregZ14WWYsvzcR7DBBJFZ4Z9qvkATDeTdqcaK54S2S3EO
	2y29A9Y10VFG9ML/u+DSolvXHWXXyqxS9EykqxCaZIKhh0dofnY6AQSThIlh/QNUnUgAsnfmO2kyC
	K7W5lTCzE0QYdVXi1k8tQffVXLKV1RjpYTlhYiHGZ+JxKmkQ2GQwm88PNy+qoYJik4Z6eMcuN5hEb
	hqiwcsw3zb7X74CwtLF9Nb/KdDXtH4ib83yKMQequNPJbc40V0zBOJmgTHUB6C61P6T1JDHhyouwg
	zJ6y3FaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrQjy-00000003501-0wcE;
	Wed, 05 Aug 2026 01:48:18 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrQjv-000000034zN-0qXL
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 01:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785894493; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rAVsXQKignswruDB3eFb2Lv1ILob6unanCeDty+AJYo=;
	b=wUm5jddUsYjBPiRnTXh1N9nK5K8CkROpqsWl2ya13p9Kz+e5n1sxGDLAjhruq2anUCrxjnQNKWGOK60EbXSP0sZCEO+FYiM+c/AFF6FBsiGYrzqd1dITpiIe9VseK7XKRsuJV7N67uwpunEJc0UT6xysi0Z8LX5SyJK0umB/bUk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X8PWGWL_1785894489;
Received: from 30.178.83.151(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8PWGWL_1785894489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Aug 2026 09:48:10 +0800
Message-ID: <694518c9-fdef-4f1e-a160-badd8c3b09d2@linux.alibaba.com>
Date: Wed, 5 Aug 2026 09:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix heap out-of-bounds read in
 nvmet_auth_negotiate()
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org
References: <20260804033800.3975537-1-kanie@linux.alibaba.com>
 <20260804161926.GC11977@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260804161926.GC11977@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_184815_931795_4446AEBD 
X-CRM114-Status: GOOD (  17.24  )
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



在 2026/8/5 00:19, Christoph Hellwig 写道:
> On Tue, Aug 04, 2026 at 11:38:00AM +0800, Guixin Liu wrote:
>> nvmet_execute_auth_send() allocates the DH-HMAC-CHAP message buffer with
>> the host-supplied transfer length (tl) and hands it to
>> nvmet_auth_negotiate() without passing tl along. nvmet_auth_negotiate()
>> then reads the negotiate header and, for each of the halen hash
>> identifiers and dhlen DH group identifiers, indexes into the fixed
>> idlist[60] array (hashes at idlist[0..halen), groups at idlist[30..]).
>>
>> Neither the transfer length nor halen/dhlen is validated. A malicious or
>> non-conformant host can report a tl smaller than the negotiate structure,
>> or a halen/dhlen larger than the array (both are u8, up to 255), making
>> the loops read past the end of the allocated buffer (heap out-of-bounds
>> read). The sibling nvmet_auth_reply() already validates tl against the
>> structure size; the negotiate path did not.
>>
>> Pass tl into nvmet_auth_negotiate(), reject a tl that does not cover the
>> negotiate data plus one full protocol descriptor, and reject halen/dhlen
>> larger than NVME_AUTH_DHCHAP_MAX_DH_IDS.
>>
>> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
>> index d1b39e64d877..d015968bae2d 100644
>> --- a/drivers/nvme/target/fabrics-cmd-auth.c
>> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
>> @@ -31,12 +31,16 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
>>   	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>>   }
>>   
>> -static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
>> +static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
>>   {
>>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>   	struct nvmf_auth_dhchap_negotiate_data *data = d;
>>   	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
>>   
>> +	if (tl < sizeof(*data) +
>> +		 sizeof(struct nvmf_auth_dhchap_protocol_descriptor))
> Odd formatting here.  Condition continuations either get two-tab indents
> or after the brace:
>
> 	if (tl < sizeof(*data) +
> 			sizeof(struct nvmf_auth_dhchap_protocol_descriptor))
>
> 	if (tl <
> 	   sizeof(*data) + sizeof(struct nvmf_auth_dhchap_protocol_descriptor))
Well, this is an oversight.

Hi Keith, could you please fix this when you apply?  Or I can send a v2 
patch.

Best Regards,
Guixin Liu
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


