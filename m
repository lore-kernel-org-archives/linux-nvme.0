Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B99C7EE32
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kXrr1PYyQadCDFI98PzEv6/fiAaxkrmNxm2/JNEyvYI=; b=nVrRIByWo1HVOEDaMpQ0U4Dwbq
	oImrgfxOkiaBAQEnlWCadoS2Gv5xTdCbb4gYqvN8tOBP224gTIpblb5l3z+EqBq09y+5niCFPnS+G
	rSlegypDxir/rHq5+gLeY2dJkVcZAwGjtiVRe77hBv0DYBfQaWZ3S1T8bXmFu14Ys8NzuGlQzeAIY
	j9qYayIx5UQ4xNFTSOg7osFCSKEapLChZMjiyJXb4p7A8bmd6b5ZUR5bKUerrhdF4fIFko+6VkK4g
	hGCzXcoQrmEZWo5vdzA1+MXHkscAQVNObrakeyQyZFUbmRTfdm7IIyJf7vNGGh7XyVG1BirAYFiQW
	8SFur1Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUiY8-0000000B5iK-2nn3;
	Thu, 26 Jun 2025 09:05:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUiB6-0000000B0aj-2wFF
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 08:41:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEC0E2116A;
	Thu, 26 Jun 2025 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750927311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXrr1PYyQadCDFI98PzEv6/fiAaxkrmNxm2/JNEyvYI=;
	b=f2yC7XXL+GZcPYXR0CM2hBRgDmxB96RKOchPZAei6X8uvzqc8w4c0QLVEyWbSliEpX9t8X
	je52Yh+nF6R7mE2RmXw7tlPrzpn+uTIF1z0C57C9WeGftL538gytQzho+5rrnmhRXDAy8g
	yoCZcOuCr1Uc9EvN53E8HacL//h1H3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750927311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXrr1PYyQadCDFI98PzEv6/fiAaxkrmNxm2/JNEyvYI=;
	b=ZwlYuAn/sPErH0IMDk/3Gh2soS7jyGUuPF6IQOo06UfYrDt0Mb8akcX9Qs9+JZ/7p6/iaA
	lGzUD85UMRrE0hAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=moR7fcoj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DOQ9O3DW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750927310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXrr1PYyQadCDFI98PzEv6/fiAaxkrmNxm2/JNEyvYI=;
	b=moR7fcojdUU1fHTjyyWhnAj2TsWw7OOadSTc6xRIC6awqeBXfJ+aoGbBhHkSmVZ4PyfRsH
	L2TRN1Za+yZZgce6OOtuS13svJ/A1MI2Cg7k2HEHlcXacoBaP+2gNATqH6vO4OQKe1JuRo
	QjzV8XH52XkgmrdRMzMPXIkU+2jLu5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750927310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXrr1PYyQadCDFI98PzEv6/fiAaxkrmNxm2/JNEyvYI=;
	b=DOQ9O3DWvaa2n7cxhrDwM//zZVraJ8BWLDEpnrYndGsJySFVFiNtMdJKtXV23ydeApt8dX
	oLoNuLQY6kIojTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2ADB138A7;
	Thu, 26 Jun 2025 08:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FceLc4HXWiBQAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 26 Jun 2025 08:41:50 +0000
Date: Thu, 26 Jun 2025 10:41:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com, hch@lst.de, 
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, axboe@kernel.dk, 
	shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: Re: [PATCHv3] nvme: correctly account for namespace head reference
 counter
Message-ID: <72756ae9-078b-4248-bc41-c6c7dea68893@flourine.local>
References: <20250626051935.801205-1-nilay@linux.ibm.com>
 <c2233513-6736-4c2c-a757-96f205286f18@flourine.local>
 <45316d0a-97fd-4f0c-aabd-30015be94059@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45316d0a-97fd-4f0c-aabd-30015be94059@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DEC0E2116A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_014152_882573_63C13690 
X-CRM114-Status: GOOD (  10.53  )
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

On Thu, Jun 26, 2025 at 01:59:22PM +0530, Nilay Shroff wrote:
> The variable @last_path is meant to indicate that we're releasing/removing the last
> remaining path to the namespace, which is relevant only when NVMe multipath is enabled
> (i.e., ns->head->disk is set). So if we rename @last_path to @multipath, it could
> become less intuitive, as the name wouldn't reflect the actual logic — that we're
> conditionally releasing the nshead reference only when the last path to the namespace 
> is being removed. Hence, in this context, IMO, @last_path is more semantically accurate
> and self-explanatory.
> 
> Moreover, in nvme_ns_remove() as well we use @last_path in the same context as
> mentioned above. 

Thanks for the explanation. As I said nitpick/bikeshedding :)

