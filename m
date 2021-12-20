Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EDC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZzps8dZUukz/uymIFEnwNv+X+mpGNbTyHdAiCV0kvk=; b=raE5JZPYl+qDJhoZsEP+/CH6KK
	XUc79/Hv2DX8dWW3w8oY90inFLz2KzzdjlX3k8u72pMizdNdfTqtT8dEMaznchWicNWzgwfWqz4tz
	OYBtxK3u9KsH+scmNo0h7g/5tluymd4pZtsAPwOGWGEG4cpSbzg6j5OIMkbLdOfx9aNQ4jYP0eaMF
	OXBvWD3w/V0G1ZJOtj2c0M5xoVDhLtOEMWO6CmoPl4JLro1dBdY5v9MYfKqVOrCAdgSWBPy3shbSY
	VViM54BrCIswwHxtQtxPsZXXQyMAaSSdtTU7JvIGSdvtOdAMpQTZhfF34h9tAhPOIDKvgSdzRM/UJ
	vY5hjwJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzExR-001Ouk-O9; Mon, 20 Dec 2021 09:27:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzExF-001Ot7-E9
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 09:27:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4F251F381;
 Mon, 20 Dec 2021 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639992453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZzps8dZUukz/uymIFEnwNv+X+mpGNbTyHdAiCV0kvk=;
 b=nlGYsinkxvPVc+rFA5sLr7Lwjob51PYbHNX3BlOlc0DEUFRB8vV4U1TvxscGY0O7DaqatR
 EFUV/OErsvCAvXzTO+pPv/tg9W4fj95F8F/c9Ip0TC7/cPTSGeGs+6ptRtmVJ+Hst9HcpF
 OFiQ604rOHOW5rSXRzemJGZ0y0dSHvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639992453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZzps8dZUukz/uymIFEnwNv+X+mpGNbTyHdAiCV0kvk=;
 b=5wqoVnLDVsWIO0PfEDH0A9bTprZTGTrZPMOCZeMvyi8gQ4yKkjFKSB2xnwEcUlKlggMKlU
 LTZazbrwQVhSeOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BADD13AE0;
 Mon, 20 Dec 2021 09:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9OLxGIVMwGE9EAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 20 Dec 2021 09:27:33 +0000
Subject: Re: [PATCHv2] nvme: add 'iopolicy' module parameter
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20211217150222.142014-1-hare@suse.de>
 <20211217180358.6j65izoebwk3raea@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <140eedb9-1c14-1bce-f2bc-0b2523320813@suse.de>
Date: Mon, 20 Dec 2021 10:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211217180358.6j65izoebwk3raea@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_012737_666280_5C5B082B 
X-CRM114-Status: GOOD (  14.23  )
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

On 12/17/21 7:03 PM, Daniel Wagner wrote:
> On Fri, Dec 17, 2021 at 04:02:22PM +0100, Hannes Reinecke wrote:
>> +static int iopolicy = NVME_IOPOLICY_NUMA;
>> +module_param(iopolicy, int, 0444);
>> +MODULE_PARM_DESC(iopolicy,
>> +	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");
>> +
>> +void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>> +{
>> +	subsys->iopolicy = iopolicy;
> 
> Wouldn't make sense to check if iopolicy has a valid value too?
> 
At this time it doesn't matter, as the only values we're checking of are 
'0' or '1' (or, rather, any non-zero value).
But yeah, one probably should check here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

