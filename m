Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF39AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLfW6lGiOtwBq2djIi4vTnw4/MC9YXqLr2n3sSRYuYI=; b=IT8v26tdxHgAnlef6PsR8lxIZs
	euNySIy6BBlIVugkigecQQ+TG6Z2j7E7Ua2OfX6d7bSrD1qVoDG+q9lLMyu66y80IDsnUObYQ+3Ro
	5GCCLu5+x7hR6n5vuiYIrNecAeGjyKze/iZr9XW0+JcbhMFHNMoT0R/2sK5rf9bAqmOtrdM1I1nwJ
	84y7iDMVCp0J92yS1hg2m4A2UVHn7v89u4O68mV6LtqQNoJj/ar4maP6Qa63IhMbm0/+8iyTK0CwR
	x6JaYhQohika/qtZqOpghW0sgzfGYS0Lw2Fi+r2l4sedOrvO01bAmdJ66h7D0EZ/HXgmL4m1ibSxC
	oXgCmwoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgra-008K6S-UI; Mon, 13 Dec 2021 08:39:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgrX-008K61-FR
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 08:39:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 918A6210F4;
 Mon, 13 Dec 2021 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639384749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLfW6lGiOtwBq2djIi4vTnw4/MC9YXqLr2n3sSRYuYI=;
 b=g8XmEa89Uq49lRVexQX/lR7Y+zeYUoR8y/KWB7HXnKuvtzfLlww5zHWBS2BXbnh9uayBql
 0zkb2GxyFC9a5fqdVGsnP08idqoiL0qKRznUHnTuRhv7xyu/rx8dcJWZ3RJP5Q9gEdhGTP
 6HejGoOVmF77pWpGLlFDjOniZuSjMH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639384749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLfW6lGiOtwBq2djIi4vTnw4/MC9YXqLr2n3sSRYuYI=;
 b=Qs9GiEQV9txPS7o/W4pOam7G4edD1nwczT469ijLe0nsmdgdVdfzW4SHxkXf6ykrQM8Qmx
 xVdeZc6DaCySNBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7329313BB2;
 Mon, 13 Dec 2021 08:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FXt6G60Gt2EnDQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 13 Dec 2021 08:39:09 +0000
Subject: Re: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Martin Belanger <martin.belanger@dell.com>, Christoph Hellwig <hch@lst.de>
References: <20211207135549.100950-1-hare@suse.de>
 <6ba69fc7-d2cf-664d-5289-89ff932b1539@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fe706681-4897-6cc7-3595-668fe824a1ed@suse.de>
Date: Mon, 13 Dec 2021 09:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6ba69fc7-d2cf-664d-5289-89ff932b1539@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_003911_687562_9D9580C5 
X-CRM114-Status: GOOD (  22.04  )
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

On 12/13/21 9:06 AM, Chaitanya Kulkarni wrote:
> On 12/7/21 5:55 AM, Hannes Reinecke wrote:
>> Currently applications have a hard time figuring out which
>> nvme-over-fabrics arguments are supported for any given kernel;
>> the ioctl will return an error code on failure, and the application
>> has to guess whether this was due to an invalid argument or due
>> to a connection or controller error.
>> With this patch applications can read a list of supported
>> arguments by simply reading from /dev/nvme-fabrics, allowing
>> them to validate the connection string.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>    drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++++-
>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 282d54117e0a..7ae041e2b3fb 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -1069,6 +1069,26 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
>>    	return ret ? ret : count;
>>    }
>>    
>> +static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
>> +{
>> +	const struct match_token *tok;
>> +	int idx;
>> +
>> +	/*
>> +	 * Add dummy entries for instance and cntlid to
>> +	 * signal an invalid/non-existing controller
>> +	 */
>> +	seq_puts(seq_file, "instance=-1,cntlid=-1");
>> +	for (idx = 0; idx < ARRAY_SIZE(opt_tokens); idx++) {
>> +		tok = &opt_tokens[idx];
>> +		if (tok->token == NVMF_OPT_ERR)
>> +			continue;
>> +		seq_puts(seq_file, ",");
> 
> Can we use "\n" instead of "," ?
> with that change it looks :-
> 
> instance=-1,cntlid=-1
> transport=%s
> traddr=%s
> trsvcid=%s
> nqn=%s
> queue_size=%d
> nr_io_queues=%d
> reconnect_delay=%d
> ctrl_loss_tmo=%d
> keep_alive_tmo=%d
> hostnqn=%s
> host_traddr=%s
> host_iface=%s
> hostid=%s
> duplicate_connect
> disable_sqflow
> hdr_digest
> data_digest
> nr_write_queues=%d
> nr_poll_queues=%d
> tos=%d
> fast_io_fail_tmo=%d
> discovery
> 
The ',' format is being used for a successful connect, so I'd rather 
stay with that to make parsing easier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

