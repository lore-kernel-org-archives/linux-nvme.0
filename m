Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8A3F588C1
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1pmzU3JStOu/o8yR6qr9HmI4cSq7KWdDZtNY9XwL50=; b=o1/qP/WSDlnAFfgkpmuLXC6kND
	q+3YCuhQ8lzrHLk5fBNagxx9p0ZDjuaKHrrWwQiBvAXTR3YZOPWCrsAi32gRLKshzAJuYQywRoFRW
	1ZAe6XBXin0yXo25tgACH1xW+FJrf9Bpm65XDVI4LAUJHvsUSTnkBdmrt9Ip1qpTHJChMV2nQIP79
	NMSGPKa0m+vZ7g+8PA3kmTP1F24d+np1py7DUO9YBRNEik2mpvV3emVJqThcN3k0yyEHcgpQvdRZ9
	nqTrUPwbgioj0PSgbM5mEzgBVFbghB9pcyoTnQZLQ7dhSt3S/i4LMtiRzNtKnjUoPzGZaqVrRvOpT
	ZR6v6D6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEndp-00000006s5a-1eKr;
	Mon, 20 Apr 2026 12:22:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEndl-00000006s5D-0R6m
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 12:22:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 742CB6A7D8;
	Mon, 20 Apr 2026 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776687729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1pmzU3JStOu/o8yR6qr9HmI4cSq7KWdDZtNY9XwL50=;
	b=gcEHP2DkGoeitRoNqpBuEnldRoTnuOscV2KIvnJJO8eutv7h3vvmLgHTC5i/PebWUUbT0d
	MS2n1fBkcE9gSZ7sK9BNYdlk82Fs2N3aeMmPHNClPJBmbomFSvbEzsLba7bPpcjrRfFM31
	Gl3aDbBtCp3er9NV9BeOtXoAcLUA7QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776687729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1pmzU3JStOu/o8yR6qr9HmI4cSq7KWdDZtNY9XwL50=;
	b=eIK2h/3qMsqAmGawH7y7c5FW9bNkDj4iaAAEwaA7Y/5OD69ocEipGWRw3Hnt+FzTefrK1D
	MEtTJWqOSYPxHrDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776687729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1pmzU3JStOu/o8yR6qr9HmI4cSq7KWdDZtNY9XwL50=;
	b=gcEHP2DkGoeitRoNqpBuEnldRoTnuOscV2KIvnJJO8eutv7h3vvmLgHTC5i/PebWUUbT0d
	MS2n1fBkcE9gSZ7sK9BNYdlk82Fs2N3aeMmPHNClPJBmbomFSvbEzsLba7bPpcjrRfFM31
	Gl3aDbBtCp3er9NV9BeOtXoAcLUA7QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776687729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1pmzU3JStOu/o8yR6qr9HmI4cSq7KWdDZtNY9XwL50=;
	b=eIK2h/3qMsqAmGawH7y7c5FW9bNkDj4iaAAEwaA7Y/5OD69ocEipGWRw3Hnt+FzTefrK1D
	MEtTJWqOSYPxHrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61E86593AE;
	Mon, 20 Apr 2026 12:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6fGvFnEa5mlEbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 20 Apr 2026 12:22:09 +0000
Date: Mon, 20 Apr 2026 14:22:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify
 Namespace
Message-ID: <cb2c00e2-ba72-4d6d-b17f-ef5ae3b0633e@flourine.local>
References: <20260418042835.420281-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418042835.420281-1-coshi036@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_052213_341468_ECDAA2A0 
X-CRM114-Status: UNSURE (   8.81  )
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

On Sat, Apr 18, 2026 at 12:28:34AM -0400, Chao Shi wrote:
> Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")

This fixes tag is wrong. The above commit doesn't touch the code line
in question.

Probably a5b1cd61820e ("nvme: move a few things out of
nvme_update_disk_info") is the better choice here.

