Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9362C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cD969DqedPvn9ocM8gsHMXlD6VkX+HSsgfVsH5SCiDA=; b=WzpAmUCzG2JWYuy1+AAluISNmz
	WHIXshmaetFUbR/xu9d1NcmSPpraOBNLIQP6g+6fJpPvFKS50kYSK6mzsLs/9PdLSSomh6egENhnj
	39JUaHYeBLK6oMyPm5QpjvSAmqtuH5TRJiVLmz/SsEef7zlZaEInJ3rZiiQelXjmJYU1XzUCY7tH1
	S2j0CzokZzdmtR0KwaY4sdT2lV+8/fXhvaeoMcIwLuBrd0v6lhvGG3mGhuP6iTQi+ILFhokmqS/8m
	cy4F80/Rt7zlNlsKuG3Pqym8rSC+qeazbZs2itsLwZpJvGArFYfzLIb46fG3ilflQWZfWcpzjNaW6
	xtMhHv2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4dyg-0000000Eq0H-32XK;
	Wed, 08 May 2024 09:52:46 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4dya-0000000EpxQ-3i8Q
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 09:52:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25DC45C793;
	Wed,  8 May 2024 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715161959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cD969DqedPvn9ocM8gsHMXlD6VkX+HSsgfVsH5SCiDA=;
	b=dwUzX/1BQU4FVHddBv4H6MgeVkjezH0KqCMp+uFXQiHR5Mue2dmDrWqvvPiSm1KzXrJ9DS
	N5nQ+aI9+6ITIPx4Xf0v2cylAMbRvWCMvFl2NsvHgY7nDAId89gS6P+NvzY5EaILoDJJGe
	WX3UkqmN162L/9reF0us31x49vR9grE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715161959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cD969DqedPvn9ocM8gsHMXlD6VkX+HSsgfVsH5SCiDA=;
	b=4vdfenuTaoFeewgPfAKxyo10BCE5/CFYLOKYdgr+rgHM9n361zkfDoAzfifhGYHjRxDbaK
	JOnfEZL1wthq5jDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715161959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cD969DqedPvn9ocM8gsHMXlD6VkX+HSsgfVsH5SCiDA=;
	b=dwUzX/1BQU4FVHddBv4H6MgeVkjezH0KqCMp+uFXQiHR5Mue2dmDrWqvvPiSm1KzXrJ9DS
	N5nQ+aI9+6ITIPx4Xf0v2cylAMbRvWCMvFl2NsvHgY7nDAId89gS6P+NvzY5EaILoDJJGe
	WX3UkqmN162L/9reF0us31x49vR9grE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715161959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cD969DqedPvn9ocM8gsHMXlD6VkX+HSsgfVsH5SCiDA=;
	b=4vdfenuTaoFeewgPfAKxyo10BCE5/CFYLOKYdgr+rgHM9n361zkfDoAzfifhGYHjRxDbaK
	JOnfEZL1wthq5jDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1178A13A27;
	Wed,  8 May 2024 09:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ejZA2dLO2ZPJwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 08 May 2024 09:52:39 +0000
Message-ID: <3545cebf-42be-4181-a370-c1ec1069d388@suse.de>
Date: Wed, 8 May 2024 11:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, lsf-pc@lists.linuxfoundation.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] nvme-of connect retries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.52 / 50.00];
	BAYES_HAM(-1.23)[89.48%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_025241_177682_349DE635 
X-CRM114-Status: GOOD (  12.50  )
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

I'd like to request another session for LSF/MM:

NVMe-oF connect retries

There had been several discussions on the mailing list on how to handle 
failures or retries which occurs during 'connect'.
Issues to discuss:
- Should the initial connect return with a status after _all_
   queues are connected? That will introduce a severe lag
   for large installation, with the risk of systemd timing out
   the command.
- Should we try to combine workflows? TCP has three different
   'connect' code paths, one for the initial connect, one for
   reset, and one for reconnect.
- Where should a possible retry be handled? Should user space
   be responsible for a retry, or should it be left to the driver?
- If user space should be driving the retry, how can we return
   a meaningful error to user space?

It would be good if we could come to a consensus here such that
we can start consolidating the various transports.

Cheers,

Hannes

