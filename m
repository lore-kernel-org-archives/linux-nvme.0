Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C1C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8p/r9X/3sB97OQMdgXBNhLhxcy8rDVOhPop0ZQMwrM=; b=u470FmPKjckQ6M+LEeqx9RbQHW
	xlraKPh6g6SdLCug+NgTgkonJEK4Th1+C4C25gRznEmDzUCC56j5LaESsaBUnZaklMfO8mcY4CDwW
	HixsG/UrbI9SIvgkKTYaQEbbjAjCE2cr0RleAlsJfHN/w7xUK+AfsCvfe1/NbaTv5nRAoSbn2y8za
	MnGZjNUxC9sIvCZfYaNv9tMIoVw70EJq/By+rWKupCYKqpf00SSWF2slFGZJILVa40XkQb8+N4u2h
	V1MAYFX+iB5nQRvkYE0HsQHlHUtiUJHFQL67oRyw9Y2UfTp/5jbc5vMRknaCjLjGvtbEl/GRBbgcF
	rf+fFNSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjGxa-00000009RBS-2tOZ;
	Mon, 13 Jul 2026 13:44:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjGxY-00000009RAQ-0unM
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 13:44:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AD8D77515;
	Mon, 13 Jul 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783950274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8p/r9X/3sB97OQMdgXBNhLhxcy8rDVOhPop0ZQMwrM=;
	b=X20Iywa8egx10cSL4Egcp7P8IaYiiLxnQcUM933ZifyqrzjNduPMS6b4VbEb9+eb+WDxD3
	zoTRscnz1uh7f28eY3Ti0I+pKhLQGrFroiNo0jQH/8FhzlzV5AUiyOezaye/LbOCOZMzkL
	EP8kHnc/Pa629BCAzlFFE/KOwKXqZ3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783950274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8p/r9X/3sB97OQMdgXBNhLhxcy8rDVOhPop0ZQMwrM=;
	b=zOUXNRZJakZ1cMExs5tglJPgNyRZbbjBYpwJgmrFQBdYDaINkoPKNp3ZeC3ipZ+jUOKvFw
	hK55OyR15DALxACA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783950273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8p/r9X/3sB97OQMdgXBNhLhxcy8rDVOhPop0ZQMwrM=;
	b=MyW5C6lQgXOm4uCUEav3mqsBiU3K1u8oecCAK19iHDchQpWNk8fgxcHn6Ppi903XmfBDib
	ZzXM/2XV8Oarb5I67mlOob22lDEwvgvYI+4KGRBr7gvFwS/ou9zKHR0kPs5wG2XTnFtzPW
	stiTqoCJywF0pyu8jCNc97+eP2Fafxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783950273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8p/r9X/3sB97OQMdgXBNhLhxcy8rDVOhPop0ZQMwrM=;
	b=7rnyXAyiIZinbZX2hlR8IvH4d4plCCY04jhnvYew+jxsiJycibGY+PTZkhklMtTjCNB/fM
	FySVzEiG9mVqm/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380B1779AE;
	Mon, 13 Jul 2026 13:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dR5GDcHrVGqIfgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 13:44:33 +0000
Message-ID: <0492bbee-a89e-45ba-b874-77ecb70be6ca@suse.de>
Date: Mon, 13 Jul 2026 15:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: store DHCHAP attributes
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
References: <20260713104657.121217-1-hare@kernel.org>
 <2b897a12-e265-40c5-8e48-b546cd606940@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2b897a12-e265-40c5-8e48-b546cd606940@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_064436_424994_E330AD60 
X-CRM114-Status: GOOD (  13.19  )
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

On 7/13/26 2:16 PM, Daniel Wagner wrote:
> Hi Hannes,
> 
> On Mon, Jul 13, 2026 at 12:46:57PM +0200, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> The DHCHAP authentication is stored under hosts/, and are starting
>> with 'dhchap_'. So add a 'dhchap' attribute group for the host object
>> to correctly save and restore DHCHAP values.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   nvmet/nvme.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
>> index faf1eb2..80d3953 100644
>> --- a/nvmet/nvme.py
>> +++ b/nvmet/nvme.py
>> @@ -1013,6 +1013,7 @@ class Host(CFSNode):
>>           '''
>>           super(Host, self).__init__()
>>   
>> +        self.attr_groups = ['dhchap']
> 
> Would you mind also extend the test case?
> 
Sure. Will be looking into it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

