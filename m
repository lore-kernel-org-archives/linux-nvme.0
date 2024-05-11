Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB73C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EDJIHdTKAjF+0N3p7+wRDHeWZQMzjKgFf0jqTyiLGPs=; b=3L4wNZux8cIjvMM0gp9mcKNqPD
	vHmKQ/kadSSObT3T0GHI/felTDTE420TyGFrwjhjqOo83PTQjEEJaeOnAFj6EFFQ2N9J+vevBJMpE
	l7ohgctsIQVtiRshmbj7fQqSSZRaw9OYiRc/KqwwSb9Z6fUI7V7u0Dn+CzK39ePLqLIy5SutYcJz+
	81f1wHjQ/Z1NeizY8hzWf9NL2ipgjylNeIHEpol2N7ZaGgwgi7l8g30YBYtiRhoo/GrVPz+vpx7Wm
	dbeLNFOA9tatuGsnkT1mzuaZ/dudeSrsDMUoW3ooAYrfwE1nOEk8KQWnlSft5iSZJz/ifT6EUiUvm
	bkj7wy5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5ise-00000007c5z-0awt;
	Sat, 11 May 2024 09:19:00 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5isY-00000007c3Z-1EP0
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 09:18:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FAA333F8B;
	Sat, 11 May 2024 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDJIHdTKAjF+0N3p7+wRDHeWZQMzjKgFf0jqTyiLGPs=;
	b=ORxHfcxo9BwaiBUnj1Vf9798HtkS1kid8AXWQ2nuA4Bml0iya3foaJvD1JrKFIssMS8e0H
	q6bGHRX/UtgtVelktEoCH9DDu+xj67kgaQUHsxQZFttiunLpIRHYlOvrhP1QKnRt5KTkoo
	31rcyrRFCW/GDrdEXpbEtE+ycXYBPXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDJIHdTKAjF+0N3p7+wRDHeWZQMzjKgFf0jqTyiLGPs=;
	b=ts2W+X3UJxvRRR2apkESvKYI5E3Hsov6RnJuI4AEVstlT3eBG7G0VwAgTMHS7nWn7s5WTc
	uuksdj/D7lwABoDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDJIHdTKAjF+0N3p7+wRDHeWZQMzjKgFf0jqTyiLGPs=;
	b=ORxHfcxo9BwaiBUnj1Vf9798HtkS1kid8AXWQ2nuA4Bml0iya3foaJvD1JrKFIssMS8e0H
	q6bGHRX/UtgtVelktEoCH9DDu+xj67kgaQUHsxQZFttiunLpIRHYlOvrhP1QKnRt5KTkoo
	31rcyrRFCW/GDrdEXpbEtE+ycXYBPXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDJIHdTKAjF+0N3p7+wRDHeWZQMzjKgFf0jqTyiLGPs=;
	b=ts2W+X3UJxvRRR2apkESvKYI5E3Hsov6RnJuI4AEVstlT3eBG7G0VwAgTMHS7nWn7s5WTc
	uuksdj/D7lwABoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2801913A3E;
	Sat, 11 May 2024 09:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id INuABvw3P2Y2KAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:18:52 +0000
Message-ID: <fb2185f1-2a0f-412c-84f8-a6cbc1fcc6ff@suse.de>
Date: Sat, 11 May 2024 11:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj6hotHEsOSL9h1K@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6hotHEsOSL9h1K@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
X-CRM114-CacheID: sfid-20240511_021854_517668_696D8920 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

On 5/11/24 00:37, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Don't set the capacity to zero for when logical block size > PAGE_SIZE
>> as the block device with iomap aops support allocating block cache with
>> a minimum folio order.
> 
> It feels like this should be something the block layer does rather than
> something an individual block driver does.  Is there similar code to
> rip out of sd.c?  Or other block drivers?

Correct, this restriction should never have been there. I'll be checking 
sd.c, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


