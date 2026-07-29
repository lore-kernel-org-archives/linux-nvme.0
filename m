Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2275C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEGS5KUg/AXQKEws9Ldankh4DNcsA//+KzGGZkZxjjE=; b=kjrq4/3a3mcq6vJ210tDwAxwdh
	S8tbnlPxZ1udpF4VBqWN8F7y5q6q365ndpdPZkUzzWDt1LWWDECSXUGI3Zpz/5EKdDrJsSg+mwiXx
	FncS4O6Fr2ir74hjgH9KODtWTmmmz8koqMJpHzbM/sDWcPXNfX033KHFkI+9MJ51CPuGqo7pzSAAX
	s70MxqY5Hodu1g8rpf3ag3+im1U5Uzl3F4E+RQOPeQlgYlMSwC0/edOyk5AgYVYNvJSqMjPzmJw+w
	EoGM5bXmpSn7aeL+6op11cG2Wzlj1ivgcHH9RqoVZtgF2NCedTOjQGrXLNp0tsAUpuFqOE9JcxOWt
	o7GhFlrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4pZ-00000008Bwi-0ODc;
	Wed, 29 Jul 2026 14:00:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4pW-00000008BcF-3oag
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 14:00:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BB1C7B80E;
	Wed, 29 Jul 2026 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785333370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEGS5KUg/AXQKEws9Ldankh4DNcsA//+KzGGZkZxjjE=;
	b=RrumLfvhJXcUCeVeJnrM0bK+uuFJOu6+vHJ3/p+iPpMLVFj1+TD0auGz97iHTu/zROmO8R
	47dBfGXkYZ/W0Yusg3svZQrhQfSiDBXf1CxqNsEtJ9M9z3HObB0S5quJIrmaO9a86c3Nmn
	YrirA7Um37RojCn5pPCtjDmDDsX0ZQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785333370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEGS5KUg/AXQKEws9Ldankh4DNcsA//+KzGGZkZxjjE=;
	b=M7lCPoWhs9CNInsDOS6XmREYNGVwAZvFWElvkVpwsSVY0VlZ5YjzKeTtkxliqM+pjWLpjS
	ZZfRtvLJ7M5TQFCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785333366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEGS5KUg/AXQKEws9Ldankh4DNcsA//+KzGGZkZxjjE=;
	b=cL+uxMfTq5Gf36+QkgJ/7K5RKfdja4PSLx6DoftKF0kIihLE/2okYcWBEj+pl1xjPI4lKO
	km4f4hwfFPjcTJKFaop3Z8di9epD1fqZp6c+9qB5wDZYH4diNlXBSRrO09G3iWtghvB3sn
	nk0rqxpxcehGCfdkamnxq5F8Zui/62A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785333366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEGS5KUg/AXQKEws9Ldankh4DNcsA//+KzGGZkZxjjE=;
	b=+Fg5QnWKTNLEvbx9z5yzmKeP4M5GDdBDzD541zkAJoa2wmUcFVe7QwvTYnzgekF12jSoiK
	d1LlvQW83gqL+fBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08335779A1;
	Wed, 29 Jul 2026 13:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FaZWAHYGamqiFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 29 Jul 2026 13:56:06 +0000
Date: Wed, 29 Jul 2026 15:56:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-pci: return error when parsing a quirk string
 fails
Message-ID: <69b48ba3-ec3d-49fb-ada5-53332bce0034@flourine.local>
References: <20260729105958.1403095-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105958.1403095-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_070019_115667_36A6B2B2 
X-CRM114-Status: GOOD (  11.49  )
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

On Wed, Jul 29, 2026 at 06:59:58PM +0800, Guixin Liu wrote:
> quirks_param_set() reuses 'err', which param_set_copystring() left as 0,
> as the return value of the whole function. When nvme_parse_quirk_entry()
> fails to parse a field, the code jumps to out_free_qlist and returns that
> stale 0, so a malformed quirks= parameter is silently accepted as valid.
> 
> Set err to -EINVAL before jumping out on a parse failure.
> 
> Fixes: 7bb8c40f5ad8 ("nvme: add support for dynamic quirk configuration via module parameter")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

