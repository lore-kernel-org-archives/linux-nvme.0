Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0785CC44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=; b=JdII3sbuhomjHQv9rbhazRjC+B
	N9MfYDx74tjqWh6PPPEziVKEddOrOGdcrWcx9NPW2u4VNhLXGjnLxQuJa/HbbwqlB/8KbADz7xVsE
	NrSuFk/5aSWpk1nrC/F/hXoXgQUsLFRmtqVG/LFsi3jHaixbVw/aBxJ4SNYBistR4we7NEayF71OF
	bLt0KO9hNbXHhOqy7XgY3zYMqJ+NKhGJi2QiJnuqIon/PUdOJW04F1V2S3lNN2GYDdD7SJ7nXITXe
	HGuYuttF6J2mjStfBGSM4uP/JGB3SUYVlD8dN9ROeekUqEZ2+F0ZfVQ2e67x0yGJ3D2caS/vVVDub
	3AAqEDdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjybe-0000000ElYf-0L0B;
	Wed, 15 Jul 2026 12:20:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjybc-0000000ElXe-1Ua9
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 12:20:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 605213E41;
	Wed, 15 Jul 2026 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=tObKmBi4kD240+5jFg1/HvfThYVwFhh37YIRtiSqpSzSpMAKVzRs/zqlqozAI32jj5K/Ca
	iIyV/7tZ5hIaI6NiJLq7e5Q5zf5EY8iT9VXoqqSbMm9EdD1wLKNBTn0NZaITM95hpyXi9c
	cFwuF5M3wV3ewphrz51OPtLgOXvZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=91ZvY8fGeNhJYeZ/jTEnRwR8H+qtDA9dJH8VpBwG27SbvenZovIWtFV4RJNJSyBRaXXCB8
	O5tbWCUdIuZbfEBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=tObKmBi4kD240+5jFg1/HvfThYVwFhh37YIRtiSqpSzSpMAKVzRs/zqlqozAI32jj5K/Ca
	iIyV/7tZ5hIaI6NiJLq7e5Q5zf5EY8iT9VXoqqSbMm9EdD1wLKNBTn0NZaITM95hpyXi9c
	cFwuF5M3wV3ewphrz51OPtLgOXvZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqIdcZkl5wMk5+BaKH82ykdei6aC8VXm1/goFEqohQ=;
	b=91ZvY8fGeNhJYeZ/jTEnRwR8H+qtDA9dJH8VpBwG27SbvenZovIWtFV4RJNJSyBRaXXCB8
	O5tbWCUdIuZbfEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B253779AD;
	Wed, 15 Jul 2026 12:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lnidECJ7V2quTAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 12:20:50 +0000
Date: Wed, 15 Jul 2026 14:20:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests] nvme/069: add a test for multipath cdev lifetime
Message-ID: <7f5c5f13-78a1-4d66-bdc4-e2e2260dd949@flourine.local>
References: <20260714094345.3370884-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714094345.3370884-1-john.g.garry@oracle.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_052052_568129_342F6BD7 
X-CRM114-Status: GOOD (  10.75  )
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

On Tue, Jul 14, 2026 at 09:43:45AM +0000, John Garry wrote:
> +	# nvme-delay-ioctl will open the nvme-generic cdev, sleep, and then
> +	# issue an ioctl.
> +	# We tear down the nvme-subsystem in the foreground so we can catch
> +	# if the ioctl triggers a use-after-free KASAN warn.
> +	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
> +	sleep 0.5
> +	_nvme_disconnect_ctrl "${nvmedev}"

The sleep above is to give nvme-delay-ioctl enough time to setup,
right? Would it possible for nvme-delay-ioctl issue some signal (or any
other working sync method) and we just wait for it to show up? IMO sleep
should be avoided if possible.

