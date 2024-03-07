Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E329CC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4euPrsgGoDOm6+mRAqhKxrOXpcoLxc08vBZxWFnsdXY=; b=GWGQtC451Rp+sywZqQ57z5D1qT
	dqvIi4PnIaSi6CUx2eC4qLZXVp5lePGVulq1UZ1Fx5hJd8tFgUZNa5GigHTvOqdnHk59gNC2X5skU
	Rx+AI+wf1iZdY7wbyRrJbrnobthdaNi1VcwlGjuRP/bP+LMmmWVEntagA0QRmiDO0IbygSrqev3ZN
	0q4PK7I24ba0kja6TX/dY5zsMT7xTn4ph7ujvydeJR/tKXwxpsNjgqh3YDrJzoJtk5kWWvP1y9Lqf
	gJRrf6/pDj2u+oBjHdzMsLa49jt8rjzjUqQZ09Jnl3Z52C8ZYzI1gEEhh28HZzP5ebobYm7x+Eqgg
	51WaMC2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCZ5-00000004V9f-2GtD;
	Thu, 07 Mar 2024 12:09:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCZ1-00000004V8F-0rRU
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:09:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 814BE5BF08;
	Thu,  7 Mar 2024 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709808428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4euPrsgGoDOm6+mRAqhKxrOXpcoLxc08vBZxWFnsdXY=;
	b=IVOHNvb/osWBSNaKCYFIsMwaQVdDJkHhdjwZZP/w5ejgBMoCf7im0P9NqH5C0lzdKfHroI
	/RAQfXMuRJQvH8P/bf0kyMCNeUi1nYpkr2bPu7eDX/jjdFVzQOVmQzZxq7ITG2yAZpS65W
	sA0LwJNJbxzbGgvPN7RRk1KnEM3Dr4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709808428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4euPrsgGoDOm6+mRAqhKxrOXpcoLxc08vBZxWFnsdXY=;
	b=UU1aUB69SO7uysyyut3p7KfM+c3H0vPiMuRaPUYmvLPUx5omGBVq3pPnzcQqJo+cOzQTUi
	u/1VkROLi0NKt5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709808428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4euPrsgGoDOm6+mRAqhKxrOXpcoLxc08vBZxWFnsdXY=;
	b=IVOHNvb/osWBSNaKCYFIsMwaQVdDJkHhdjwZZP/w5ejgBMoCf7im0P9NqH5C0lzdKfHroI
	/RAQfXMuRJQvH8P/bf0kyMCNeUi1nYpkr2bPu7eDX/jjdFVzQOVmQzZxq7ITG2yAZpS65W
	sA0LwJNJbxzbGgvPN7RRk1KnEM3Dr4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709808428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4euPrsgGoDOm6+mRAqhKxrOXpcoLxc08vBZxWFnsdXY=;
	b=UU1aUB69SO7uysyyut3p7KfM+c3H0vPiMuRaPUYmvLPUx5omGBVq3pPnzcQqJo+cOzQTUi
	u/1VkROLi0NKt5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65482136BA;
	Thu,  7 Mar 2024 10:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bw8cGCub6WXELQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 10:47:07 +0000
Message-ID: <bf86f3ec-738f-49e5-ad54-c817f9d9542d@suse.de>
Date: Thu, 7 Mar 2024 11:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226122449.46976-1-hare@kernel.org>
 <1aee2876-15dd-48dd-a6b1-76ac1ebfc682@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1aee2876-15dd-48dd-a6b1-76ac1ebfc682@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IVOHNvb/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UU1aUB69
X-Spamd-Result: default: False [-5.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 814BE5BF08
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_040931_544647_02800FA7 
X-CRM114-Status: GOOD (  16.28  )
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

On 3/7/24 10:45, Sagi Grimberg wrote:
> 
> 
> On 26/02/2024 14:24, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> If the user specifies a specific TLS key via the '--tls_key'
>> option to nvme-cli we should be adding a ';static' suffix
>> to the 'tls_key' sysfs attribute to signal that this is a
>> user-specific key, and not one auto-selected during TLS
>> protocol negotiation.
> 
> Static is not the best wording. Doesn't the user already
> know what it provided? How is this indication useful?

What I'm trying to achieve here is to differentiate between

nvme connect --tls

and

nvme connect --tls_key=<key_id>

both calls will result in key serial number in the
'tls_key' attribute, so if we try to generate the json
configuration file from an existing connection we
have no idea which of the arguments the admin has
used. Problem is that first invocation will auto-select
the TLS key, and hence we can do a key rotation.
The second invocation will always refer to a specific
key, and hence we cannot do a key rotation.

So we'll need an additional setting allowing us
to differentate here.

I do agree that adding a field to an existing
attribute is probably suboptimal, so I guess
I'll retract this patch and send another introducing
a new sysfs attribute ('tls_provisioning' ?)
The alternative would be to add a new attribute for
the keyring (ie introduce a 'tls_keyring' attribute).
That would be empty for a pre-configured key (as we
are looking up the key by serial, and don't care on
which keyring the key is in), and contain the keyring
name otherwise.

Hmm. I guess I like this better, as then we would
also be able to display the 'keyring' setting which
currently is also not present in sysfs.

Cheers,

Hannes


