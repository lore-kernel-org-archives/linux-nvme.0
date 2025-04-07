Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A44BC36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/c8Nh/DbJPm/qqPYIvGyUU88iRIf7F0aooROszBmTU=; b=KGN3nC4G1jokVnBvegm5xiThDq
	wtYzANFhrRlQxeRq7tiqlaIYNVL06L/JO4hm6atusFiWLAhD7F2YSkZKf2tmEUhrVSQ6yBtAM5v2S
	ksPQqA3HNfb7EQiU4VHOU0KnShGSEmudxiw++WgmfXQllHMgy/Rr20+xHRYy2LEmlR3N8mBuI/UtI
	SGGs3miZKt9UDYhQeKRiTt8lblYxNPeJ0KA5kAU52FlyV5okbX95Lx+b5XeBO7VZAmORJ8sfFH7JA
	lDkv06tvtFEoJdcjiIj52eKUOSYfnNv4ceMPicmYTptKeVA5yiDcGFYQQ5fFeevObVZWtbrR9ufN7
	4SsoIFjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hMu-0000000Gtpq-0jYx;
	Mon, 07 Apr 2025 07:58:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1h5X-0000000Gogb-2kU1
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 07:40:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14BB421162;
	Mon,  7 Apr 2025 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744011610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/c8Nh/DbJPm/qqPYIvGyUU88iRIf7F0aooROszBmTU=;
	b=yFLQt/1IIOf3ZPEgbKPTUOuUez2vy/sEU4kihn5LZ08/2bmKRIp8sOunXj1P2f8vdpU1+W
	58dQYnJt0WXeDHwmEjdDQzdYw/ddbRsGhqn7NJjGpsMV8o7E4DDR31hq2G4rtG9FJZxKGP
	f3k+cA3DjHluk32Di7ykws09a4tZVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744011610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/c8Nh/DbJPm/qqPYIvGyUU88iRIf7F0aooROszBmTU=;
	b=gm0U3YeZFCUhdyN4kXdBoE3Lj0WVEjuUTxeXUR2hfzv9P9NS7oRUwBi1LZXcM1pJqwaMeA
	NfdjLuq+MdBfFrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744011610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/c8Nh/DbJPm/qqPYIvGyUU88iRIf7F0aooROszBmTU=;
	b=yFLQt/1IIOf3ZPEgbKPTUOuUez2vy/sEU4kihn5LZ08/2bmKRIp8sOunXj1P2f8vdpU1+W
	58dQYnJt0WXeDHwmEjdDQzdYw/ddbRsGhqn7NJjGpsMV8o7E4DDR31hq2G4rtG9FJZxKGP
	f3k+cA3DjHluk32Di7ykws09a4tZVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744011610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/c8Nh/DbJPm/qqPYIvGyUU88iRIf7F0aooROszBmTU=;
	b=gm0U3YeZFCUhdyN4kXdBoE3Lj0WVEjuUTxeXUR2hfzv9P9NS7oRUwBi1LZXcM1pJqwaMeA
	NfdjLuq+MdBfFrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA27413A4B;
	Mon,  7 Apr 2025 07:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBHINlmB82eSHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 07:40:09 +0000
Date: Mon, 7 Apr 2025 09:40:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 2/3] tree: add queue-depth attribute for nvme path object
Message-ID: <4af74f9f-32e1-4ce6-a078-3a494d7fb5d0@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405130255.448345-3-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_004011_846702_D2C45652 
X-CRM114-Status: GOOD (  14.22  )
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

Hi Nilay,

On Sat, Apr 05, 2025 at 06:32:48PM +0530, Nilay Shroff wrote:
> Add a new attribute named "queue_depth" under the NVMe path object. This
> attribute is used by the iopolicy "queue-depth", which was introduced in
> kernel v6.11. However, the corresponding sysfs attribute for queue depth
> was only added in kernel v6.14.
> 
> The queue_depth value can be useful for observing which paths are selected
> for I/O forwarding, based on the depth of each path. To support this,
> export the attribute in libnvme.map so it can be accessed via
> nvme-cli.

I understand the idea here is to get live update of the queue depth?
This here will only read it once and report always the same value. This
will work for nvme-cli but users which run the library for longer.

Thanks,
Daniel

