Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E3C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zRmuiFygPdKWPfdghOCSue55HLExz7v1QnK4dEEXTA=; b=YfQhMbR+q7dx4rx+7N9KRp0Snz
	8tFmSaNNc1rqqFy2Q1xjsuGRrygtyD740dmVyBbFlXB3WCpkeZV9QNSfkHy8bZTTmwwKpTk/5w/B+
	c3+LrKTg3ixQRbfdhNkj53e/EAHQUszXQKCWkJX20kxlXg/28OAUI/RaDoTXOKnGSTm1q561wO5BW
	0GU2hFBTYlMvMaXBQ+lk4RvVUyhpiKu0bT8YvygHCHsMkLgCsSc3J91DaZqHWwqUaVyWFhNwsLJRG
	Or1v2kr4otHs6JX+UA6vpFVJxDXZz6pcG4KbIG4vZi/uIAbjGcG587KPynzvCKvr2UQsn26ubagKD
	DQSVfOFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1p53-000000016n2-1hjJ;
	Mon, 07 Apr 2025 16:12:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1oGN-00000000vu0-3ix6
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 15:19:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 555FE21179;
	Mon,  7 Apr 2025 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744039190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zRmuiFygPdKWPfdghOCSue55HLExz7v1QnK4dEEXTA=;
	b=CCy3hYFo9J3trAS5A8TaPqtz+QnUisSKiw789361yyR3XYm8IiVVF2zfUnIo92ByN5NRaQ
	cLK7lm2zUrnoaGnM2BL+5iXBZJDqFFD8//NRVtz6+wftqBUbln79DPUfIvLliekbTzsC4Z
	Iduvjag9ERWk91DGBd6g3aRUNuGdY+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744039190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zRmuiFygPdKWPfdghOCSue55HLExz7v1QnK4dEEXTA=;
	b=t0hNJ/2f0zGLFGUfDH9CQ2Pjy41ev5ksFVudez+2WBq5fQTT3Kv8E/PaxTg5DJ7su8XIl9
	qmq2qGMnLN054uAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744039190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zRmuiFygPdKWPfdghOCSue55HLExz7v1QnK4dEEXTA=;
	b=CCy3hYFo9J3trAS5A8TaPqtz+QnUisSKiw789361yyR3XYm8IiVVF2zfUnIo92ByN5NRaQ
	cLK7lm2zUrnoaGnM2BL+5iXBZJDqFFD8//NRVtz6+wftqBUbln79DPUfIvLliekbTzsC4Z
	Iduvjag9ERWk91DGBd6g3aRUNuGdY+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744039190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zRmuiFygPdKWPfdghOCSue55HLExz7v1QnK4dEEXTA=;
	b=t0hNJ/2f0zGLFGUfDH9CQ2Pjy41ev5ksFVudez+2WBq5fQTT3Kv8E/PaxTg5DJ7su8XIl9
	qmq2qGMnLN054uAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A1A313A4B;
	Mon,  7 Apr 2025 15:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qdsdERbt82f2OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 15:19:50 +0000
Date: Mon, 7 Apr 2025 17:19:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Message-ID: <9b957880-ec3b-4b22-a923-f5b91dee9b76@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
 <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
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
X-CRM114-CacheID: sfid-20250407_081952_086981_890D621F 
X-CRM114-Status: GOOD (  12.91  )
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

On Mon, Apr 07, 2025 at 07:49:41PM +0530, Nilay Shroff wrote:
> Both approaches — either adding a no-cache flag or introducing dedicated
> __no_cached APIs — would work. However, in my opinion, we should aim to 
> use a consistent method across both libnvme 1.x and 2.x versions.

There will be a lot of API changes for 2.x to address all the silly
mistakes. That's way it will be a major version change.

> As we discussed during LSFMM, if we plan to implement an "nvme top" command, 
> we would need non-cached versions of these APIs even for nvme-cli.

Yes, that is why I brought up this discussion. For such a command we
would need non cached versions. And I realize that we would need this
feature also for other commands. So it's not just the queue depth which
changes. Maybe we should just not try to add this feature to 1.x and
rather start the 2.x project.

> So, using the same mechanism for both versions makes sense. Otherwise,
> we’d also have to maintain different logic in nvme top depending on
> the libnvme version, which adds unnecessary complexity.

I don't see a big problem here. Either use the 1.x or 2.x.

