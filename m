Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B69C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xf1M+QjVIhp4qI2TdVgWQA1ZXH+82asZlK2b3D1j680=; b=oixDjoYhO54YOy1c8NRgBGgDRg
	PaDzS+PdWTwxqzRg38QUJYapVhE74hP/trMDoeLDIW3KY8jHnFre+PxiptVkdcNUFyh7zNnWqRwt4
	I81RfUJR715oh7FwLnS1RHbiCUFGjSD/J5gR72Bh0JYj8KzBYdkTn5QgK9DSUP0XMFZpLIwt9JFVa
	pJXj6ID9GrSlcir78s6bb9VMT2lsKOFBmQsSZY15bHsr4Bcf0V/1nsCvj1bX09Yp+HfzUC8MEELC2
	5+RcKgAnGsbLTEq23/1mZQPN9FfnoSlJQeSR8/Evv5Y3eKCCGEWvRvs3JOwtRtKN0el4y6suvSaNb
	jB985Cww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrfQI-006hHG-UF; Thu, 19 May 2022 12:38:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrfQF-006hEu-SB
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 12:38:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 681A51FD38;
 Thu, 19 May 2022 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652963904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf1M+QjVIhp4qI2TdVgWQA1ZXH+82asZlK2b3D1j680=;
 b=qan6lifZrxQyTuqZ+YTDgUp5Bhvh9dCRcu1aLJlH6yrRV8zbw38VV3hGY0JvUTnhPO0Pxa
 e1ccXbaQ1mXIo3K60bkvA0qzLaImCKPW2v/oWAOMB3xh6UEBw2Lp3k+3bOO1CMMBWJA+Pf
 8MMTgN+b/nmtVBbLMDVCsxFCeERW6hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652963904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xf1M+QjVIhp4qI2TdVgWQA1ZXH+82asZlK2b3D1j680=;
 b=HPf/W/bXe1EQ0FT8SaZwRV4bAPvX9hhkMHazwG7W4Jvghynj5aGFOHHX7Xd1Nqfrfubqzt
 sZGXx+mX8GX6C0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403C613456;
 Thu, 19 May 2022 12:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HxfsDUA6hmL9DQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 19 May 2022 12:38:24 +0000
Message-ID: <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
Date: Thu, 19 May 2022 14:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>,
 Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
 sachinp@linux.vnet.com, mputtash@linux.vnet.com,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_053832_087455_469128E6 
X-CRM114-Status: UNSURE (   9.38  )
X-CRM114-Notice: Please train this message.
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

On 5/19/22 14:14, Jens Axboe wrote:
> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>> Greetings,
>>
>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>
>> Console Logs :
>>
>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>> make -j 17 -s && make modules && make modules_install && make install
>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>> make: *** [Makefile:1914: modules] Error 2
>> make: *** Waiting for unfinished jobs....
> 
> Christoph, can you fix this up?
> 
Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
Please share details.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

