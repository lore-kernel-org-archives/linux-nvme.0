Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3CAC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caZjvLW+hxseAxT77cmxzbsXNeGlwFqNWf6vdwXoMmQ=; b=mqny8LveejN4n/17fPCbM+6Raq
	HkSW93YP094OgEfJgQl+0pp/++YmJlHfqTas+pnHnDayPhDX8ghAbxPc9zmBJf5QgeO6X41DsPwzI
	9uVrfwlyAoUUUd2ToTa4IrvQ1OnMSCG+OQoPd3OpGHMVc9ujNsRZWvtSDMTsseg0H1fU7MAC6iHD2
	1Azlx9rmKcEuiJmoL54wJmewWtH58Qteh2Lx8xXXaaF0NqT+zmsieXkOV0r5gzlmJhxNA58EHANYX
	H7D72s0N2HBhb5QxwVm8mpZdlFKNVVNrcm08n3TgP+IGoVLleXgIwPXolTzkAKsV1AGWd5wDyMVME
	mgIIPJcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rChj6-005FIh-2u;
	Mon, 11 Dec 2023 14:57:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rChiz-005FHv-0z
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:57:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5BF81F8B3;
	Mon, 11 Dec 2023 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702306649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caZjvLW+hxseAxT77cmxzbsXNeGlwFqNWf6vdwXoMmQ=;
	b=QSBsWdR4AyVvnoOF9irj1SI/sxmQcvnoY0ElO2wtV41hpLFmcYIVwUMNektfmRIP09oVvC
	jVovg2Oy9dFvXSOOIdm9iCEIno1leAtFaFmi9wk2x4c8lssuHjbvTj8oq5CpI4qnsMbvVG
	gMFJ4F2Lmodw0JGy9UQdsT4qxsQ+uyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702306649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caZjvLW+hxseAxT77cmxzbsXNeGlwFqNWf6vdwXoMmQ=;
	b=tk6BC9fPaJdR6Xg8G1mYvnrjkLXVCX55VR30bD4oGyHmRVYbjEHDr75A1wb6cYdpWv+Ia6
	fS/fWGTzitkfmjAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702306648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caZjvLW+hxseAxT77cmxzbsXNeGlwFqNWf6vdwXoMmQ=;
	b=qkR3GhEKSh4VMrjSRtwdjye1wdnyVLHHZpEvw3B8KGSOnNL9Qp97WYWVdR7x+YmiDq2FKP
	k74iqM/dVP7dlpzsYpqaFEZHZ9NPap4NwmqTflkFZousAkpn1DfmO7XQHMtD6qrx5B9CoT
	43W2wOd+VnU5RqAQiIeaOiLEDj6bFJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702306648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caZjvLW+hxseAxT77cmxzbsXNeGlwFqNWf6vdwXoMmQ=;
	b=mG9z7VV4j0GNgH/hnxSIULIS2UJqaZEgF8kAgIlqH5n0WtKEO2qGTcVzEnU325a3jc/Qgq
	AV2mOj+rN30vTmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F1ED133DE;
	Mon, 11 Dec 2023 14:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f4ouFlgjd2XOLgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Dec 2023 14:57:28 +0000
Message-ID: <0fffce6a-2a05-40ef-9cc2-f27e03da6b8d@suse.de>
Date: Mon, 11 Dec 2023 15:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: implement unique discovery NQN
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231211081033.14529-1-hare@kernel.org>
 <f7a25a88-a928-40f2-ba52-3c74356e58cd@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f7a25a88-a928-40f2-ba52-3c74356e58cd@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qkR3GhEK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mG9z7VV4;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-11.97 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.97)[99.86%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: D5BF81F8B3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_065737_551580_7AD1BF02 
X-CRM114-Status: UNSURE (   5.28  )
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

On 12/11/23 15:15, Sagi Grimberg wrote:
> So it also responds for the default discovery-nqn?
> 
yes.

Cheers,

Hannes


