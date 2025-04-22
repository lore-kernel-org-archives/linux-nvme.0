Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C2C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znn97olydfurbU8I1YKq2FVYV1KXqvh/uxg7YALmhjw=; b=MwgoxIgo6ue7jSjRFz67BXUENu
	YePANRMQiXeElyQjvzPfW0Ox4QNgJow85W5d87gSYEzMI7V/RCL+Yb89lIU1z1F+1nTTmwpM6jaTF
	BWfGr4IQ0bq2IoDP3OT+5wxnAwDkffwFV3vUzS16xTrgz8zbYMecykY3LbyDXECWEcQsXo+0D+F/i
	AD1nUE8ocqeTBOVLSEh42nc3O8mLvEkmcCqQ/wtQoIOqFcdzZgQpjVIYOBgFCs9+BNEgiNbrOLGOo
	OqxEIN1YlfYkW9v20oTumGcgCaDghoU9wM4F4XGT4uejHGsNfEVCvCByM+VYsYGFDgmF97wF1cVEW
	LxOib9/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77GE-00000005zdl-3cFl;
	Tue, 22 Apr 2025 06:37:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77GB-00000005zbb-34T8
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:37:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0739C1F7C1;
	Tue, 22 Apr 2025 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znn97olydfurbU8I1YKq2FVYV1KXqvh/uxg7YALmhjw=;
	b=L1Lf9Jh563HnDAlC7XT599vndMOaowWHuGPDJFDR8uDibvek38+0AVpyF6yA5DNngdcoxm
	DhKJ1NF5MQeblYDD8qKOGqGUmGumvC4asiTqZOQEAuCXRpJBb3P0u2fW0CMNY+PXNUWHOv
	cjc/ZMXxZJnDdBvNAWC9sHLwPlSSHzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znn97olydfurbU8I1YKq2FVYV1KXqvh/uxg7YALmhjw=;
	b=pwh25zNMPmBWItgOJ7j9TqCLxiKUrj8XoW79uV6QCFkwAsKweXL2G8Uj4kre3U4LRoFM1R
	QTboZsUO9OIkHWCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L1Lf9Jh5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pwh25zNM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znn97olydfurbU8I1YKq2FVYV1KXqvh/uxg7YALmhjw=;
	b=L1Lf9Jh563HnDAlC7XT599vndMOaowWHuGPDJFDR8uDibvek38+0AVpyF6yA5DNngdcoxm
	DhKJ1NF5MQeblYDD8qKOGqGUmGumvC4asiTqZOQEAuCXRpJBb3P0u2fW0CMNY+PXNUWHOv
	cjc/ZMXxZJnDdBvNAWC9sHLwPlSSHzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745303854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znn97olydfurbU8I1YKq2FVYV1KXqvh/uxg7YALmhjw=;
	b=pwh25zNMPmBWItgOJ7j9TqCLxiKUrj8XoW79uV6QCFkwAsKweXL2G8Uj4kre3U4LRoFM1R
	QTboZsUO9OIkHWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86E30137CF;
	Tue, 22 Apr 2025 06:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXesHS05B2goKwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:37:33 +0000
Message-ID: <a13592e6-0259-4c12-ab6f-0e014bd62b3b@suse.de>
Date: Tue, 22 Apr 2025 08:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: frozen PHB on IBM Power9 system in 6.15-rc2 (bisected)
To: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
References: <20250417171026.b4474b4e2d0b528411c0e508@danny.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250417171026.b4474b4e2d0b528411c0e508@danny.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0739C1F7C1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_233735_916591_14679DEF 
X-CRM114-Status: GOOD (  11.40  )
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

On 4/17/25 17:10, Dan Horák wrote:
> Hi,
> 
> I am seeing "frozen PHB" on Power9 bare-metal (PowerNV ppc64le) system
> leading to non-accessible nvme drives (they are behind a switch) in the
> 6.15-rc2 kernel (originally with kernel-6.15.0-0.rc2.22.fc43). I was
> able to bisect the issue to commit
> 62baf70c327444338c34703c71aa8cc8e4189bd6 [1].
> 
> Please see [2] for full console log and other details. Please ignore
> the "soft-lockup" messages, they are unrelated and going to be resolved
> with [3]. We are building the kernel with CONFIG_NVME_MULTIPATH=y
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62baf70c327444338c34703c71aa8cc8e4189bd6
> [2] https://fedora.danny.cz/ppc/rdsosreport.txt
> [3] https://lore.kernel.org/all/20250410125110.1232329-1-gshan@redhat.com/
> 
Already fixed with 'nvme: fixup scan failure for non-ANA multipath
controllers', included in the latest pull request to Jens.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

