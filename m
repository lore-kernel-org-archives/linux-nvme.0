Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F4C43458
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hINcJMMlrjmj+gAMAT7gLN0Dxh2PHS1iT39YskCzD60=; b=si+ePcUizp1Yofu1XaFNMz5ejk
	y0tn2ERh9NnIDyN9DomALWs3mhTL1AbEMSkJCnehbQhO+ZQrd+zSSDH3LJwLbalve6ntVkQeZqJuc
	sQ9HeEROrM6zVdFHislpro4GLUKGJTBfwxUSU8J+ds+YNxkRyTCXRISCC8h6kQzO9CZpmVMHk9dJv
	0k3pt0F/D6KnsF5RaBIj3cckNGhlM/0fUrgNiDxDCYhB0+CGA42/mqPvpGh/lOfTzFaCrEDCee8mD
	Ud+HAl+b7bb4x6YXY9O2VlIXoSLJp0UjsdPq2zS4vjM1PngNP7qKk4nKFUzsZ5YGy6bjs9Lbbg1NH
	OUGgAc6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1yW-0000000Ec25-3bfH;
	Tue, 07 Jul 2026 09:20:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1yU-0000000Ec19-3Fds
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 09:20:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4117F73FA5;
	Tue,  7 Jul 2026 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783416015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINcJMMlrjmj+gAMAT7gLN0Dxh2PHS1iT39YskCzD60=;
	b=FFHhDgJdDsL63lS5ay5aPt4bWBEMcBhY8KnWRpcpjcMgKdFCrd9goNgdFZLVi7vlZlH2M0
	RuS3YBwgIoVku5x/ZBu9LmzE/Y99dE1dO5ZihBTOuoIi2bHkj7Z2y/J+nnSrvgaVm+0khf
	G5zKMGnQsEdDaXNkmM5IR6M5lQSq5YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783416015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINcJMMlrjmj+gAMAT7gLN0Dxh2PHS1iT39YskCzD60=;
	b=Pc6eYddij8aKNs85GgW9huHtylX3jUFuAV4lyiHGzDNK9mZtRRx3EPZVO5lVQQLj974VLC
	2SUKhB/1ZzVcOcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783416014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINcJMMlrjmj+gAMAT7gLN0Dxh2PHS1iT39YskCzD60=;
	b=UxaJbyC16WHOq+jQ5T5EkpiBUgB72NldW02HAKuuD1qMOOwut0l3BXv20kiZBhucj5mr/A
	SIxGy0qJ1l/2TdPDL0VW67kVs+HylpQPlM5VuF7q5yjE+sEBBcwpsy5ydXS16C21vWu7t8
	qGVuyKYSGv0KYc1PWtHKkTG8/xZPiw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783416014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINcJMMlrjmj+gAMAT7gLN0Dxh2PHS1iT39YskCzD60=;
	b=6TKWM9e+cPWVT6jDX5dfrnQy4s8ptSg4W2pPO8Vhl0TQ6bO5sZxBM4HQASbS3KK8B+S+eD
	GmPRcvZ9y4zOzSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242AD779AF;
	Tue,  7 Jul 2026 09:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qRfMCM7ETGpLOAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 07 Jul 2026 09:20:14 +0000
Date: Tue, 7 Jul 2026 11:20:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
Message-ID: <e2ac204c-83bf-4738-bbed-a1fffc98a678@flourine.local>
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
 <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
 <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
 <7f5a765a-1f2b-4d67-b03d-f2cd7c73218c@flourine.local>
 <fb23530e-3b0c-4993-ac98-d7c1ba3f5986@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb23530e-3b0c-4993-ac98-d7c1ba3f5986@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_022018_960163_E3999007 
X-CRM114-Status: GOOD (  13.39  )
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

On Tue, Jul 07, 2026 at 09:40:01AM +0800, Guixin Liu wrote:
> > > so I've put them all under the testing directory for now.
> > The NVMe APIs are definitely not in the 'testing' section. The nvmet
> > APIs are also not in 'testing', IMO. While they are used upstream
> > predominantly by blktests, there are also people out there using them in
> > production systems, if we like or not.
> You mean we can put them all under stable directory?

Exactly, let's go ahead and put them under the stable directory.

