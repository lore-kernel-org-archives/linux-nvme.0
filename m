Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A13C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIetzjbiVEGTMcrTWBlDDNnlVN5rsVrvsgGQCgg/b18=; b=sM9uaJCOXxpzbCkVubT7dopST/
	WAmOs/ORbf/Q/yiymkWQokpZms9z8IHbNatLp+JQwPJO4RZ7I/l9Htl3+GazV0lFvQLWh6x07Curd
	+bPlzbZFKX9salbxddLrUYL98XghxvUivxcwHGbV66xmtFN7w4qyM7HWAunaothtd1G4eFt+Xo5Dd
	YmAlgRco0zkq883ZKcXtfPEAFjHTdnMh0CpKe/g3wM+6m5XR1nha/YK+LsV36EgYgFS+tB1yIWOiv
	dMPjDyzgQ7L5ozkjLAOIbRSDCLDv/+rxlhUz5uNcKqKHZeglzWQmJZlK/GTQ/xVT6ibYQ/8G7WO11
	2rRRglzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQvJ-00000004X8d-295Y;
	Mon, 12 Feb 2024 07:40:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQvE-00000004X7Q-3rPI
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:40:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0BC11F455;
	Mon, 12 Feb 2024 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIetzjbiVEGTMcrTWBlDDNnlVN5rsVrvsgGQCgg/b18=;
	b=Oic6HfSJu7XQ8tSBo3QZwuKoDJPpYhi80JFqSGzIww12z7AFT9qtfGBVzSWXcH2zFCaLRL
	PrdpScnlrCVJdlhStaJDfuFOh+JGdVVHagJZ47+RkJWvtT3WPRy07t+9HlFjpZEOyDoCWJ
	Odcu5umXDfluZHUvCEQ9wo40v414Mac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIetzjbiVEGTMcrTWBlDDNnlVN5rsVrvsgGQCgg/b18=;
	b=F1d8Dt+jkfdgy+6WT4G9fOiNE4dvCETDjsXjg258qbFl4uoOeJp5aAQ7BCaXCDfgnRD4Qg
	UyMk9PAogKZFzPDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIetzjbiVEGTMcrTWBlDDNnlVN5rsVrvsgGQCgg/b18=;
	b=iwzguCp574aTV4MmZVFZgWz5uoEHco9odQnotjYCuzOWXRIxzT8jszzg5fpNGCKTkmV7Hf
	K7FSDa6smUcmpCk1M6exzuC/X0Jxm7K6ahzNucC5VvYfz5QTjjm4kIWadjk41+OlFEkuka
	lGxbgkakKdHQpmX7BNLU1f3jLtQ4tls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIetzjbiVEGTMcrTWBlDDNnlVN5rsVrvsgGQCgg/b18=;
	b=nqBKFUyI7JbO7qXqHMg2/9t1cydof/kvEVADSlYvMenkNF/+znbdAgdIRCYR9OCSxRcLYx
	pERQKGG8n/+4dGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6730812FF7;
	Mon, 12 Feb 2024 07:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LgPjFVrLyWWcZgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Feb 2024 07:40:10 +0000
Message-ID: <9a780a15-9ff8-4738-9579-9c5cf8794cbc@suse.de>
Date: Mon, 12 Feb 2024 08:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 00/13] nvme: implement secure concatenation
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iwzguCp5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nqBKFUyI
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: E0BC11F455
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_234013_135022_793FB648 
X-CRM114-Status: GOOD (  18.32  )
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

On 1/27/24 17:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Hi all,
> 
> here's my attempt to implement secure concatenation for NVMe-of TCP
> as outlined in TP8018.
> Secure concatenation means that a TLS PSK is generated from the key
> material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
> is then used for a subsequent TLS connection.
> The difference between the original definition of secure concatenation
> and the method outlined in TP8018 is that with TP8018 the connection
> is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
> with the generated TLS PSK.
> 
> To implement that I have decided on resetting the connection from the
> nvme-tcp driver after the initial connection has been set up.
> Another way would have been to offload the connection reset to userspace,
> and let nvme-cli reset the connection. But that would be a modification
> to the userspace interface, and hence I didn't go that way.
> The drawback with this approach is that we'll create all I/O queues
> before resetting for TLS, even though these queues should never be used.
> But fixing that requires a larger rewrite of the TCP driver to unify the
> setup and reconnect paths. So keep it that way for now.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to the original submission:
> - Sanitize TLS key handling
> - Fixup modconfig compilation
> 
Ping?

Anyone interested in giving feedback?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


