Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F911C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMviZ1hAtonvzTvuNyrvqk/vs/iaohhG0xo4UyKe/bo=; b=NSdgaRO1rCxi4qsWb5ounCf7jL
	Gm/Nm1CSIEWrmrQAQJkvWWtqFaaFECAQzKHxa867oW0cuvO6keLwKhU3qSVK66XMj0CD8LIileD+U
	hQjfERS8pzJZdKOE+grkKhi6/665q/udLQyggH+Lc+gzuU2FYfnukoOt/UJsYINRAn5025TOlCL/h
	/fDCvtBkBOmmuoruI6SzjSgNoRELkZX3NwlJxsQkQQuC/ODoCvnAW5g/f6XlElL/Hh85IOYJJ2pWD
	7jm89JDGDptkQau0qIKJtEpyJY/vHxRnstiQt+YnMwDMcv6/w++OqOKFGx4mIlYdqmiO62BoxNut4
	V/y300GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Mrh-00000009I71-40dl;
	Thu, 03 Apr 2025 15:52:25 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Mrf-00000009I6B-1wbj
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 15:52:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12AA5211CB;
	Thu,  3 Apr 2025 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743695542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMviZ1hAtonvzTvuNyrvqk/vs/iaohhG0xo4UyKe/bo=;
	b=WsancuGAXyY9l9IvQN5Ty2N5GWqf9JsDeu3+L94yzl4ZdkBvTq49Wftw4S/p89kNzwOL6X
	DRkCxsPRglve11jYjz7N27SF1147/WiJGTdt8Ev2LSY3U4IrsyCAKxPGajUPf/HaJBcgvI
	bZValyIzj0olRb52GsMNvKuU7oO6udM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743695542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMviZ1hAtonvzTvuNyrvqk/vs/iaohhG0xo4UyKe/bo=;
	b=D3xQWyBa6sPvfvxEKiGa0NjwBeqqljgiTKjtYieMmQ5IKtmZTVmJxLIzN3/9FX9+bAVm7d
	CnmUC/osxbOaODAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743695542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMviZ1hAtonvzTvuNyrvqk/vs/iaohhG0xo4UyKe/bo=;
	b=WsancuGAXyY9l9IvQN5Ty2N5GWqf9JsDeu3+L94yzl4ZdkBvTq49Wftw4S/p89kNzwOL6X
	DRkCxsPRglve11jYjz7N27SF1147/WiJGTdt8Ev2LSY3U4IrsyCAKxPGajUPf/HaJBcgvI
	bZValyIzj0olRb52GsMNvKuU7oO6udM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743695542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMviZ1hAtonvzTvuNyrvqk/vs/iaohhG0xo4UyKe/bo=;
	b=D3xQWyBa6sPvfvxEKiGa0NjwBeqqljgiTKjtYieMmQ5IKtmZTVmJxLIzN3/9FX9+bAVm7d
	CnmUC/osxbOaODAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D167D13A2C;
	Thu,  3 Apr 2025 15:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqHAMbWu7mdQcQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Apr 2025 15:52:21 +0000
Message-ID: <54e0fb21-b609-4a60-9aee-63943069f089@suse.de>
Date: Thu, 3 Apr 2025 17:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-3-hare@kernel.org> <Z-6haRYmf7PMn3vW@kbusch-mbp>
 <c304f189-cc59-4ae3-b42a-282eb74f02cf@suse.de> <Z-6rSkBZ5g9FiTXq@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z-6rSkBZ5g9FiTXq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_085223_653608_205936AE 
X-CRM114-Status: GOOD (  12.03  )
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

On 4/3/25 17:37, Keith Busch wrote:
> On Thu, Apr 03, 2025 at 05:32:59PM +0200, Hannes Reinecke wrote:
>> On 4/3/25 16:55, Keith Busch wrote:
>>> On Thu, Apr 03, 2025 at 09:19:30AM +0200, Hannes Reinecke wrote:
>>>> When scanning for new namespaces we might have missed an ANA AEN,
>>>> so we should always re-read the ANA log page after scanning to ensure
>>>> we don't miss updates there.
>>>
>>> Worst case we might check a log page that hasn't changed. Rescans should
>>> be rare, so I guess it's fine. But I'm not sure why scanning might cause
>>> an ANA AEN to be missed. ?
>> Well, it's not that we're _missing_ AENs here.
>> As per quoted spec ANA change events are not sent if there had been
>> an event (on the controller) which would have caused both an ANA change
>> event and an NS changed AEN to be sent.
>>
>> So any NS changed event really needs to be treated as a combination of
>> NS changed _and_ ANA changed, and after each namespace rescan we need
>> to re-read the ANA log page.
> 
> Oh, good call. I forgot about that text.

NP. We all did :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

