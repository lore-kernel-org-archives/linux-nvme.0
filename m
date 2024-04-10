Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32845CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=; b=H1YW7qACY4+45tfowOE3e+v7/C
	FrpaMIrTtD+5XOtkE1yvlOHsxmtlAe1/3b0kjS9BGegrGLrvkT0v22yrltaERnBa4ciB6aE67H8Dq
	K0dWRsz8LDcMrkZ/YDA6s2CaRwCbOpcDSzO/soqoawkgAlDzrLRq5Be+/d8ZD5MEH1dD4faSZZ3lf
	F41HmFVhSCY2/Lh5QUmZ7k+Fjga9rWUgO9/qTJAVjP7SwYJQ9zZaE2/H/Oh8c/uoviIVFwD8H9OY/
	m/8GGvOQaoAAzVEoZFEpnPM8pAHVAzaDn2Tgg7vFKUfc3LKHvYO4mvz3xM8peSD8cdqYiOJofEZrt
	iuq+28FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruWiH-00000006nY3-3z1b;
	Wed, 10 Apr 2024 12:06:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruWi8-00000006nT8-1M66
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 12:06:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3FF350AF;
	Wed, 10 Apr 2024 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712750747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=MWvIQLTwbXcgNFmRvHLmwIeXh898YX/cEHNWnqllD3GJUwCXNDFoDWltNUogOkQwRQTmQp
	4tLsWFihoU9rnG79zun4pj458HCjHZjAqGoNcmkH1YhkWFE3BviTl9spP9PcaSnRUQHyct
	R/nPE/2O40QqXJ+BU9Z75RZsadwejk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712750747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=LcV4U1khzrJcHGDdKsndPqNQnNpqBGsbCVkr5UDh0rOhPkhLhWt4BV6MpZ92iDSxejYgEI
	8N0vNLoQ5X9VFlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712750747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=MWvIQLTwbXcgNFmRvHLmwIeXh898YX/cEHNWnqllD3GJUwCXNDFoDWltNUogOkQwRQTmQp
	4tLsWFihoU9rnG79zun4pj458HCjHZjAqGoNcmkH1YhkWFE3BviTl9spP9PcaSnRUQHyct
	R/nPE/2O40QqXJ+BU9Z75RZsadwejk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712750747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=LcV4U1khzrJcHGDdKsndPqNQnNpqBGsbCVkr5UDh0rOhPkhLhWt4BV6MpZ92iDSxejYgEI
	8N0vNLoQ5X9VFlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 611D513691;
	Wed, 10 Apr 2024 12:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hbs0FJuAFmawdwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Apr 2024 12:05:47 +0000
Message-ID: <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
Date: Wed, 10 Apr 2024 14:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_050552_725673_F67AF318 
X-CRM114-Status: GOOD (  20.32  )
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

On 4/10/24 12:21, Sagi Grimberg wrote:
> 
> 
> On 10/04/2024 9:52, Daniel Wagner wrote:
>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>
>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> Any authentication errors which are generated internally are always
>>>> non-retryable, so use negative error codes to ensure they are not
>>>> retried.
>>> The patch title says that any authentication error is not retryable, and
>>> the patch body says "authentication errors which are generated locally
>>> are non-retryable" so which one is it?
>> Forgot to update the commit message. What about:
>>
>>    All authentication errors are non-retryable, so use negative error
>>    codes to ensure they are not retried.
>>
>> ?
> 
> I have a question, what happens if nvmet updated its credentials (by the 
> admin) and in the period until the host got his credentials updated, it
> happens to disconnect/reconnect. It will see an authentication
> error, so it will not retry and remove the controller altogether?
> 
> Sounds like an issue to me.

Usual thing: we cannot differentiate (on the host side) whether the
current PSK is _about_ to be replaced; how should the kernel
know that the admin will replace the PSK in the next minutes?

But that really is an issue with the standard. Currently there is no
way how a target could inform the initiator that the credentials have
been updated.

We would need to define a new status code for this.
In the meantime the safe operations model is to set a lifetime
for each PSK, and ensure that the PSK is updated on both sides
during the lifetime. With that there is a timeframe during which
both PSKs are available (on the target), and the older will expire
automatically once the lifetime limit is reached.

Cheers,

Hannes


