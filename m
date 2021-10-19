Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6E561074
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF6E561074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvzBB0j2Zsgr9oixxouqjV2m43lB4I0+VdOoVpHzHwI=; b=QW1yEq9sQLaIQRaAbfFUTbMqHl
	E3VstNMFZbEJLMv6QFK5OzXsn+dmvYfXX+ZZd8goIFvLmsFLLkcHhEy06mdk8fDEV13ksWeKATYxp
	00aNxfFzzQ9MmE1K0F/tJ00zcn3B8hTDqQ+01JjTHhdb8TJVudeMGOr0ZbbDqM3n9WAwaEer1qbW2
	J+5gFFdezYyq0R/4v2+A7+Mq1IAFEesa7dMX70L3vg5ctkUiY2Brs4KIUpNIc0aKpbeHih8tFAlRd
	sRDaxkAywg2AFe9ty9uQe3Jj8ef4HjmYprou9Bokqr2qj61/H8vOCDr3VajLuPBMczwDvFjGUIBXq
	lGtfTfEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcpVF-001TNW-9t; Tue, 19 Oct 2021 13:50:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcpVB-001TMc-UV
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:50:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D2331FD85;
 Tue, 19 Oct 2021 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634651400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvzBB0j2Zsgr9oixxouqjV2m43lB4I0+VdOoVpHzHwI=;
 b=HbIn69w9597oj4gbj+oxDYYz8JfYcGWdiErQJp3lkkWtimdHDKeIL6jlMxe0ugBFjXQyE7
 eYUPv9SfQl5NOzALUSuQ1gS0hw94/kTLCwudkuV/QDHBVLj3pgFZkh5BjMxnYnxqtO+shE
 H3+MdQBTtY/YIrchQ7sC3SKx/JOeeFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634651400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvzBB0j2Zsgr9oixxouqjV2m43lB4I0+VdOoVpHzHwI=;
 b=warXWfBLaZVIDQg7BaqGquEnAv1hstzTLrJzRym19BAyX+DxkI9drhIW0C25ZM8xtUp51R
 wkny3a5dXJMSyJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC1713E73;
 Tue, 19 Oct 2021 13:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jgI1IgjNbmFjPQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 13:50:00 +0000
Subject: Re: [PATCH 1/3] nvmet: switch check for subsystem type
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211018152138.2128-1-hare@suse.de>
 <20211018152138.2128-2-hare@suse.de>
 <78859610-656a-ef43-6a20-d3fc71dab4a2@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <744dd4ce-34e5-1860-3f1d-b12f2ad00820@suse.de>
Date: Tue, 19 Oct 2021 15:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <78859610-656a-ef43-6a20-d3fc71dab4a2@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_065002_165212_A01C55FB 
X-CRM114-Status: GOOD (  16.69  )
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

On 10/19/21 8:37 AM, Chaitanya Kulkarni wrote:
> On 10/18/2021 8:21 AM, Hannes Reinecke wrote:
>> Invert the check for discovery subsystem type to allow for additional
>> discovery subsystem types.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>    drivers/nvme/target/nvmet.h | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index f31dcc4fb1a2..af193423c10b 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -579,7 +579,7 @@ static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
>>    
>>    static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
>>    {
>> -    return subsys->type == NVME_NQN_DISC;
>> +    return subsys->type != NVME_NQN_NVME;
> 
> shouldn't we use switch and make code more readable for allowed
> subsys->type values ? unless there is a reason ..
> 

Well, with this patch we still have only two values; introducing a 
switch for this feels a bit silly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

