Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0AE9A03B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=; b=NNSA/TFsz65vjV/d/eR6U1D93x
	ulqHvrLKYKArHPOA6s1AZ9LTU6XrOGakIZM+wW/XpnZksCXE9jVPaUIC+vEjbAtmYIoJvdVfDTy4D
	buVO0nPSdkJqSiwihenxVwExDfIjGJeccugI8HNY+ntjIif61elLzFkyJqppn5B19c40nZ1yApO/8
	7P+RLgVz29R0WnkGjlpXhKRZ/12J7f6c/NFox4LWpoGFet144seWrayJFKeO0VCHFEtO985OBmzWC
	XlWeQB02Ynca+K1f+w0wgMtlayTtXZ8Y/1aKFWYuKQe7ScMjENpZvpABVs9Vr4wUEYVfGNZ46neWL
	P3mrPfVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt0kK-0000000BCEW-0UUs;
	Thu, 19 Feb 2026 09:54:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt0kG-0000000BCE2-3mft
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 09:54:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 313055BCC7;
	Thu, 19 Feb 2026 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771494889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=BNoOW7Ta9bzhOeu6BmeXIU3CukJpHmWhf3JW9U55bYDe1aXhPML9SZx/SzLQpHYLhXmhJ4
	XeVGHpBZQJ5QgPfCDgDwY8fSwMdoEGtFGUPljC2m7xODa/LGoDYo8q+ddBM8B+1FuVelER
	/Ms74PK1QoBqlMqzd9RmTdfnKCvairE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771494889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=rGfDI4SzjwY8KzuPdzLugT9WuovU6r0d+qVBpZP4QOsfeUm8yoYUXuMpMaf13jorWQpw7T
	DKkwtNsJvzv8ZWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BNoOW7Ta;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rGfDI4Sz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771494889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=BNoOW7Ta9bzhOeu6BmeXIU3CukJpHmWhf3JW9U55bYDe1aXhPML9SZx/SzLQpHYLhXmhJ4
	XeVGHpBZQJ5QgPfCDgDwY8fSwMdoEGtFGUPljC2m7xODa/LGoDYo8q+ddBM8B+1FuVelER
	/Ms74PK1QoBqlMqzd9RmTdfnKCvairE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771494889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3e7k0CMgUbTj2xC5pAxQgef7+E5hHmV9itvXo3DbZGE=;
	b=rGfDI4SzjwY8KzuPdzLugT9WuovU6r0d+qVBpZP4QOsfeUm8yoYUXuMpMaf13jorWQpw7T
	DKkwtNsJvzv8ZWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7D9B3EA68;
	Thu, 19 Feb 2026 09:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c/GwNujdlmkBSgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 09:54:48 +0000
Message-ID: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Date: Thu, 19 Feb 2026 10:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 313055BCC7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_015453_117190_1197E0B2 
X-CRM114-Status: UNSURE (   9.53  )
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

Hi all,

I (together with the Czech Technical University) did some experiments 
trying to measure memory fragmentation with large block sizes.
Testbed used was an nvme setup talking to a nvmet storage over
the network.

Doing so raised some challenges:

- How do you _generate_ memory fragmentation? The MM subsystem is
   precisely geared up to avoid it, so you would need to come up
   with some idea how to defeat it. With the help from Willy I managed
   to come up with something, but I really would like to discuss
   what would be the best option here.
- What is acceptable memory fragmentation? Are we good enough if the
   measured fragmentation does not grow during the test runs?
- Do we have better visibility into memory fragmentation other than
   just reading /proc/buddyinfo?

And, of course, I would like to present (and discuss) the results
of the testruns done on 4k, 8k, and 16k blocksizes.

Not sure if this should be a storage or MM topic; I'll let the
lsf-pc decide.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


