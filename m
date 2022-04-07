Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AykFZR8kRKM1HU37Ctvezreckz8shrbuSAQWNbTVcDM=; b=QOsOjsQniHKcIUBpCLeZfMT16e
	AHfZ0QDsfdJ5atJt8luRLfVbi7bTlvFf5J0qAC/DCFEzfkzpdbB1nw6Uo1EJSIwHTdEbRmVGxUrXc
	9ZAMrJdT5CnRwmzPSPwY9Wwk+W7TLERtFJ+yu/aNOCXhQtAeHflsWrrXjzhRA/nRznyL8wcfwWOlD
	RaOttD1CcHDt880bSt3tIiKn067gT3gxXuOWy/CVEYn+fhaZmcZWcHBx570uveGXcxAwqiJZqLUzD
	VbWqwpM1sFutYbSuTg8XnXSLgfQUpR3KdrERkaCwggQdl4MIdcDVLSRBUdIPNpNCakgjTpwNTjXl3
	ocYYs2+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVqw-00DLHh-0t; Thu, 07 Apr 2022 17:23:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncVqt-00DLFw-0A
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 17:23:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8906D212CA;
 Thu,  7 Apr 2022 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649352201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AykFZR8kRKM1HU37Ctvezreckz8shrbuSAQWNbTVcDM=;
 b=Y27QYER8/+mYSPPMLh59MfWVAw9qH+1QvPTYzdxE5baa8IU0q2RkIoiFMuB6h/dhX4Il45
 JYWOmGfmLjkpIpBkWAg/1hh2of/DpdvnWV6EsUwkSTOokbrCVJOJ2tuRRqjt5VOLy3FRpV
 aQLxMLgSOWUX0QSe+xAaHgYbIJsmWo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649352201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AykFZR8kRKM1HU37Ctvezreckz8shrbuSAQWNbTVcDM=;
 b=l4m7PyyhHEpODNxjry5Ei1/uBFOi654e4+rk20C4RKs30TMHboe3dCWRiAkJ3jd/9OICrd
 aSbF1MXQVt7u8+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60B7E13485;
 Thu,  7 Apr 2022 17:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T3/aFAkeT2JrJQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 17:23:21 +0000
Message-ID: <8f5bac0c-a80d-9ef5-76e7-9af9938ccd2c@suse.de>
Date: Thu, 7 Apr 2022 19:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-3-hare@suse.de> <20220407154924.GD15988@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220407154924.GD15988@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_102323_224224_4A5D1D88 
X-CRM114-Status: GOOD (  25.13  )
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

On 4/7/22 17:49, Christoph Hellwig wrote:
> On Thu, Apr 07, 2022 at 12:48:07PM +0200, Hannes Reinecke wrote:
>> Add a 'disc_subsys' pointer to each port to specify which discovery
>> subsystem to use.
>> The pointer is set when a discovery subsystem is linked into a port,
>> and reset to the original, built-in discovery subsystem if that link
>> is removed.
> 
> This doesn't really make much sense stanadlone without the next
> patch, so I'd be tempted to say they should be merged.
> 

Sure. I just didn't want to make the patches too complicated initially.

>>   	down_write(&nvmet_config_sem);
>> +	if (subsys->type == NVME_NQN_CURR &&
>> +	    port->disc_subsys != nvmet_disc_subsys) {
> 
> Curious, would NULL not be a better encoding for the default discovery
> subsystem?
> 
Hmm. Sure, could do.

>> +++ b/drivers/nvme/target/core.c
>> @@ -1496,9 +1496,9 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>>   		return NULL;
>>   
>>   	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
>> -		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
>> -			return NULL;
>> -		return nvmet_disc_subsys;
>> +		if (!kref_get_unless_zero(&port->disc_subsys->ref))
>> +				return NULL;
>> +		return port->disc_subsys;
> 
> This has an extra tab indent.  But: should we even redirect from the
> well known discovery NQN for a configured discovery subsystem here?
> If yes at least this needs a big fat comment explaining why we do it.
> 
Yes. This is mandated by the spec
(section 3.1.2.3 Discovery Controller):
If the Discovery subsystem provides a unique NQN, then that Discovery 
subsystem shall support both the unique subsystem NQN and the well-known 
discovery service NQN.

Will be adding a comment.

>> +	if (req->port->disc_subsys == nvmet_disc_subsys)
>> +		entries++;
> 
>> +	if (req->port->disc_subsys == nvmet_disc_subsys) {
>> +		nvmet_format_discovery_entry(hdr, req->port,
>> +				nvmet_disc_subsys->subsysnqn,
>> +				traddr, NVME_NQN_CURR, numrec);
>> +		numrec++;
>> +	}
> 
> Why don't we report the current discovery subsystem for if it isn't
> the well known one?

Thing is, unique discovery subsytems are just 'normal' subsystems; the 
only thing which is different is the type.
The static discovery subsystem OTOH is special as it's not linked to the 
normal subsystem list and consequently doesn't show up in the 
port->subsystem list.
Hence the extra entry here.

Linking it into the port->subsystems list seemed overly complicated for 
no real gain.

At the same time using the ->disc_subsys link directly here would have 
meant that I have to filter out that subsystem in the 
list_for_each_loop(); also an awkward choice.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

