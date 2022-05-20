Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891C4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dfNLPWPCb8bdGAFCCe0pYlhhUib0xjakex5hlXvt6aY=; b=AV8Tcu+fxlzoExjCFvH86GIkKa
	0gikIiBIZvu6MSHLqpv0cmwJI5gZEltj4/+8TJShFXOOpQg76XPhVL9OjGncccu+tJoVDSYzXvtnd
	JNYsd8PqI1h7ExUMAMiPFlZy9rjUJANvWW26y6A3YRLsPez4zqupYHK2ufCP5noULYmv9fGWwCJ9K
	RpOAivrs8oEJA83UGg2F01W/WLjwPnlryT7D3tlPw1X5C7vLoyd6/NAnJ3DgVlQxNU1cmCqNpMLuK
	XKZDwNyu08lviyKQN2JD4fkZzV3IdJCDzKsb/GngffJSQMPDSOv4/Q2yOU2eSdTUhwj+jkPE8iEo8
	R2iB+itA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzQQ-00Bkjk-1I; Fri, 20 May 2022 10:00:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzQM-00BkiN-LN
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:00:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4A6A21C6C;
 Fri, 20 May 2022 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653040796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfNLPWPCb8bdGAFCCe0pYlhhUib0xjakex5hlXvt6aY=;
 b=ipTIpdrQDQ5znOVlaKWu25Y0EPzN8DFaP5CQ01OG4aVy3mbDEPWGFSTjWZsUBtx0gqUU7P
 HzUHyqBLUoNwdgmZ8sOufVcWYfnPv7QPGw2bOyrLoXoozzUfWV2Qv61IHphypnUSit/217
 id+T1/O1y6qNLGB10kQZPlSli6RwHFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653040796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfNLPWPCb8bdGAFCCe0pYlhhUib0xjakex5hlXvt6aY=;
 b=tDqJNrxHO4JLneLOgHByTeOliQob1wUxk/tdXeiNWL2fCop74SONUjX357oHJWG+hMUpaa
 TI7B2JnshnjCeTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CB8A13AF4;
 Fri, 20 May 2022 09:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QYGnIJxmh2JsfQAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 20 May 2022 09:59:56 +0000
Message-ID: <86bde5aa-aa48-3aa8-f47e-6f2e7ab1ac7a@suse.de>
Date: Fri, 20 May 2022 11:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-4-hare@suse.de>
 <6c685c87-519e-68a1-bce8-8ac69929adb7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6c685c87-519e-68a1-bce8-8ac69929adb7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_025958_903774_883C026E 
X-CRM114-Status: GOOD (  16.14  )
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

On 5/20/22 11:19, Sagi Grimberg wrote:
> 
>> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
>> large amounts of requests.
>>
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 606565a4c708..87d760dfa3a9 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -308,11 +308,12 @@ static inline void nvme_tcp_advance_req(struct 
>> nvme_tcp_request *req,
>>   static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>>   {
>>       int ret;
>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>       /* drain the send queue as much as we can... */
>>       do {
>>           ret = nvme_tcp_try_send(queue);
>> -    } while (ret > 0);
>> +    } while (ret > 0 || !time_after(jiffies, deadline));
> 
> Umm, this will stay here a deadline period even if we don't have
> anything to send?

Ah. Yeah, maybe. We can change it to '&&', which should solve it.
(I think)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

