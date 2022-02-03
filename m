Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0103C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4G1v1LAii/eUBmMn/07Ly+L7BrPraFumWPPW9oell0=; b=vckQP/2pW4QYqoqZLiG6hKcFDc
	62gACFkUDFL8hVLLNIjQVt26Z8k5ivo6bnSL/765Ueksq25hOrY4oJeuPIjpzCdUDJVQeQZQiFuzG
	+R6jQwXy1dKxQ7XrqHe75uqNTCGcs1XH/bvBzoohsgZsPzOBZ1LSv33BYrbSI67XifVib0/djY+eR
	1+xsKs4jKLx74G0qMAa+agHTRIzZMTl0UOitO1oaXJCDV2D7KmTKfXxBkfLmvs8RI8xNvrhm5qRa2
	aCIY9P89sVMobPbo3MUcEPBd+3MvUCaPSZDARET7ThBiVmbJKpPICOPqxJYTL+kYQMZRWLkETitl0
	coY0Adhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFbK5-001ILW-Lb; Thu, 03 Feb 2022 12:34:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFbK0-001IIV-2H
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 12:34:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4A1C210F8;
 Thu,  3 Feb 2022 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643891679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4G1v1LAii/eUBmMn/07Ly+L7BrPraFumWPPW9oell0=;
 b=tooH1vGDLzdw5i9gYTFcgC9vC86syeOOtF3uQz808Bm9k7ehpv9F6oC2tXV+y2CWocqLcn
 V18/Hw3pk/r/dPwqo4Z9Si/cdvijkRDDFHMAFXWc6DBhjt0TLwsmkFHG2bNCbyirOH6g5j
 fa0uABtxhU0fUc19t/qO2dVyIBmKu40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643891679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4G1v1LAii/eUBmMn/07Ly+L7BrPraFumWPPW9oell0=;
 b=xU2J93CeM7MmzWy0y8nL4IyuwA44uaOrZdtlN+vs9qfQb4LQKzoHUaj6e0pG8rm9VAOjS5
 wzyHokzPJWR0w1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6AD81348D;
 Thu,  3 Feb 2022 12:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QoeML9/L+2E8GwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 03 Feb 2022 12:34:39 +0000
Message-ID: <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
Date: Thu, 3 Feb 2022 13:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Rose, Charles" <Charles.Rose@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_043444_317575_11A409DD 
X-CRM114-Status: GOOD (  22.32  )
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

On 2/3/22 12:59, Belanger, Martin wrote:
>> On 2/2/22 22:34, Martin Belanger wrote:
>>> From: Martin Belanger <martin.belanger@dell.com>
>>>
>>> TP8010 introduces the Discovery Controller Type (dctype) attribute.
>>> The dctype is returned in the response to the Identify command. This
>>> patch exposes the dctype through the sysfs. Since the dctype depends
>>> on the Controller Type (cntrltype), another attribute of the Identify
>>> response, the patch also exposes the cntrltype as well.
>>>
>>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>>> ---
>>>    drivers/nvme/host/core.c | 35
>> +++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h |  3 +++
>>>    include/linux/nvme.h     | 10 +++++++++-
>>>    3 files changed, 47 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
>>> 872c389dc6d3..c65d44fb65c4 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2992,6 +2992,9 @@ static int nvme_init_identify(struct nvme_ctrl
>> *ctrl)
>>>    	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>>>    	ctrl->ctratt = le32_to_cpu(id->ctratt);
>>>
>>> +	ctrl->cntrltype = id->cntrltype;
>>> +	ctrl->dctype = id->dctype;
>>> +
>>>    	if (id->rtd3e) {
>>>    		/* us -> s */
>>>    		u32 transition_time = le32_to_cpu(id->rtd3e) /
>> USEC_PER_SEC; @@
>>> -3525,6 +3528,34 @@ static ssize_t
>> nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>>>    static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>>>    	nvme_ctrl_fast_io_fail_tmo_show,
>> nvme_ctrl_fast_io_fail_tmo_store);
>>>
>>> +static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
>>> +				     struct device_attribute *attr, char *buf) {
>>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +
>>> +	switch (ctrl->cntrltype) {
>>> +	case NVME_CTRL_IO:	return sysfs_emit(buf, "io\n");
>>> +	case NVME_CTRL_DISC:	return sysfs_emit(buf, "disc\n");
>>
>> 'discovery', please. 'disc' is misleading here.
>>
>>> +	case NVME_CTRL_ADMIN:	return sysfs_emit(buf, "admin\n");
>>> +	default:		return sysfs_emit(buf, "reserved\n");
>>> +	}
>>> +}
>>> +static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show,
>>> +NULL);
>>> +
>>> +static ssize_t nvme_ctrl_dctype_show(struct device *dev,
>>> +				     struct device_attribute *attr, char *buf) {
>>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>> +
>>> +	switch (ctrl->dctype) {
>>> +	case NVME_DCTYPE_NOT_REPORTED:	return sysfs_emit(buf,
>> "nr\n");
>>
>> Please use 'none' here; 'nr' is ambiguous ('Number'?)
> 
> Thanks for the review. I will apply the changes.
> 
> Question: Since this was part of a set of patches, do I need to resubmit
> the whole set or can I just resubmit this one patch?
> 
Whole series, please. And gather up the reviews when resubmitting.

> Also, Sagi mentioned that the dctype should only be exposed for
> Discovery Controllers, which makes sense. However, I found that
> when  nvme_dev_attrs_are_visible() is invoked the ctrl object is
> not fully configured yet (i.e. the controller is not yet identified).
> Is there any other way to determine the controller type prior to
> receiving the response to the Identify command?
> 
Nope, unfortunately.

But maybe we can lump both attributes together in to a single ctrltype;
then we would have 'io', 'admin', 'discovery', 'discovery-cdc', and 
'discovery-ddc'.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

