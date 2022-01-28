Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B457EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/1472KZU3nAC1w1yUJXTLLSRgqFxdu3HYz3RKoFZQk=; b=2PwDlCXqyOcwyLJY6oth+iHuRW
	sDTig85KvwGi9wY1lF4omkoG+FB55RM5pwT4PEa/AQvCwcMM5giR8mofgPcdZDDETphOB4jzpByyp
	Lu9LeW8+EYucLD5+T4XYBghEWXzxQtoE1plBfk0S7DESAgDWH8cXBYZDHN5KDH9pLPCjXPrFVtFZ8
	W3BLK4Me1nzCGkd5tkteUG28oDN+5eIFOVuSvzD1HYUkwP5P1knH1rWoQksuiZVqsdzI+3I1rK8Hu
	8ILl6/M2U1LTRkRHzGR8is7M26c3ws+NvX0mvnjb9/MXXudsTXDtZGzvTcJY6pT3yG9g/PNxSsNvD
	+SITediw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDUhd-0038Tx-AP; Fri, 28 Jan 2022 17:06:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDUha-0038SI-BN
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 17:06:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBB6B210E6;
 Fri, 28 Jan 2022 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643389580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/1472KZU3nAC1w1yUJXTLLSRgqFxdu3HYz3RKoFZQk=;
 b=Cdm+ypEBhkbghnnsm9wFi79uCSkOrv92sXWLoT0MEDj4V3weyKo5M5uwXuqw+FTWWhZ7YP
 zyMUu7ExCWzUkEqEG01bHVgFS7hQ2fZZodqXiebbo6AwIB16OGARgxlD7o39huj2XGh7yR
 AQb8Y+Bq5k19QkYe7ia4UY8hK3ioGBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643389580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/1472KZU3nAC1w1yUJXTLLSRgqFxdu3HYz3RKoFZQk=;
 b=uaNamDerDMGoBt4kQ2qPMjGW7y6KNn7FMsSwOweCPFPej4xYY6IBAHPNu6khTw1BoFKyGA
 7LnqfQttrAdmixAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2D4213A4A;
 Fri, 28 Jan 2022 17:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iocnJ4wi9GGffgAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 28 Jan 2022 17:06:20 +0000
Message-ID: <e3cdb1c4-dbdc-abf9-8a7b-d272960ae382@suse.de>
Date: Fri, 28 Jan 2022 18:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127133648.8201-1-dwagner@suse.de>
 <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
 <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
 <20220128123638.unxd5fzoctit6lpi@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220128123638.unxd5fzoctit6lpi@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_090622_558799_DF6128DA 
X-CRM114-Status: GOOD (  14.19  )
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

On 1/28/22 13:36, Daniel Wagner wrote:
> On Fri, Jan 28, 2022 at 11:31:37AM +0100, Daniel Wagner wrote:
>> On Thu, Jan 27, 2022 at 09:17:58AM -0800, Keith Busch wrote:
>>>> +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
>>>> +{
>>>> +	return ctrl->cntlid == 0xffff;
>>>> +}
>>>
>>> It's probably safe to assume 0xffff is dynamic, but spec suggests we
>>> check ID_CTRL.FCATT bit 0.
>>
>> Okay, but this one is only defined for fabrics. I haven't found anything
>> so far which is equivalent to FCATT bit 0 for memory based transport.
> 
> Never mind. After discussing it with Hannes it turns out there is no
> problem here. I didn't understand the spec correctly (it's difficult to
> get an exact answer) on this topic.
> 
Weasely wording in the spec again.
It talks at great length on controller IDs for fabrics, which values are 
allowed and which not, and how one should do dynamic controller ids _on 
fabrics_, but is strangely silent for memory-based (ie PCI) transports.
There, apparently, 0xFFFF _is_ a valid controller id, and the only 
restriction is that the controller ID must be unique.
And even that is never stated directly, but must be inferred from the 
various command payload descriptions.
Guess it's a topic for the fmds call.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

