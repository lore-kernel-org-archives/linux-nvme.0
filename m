Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ABC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5LqApwze1R8wMwIdtF8VNqJBIOuuKEgmNwcU6k6WQ4=; b=dH4/tF9aMFjfRtAkZ+DBpJQbUl
	pkBQOR8cRY5fFitAgjahlDS1Wm0oYXOgoLivyHI79x7xY1N8dMZOJpXgawPN02PRQcL/1pb4u3yQA
	2p4EN7JWZC+F/Wn3ux68xg3r9NQ0ea8pkHI469UqXxvoX9OgvLWXYGYsRBbzl107oD0/4eccWlFSV
	IcHhXBS/ibkYJDNblz5C3g+kaPZP8scCHUClZHri+Zdl0lSw5Zs2cTM7Lyk6kl6NcXpe6OUWJRqR6
	FQtl3ueEpbDWW5IcC/IrKW7cNuOVm9R3QAnOkT81mSklJM97lMozez/NVozYxgfsJx9S8TBlkhs6r
	rft7073w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc8T-00HDwS-O1; Tue, 05 Apr 2022 05:53:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc8R-00HDvg-E0
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:53:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E461A210E1;
 Tue,  5 Apr 2022 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649138023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5LqApwze1R8wMwIdtF8VNqJBIOuuKEgmNwcU6k6WQ4=;
 b=MS4RovgrML9O6LRN24MVPsx3xKU7k4Nm8uP2Rj+SxsYJsFB1bsM9OGSQa4r1I5w8To54n3
 tk9NgeqnUw08G+8enojtaPRhsuKqvzWusOxRERzmlHRDnO90wT0rjxhZgOMbUQ0eiexJGN
 jyL04xZLR8TpUSb2FzV1Zh+rcYx8TlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649138023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5LqApwze1R8wMwIdtF8VNqJBIOuuKEgmNwcU6k6WQ4=;
 b=AatTz9KvTxy8WVAgaNtEB8PfxnxU3lNViunplUQXMbObJrehER5XL25SXp+SWdIvLUrO19
 WdxaMZo9UIIkAzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA73013216;
 Tue,  5 Apr 2022 05:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1vHiL2fZS2JCSgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 05:53:43 +0000
Message-ID: <1c44e4aa-f966-5767-a147-a7f24f6753ee@suse.de>
Date: Tue, 5 Apr 2022 07:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] nvmet: check for subsystem type in
 nvmet_find_get_subsys()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-2-hare@suse.de> <20220405054536.GB23466@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405054536.GB23466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_225347_656404_11A5B44E 
X-CRM114-Status: GOOD (  24.68  )
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

On 4/5/22 07:45, Christoph Hellwig wrote:
> 
> 
> On Thu, Mar 17, 2022 at 03:26:32PM +0100, Hannes Reinecke wrote:
>> When looking for a subsystem we have two ways of finding the
>> subsystem: either looking for the subsystem NQN itself, or check
>> the type of the subsystem when looking for a discovery controller.
>> This patch implements this check, and also moves the check for
>> the static discovery controller to the end such that we can
>> return unique discovery controllers.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/core.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index b0dc6230d1b9..83eba511d098 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -1508,12 +1508,6 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>>   	if (!port)
>>   		return NULL;
>>   
>> -	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
>> -		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
>> -			return NULL;
>> -		return nvmet_disc_subsys;
>> -	}
>> -
>>   	down_read(&nvmet_config_sem);
>>   	list_for_each_entry(p, &port->subsystems, entry) {
>>   		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
>> @@ -1523,8 +1517,22 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>>   			up_read(&nvmet_config_sem);
>>   			return p->subsys;
>>   		}
>> +		if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) &&
>> +		    nvmet_is_disc_subsys(p->subsys)) {
> 
> I don't get this.  The strcmp is on the passed in subqnen that we are
> looking for.  So with this patch we now do the fairly expensive string
> compare for every subsystem in the loop, and the just retuns the first
> discovery subsystems when we look for the well known discovery
> subsystem.  As-is there is only one, so this is pointless.  If we add
> discovery subsystems with different names (as I assume the later patches
> do), this changes beahvior in a rather unexpected way.

Will have to check; might be that this is a left-over from the previous 
attempt of handling discovery subsystems just like any other subsystem.

However, this is just part of a larger patchset to support unique 
discovery controller NQNs. And the overarching question here is:

Do we want to support unique discovery controller NQNs in nvmet?

Previously there was a rather strict policy of implementing only the 
bare necessities in nvmet, and unique discovery controller NQNs is 
arguably not a necessary thing.
So the whole discussion gets pretty pointless if we decide _not_ to 
support it after all.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

