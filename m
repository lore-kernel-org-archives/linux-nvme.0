Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B6ACE7AEB
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQ3NZAebxsbDuoB9UZXppNfpQjJtliPm/UHYRTVskkQ=; b=et6KQk5XnkBxJp5PKs7voncgP9
	Rm7xst0gibKlSl7Eij/l0ytvphj6qNKhGWdEs5XO3PD/1xTF0hrreyiT/utxytWghp50CYGPyGipT
	4JLPEks5sMvj7nziCYplPvkamgOXfDmuT2SE64jc3DoMLbBfTJKhVVat/3cDTI7UmYvnmOrgW+Jug
	P9fhfnpOmjFGvLrNtpQhxSNzuDwb5rmwB+M4XGecKgVy0zpEBZsucvTSr/GPKVIsYm93ZiF/Oz3GU
	tENXxhtm2jN7qIEtqOsxbPWoDL70DP7MRlgU/HAeJbLnBM5bxhnbm4ScmYJEisZIYPBYt0dNa4eaM
	PTAn+NfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUYp-0000000BO1K-2Gqr;
	Fri, 06 Sep 2024 08:43:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUOa-0000000BL6F-3B6g
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 08:32:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FC621F8A4;
	Fri,  6 Sep 2024 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725611563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ3NZAebxsbDuoB9UZXppNfpQjJtliPm/UHYRTVskkQ=;
	b=F5zeNiH8yM/r5r5SBOjj7cmkgLYDzkhXqwgNqxZ1TaOUCHBnX7xX6S1XSCFwlXA+cGiA3j
	yodjFk8hPjFgHRgO8d63tcJUIjG1SJ08es1FHL/aFcymX4p/MXM4f+pOUJIs1C52mTarNN
	AHae5T0+T3es10cvbA8V0qwB+3qTrDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725611563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ3NZAebxsbDuoB9UZXppNfpQjJtliPm/UHYRTVskkQ=;
	b=4+iv1sa7d9lMPy7qc1Jmg/PyBm0RpVFCs1gS+yX6V0yt81cexzYbk1FbNxEFcUymIgvWxN
	4unCzyO4+zQFfoCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F5zeNiH8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4+iv1sa7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725611563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ3NZAebxsbDuoB9UZXppNfpQjJtliPm/UHYRTVskkQ=;
	b=F5zeNiH8yM/r5r5SBOjj7cmkgLYDzkhXqwgNqxZ1TaOUCHBnX7xX6S1XSCFwlXA+cGiA3j
	yodjFk8hPjFgHRgO8d63tcJUIjG1SJ08es1FHL/aFcymX4p/MXM4f+pOUJIs1C52mTarNN
	AHae5T0+T3es10cvbA8V0qwB+3qTrDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725611563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ3NZAebxsbDuoB9UZXppNfpQjJtliPm/UHYRTVskkQ=;
	b=4+iv1sa7d9lMPy7qc1Jmg/PyBm0RpVFCs1gS+yX6V0yt81cexzYbk1FbNxEFcUymIgvWxN
	4unCzyO4+zQFfoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 039EF136A8;
	Fri,  6 Sep 2024 08:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uGpyACu+2mZDSAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Sep 2024 08:32:43 +0000
Message-ID: <c40aceda-f64b-4df2-8030-0a6eb2a2ebdc@suse.de>
Date: Fri, 6 Sep 2024 10:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: set 'failfast_expired' in
 nvme_remove_namespaces()
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906071828.125614-1-hare@kernel.org>
 <20240906071828.125614-5-hare@kernel.org>
 <bb65b34d-9f30-4799-b34e-9665367b8aa0@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bb65b34d-9f30-4799-b34e-9665367b8aa0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FC621F8A4
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_013244_988646_FBD3877E 
X-CRM114-Status: GOOD (  23.06  )
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

On 9/6/24 09:38, Sagi Grimberg wrote:
> Please describe what the patch fixes in the title, not what it does.
> 
> 
Yeah, will do.

> On 06/09/2024 10:18, Hannes Reinecke wrote:
>> nvme_remove_namespaces() is only called when the controller is
>> being removed. If there is a scan process still pending and
>> the I/O from that process cannot make progress (eg if all paths
>> are in ANA state 'inaccessible') we cannot disconnect the
>> controller as the 'nvme disconnect' process will hang in
>> flush_work(&ctrl->scan_work).
> 
> Please include the hang process stack.
> 
Ok.

>>
>> This patch sets the 'failfast_expired' bit for the controller
>> to cause all pending I/O to be failed, and the disconnect process
>> to complete.
> 
> How did you reproduce it? trigger namespace scanning and disconnect-all
> in a loop? Can we get a blktest for it?
> 
The script is quite easy:

for i in $(seq 0 8); do
         for j in $(seq 1 6 | shuf); do
                 ns="${CONFIGFS}/subsystems/${NQN}/namespaces/${j}"
                 grpid=$(( ((($j / 3) + $i) % 3) + 1 ))
                 echo "$i: enable $j (grpid $grpid)"
                 echo $grpid > $ns/ana_grpid
                 uuidgen > $ns/device_uuid
                 echo 1 > $ns/enable
         done
         ls /sys/block | grep -v ram
         for j in $(seq 1 6 | shuf); do
                 echo "$i: disable $j"
                 ns="${CONFIGFS}/subsystems/${NQN}/namespaces/${j}"
                 echo 0 > $ns/enable
         done
         ls /sys/block | grep -v ram
done

but in order to recreate that you'd need several paths, each with its
own ANA group id, and at least one in 'inaccessible'.
On my testing I've been using 6 paths, four 'inaccessible', one 
'optimized', and one 'non-optimized'.
And having one namespace for each ANA group ID.

I'm planning to do a blktest for it, but that requires to first 
implement ANA support there.

>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 651073280f6f..b968b672dcf8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl 
>> *ctrl)
>>        */
>>       nvme_mpath_clear_ctrl_paths(ctrl);
>> +    /*
>> +     * Mark the controller as 'failfast' to ensure all pending I/O
>> +     * is killed.
>> +     */
>> +    set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> 
> What about nvme_stop_failfast_work() ?
> 
That is already done; nvme_remove_namespaces() is called after 
nvme_stop_ctrl() which already called nvme_stop_failfast_work().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


