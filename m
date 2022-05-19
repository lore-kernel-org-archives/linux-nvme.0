Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C93C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ColDhVfTgtDNAvcfht1bJmFjFnebvCnCTK2LPqx1PRE=; b=QB1vJWJEVhqKgBtmhl8XBe/dHm
	P+47h4UpiVQhOogXfJJ3ovKRCEPU8UhUHBTu7CzHVvLSD0CA2VYyp4SGHq8wgKA6imKJOAuOPk/vf
	aDHZVfHVnEZAcp0eGpxD+cGhWCxtYtiCCYpr+UH5QjRyule2soyrUxDes/PNBoV/N+6csbCod9kqi
	t1YXXACgOjMvPlksEVkgVSLlTnMW50XeMU1LBqXj91cUdYGgF6e/PYnZKjUDpOUsoXAu/muqrR9ur
	OnwitUxuOm3OmUlR0C8NIbnVNA76fvFteFhJMAZQr5UhfC4wczOnSQ9H+kSU7rYuclWW2jR+VRRsl
	gNMrakGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrfpL-006sOr-Qa; Thu, 19 May 2022 13:04:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrfnX-006rFX-E2
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 13:02:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B6B81F918;
 Thu, 19 May 2022 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652965353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ColDhVfTgtDNAvcfht1bJmFjFnebvCnCTK2LPqx1PRE=;
 b=JtNa1jcBjMsMUwi+5i/5rpr4WhwCaZDZW2easZBZcVaAoTAbu5UCUQg9o3RLex00s/YZ1R
 XsvAhLvUIYxfKMjrIdYoK6f4jY4QJ7kd9juHiwZQylFc5UamCw/dss9M+ArrK9S4fQrlyB
 6sekTKDOZPF+B1EeojxSjq67HB+XrS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652965353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ColDhVfTgtDNAvcfht1bJmFjFnebvCnCTK2LPqx1PRE=;
 b=mNhgRujtYO0Yqplw+t8Js+Jl3K443ru1BYtpSI1RT48PR5A6Hl0aOtHI6Ji8jX2dWsBcxn
 fHbO9OgSUlK0KzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 322BB13AF8;
 Thu, 19 May 2022 13:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rhrxCek/hmLKGgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 19 May 2022 13:02:33 +0000
Message-ID: <268233c7-88ad-6b5c-6991-e3a4f1ac2540@suse.de>
Date: Thu, 19 May 2022 15:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
 linux-block <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, sachinp@linux.vnet.com,
 mputtash@linux.vnet.com, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
 <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
 <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_060235_684064_DB8619D7 
X-CRM114-Status: GOOD (  10.96  )
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

On 5/19/22 14:42, Jens Axboe wrote:
> On 5/19/22 6:40 AM, Jens Axboe wrote:
>> On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>>
>>> On 5/19/22 14:14, Jens Axboe wrote:
>>>> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>>>>> Greetings,
>>>>>
>>>>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>>
>>>>> Console Logs :
>>>>>
>>>>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>>>>> make -j 17 -s && make modules && make modules_install && make install
>>>>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>>>>> make: *** [Makefile:1914: modules] Error 2
>>>>> make: *** Waiting for unfinished jobs....
>>>>
>>>> Christoph, can you fix this up?
>>>>
>>> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
>>> Please share details.
>>
>> The kerneltest bot also reported this a few days ago, you might be able
>> to find the details there as that includes config etc.
> 
> Here: https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com/
> 
Right. Send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

