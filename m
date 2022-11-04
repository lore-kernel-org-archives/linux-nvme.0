Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB97C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=laMrnNu1E7g/BrIErPct2AgiEjluuhHvKXROXx+KSQw=; b=e0xyvo49ytxfJBz4sRAKTYsgqN
	jKRWhydcch+oE/bR1F/Itk9+PHOIlLuQdAInnZVBILdMLZ5qGyMzjuv6Gp8PAdww6W5zExSsKW+cr
	1ZMn6TppvYOqOhfYY5W9X+jbVB9lX7vDk+86DEgO8DEGbGV2UactUzHQ7khO2OB132FCJXv3DK/7Q
	lxuWBpQNU5XZi79B1/AgGhels3GpeCdoqVZjfr3A8GFNW2LY8jNk0+2zShLy1ho+upCP5q01bgTTz
	vxzc681GURsSMCDtZZl4MbzYyS4WGvBT0DYWPBeBW51bGPWwaMRFHkcWE3zc0e85JiaPdfulvsRDx
	0kW0c16A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqbK-002fKr-Ol; Fri, 04 Nov 2022 06:54:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqbG-002fJm-Fj
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 06:54:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E29B2188F;
	Fri,  4 Nov 2022 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667544885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laMrnNu1E7g/BrIErPct2AgiEjluuhHvKXROXx+KSQw=;
	b=zS3jI1lfpuIUfeYPGgQ30RdzXJwZP7/m0KJd01RO7GQfDc2y04IDJrV/ZXMrGqOHubyqZ2
	p/fCnUVawunSM8ZNsE5dSxKmhDPi0i+VNqkmeharwRzdCiMID0Kl7xkF2TX9tS6m/cKTzJ
	Bp3/USahH0jxxoYwcA3coJnzeVWOSO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667544885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laMrnNu1E7g/BrIErPct2AgiEjluuhHvKXROXx+KSQw=;
	b=XtRe6hB6ir04VMSs6L2aFI73o97A7o+ifvmHyjErBLBlXxTkPHjLL+OzZjE1VL9um/FiAd
	Qh3qy5ui3sww/sDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 073921346F;
	Fri,  4 Nov 2022 06:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PTlIATW3ZGPVMgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 04 Nov 2022 06:54:45 +0000
Message-ID: <25cf4827-38b5-8b82-f9f3-c84939d0fb20@suse.de>
Date: Fri, 4 Nov 2022 07:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6] nvme-auth: do not queue authentication if the queue
 is not live
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-3-hare@suse.de>
 <4611b6ed-fb24-b17b-6320-dffc324b5ede@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4611b6ed-fb24-b17b-6320-dffc324b5ede@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_235446_701410_C9DB406B 
X-CRM114-Status: GOOD (  17.13  )
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

On 11/3/22 22:19, Sagi Grimberg wrote:
> 
>> If the queue is not connecting or live there's no point in trying
>> to start authentication as we won't be able to send commands.
>> So terminate the work functions directly if the controller is
>> in a wrong state.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/auth.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index b68fb2c764f6..719c514363ee 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -696,6 +696,12 @@ static void __nvme_auth_work(struct work_struct 
>> *work)
>>       size_t tl;
>>       int ret = 0;
>> +    if (ctrl->state != NVME_CTRL_CONNECTING &&
>> +        ctrl->state != NVME_CTRL_LIVE) {
>> +        chap->error = -ENOTCONN;
>> +        return;
>> +    }
> 
> Why do you want this to run in CONNECTING at all? The connect itself
> will authenticate...
> 
Precisely. It will authenticate _using this function_ ...

>> +
>>       chap->transaction = ctrl->transaction++;
>>       chap->status = 0;
>>       chap->error = 0;
>> @@ -937,6 +943,10 @@ static void nvme_dhchap_auth_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, dhchap_auth_work);
>>       int ret, q;
>> +    if (ctrl->state != NVME_CTRL_CONNECTING &&
>> +        ctrl->state != NVME_CTRL_LIVE)
>> +        return;
> 
> Same here.
> 
Here, however, things are different, as this function is only called 
during re-authentication (ie if someone wrote into the sysfs attributes).
This really makes sense only when the controller is live.
Will be fixing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


