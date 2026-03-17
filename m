Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F5FB5EAD
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTHX7SUh8Gzk6axT3IGyIcGR63ICOzO5rGy/36evySM=; b=CIYBVpub6CDEm3avO/oMh+uMzD
	clFIf6KHLXQf+zAiyyn1fSy06SDyCR58rP2Zw20ec6d4uv/mXz+2jrmop9+UtCsaVJXs5bCV6rs7D
	80HN1wH13BVoh21ae7n6hfEm0M8za8ooJAKnkLe8hS8oHS318iQIWf4eQ1iPfExwbUTuH4aEz53zt
	8yL18zLMhGqBD63Zh5UW+F8wjVaht9FEGZ5pSB8zBpAWC0/VIjffXTyhmYaZcqK7CwuTIZ8YiGP+q
	ksAhz7ztQx3FjMQRtORVv7uLNKlFtq1QuuESdw9Bwzc3pm6ZzOUPEN3N6YLZmQthsv6VbkRPOKW9E
	1koaxICg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VeV-00000006eCA-0lQo;
	Tue, 17 Mar 2026 14:44:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VeS-00000006eBl-0jfR
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:44:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F8AD4D337;
	Tue, 17 Mar 2026 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773758646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHX7SUh8Gzk6axT3IGyIcGR63ICOzO5rGy/36evySM=;
	b=OFsDRun++1ZAP9pWGbFVT7ffN6Ys00O/tRydmbcG8hhN8m/Jh28eoAYL9gw5wHAd94Btcn
	w8qU/FVic3kOzxHb77AybwS2h2fckA6DIOl5odhZxi1fM1ksXNwK0dN6RXo0QzuRHlpVCY
	3Hjn0L3f5Jwzs52gMN50XTfge90ZNsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773758646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHX7SUh8Gzk6axT3IGyIcGR63ICOzO5rGy/36evySM=;
	b=t2pCbjPBgNcTV6i1W0Ih/Ir7pKt8t8AAGkKHMNdrzKcxtKmnpEZCzql4tmkIcRkQg8Vw9u
	MVF9GuhTmqhXePBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773758646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHX7SUh8Gzk6axT3IGyIcGR63ICOzO5rGy/36evySM=;
	b=OFsDRun++1ZAP9pWGbFVT7ffN6Ys00O/tRydmbcG8hhN8m/Jh28eoAYL9gw5wHAd94Btcn
	w8qU/FVic3kOzxHb77AybwS2h2fckA6DIOl5odhZxi1fM1ksXNwK0dN6RXo0QzuRHlpVCY
	3Hjn0L3f5Jwzs52gMN50XTfge90ZNsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773758646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHX7SUh8Gzk6axT3IGyIcGR63ICOzO5rGy/36evySM=;
	b=t2pCbjPBgNcTV6i1W0Ih/Ir7pKt8t8AAGkKHMNdrzKcxtKmnpEZCzql4tmkIcRkQg8Vw9u
	MVF9GuhTmqhXePBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CF9E4273B;
	Tue, 17 Mar 2026 14:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PMdAArZouWk3EQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Mar 2026 14:44:06 +0000
Message-ID: <7b95a295-c071-4148-9234-163e223a413b@suse.de>
Date: Tue, 17 Mar 2026 15:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/8] nvme-auth: switch to use the kernel keyring
To: Maurizio Lombardi <mlombard@arkamax.eu>, Hannes Reinecke
 <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20260317130103.107360-1-hare@kernel.org>
 <DH536IY4JYD6.JPEWTIJ6WS4E@arkamax.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DH536IY4JYD6.JPEWTIJ6WS4E@arkamax.eu>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_074408_508916_2112B2F0 
X-CRM114-Status: GOOD (  18.65  )
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

On 3/17/26 14:20, Maurizio Lombardi wrote:
> On Tue Mar 17, 2026 at 2:00 PM CET, Hannes Reinecke wrote:
>> Hey all,
>>
>> the current NVMe authentication code is using a hand-crafted key
>> structure; idea was to have the initial implementation with a minimal
>> set of dependencies.
>> (And me not having a good grasp on how to use the kernel keyring :-)
>> That had the drawback that keys always had to be specified on the
>> nvme-cli commandline, which is far from ideal from a security standpoint.
>>
>> So this patchset switches the authentication code over to use the
>> kernel keyring. User-facing interface (namely argument to 'nvme
>> connect') remain the same, but the key data is converted into keys
>> which are stored as a new key type 'dhchap' with a random UUID as
>> description in the kernel keyring.
>>
>> With this I have updated the dhchap arguments to 'nvme connect' and
>> the configfs interface to either be the keydata (ie the original
>> interface) _or_ a key description referring to a pre-populated dhchap
>> key in the kernel keyring. This allows for easier provisioning of keys
>> and avoids the security risk from having to specify the key data on
>> the kernel commandline.
>>
>> The entire patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
>> branch dhchap-keyring.v3
> 
> Are you sure you pushed it? I can't see it
> 
> $ git branch -a | grep dhchap
>    remotes/hare/dhchap-keyring.v1
>    remotes/hare/dhchap-keyring.v2
> 

Ho-hum. You are right; having a local branch doesn't equate with 
havingit available on kernel.org. Pushed now.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

