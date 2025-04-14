Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56477C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upuchZCMxQMWeKnRu8qrkZMId0dgJRkKPZA7k/sCJ0o=; b=QSUTt4SMZdOC2+8cwb9ptEHza/
	J1njEHF8bpU3xOmAGm+1PZkv2u08zoRB65cCFAr0Gg8LEnRAUBl8YTt7tnMsFoucgnyEcqeRYEkg/
	ey8UiZwC7Z5s5iWiy+QnmyrDhhgssKA5bC2UhF21sDT0RMZ/UUMUG59Epa5aQE7BbE/w2bLXumLrM
	YiH+phxk4eclUp1dbYtXu1XMnVZZQtAlXmwFjXjwQfnBECfK8I8To6zdMr/HsVgC2Z11z7r9p/vGk
	hwKNLtdn0nLmiTfn4YiWYt2eD2aekWAwfkJbO9IuCheWbk6SD/bfI0cLkZXOn3YjPS5Mc9x/H5wPG
	bzedt2HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I2J-00000001mC7-0Ivb;
	Mon, 14 Apr 2025 11:31:35 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I2F-00000001mAo-2j6C
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 11:31:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11AFE21163;
	Mon, 14 Apr 2025 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744630290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upuchZCMxQMWeKnRu8qrkZMId0dgJRkKPZA7k/sCJ0o=;
	b=v4YR0PxJiLFajBjStLyVT8JFOmtSCne51/CLAJ2btE9xvnxBhYuQsCoANaueHPqlLXx/Fh
	5gTBl0PlpU6UxeGIIvYxAvih07XOE1CSj1ry451nPQref23HU1S6GSZZcTkQZMK1LcLLJn
	edJKdXgifEOLdVv14AkPMsZG7Kc/LMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744630290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upuchZCMxQMWeKnRu8qrkZMId0dgJRkKPZA7k/sCJ0o=;
	b=7oidR0bHfi0P+jgOBVI4Fz8SxwjxuPRCmU87q5FMIoeGDEPsr6zeyTe+l3+jtqu04hyNB4
	9RmXNKf6xM8lFaDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744630290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upuchZCMxQMWeKnRu8qrkZMId0dgJRkKPZA7k/sCJ0o=;
	b=v4YR0PxJiLFajBjStLyVT8JFOmtSCne51/CLAJ2btE9xvnxBhYuQsCoANaueHPqlLXx/Fh
	5gTBl0PlpU6UxeGIIvYxAvih07XOE1CSj1ry451nPQref23HU1S6GSZZcTkQZMK1LcLLJn
	edJKdXgifEOLdVv14AkPMsZG7Kc/LMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744630290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upuchZCMxQMWeKnRu8qrkZMId0dgJRkKPZA7k/sCJ0o=;
	b=7oidR0bHfi0P+jgOBVI4Fz8SxwjxuPRCmU87q5FMIoeGDEPsr6zeyTe+l3+jtqu04hyNB4
	9RmXNKf6xM8lFaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBEAE136A7;
	Mon, 14 Apr 2025 11:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /pUjORHy/GcDVwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 14 Apr 2025 11:31:29 +0000
Message-ID: <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
Date: Mon, 14 Apr 2025 13:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 wagi@lst.de, linux-nvme@lists.infradead.org,
 "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
 Javier Gonzalez <javier.gonz@samsung.com>
References: <20250414090959.2015-1-hare@kernel.org>
 <20250414111916.GB13225@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250414111916.GB13225@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_043131_834748_097C4736 
X-CRM114-Status: GOOD (  16.63  )
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

On 4/14/25 13:19, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 11:09:57AM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Hi all,
>>
>> we have encountered a customer issue where the NID values for additional
>> namespaces on the same device are not unique in all cases; the NGUID is,
>> but the EUI64 is not. Problem is that prior to commit e2724cb9f0c4 there
>> devices worked without a problem, but after that all NIDs are blanked out.
>> This results in udev not creating persistent device links anymore and the
>> system failing to boot.
> 
> These devices are so broken that we absolutely should not support them
> You've also received that feedback both in person from me, from Daniel
> and from the nvme technical working group.  I'm not sure why you insist
> resending it instead of telling the OEM that specifically requested this
> spec violating behavior from their SSD vendor to stop doing those
> broken thing in the many months you have known of this gravely incorrect
> indefensible behavior.
> 
Thank you for your kind words.

We have discussed this at LSF, and the involved parties (ie
Samsung as the vendor, HPe as the IHV, and us as the OS provider)
are happy with this approach.
And we have paying customers for which the cited patch caused a 
regression, so ignoring it is not an option for us.
I hoped this patchset would be acceptable for upstream; as it is not
we will have to include this patchset as a SUSE-specific modification.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

