Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB4C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 07:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KmWtAhtmbCIs/aY4wZ4g+1Rff83yXWU7sfeWPnJCag=; b=OpoZFI55xp4w96dWCq3PFNIJgu
	qsscGmNYblpnohgdo8RPGVzFeV2uMluDsbYJyHsw983AVumiyeSnetNgGGJjuQlRmXeHio8ZnN6Zo
	G/4U7J9TS/o54AMVGS68TJPeJfpK6zGN0jhKWY4l+vkmc1Fly996zRhvmvwRFvw18pFVN7p10PqNX
	QvYTL/iK76OrLMzmXhSMBfoLgZIiKVdm9XB2oGQUHgmmWhUc2NPVIgz2a1gFmMVIBD5pXigbSY59H
	knOoJiBA0xEkZaF9IuVWEnDVzG14ZqlknzrnFlRrHxZRypFtZWLNgjiipX98H/saxurauPcvYqq2A
	G043vorw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9eyp-00000008g7R-2XRq;
	Tue, 29 Apr 2025 07:02:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9eye-00000008g5e-2JYG
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 07:02:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1521F7A4;
	Tue, 29 Apr 2025 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745910114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KmWtAhtmbCIs/aY4wZ4g+1Rff83yXWU7sfeWPnJCag=;
	b=h6FkDf4UDhDNikuSXGZRdzhGurtIyAEvr86Ijw8SIOG5+DH5WUcAcqXuYs0Ucx6sMFZxcd
	O01maB2TZU3tONr8IpKFu6p98pAXXoDszgBfgMkc8yrlk+nL+WOSA3I6IigYpSARvBmVYi
	CNL4UYT+sRmu+X/RESH4YFEJeSZLuWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745910114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KmWtAhtmbCIs/aY4wZ4g+1Rff83yXWU7sfeWPnJCag=;
	b=LaUClwKU5E1RGuIX9N/GsaPX6j0BY4Jbf0KLw8gKBy+QBcQ/7sLbJyrrqDLZ031Y8KflvY
	IYWjJ2dgPWSUFZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745910114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KmWtAhtmbCIs/aY4wZ4g+1Rff83yXWU7sfeWPnJCag=;
	b=h6FkDf4UDhDNikuSXGZRdzhGurtIyAEvr86Ijw8SIOG5+DH5WUcAcqXuYs0Ucx6sMFZxcd
	O01maB2TZU3tONr8IpKFu6p98pAXXoDszgBfgMkc8yrlk+nL+WOSA3I6IigYpSARvBmVYi
	CNL4UYT+sRmu+X/RESH4YFEJeSZLuWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745910114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KmWtAhtmbCIs/aY4wZ4g+1Rff83yXWU7sfeWPnJCag=;
	b=LaUClwKU5E1RGuIX9N/GsaPX6j0BY4Jbf0KLw8gKBy+QBcQ/7sLbJyrrqDLZ031Y8KflvY
	IYWjJ2dgPWSUFZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F691340C;
	Tue, 29 Apr 2025 07:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vc3gNWF5EGh4aQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 07:01:53 +0000
Message-ID: <10ba7fa9-15e9-48b9-a8ac-e7c3982a211c@suse.de>
Date: Tue, 29 Apr 2025 09:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
 <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
 <a33c691a-d4f6-4cd8-96e0-17e2e4078d37@linux.ibm.com>
 <89f3680d-442e-47cc-822e-f00f474dd597@suse.de>
 <cdbd9209-420e-4c1b-a0f4-30b2c7e9cfb3@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cdbd9209-420e-4c1b-a0f4-30b2c7e9cfb3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_000201_015272_2B349E33 
X-CRM114-Status: GOOD (  19.92  )
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

On 4/29/25 08:24, Nilay Shroff wrote:
> 
> 
> On 4/29/25 11:19 AM, Hannes Reinecke wrote:
>> On 4/28/25 09:39, Nilay Shroff wrote:
>>>
>>>
>>> On 4/28/25 12:27 PM, Hannes Reinecke wrote:
>>>> On 4/25/25 12:33, Nilay Shroff wrote:
>>>>> Currently, a multipath head disk node is not created for single-ported
>>>>> NVMe adapters or private namespaces. However, creating a head node in
>>>>> these cases can help transparently handle transient PCIe link failures.
>>>>> Without a head node, features like delayed removal cannot be leveraged,
>>>>> making it difficult to tolerate such link failures. To address this,
>>>>> this commit introduces nvme_core module parameter multipath_head_always.
>>>>>
>>>>> When this param is set to true, it forces the creation of a multipath
>>>>> head node regardless NVMe disk or namespace type. So this option allows
>>>>> the use of delayed removal of head node functionality even for single-
>>>>> ported NVMe disks and private namespaces and thus helps transparently
>>>>> handling transient PCIe link failures.
>>>>>
>>>>> By default multipath_head_always is set to false, thus preserving the
>>>>> existing behavior. Setting it to true enables improved fault tolerance
>>>>> in PCIe setups. Moreover, please note that enabling this option would
>>>>> also implicitly enable nvme_core.multipath.
>>>>>
>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>> ---
>>>>>     drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>>>>>     1 file changed, 63 insertions(+), 7 deletions(-)
>>>>>
>>>> I really would model this according to dm-multipath where we have the
>>>> 'fail_if_no_path' flag.
>>>> This can be set for PCIe devices to retain the current behaviour
>>>> (which we need for things like 'md' on top of NVMe) whenever the
>>>> this flag is set.
>>>>
>>> Okay so you meant that when sysfs attribute "delayed_removal_secs"
>>> under head disk node is _NOT_ configured (or delayed_removal_secs
>>> is set to zero) we have internal flag "fail_if_no_path" is set to
>>> true. However in other case when "delayed_removal_secs" is set to
>>> a non-zero value we set "fail_if_no_path" to false. Is that correct?
>>>
>> Don't make it overly complicated.
>> 'fail_if_no_path' (and the inverse 'queue_if_no_path') can both be
>> mapped onto delayed_removal_secs; if the value is '0' then the head
>> disk is immediately removed (the 'fail_if_no_path' case), and if it's
>> -1 it is never removed (the 'queue_if_no_path' case).
>>
> Yes if the value of delayed_removal_secs is 0 then the head is immediately
> removed, however if value of delayed_removal_secs is anything but zero
> (i.e. greater than zero as delayed_removal_secs is unsigned) then head
> is removed only after delayed_removal_secs is elapsed and hence disk
> couldn't recover from transient link failure. We never pin head node
> indefinitely.
> 
>> Question, though: How does it interact with the existing 'ctrl_loss_tmo'? Both describe essentially the same situation...
>>
> The delayed_removal_secs is modeled for NVMe PCIe adapter. So it really
> doesn't interact or interfere with ctrl_loss_tmo which is fabric controller
> option.
> 
Not so sure here.
You _could_ expand the scope for ctrl_loss_tmo to PCI, too;
as most PCI devices will only ever have one controller 'ctrl_loss_tmo'
will be identical to 'delayed_removal_secs'.

So I guess my question is: is there a value for fabrics to control
the lifetime of struct ns_head independent on the lifetime of the
controller?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

