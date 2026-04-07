Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CCCFB519B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 06:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/a8WepvLdEFvtbnI0sQXuAtxaeACvUbuUSSAo+zhbvI=; b=TKQXuy+01XTVpd8c9YLZSKtCKq
	zUvbhqiJe3RKdchcgwam2LcbCTaao4V6C7umDvpELY+cbhsF25/pd/1oWCfBzTi7DJGq9uFQSWdwO
	Gdxt8ZFsA9ipADiZIqGLz/zgCKRC+0r47JBQKiYSLDIfAI7Vw8OYyD3By58dLYNPXVwC2u49BtjL+
	ItmwMnl9HBsgQb320SgswpL6+/bqTfRH+mlaOb+ZOP2cEqAV4678e75LSHWCFA1/s0+i8+npgUhek
	zzgLzN9esW3erwsZUXmdBiLLbpXbi055GRDOnL0UG3dr3QL9aB+HW9ZShlkOGnPwGFkL9AQHkoq8W
	xbrLHDuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zo5-00000005ykt-0x9q;
	Tue, 07 Apr 2026 06:21:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zo2-00000005yjx-0mQF
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 06:20:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3615C4E2EC;
	Tue,  7 Apr 2026 06:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a8WepvLdEFvtbnI0sQXuAtxaeACvUbuUSSAo+zhbvI=;
	b=E1bprPUJC9VXdhj0DqR+9ld7I/0VCKF1k1LMtPnEWMBfNjvD16SMOEQEzHZiRHsTVOH2b2
	ejgFXyU9Dpc/J4+1y7lgQHnNQKIR/Yhc2TG6FxcaDMhpFTxTVw96uZWQJbSfnOv887/z0J
	5l/J9GToinIh9pRxqgUIm6s91cOj72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a8WepvLdEFvtbnI0sQXuAtxaeACvUbuUSSAo+zhbvI=;
	b=cKnVxNXzlRQEwuFy8H5N9WIB+YMxTxYZjCQuKjWnZtOQ1ettmtDZkaBZbucvjTqNRFIHBB
	smHdc0EqNQBlgoBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a8WepvLdEFvtbnI0sQXuAtxaeACvUbuUSSAo+zhbvI=;
	b=E1bprPUJC9VXdhj0DqR+9ld7I/0VCKF1k1LMtPnEWMBfNjvD16SMOEQEzHZiRHsTVOH2b2
	ejgFXyU9Dpc/J4+1y7lgQHnNQKIR/Yhc2TG6FxcaDMhpFTxTVw96uZWQJbSfnOv887/z0J
	5l/J9GToinIh9pRxqgUIm6s91cOj72Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a8WepvLdEFvtbnI0sQXuAtxaeACvUbuUSSAo+zhbvI=;
	b=cKnVxNXzlRQEwuFy8H5N9WIB+YMxTxYZjCQuKjWnZtOQ1ettmtDZkaBZbucvjTqNRFIHBB
	smHdc0EqNQBlgoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CCC74A0B0;
	Tue,  7 Apr 2026 06:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8D/yAUii1GkYEQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 06:20:56 +0000
Message-ID: <9b171c17-7312-4f28-a628-2e136e42ddd1@suse.de>
Date: Tue, 7 Apr 2026 08:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] nvme: parse dhchap keys during option parsing
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-5-hare@kernel.org>
 <20260401-9844eebdfe2fe11cf72e20aa@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260401-9844eebdfe2fe11cf72e20aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_232058_392437_2B5B0404 
X-CRM114-Status: GOOD (  14.12  )
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

On 4/1/26 20:43, Chris Leech wrote:
> On Tue, Mar 17, 2026 at 02:00:59PM +0100, Hannes Reinecke wrote:
>> We really should parse the dhchap keys during option parsing to avoid
>> having to pass around the plain dhchap secret. During options parsing
>> we will create a 'dhchap' key with a random UUID as description, and
>> store the key serial in the 'opts' structure.
>> This simplifies key handling as on every access the key needs to be
>> looked up and checked for validity before accessing the key data.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/auth.c    | 118 +++++++++++++++--------
>>   drivers/nvme/host/fabrics.c |  82 +++++++++++-----
>>   drivers/nvme/host/fabrics.h |   8 +-
>>   drivers/nvme/host/sysfs.c   | 185 ++++++++++++++++++++++++++----------
>>   4 files changed, 275 insertions(+), 118 deletions(-)
>>
> ...
>> @@ -1290,8 +1314,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>   	kfree(opts->subsysnqn);
>>   	kfree(opts->host_traddr);
>>   	kfree(opts->host_iface);
>> -	kfree(opts->dhchap_secret);
>> -	kfree(opts->dhchap_ctrl_secret);
>> +	if (opts->dhchap_key) {
>> +		pr_debug("revoke dhchap host key %08x\n",
>> +			 key_serial(opts->dhchap_key));
>> +		key_revoke(opts->dhchap_key);
>> +		key_put(opts->dhchap_key);
>> +	}
>> +	if (opts->dhchap_ctrl_key) {
>> +		pr_debug("revoke dhchap ctrl key %08x\n",
>> +			 key_serial(opts->dhchap_ctrl_key));
>> +		key_revoke(opts->dhchap_key);
> 
> This is revoking the wrong key, it should be dhchap_ctrl_key.
> 
Indeed. Will fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

