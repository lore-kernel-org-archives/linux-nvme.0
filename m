Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C0E6529D
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Feb 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=; b=1MkoPDZXx88ChTeeH/lxIv5j4C
	QqZHEf2Cuaac9H/JbynUui8bPZNMpUzL5c0ZslvYVKHNAUdWB4SnX9Mssh984QDuPjxZunHGohMwM
	4mr/RrA8P34BBMJWR3O4ChfXhNpggcwvvqraJuvYAoZjbQbul5FYcImFa20XxCrH0LhQ50q9cHmFm
	mBm1Bw51NKrJQR49+djdzLVj4sl7+y+8c0mAY3vHaNbs8ymrIQj2S6BOksF6rpygR87hQMQ74riRp
	juPjvFeeDibxiHosXO22pMQqaQdNOdAjumjdAAmL5K4I0pIfoewxDogkczqYW56LtwPvy70DCuEls
	GNYFgKFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmaud-000000041LW-2PCw;
	Sun, 01 Feb 2026 17:07:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmaub-000000041Ky-02YZ
	for linux-nvme@lists.infradead.org;
	Sun, 01 Feb 2026 17:07:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EBD935333;
	Sun,  1 Feb 2026 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769965617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=Q3W+XikXte+zwB8vDEZ2JOJfS9pB5S/C7XdlArNEidopw+i7GLwtDx0Brde3uXk73i5A21
	3egDpDGg5uxXips9LHgUQgV1IaDEi4T709EjAOeaQheNC5jsc+b6zr84vX8CdlQ7uXgUkn
	FpNb4DEae/c18kFQUCpQyImRxGDb/50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769965617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=WXnGySUQFhe2jRqe8d4DtfUNbJ6/xi0xlcwtuBGzbzBhH2lg7htIFVD8daI94u35g+ZJqD
	qdEmlHp/ut+O2uCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q3W+XikX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WXnGySUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769965617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=Q3W+XikXte+zwB8vDEZ2JOJfS9pB5S/C7XdlArNEidopw+i7GLwtDx0Brde3uXk73i5A21
	3egDpDGg5uxXips9LHgUQgV1IaDEi4T709EjAOeaQheNC5jsc+b6zr84vX8CdlQ7uXgUkn
	FpNb4DEae/c18kFQUCpQyImRxGDb/50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769965617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhWs3crfA2G6ueORTmclwUlmcN2OtgYnNiy2QgcLdF8=;
	b=WXnGySUQFhe2jRqe8d4DtfUNbJ6/xi0xlcwtuBGzbzBhH2lg7htIFVD8daI94u35g+ZJqD
	qdEmlHp/ut+O2uCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8CF3EA62;
	Sun,  1 Feb 2026 17:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4tDFDGIf2nrWQAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 01 Feb 2026 17:06:57 +0000
Message-ID: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Date: Sun, 1 Feb 2026 18:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM?BFP TOPIC] Block-layer device resets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9EBD935333
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_090701_192413_C4630E98 
X-CRM114-Status: UNSURE (   7.76  )
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

We are currently working on implementing cross-controller resets for
NVMe, which requires to send a command to the target which then should
terminate all commands on a given controller.
While we could easily terminate the controller, the specification
also requires us to terminate all outstanding commands.
Which then recurses into my all-time favourite topic on how to
abort outstanding commands from the fs/bio layer.

However, here we don't have to dissect/match to individual commands,
but rather have to abort everything, which seems rather easier.s

So I would like to fathom whether such a thing is feasible/reasonable
(I think so, obviously, and can think of several other use-cases, too,
qemu springs to mind here ...) and discuss possible implementations
(set 'req->deadline' to zero for all pending commands?).
Or maybe we can do such a thing already and I'm just not aware of it...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


