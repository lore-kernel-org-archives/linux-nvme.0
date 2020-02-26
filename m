Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41806C4BA13
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 15:47:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136DF20637
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fK6ztKnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136DF20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b/LXzzsMG6ltmhIUcS7AgoDyNQIhZeSbWj6w4WLZrew=; b=fK6ztKnB6MHI9aspT7C6ewy0Q
	96qgim6DBWUvcnLqLFKJCqtuZBUSI0MFri/VipPBDM1cWHmA89fGe0rYBDLt1INnAwc7QvlhOG5Gj
	kdSmpimpEWmKi94rf0fHR9vvkQWa9PyEKLXlXFkg8823gnHwxiYe/+ZrqF/8pcx8MMnJH88emWTQF
	pe9UCNP30r64/jPQG/8oRJ/YuUVswu18eRaoTykc6X2+rXeeUjEjnLl2NyhIE0h3rKMz0IPnZ2oOA
	3fU45Qn1Bd6YNQgrcv1BlWxf6m+1Jd77GGW1ScVViF1vSXHkqZAvrKoamVqv5kBIYivo61zGRIV61
	zPyp3RMWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6yuJ-0004Fp-Km; Wed, 26 Feb 2020 15:47:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6yuH-0004FW-6a
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 15:47:30 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 612A3AD82;
 Wed, 26 Feb 2020 15:47:27 +0000 (UTC)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Martin Wilck <mwilck@suse.com>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <285681d11e1164693666eeaead4926159d89549f.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3eddfaea-aaad-a87d-6f22-d9d34b8935da@suse.de>
Date: Wed, 26 Feb 2020 16:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <285681d11e1164693666eeaead4926159d89549f.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_074729_385398_7081E554 
X-CRM114-Status: GOOD (  18.39  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, John Meneghini <john.meneghini@netapp.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/26/20 11:44 AM, Martin Wilck wrote:
> On Wed, 2020-02-26 at 00:59 +0100, Hannes Reinecke wrote:
>> As per NVMe-oF spec sq flow control is actually mandatory, and we
>> should
>> be implementing it to avoid the controller to return a fatal status
>> error, and try to play nicely with controllers using sq flow control
>> to implement QoS.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fc.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index a19ddb61039d..628397bd5065 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> ...
>> @@ -2177,6 +2181,18 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl,
>> struct request *rq,
>>   	freq->sg_cnt =3D 0;
>>   }
>>   =

>> +static int nvme_fc_update_sq_tail(struct nvme_fc_queue *queue, int
>> incr)
>> +{
>> +	int old_sqtl, new_sqtl;
>> +
>> +	do {
>> +		old_sqtl =3D queue->sq_tail;
>> +		new_sqtl =3D (old_sqtl + incr) % queue->ctrl-
>>> ctrl.sqsize;
>> +	} while (cmpxchg(&queue->sq_tail, old_sqtl, new_sqtl) !=3D
>> +		 old_sqtl);
> =

> Shouldn't you use READ_ONCE() to update old_sqtl, or better even, use
> the return value of cmpxchg()?
> =

Good point.
Will be doing so.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
