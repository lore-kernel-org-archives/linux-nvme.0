Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEF4C02183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//XtuShVbHUfxp0Inx+4pASPKro9ox+DPyIGiU31BAs=; b=DVsPWrsllVJTc1QUBLiPHdBqnY
	kIdWNV44yDP3t6Rjpzp/saOPXBjXfS4ZsO9FbsAJFGmuPSxz7KLHM+g/KnwsJQikNEP4MLwOdI894
	hkjxbnhcmVgjrjmhrhyqCOjWFVwKEWMiXTA7Zg72oevlXV51lg6sCsb9qadFZgkqmpjUjw6zUutNh
	AB1+x5RSRVC8RmJtUk3bzLzvv44LlHOm/n1juJASamljzRhn1LeuFjNfU294A0b39QHqIQJ6EwGMT
	iJl+FEcFTCB1X0m9vzjHPXOU68yfRlhezBPX9zHVJYaCbtgt9m2s3ndEHJJsj4QvV/EBzJzDfFbXt
	jzt/EZNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXLTb-00000005PsE-1isE;
	Mon, 13 Jan 2025 14:31:35 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXLRN-00000005PQ5-1c1o
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 14:29:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C26D621160;
	Mon, 13 Jan 2025 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736778554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XtuShVbHUfxp0Inx+4pASPKro9ox+DPyIGiU31BAs=;
	b=Vj0j5ycJWctVteX/YPUQI+EMHkjdb5UXRt7Qzj9UGTLlA8mf1T8Gs37h9ElOLf7/REOf/1
	7Xwcbk6eRovZC8UMfJcHukQBTzFVxkTNytdQSNpY0Mu5PJWmQGJnGm0sFMeKsXfueofKix
	kV4ozHsT4DPCqgxM9gktHfQOlD0hAmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736778554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XtuShVbHUfxp0Inx+4pASPKro9ox+DPyIGiU31BAs=;
	b=oFA5Nh9kdXYb9R+iEQqwtcIc69am2lmiy0IEe4KANLGJIg4NkDCKeNK4CXUg9m44rBQ+Gi
	u+oWYTsCSp/6Y6Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vj0j5ycJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oFA5Nh9k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736778554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XtuShVbHUfxp0Inx+4pASPKro9ox+DPyIGiU31BAs=;
	b=Vj0j5ycJWctVteX/YPUQI+EMHkjdb5UXRt7Qzj9UGTLlA8mf1T8Gs37h9ElOLf7/REOf/1
	7Xwcbk6eRovZC8UMfJcHukQBTzFVxkTNytdQSNpY0Mu5PJWmQGJnGm0sFMeKsXfueofKix
	kV4ozHsT4DPCqgxM9gktHfQOlD0hAmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736778554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XtuShVbHUfxp0Inx+4pASPKro9ox+DPyIGiU31BAs=;
	b=oFA5Nh9kdXYb9R+iEQqwtcIc69am2lmiy0IEe4KANLGJIg4NkDCKeNK4CXUg9m44rBQ+Gi
	u+oWYTsCSp/6Y6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD59813876;
	Mon, 13 Jan 2025 14:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqrbKTojhWd+OQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 14:29:14 +0000
Message-ID: <7aacb2fa-a7b9-4eb2-ad87-bdd24e1cd308@suse.de>
Date: Mon, 13 Jan 2025 15:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp> <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp> <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
 <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
 <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
 <97a8263b-1efb-43ce-b6ad-8444cf148346@linux.ibm.com>
 <f71a0a75-1a79-4d0f-803f-5eb8835252ef@suse.de>
 <c0f49aed-2f93-4b31-b768-e9e354c98d42@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c0f49aed-2f93-4b31-b768-e9e354c98d42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C26D621160
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_062917_576846_890890A7 
X-CRM114-Status: GOOD (  18.34  )
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

On 1/13/25 15:12, Nilay Shroff wrote:
> 
> 
> On 1/13/25 1:13 PM, Hannes Reinecke wrote:
>> On 1/11/25 15:01, Nilay Shroff wrote:
>>>
>>>
[ .. ]
>> So my argument is that in this specific case the 'ANA inaccessible' nvme
>> state should _not_ be retried, but should be treated as identical to
>> 'invalid namespace' errors.
>>
> I think I got what you're trying to propose. So when this issue manifests, on host, if we
> could possibly differentiate between nvme_identify_ns_descs() failed reasons : is it failed
> because the nsid has been removed/un-mapped on the target or is it failed due to "ANA inaccessible"
> state? IMO, for "ANA inaccessible" status, we may not want to immediately remove the ns from
> the host (due to reason I mentioned earlier per NVMe spec section 8.1.3.3), however for the
> other error case we may remove the ns from the host.
> I think issuing ns descriptor list command to target for a nsid which doesn't exist on the
> target would return buffer filled with all zeros. So that might be an indication that ns has
> been removed from the target.
>   
But only if the NSID has not been remapped in the meantime.
If it has (as in my case) the ns descriptor list will be valid, it just
refers to another namespace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

