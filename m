Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC8CC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ra6HRx10KH3OuXXKhjRvnQ0Xf+TI0fkuDWv4rdUeJyU=; b=lYePHQ0pG8wPptuqP0EIpNOZd9
	dJQDolubEL41IFDRohS0D1q2Bpk2jpExbNq5ImJzg3rD/dr/oIZUa+GAHirIsMvuqLNYmn62NrZlW
	CWd22my7hy4fQ4QXGt1IAmfVP+C8P4jXVMQCmN0XNjZ/nIRvVqBEpNPkWq/zsZhb3ZFcI3LioTif9
	r8RwrtO4KyqMPnYzvOL91hVdtG/VDlGBjj0wfRuI3MDfuedr18e+f7NynY9kr8ghYp6OElfsAfupK
	UHvupKzKIFu5ocHwT3eeMTiGzKr4N7yvOTo4CE1xKOXT8MYSMlbxMsGp3dEMTDOLV8El9tdwOEdSo
	lUoaUnrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riZ4M-000000094w0-2sBk;
	Fri, 08 Mar 2024 12:11:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riZ4H-000000094su-1W8v
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 12:11:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF8B520FA1;
	Fri,  8 Mar 2024 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709899863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra6HRx10KH3OuXXKhjRvnQ0Xf+TI0fkuDWv4rdUeJyU=;
	b=OmE28UyMIf1ns8h7R2jyTkZ6y45vvcTyprIEpDwkhcQaigwqN9kXEvq7XnlWV+dtuwn48x
	U3Y9hxHiRyMoTmNRs+naWe7HAyNp4chYT7gUw8hp1Q/+pxEZGj4asSNFb4b6XgMCWMFG8a
	rUyhybE0fcln1t1MwlSC64866af4J00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709899863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra6HRx10KH3OuXXKhjRvnQ0Xf+TI0fkuDWv4rdUeJyU=;
	b=nURl1D5UG4CkD02zyVSa4S+fK0ti8A0q2RnYrRz/U/Vtla8oAfKn29lLABhlMQDbsGRZFr
	gV7axfDQMrTXZVBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709899863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra6HRx10KH3OuXXKhjRvnQ0Xf+TI0fkuDWv4rdUeJyU=;
	b=OmE28UyMIf1ns8h7R2jyTkZ6y45vvcTyprIEpDwkhcQaigwqN9kXEvq7XnlWV+dtuwn48x
	U3Y9hxHiRyMoTmNRs+naWe7HAyNp4chYT7gUw8hp1Q/+pxEZGj4asSNFb4b6XgMCWMFG8a
	rUyhybE0fcln1t1MwlSC64866af4J00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709899863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra6HRx10KH3OuXXKhjRvnQ0Xf+TI0fkuDWv4rdUeJyU=;
	b=nURl1D5UG4CkD02zyVSa4S+fK0ti8A0q2RnYrRz/U/Vtla8oAfKn29lLABhlMQDbsGRZFr
	gV7axfDQMrTXZVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EEDA13310;
	Fri,  8 Mar 2024 12:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g4+IHlcA62VQCgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 08 Mar 2024 12:11:03 +0000
Message-ID: <a566dfe2-0664-4734-8a72-89c053a603e6@suse.de>
Date: Fri, 8 Mar 2024 13:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226122449.46976-1-hare@kernel.org>
 <1aee2876-15dd-48dd-a6b1-76ac1ebfc682@grimberg.me>
 <bf86f3ec-738f-49e5-ad54-c817f9d9542d@suse.de>
 <e7d8627d-d6a2-429c-bf1d-6e995c0ca5a5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e7d8627d-d6a2-429c-bf1d-6e995c0ca5a5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OmE28UyM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nURl1D5U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: CF8B520FA1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_041117_675978_CD276E63 
X-CRM114-Status: GOOD (  20.38  )
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

On 3/8/24 11:42, Sagi Grimberg wrote:
> 
> 
> On 07/03/2024 12:47, Hannes Reinecke wrote:
>> On 3/7/24 10:45, Sagi Grimberg wrote:
>>>
>>>
>>> On 26/02/2024 14:24, Hannes Reinecke wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> If the user specifies a specific TLS key via the '--tls_key'
>>>> option to nvme-cli we should be adding a ';static' suffix
>>>> to the 'tls_key' sysfs attribute to signal that this is a
>>>> user-specific key, and not one auto-selected during TLS
>>>> protocol negotiation.
>>>
>>> Static is not the best wording. Doesn't the user already
>>> know what it provided? How is this indication useful?
>>
>> What I'm trying to achieve here is to differentiate between
>>
>> nvme connect --tls
>>
>> and
>>
>> nvme connect --tls_key=<key_id>
>>
>> both calls will result in key serial number in the
>> 'tls_key' attribute, so if we try to generate the json
>> configuration file from an existing connection we
>> have no idea which of the arguments the admin has
>> used. Problem is that first invocation will auto-select
>> the TLS key, and hence we can do a key rotation.
>> The second invocation will always refer to a specific
>> key, and hence we cannot do a key rotation.
>>
>> So we'll need an additional setting allowing us
>> to differentate here.
>>
>> I do agree that adding a field to an existing
>> attribute is probably suboptimal, so I guess
>> I'll retract this patch and send another introducing
>> a new sysfs attribute ('tls_provisioning' ?)
> 
> What are the outputs for this new attributes?
> 
I've just sent a patch for this.

>>
>> The alternative would be to add a new attribute for
>> the keyring (ie introduce a 'tls_keyring' attribute).
>> That would be empty for a pre-configured key (as we
>> are looking up the key by serial, and don't care on
>> which keyring the key is in), and contain the keyring
>> name otherwise.
>>
>> Hmm. I guess I like this better, as then we would
>> also be able to display the 'keyring' setting which
>> currently is also not present in sysfs.
> 
> Agree that displaying the keyring in sysfs is useful to
> have.

Indeed.

Cheers,

Hannes


