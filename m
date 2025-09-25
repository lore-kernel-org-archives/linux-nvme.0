Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A9CAC5A7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=leOjThe1l7+nO3ZtY26UafjtMJhUwkahFyMlUkBR3GU=; b=DoH5BmgSDiVYHd9XetRlQWT+Hw
	w9xkX/LSUHZyYcAZMlcudifci6B/qtZgvhZsb0y+G8UVRH8Wgu3Plh9CnHZhSKXTAl0vApm+IduI7
	AdQaXYdRgvq6ROBjo4V7yvWbIn1MxvFv31hgcYYzaBFKnh/hbtAY9pvMWjw0ajrD67NVYPS5gG2fx
	g+dXgi3bnFj2TUW1ywtC5IX099hEizT6K9ZNvo2469Azr5DXr/pwc5lw/ohYEmXMmItfOiyJH4GI6
	LBPBpwf89wMm0VYT/aoicMLy6d2LG1I/CzgVBtwGZUJqM5Q3aV6QkZQ1cOUL4bPFKwjfKFPql55Sz
	5ete4qsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1kD0-00000008XUF-3rwR;
	Thu, 25 Sep 2025 11:32:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1kCy-00000008XRp-34Tl
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 11:32:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FCEA6A9DF;
	Thu, 25 Sep 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758799937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leOjThe1l7+nO3ZtY26UafjtMJhUwkahFyMlUkBR3GU=;
	b=M2myF5kWLAniW9/7a5yv7Bq76xrQx+0nca1EjB//QnOjMPDYs2VCcIV0rQjJw11qRFbnu6
	E4UfpZX44XM5lk6Em8QW/AEozSQYr4slY+TmfK4QSCPdA90/8A+N1/uVYIs0UCpcjQlZbw
	WZpgF2lXz5/MYzqHnahxc1CVPYzVFYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758799937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leOjThe1l7+nO3ZtY26UafjtMJhUwkahFyMlUkBR3GU=;
	b=TtgEj3G4ebI4LSo7uqkbwxYitLmjDF5S7EjoTEBZwQHwXeNOecQljQcj+cU/olEdrOKlH4
	ujupm+M9aObb17Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758799937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leOjThe1l7+nO3ZtY26UafjtMJhUwkahFyMlUkBR3GU=;
	b=M2myF5kWLAniW9/7a5yv7Bq76xrQx+0nca1EjB//QnOjMPDYs2VCcIV0rQjJw11qRFbnu6
	E4UfpZX44XM5lk6Em8QW/AEozSQYr4slY+TmfK4QSCPdA90/8A+N1/uVYIs0UCpcjQlZbw
	WZpgF2lXz5/MYzqHnahxc1CVPYzVFYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758799937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leOjThe1l7+nO3ZtY26UafjtMJhUwkahFyMlUkBR3GU=;
	b=TtgEj3G4ebI4LSo7uqkbwxYitLmjDF5S7EjoTEBZwQHwXeNOecQljQcj+cU/olEdrOKlH4
	ujupm+M9aObb17Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70E5D13869;
	Thu, 25 Sep 2025 11:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkWSGkEo1WjkBgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 25 Sep 2025 11:32:17 +0000
Date: Thu, 25 Sep 2025 13:32:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
Message-ID: <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_043220_916896_A7510BDE 
X-CRM114-Status: GOOD (  19.71  )
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

On Thu, Sep 25, 2025 at 11:28:04AM +0300, Max Gurtovoy wrote:
> The above mentioned commit 555f66d0f8a3 ("nvme-fc: update hardware queues
> before using them") was added to Linux-v5.15.
> 
> The qid_max support was added to Linux-v6.1 commit 3e980f5995e0 ("nvmet:
> expose max queues to configfs").
> 
> IMO the real objective of adding qid_max support is to make the subsystem
> more configurable and not for testing reconnect attempts of the host, as was
> mentioned in the commit message.

The nvmet change took a bit longer to get added. My main objective when
I wrote this ode was to test the reconnect attempt.

> This re-connect scenario can be easily tested in a different manner, and the
> target driver code is not there for testing the host driver unique
> scenarios. At least it is not its main goal.

As I said, I don't mind to change/adapt the test infrastructure, but not
the test case. FWIW, it found more than the above bug over time.

> I don't know how the driver will handle it but for sure this is a situation
> we would like to avoid.

No objection.

> I guess we can try fixing this problem in other ways, but why should we
> complicate the code so much ? let's try to avoid this scenario to happen and
> simplify the code where we can...

Sure. Maybe the failover tests should setup two controllers instead a
single one. But not sure if this is supported at all from nvmet or
blktests perspective.

