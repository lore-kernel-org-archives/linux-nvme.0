Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC9C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+hri+d2IVuaUuq8i3jnzd+6Qmgzp3y9lXRUcS4mQ9DM=; b=VDsHrYX5iiOopUYroPucB4UZU7
	ReWJuPDjMessIvvw1b7N/uqB/wtpryMsp/oVJlU4foWitydn0cwXUbAosFlRkJsPpvQP1jasZP9xH
	4nrHdDvdpD9hmYndMLLOpphui/QFiN2/7T8Qz9AeA+DsyBlPdJjDujzxtcf53L3LcvGbDvdKRFe0S
	e+16JlVS4HdCLaSmnWRw9PM1fRQ9ZAV1aDex7FaOeb0X0iow7Kit9OTg9ipn6MOvP3o1ROwdhWTL/
	abFhrA8hVkwx9oA5a4TXAAY/fjbPDYg+YsaNFzFKw/IX/DRW9cLh17DQXZcj1+B/Ren6YDYthz9C+
	ab5E/l+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdop0-0000000ASUJ-0G79;
	Fri, 31 Jan 2025 11:04:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdone-0000000ASEl-2tor
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 11:03:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FEB62115A;
	Fri, 31 Jan 2025 11:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738321379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hri+d2IVuaUuq8i3jnzd+6Qmgzp3y9lXRUcS4mQ9DM=;
	b=d+8BfL3r0aoFavWDBffrCB3vyfKWs0JPrClkJqmT0HCTGcMafkFvYXyBENyfUuWceQZWLW
	w0G+neH/JXUL2tQ980mFBB8nkyYUGzC5BqL0Y+PoRjAagqJMNCimqkcpiqFmahBRppeWF/
	2Wu2NGcS60vb84zXHOFyt1wLqeF9f0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738321379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hri+d2IVuaUuq8i3jnzd+6Qmgzp3y9lXRUcS4mQ9DM=;
	b=7IqGfan8AUJNHPz7/+NEYbzHNCaX2BatsPLMm/ejM45yux9XqdwR7XaDaYihlLn7Q2xwJw
	5HiN8c3lTIdohrDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738321379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hri+d2IVuaUuq8i3jnzd+6Qmgzp3y9lXRUcS4mQ9DM=;
	b=d+8BfL3r0aoFavWDBffrCB3vyfKWs0JPrClkJqmT0HCTGcMafkFvYXyBENyfUuWceQZWLW
	w0G+neH/JXUL2tQ980mFBB8nkyYUGzC5BqL0Y+PoRjAagqJMNCimqkcpiqFmahBRppeWF/
	2Wu2NGcS60vb84zXHOFyt1wLqeF9f0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738321379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hri+d2IVuaUuq8i3jnzd+6Qmgzp3y9lXRUcS4mQ9DM=;
	b=7IqGfan8AUJNHPz7/+NEYbzHNCaX2BatsPLMm/ejM45yux9XqdwR7XaDaYihlLn7Q2xwJw
	5HiN8c3lTIdohrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 449531364B;
	Fri, 31 Jan 2025 11:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id suQfEOOtnGehOQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 31 Jan 2025 11:02:59 +0000
Message-ID: <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
Date: Fri, 31 Jan 2025 12:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
To: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
 Randy Jennings <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z5yYk7vHIhMfiPz1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_030302_878839_67A66FA4 
X-CRM114-Status: GOOD (  12.96  )
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

On 1/31/25 10:32, Christoph Hellwig wrote:
> On Fri, Jan 31, 2025 at 10:24:31AM +0100, Daniel Wagner wrote:
>> Hi,
>>
>> The KATO handling in the spec got updated via the TP4129. In short it
>> mandatas that failing requests should be delayed by some value before
>> retried on a different path.
> 
> TP4129 is broken and the TWG has been told that.  There is absolutely no
> point in either implementing it or rehashing the discussion over and
> over again.  Concentrate on making 8028 useful instead.  And if you want
> a discussion, "why do people people push stupid things though the
> NVMe TWG and then comaplain later about the lack of implementations"
> might be more useful.

Okay, let's rephrase that to 'Improve NVMe-oF error handling'.
We are trying to get TP8028 out into the open until LSF,
then we can discuss that and also how to fold in the
'command cancel' patchset into the overall picture.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

