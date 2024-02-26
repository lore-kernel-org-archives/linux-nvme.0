Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A57DC5478C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VetWVjgm6+KIsR4jI5eMhI4TWRf1PhpvlcZxEWrziWM=; b=BDbYOGYTn73WiJzCq5CltZzSCs
	qvosGhfX9cGea51QKqJloSiNR7RCRr2e6zG/zy0U8LkWoc3IEkZdSoSimWZ1iSzOp884jTBBaWuyS
	Gjw+YhYjpeQ1RYgNMa2ZxMgDzqLCDAAq1qCnNqVtU8FeTdl8WnegY+kipWi4QUkT5NFZY02bkiqgy
	xWy8GZOTjClAnvPihsALotPb3623TW+AJ/tHhfz9D0kbaBHOentN6nUcf0W4osNC6UoY4x1Po0Ppb
	B04+f+bXIqSGOMHMwJZqIfljz65FgmAb1SvTvc/5je8y3n50g2JWoHQJuygQ/lsEMrOVGiW6FX/Nh
	StAD9ztQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVf7-0000000GrBx-3HNS;
	Mon, 26 Feb 2024 07:44:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVf2-0000000Gr8R-2QxC
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 07:44:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31BEF224F6;
	Mon, 26 Feb 2024 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708933465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VetWVjgm6+KIsR4jI5eMhI4TWRf1PhpvlcZxEWrziWM=;
	b=NnsCetrC1YfCP6yhHXppxW5hrFgjrrRaioQDMabeBIiiHQ4HcgKXOj4/SLWfWhq6DnZi8X
	T//PA0r1g9uVyyMScD0T6r1V5K3wtyQFQjF9dgvlUJ19+rh5zQBNzn5xlb1OF2ZNdDqkFz
	ZY6e/GRU3YrgPldOjpF33CAzmMV4naI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708933465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VetWVjgm6+KIsR4jI5eMhI4TWRf1PhpvlcZxEWrziWM=;
	b=2rWf+FJjbRFm2hnfBLKe7xj2Fc3JN+eR+LMTJ44l7cVKfBCMSOvlv2WBimdc+8tM+DvMJg
	BhOQr8aoykJvZcCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708933465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VetWVjgm6+KIsR4jI5eMhI4TWRf1PhpvlcZxEWrziWM=;
	b=NnsCetrC1YfCP6yhHXppxW5hrFgjrrRaioQDMabeBIiiHQ4HcgKXOj4/SLWfWhq6DnZi8X
	T//PA0r1g9uVyyMScD0T6r1V5K3wtyQFQjF9dgvlUJ19+rh5zQBNzn5xlb1OF2ZNdDqkFz
	ZY6e/GRU3YrgPldOjpF33CAzmMV4naI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708933465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VetWVjgm6+KIsR4jI5eMhI4TWRf1PhpvlcZxEWrziWM=;
	b=2rWf+FJjbRFm2hnfBLKe7xj2Fc3JN+eR+LMTJ44l7cVKfBCMSOvlv2WBimdc+8tM+DvMJg
	BhOQr8aoykJvZcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A02C13A3A;
	Mon, 26 Feb 2024 07:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GlEBAllB3GVFBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 26 Feb 2024 07:44:25 +0000
Message-ID: <beef936a-c3aa-4300-b141-ab37ad5d7bf1@suse.de>
Date: Mon, 26 Feb 2024 08:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240223105804.44473-1-hare@kernel.org>
 <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NnsCetrC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2rWf+FJj
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.21)[89.25%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31BEF224F6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_234428_810990_3E1EF178 
X-CRM114-Status: GOOD (  10.70  )
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

On 2/23/24 14:29, Daniel Wagner wrote:
> On Fri, Feb 23, 2024 at 11:58:04AM +0100, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Any authentication errors which are generated internally are always
>> non-retryable, so set the DNR bit to ensure they are not retried.
> 
> This still keeps nvme-fc in the retry loop. It fails with -126 which is
> -ENOKEY:
> 
> [ 2267.185691] nvme nvme0: qid 0: no key
> [ 2267.187596] nvme nvme0: qid 0: authentication setup failed
> [ 2267.188866] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id 2a3022dff0fe0000 ret -126
> 
Aw. Bugger.
Of course we do retry, as negative transport errors are considered 
retryable. Curiously enough, negative _NVMe_ errors are considered 
non-retryable. Hmph. We may want to work on that.

Cheers,

Hannes


