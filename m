Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DCCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JW3IMjIhss9WN8n4xMbAYXW9Jp23jxvB/z2nxhvy82s=; b=HmUf8nJyMDGsFfTmUwbl9X84lQ
	HeIg+zTDBIYmke1fI82ZlHZSQjHWeqWnV6ju/JFQ4pZGy+m8yY6laZFeF480OY40SQB5rCu1dH2NM
	UAmxE5r0bnwwe6Gr3uqbuRkx56Fubcu3yJPSscshMVMM0BH0ealGo/jTSgmlwebOiyGTWLYmnbizg
	60GdLuD5GJAT3JMz406h7ZidR0wb0HuDiTSb9xvSE81qS1ZtMoxlaIfBpV46tkNYEJCvl7lPIuDaN
	BiMENU/w6nl3mXyqLlabIPnHiOrXkNH1Yv/7Xe0h05kv/qAjoPf58tX80BRnP55TfDo5pPr8gIHPV
	leutLyeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVtL-00DM9X-Vq; Thu, 07 Apr 2022 17:25:56 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncVtJ-00DM79-Ha
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 17:25:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9B01F85E;
 Thu,  7 Apr 2022 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649352350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW3IMjIhss9WN8n4xMbAYXW9Jp23jxvB/z2nxhvy82s=;
 b=QO3XWlWiNZO2NsrnXiV0bHpx/mYrXcKCfUgBJtPq0/XctgzBtYUvTtxxbkXFcKVd+IL+mt
 /eFermVgK56nwhjQAHUS/Vbl6BeB0hIaghMJMgqFJbjwVJdCNu2P06l08tktO4XxbH0Jxx
 LTVAVDwscUu6mt5JUJ1LOiMuGhCFogY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649352350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW3IMjIhss9WN8n4xMbAYXW9Jp23jxvB/z2nxhvy82s=;
 b=CSauRVkxiunm5wD4OJ0etWlrr5dBXGVkTsJLTXb9SqXMzeLQvmZhBpxM6VzE5VkSEh96QX
 Wl18Til+T2fOMnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BF6813485;
 Thu,  7 Apr 2022 17:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rp6tAJ4eT2JXJgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 17:25:50 +0000
Message-ID: <11a2f28f-63ce-c103-3fef-f80085c03473@suse.de>
Date: Thu, 7 Apr 2022 19:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de> <20220407154127.GB15988@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220407154127.GB15988@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_102553_772483_2C7B0711 
X-CRM114-Status: GOOD (  15.53  )
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

On 4/7/22 17:41, Christoph Hellwig wrote:
> On Thu, Apr 07, 2022 at 12:48:08PM +0200, Hannes Reinecke wrote:
>> +		if (req->port->disc_subsys == nvmet_disc_subsys) {
>> +			/*
>> +			 * Present information about the port to which
>> +			 * the controller is connected.
>> +			 */
>> +			if (r != req->port)
>> +				continue;
>> +		} else {
>> +			/*
>> +			 * If a per-port discovery subsystem is used present
>> +			 * information about all ports into which the
>> +			 * same discovery subsystem is linked.
>> +			 */
>> +			if (ctrl->subsys != r->disc_subsys)
>> +				continue;
>> +		}
> 
> Please factor this logic in a helper given that it is also used
> by discovery_log_entries (and to document the logic a bit better).

Sure, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

