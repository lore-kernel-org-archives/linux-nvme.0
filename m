Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00ACCF2E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eizw4Kp0fIdeSJH2kfJJvLAORXAdc5N5Ckf4TmLSqPo=; b=PXf4aEPOcOn59rwdtX+6kT/L/p
	9575Vr8BVhYFG0ftS0njWLn5EAtYSqY0I0Kpg/w2GCWDbxp+EwzPvHeFuboqfhyk3TP+wkWSIZG4B
	nDA3ocUV55QskSEqdjjVL3cxq0IaAnksnjViI7i5MVeDdf66zy4bzJhQobr4rjdNz7rWqjeJR0WO0
	RpKjukVl3UBB0bs9pmQl8xn5Hm9bDInNc3FBH2R5wzPgHUqCSR6Oe6CzxumTT6wqNU7+ijNANSNV5
	q4AwLMjqrB2AONxwBETSvRfjYG9L04hB2TnJKKxSG01FPc11oUAuIIfxV1Ud8X7GDC3Da/8jhXtMf
	IsWxHoeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm3e-00000007KxJ-0lD6;
	Mon, 19 Oct 2026 12:01:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm3X-00000007Kwm-0Gvk
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 12:01:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A551D21CAB;
	Mon, 19 Oct 2026 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792411283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eizw4Kp0fIdeSJH2kfJJvLAORXAdc5N5Ckf4TmLSqPo=;
	b=E2juYitcp/qobVMtOz9jE853ph6Gq1X9Zo7mt01mrGjaRRJ1xLxgTl1BhBqot+Bb0EXJhF
	wHn8lacXnqkwMZoQFugyAwQkd/w46D7jjX1gf0tsP+y/ibEsyWI9GPYqVX90gVTdWxOHuR
	YQvX2BIqeZ9DWvSpPdMWEtrQn3jMGq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792411283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eizw4Kp0fIdeSJH2kfJJvLAORXAdc5N5Ckf4TmLSqPo=;
	b=B+5CrO4GXcb2bzjj+cekLWGvGil3GioODo37qAn17GSktk2LJyn5tjeFP1VHYPct/LRGpS
	NIxhKw8Tg8jQINBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lyYoJ6Ji;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="X/4CYOJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792411278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eizw4Kp0fIdeSJH2kfJJvLAORXAdc5N5Ckf4TmLSqPo=;
	b=lyYoJ6JiarDMyrCxZqTcc2OA2F/+J9aCig+Xsp/07GwWWGsxWURhEPzv5R2Y+UKk1TnX8A
	H92jL14TrFLys/5abUjf1LVLI7IHaVFqxen7naykFdnvem93qzYgCg/b/7t+pCEvEaMtw6
	i8JodyS5aFqLyP87p6dLUAx598h3kMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792411278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eizw4Kp0fIdeSJH2kfJJvLAORXAdc5N5Ckf4TmLSqPo=;
	b=X/4CYOJShcC0aCzxwrpzZpEi37m9AOys9POzAd2xR6sIx6Muy37Rl0pc7PYp+avCrU8OKW
	0B2hexYJjVF4eXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B996136CC;
	Mon, 19 Oct 2026 12:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vi1wFI4G1mojTAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 12:01:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Justin Tee <justin.tee@broadcom.com>, 
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260920182936.2317916-3-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-3-mkhalfella@purestorage.com>
Date: Mon, 19 Oct 2026 14:01:13 +0200
Message-Id: <179241127352.3544975.2554197788837860779.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A551D21CAB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_050131_397718_8607C0BB 
X-CRM114-Status: UNSURE (   9.42  )
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

On 2026-09-20 11:28 -0700, Mohamed Khalfella wrote:
> Export ctrl->ciu and ctrl->cirn as debugfs files under controller
> debugfs directory.

Could you add the 'why' part to the commit message?

> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Besides the missing 'why', it looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


