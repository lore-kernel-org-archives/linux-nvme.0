Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E8C77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2ZchiFoDZK7GFVueO+L/sMwPhDa0k+fsvYDQVuGCSY=; b=uf1Y/sjYMoISTRdSvjFtdt5GBE
	S23HY03foBKUM/fUndB0ViejBdbvXFgGh116ohVm1UdhKRNQmUKG8HNDd3SevsBvX8AXRQ1fWG9vb
	CmUaNtHSFRGL8KTx0/diK4frtVuXRN81TUu5X2A9UvK3dx+9O1VuhuMzGy1pUhDEGT339INJjGSX1
	/M5eVOsO6E+kwXgi76918foM/LGUS7RYvzVVjWwQPrCZH/LdULuqh5Aqsbp1eu/eSbiP3VwcUwqvf
	O6EkFd7lRaRP8NHDjIe6Yx1RkCm5xfVAta4hFXgQ2Pywjy7sEZZ4b9mM+z7mOl23SdoO2QJhyXU6b
	A6hGBubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhFj-0000000ApfB-1Ast;
	Thu, 26 Jun 2025 07:42:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUh85-0000000AodK-0DLK
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 07:34:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E230A1F38D;
	Thu, 26 Jun 2025 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750923278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ZchiFoDZK7GFVueO+L/sMwPhDa0k+fsvYDQVuGCSY=;
	b=WMCthMGdli0ZfnoGasDh35EvFhqbD4c5tw9q9reicpc1XdUPU3fLHYgJDSNt8Jp6XWfUaO
	NqfliOVVdWPX2VyaUBBI4SFA54+7CpJVwv5BMZ/zQdtuz52KHRxahTz/iUhIb9Ydna/HB1
	KuUh0oGZVdMdh+DXxhgZg/ZXl8kFLOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750923278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ZchiFoDZK7GFVueO+L/sMwPhDa0k+fsvYDQVuGCSY=;
	b=9ahwNPV9vBdav/35MUNDfvokx9mo/RglQtu+fHHr16hYtPsaq9pHHJzIks08iMyqE/CMBW
	Wt4zsKk9WwzUeABA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750923277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ZchiFoDZK7GFVueO+L/sMwPhDa0k+fsvYDQVuGCSY=;
	b=Dg9ptmTz2oEiZXjzuJbq1SFAgBaFyUxdzhtPNCPzwIJ6yF/eRxKRrOQvHIAFQSspUv1LMF
	Qun5oMd6+9o4F5Z1hBP8ItqjA7jYC1yIMwxEnmPqUh0W5y1KXSqkOyd5mCurbt+qv67uCM
	NfF0AyTcCDHY13CWJpMS9k60utxdHZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750923277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ZchiFoDZK7GFVueO+L/sMwPhDa0k+fsvYDQVuGCSY=;
	b=4Yc+Cw8D/UYSFeUEjgKRHxQaBLKi1wNsy/pfBrLeMdYI/v85MbOlJ7vQwpshBKhk7wKqlq
	6Ankh/EsXfiP5sAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 862DD13188;
	Thu, 26 Jun 2025 07:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6iilHg34XGjgKwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Jun 2025 07:34:37 +0000
Message-ID: <51d3ce7a-0a2f-4e96-93d2-88c814a92c45@suse.de>
Date: Thu, 26 Jun 2025 09:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: correctly account for namespace head reference
 counter
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: yi.zhang@redhat.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 dwagner@suse.de, axboe@kernel.dk, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250626051935.801205-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250626051935.801205-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_003441_235749_B38EF7EE 
X-CRM114-Status: GOOD (  23.23  )
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

On 6/26/25 07:19, Nilay Shroff wrote:
> The blktests nvme/058 manifests an issue where the NVMe subsystem
> kobject entry remains stale in sysfs, causing a failure during
> subsequent NVMe module reloads[1]. Specifically, when attempting to
> register a new NVMe subsystem, the driver encounters a kobejct name
> collision because a stale kobject still exists. Though, please note
> that nvme/058 doesn't report any failure and test case passes and
> it's only during subsequent NVMe module reloads, the stale nvme sub-
> system kobject entry in sysfs causes the observed symptom[1].
> 
> This issue stems from an imbalance in the get/put usage of the namespace
> head (nshead) reference counter. The nshead holds a reference to the
> associated NVMe subsystem. If the nshead reference is not properly
> released, it prevents the cleanup of the subsystem's kobject, leaving
> nvme subsystem stale entry behind in sysfs.
> 
> During the failure case, the last namespace path referencing a nshead
> is removed, but the nshead reference was not released. This occurs
> because the release logic currently only puts the nshead reference
> when its state is LIVE. However, in configurations where ANA (Asymmetric
> Namespace Access) is enabled, a namespace may be associated with an ANA
> state that is neither optimized nor non-optimized. In this case, the
> nshead may never transition to LIVE, and the corresponding nshead
> reference is then never dropped. In fact nvme/058 associates some of
> nvme namespaces to an inaccessible ANA state and with that nshead is
> created but it's state is not transitioned to LIVE. So the current
> logic would then causes nshead reference to be leaked for non-LIVE
> states.
> 
> Another scenario, during namespace allocation, the driver first
> allocates a nshead and then issues an Identify Namespace command. If
> this command fails — which can happen in tests like nvme/058 that
> rapidly enables and disables namespaces — we must release the reference
> to the newly allocated nshead. However this reference release is
> currently missing in the failure, causing a nshead reference leak.
> 
> To fix this, we now unconditionally release the nshead reference when
> the last nvme path referencing to the nshead is removed, regardless of
> the head’s state. Also during identify namespace failure case we now
> properly release the nshead reference. So this ensures proper cleanup
> of the nshead, and consequently, the NVMe subsystem and its associated
> kobject.
> 
> This change prevents stale kobject entries from lingering in sysfs and
> eliminates the module reload failures observed just after running
> nvme/058.
> 
> [1] https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
> 
> Reported-by: yi.zhang@redhat.com
> Closes: https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
> Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Tested-by: yi.zhang@redhat.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v2:
>      - Fix typos in the commit message (hch)
> changes from v1:
>      - Avoid double free of nshead when multipath is not configured.
> Link to V1: https://lore.kernel.org/all/c2e2aa93-9213-4322-a95d-27447f8b08de@linux.ibm.com/t/#u
> ---
>   drivers/nvme/host/core.c      | 16 +++++++++++++++-
>   drivers/nvme/host/multipath.c |  5 ++++-
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

