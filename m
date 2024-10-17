Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4CED37483
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVn8z7/ToR7rOOuTwWcYN8melQ1MwHnseulk5wk4p3w=; b=B2dNNghNG0SZ4tIEjsnQHIR5Zd
	GIR2KOvd4LYLD0JSRbB6hhIo0H4TBFabpqoP/NrFqhAQ88xExq2zZhubKsajn+RHSciwAOJQNEk0k
	kennxczE2RzkcGaqB7V1AXHlJLRrabUdp47LoWitgcFw4qf1WXFZOZCtZnrLYqXaFU90lFK1WhbSj
	4qVzr1B/Ug951GGVemdz2+QKUTiQ+sAFRINM2sWwG6lIvwEJ6NWUMkqM+WmBpv12Jg9mWCv2PDADN
	Zblg2QPYpsTvHf9e7T+OwhQMzGXEUiNbLqvv11aG8+SzZmU8uxxCZOdnuYiw0l0Y1XUhrQz3Y8Cvm
	W0BA58bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PPs-0000000Ek9H-1nmN;
	Thu, 17 Oct 2024 12:15:44 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PNr-0000000Ejoy-45jW
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 12:13:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8B31FCD6;
	Thu, 17 Oct 2024 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729167216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVn8z7/ToR7rOOuTwWcYN8melQ1MwHnseulk5wk4p3w=;
	b=JD9wmF7G43mTfmqb1AhBHCjO+28bM5jMWzYSOjRpazb46+EQHQqbYn6vJYJUiinAs/ySLs
	o4OYM7WbS1lRZa5JCcFsfJeLPBDlU9J9jTACJEqZYL0MFFcIYkiA55szxvA3YveUP00LJG
	g4FvAinf2QnT7JmOiWf0Uo6c75MEcy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729167216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVn8z7/ToR7rOOuTwWcYN8melQ1MwHnseulk5wk4p3w=;
	b=vchpUsqU55t/gdCxshgYDRbGU+ZSJt7KWgZZJzzNnTUuEIjM21mZJ/S/KcLop1B04tXH2z
	rxPTOPeimK69l8CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729167216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVn8z7/ToR7rOOuTwWcYN8melQ1MwHnseulk5wk4p3w=;
	b=JD9wmF7G43mTfmqb1AhBHCjO+28bM5jMWzYSOjRpazb46+EQHQqbYn6vJYJUiinAs/ySLs
	o4OYM7WbS1lRZa5JCcFsfJeLPBDlU9J9jTACJEqZYL0MFFcIYkiA55szxvA3YveUP00LJG
	g4FvAinf2QnT7JmOiWf0Uo6c75MEcy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729167216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVn8z7/ToR7rOOuTwWcYN8melQ1MwHnseulk5wk4p3w=;
	b=vchpUsqU55t/gdCxshgYDRbGU+ZSJt7KWgZZJzzNnTUuEIjM21mZJ/S/KcLop1B04tXH2z
	rxPTOPeimK69l8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6797413A53;
	Thu, 17 Oct 2024 12:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jrBLGHD/EGcwfQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 17 Oct 2024 12:13:36 +0000
Message-ID: <f56b5973-81c0-4e1d-8552-ee87066029bf@suse.de>
Date: Thu, 17 Oct 2024 14:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sysfs tls_configured_key naming?
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d3466e4f-23dc-4a07-a2c3-98bcbf6c7960@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d3466e4f-23dc-4a07-a2c3-98bcbf6c7960@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_051340_228003_9899E6A7 
X-CRM114-Status: GOOD (  18.29  )
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

On 10/17/24 12:54, Daniel Wagner wrote:
> f5eb7397471b ("nvme-sysfs: add 'tls_configured_key' sysfs attribute")
> claims that the --tls_key is expecting a 'Configured PSK'. That is not
> correct. It expects a 'Derived TLS PSK'. That means user space has to do
> the whole key transformation as described in Figure 21: {TLS PSK, TLS
> Identity, Hash} Tuple Derivation in TCP Transport Specification,
> Revision 1.1.
> 
Not necessarily. The spec indicates two methods:

 > Each NVMe/TCP entity shall support:
 > * transforming the configured PSK into a retained PSK before it is
 >   stored by the NVMe/TCP entity for repeated use with another
 >   NVMe/TCP entity; and
 > * using the configured PSK as a retained PSK.

>  From a quick look at the concatenation patches and based on the spec,
> tls_configured_key will never hold the 'Configured PSK'. I think we
> should use a better name for this sysfs attribute. I suppose it should
> be named 'tls_generated_psk'?
> 
No. The 'generated' PSK (in the current wording of the TLS concatenation
patches) is the PSK generated internally during TLS concatenation.
And, curiously, the only one which will _never_ be presented in the
'tls_configured_key' attribute.

> BTW, that means also for the second tuple derivation flow (where we
> start with the 'Configured PSK'), the keystore doesn't contain a
> 'Retained PSK'. I think I need to do some more reviewing and cleanups in
> libnvme to get it matching with the naming scheme of the spec in line.

There actually is an easy way out of it; the TLS interchange format is
NVMeTLSkey-1:xx:<Base64 encoded string>:
where 'xx' can be either '00' (indicating no transformation should be
done, ie the second bulled point above), or '01'/'02' (indicating which
hash function to use for the key derivation).

So in our internal parlance, the key data in 'tls_configured_key' can 
only be used as 'NVMeTLSKey-1:00:<base64 encoded string>' format, to
avoid any addtional transformation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

