Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC4FC3601E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWnS7ZQoISH7tTltcODp/HhWoPwVi1B6QySZDUbgnpI=; b=Wy1ec3/xLDYAUkRAJET3M1XSmk
	ZqGD2nNETRzzYIv+BkbYa+8ZZsoEEmxZwzr5Pd9haVZsWCJzeo6qYKiPUOsc3nRrF2r5wpkh+W2vq
	LD1JstQFaNgGZkCq0O4Bi9JLzyLRtUNovKFcdowP48xQ48zvVm7MWjuLMBO7lBeDGm7KqqvqcQSq8
	TWqATUbxjXOOao/uzLzQ0yv8d7jn3p2BBvrll01rddUvDyRs4TPh5tVlhE4SLPbSalyvZOjR3F41x
	YbWeAeahEefgiIJKmnf58CE2BL3F8QVMdlnOZ+6TBHYNezrkEhyv1U36qGQwR6T1U1Jax+yfnfbbi
	9s3vLGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iWt-0000000H8gq-2U5O;
	Mon, 07 Apr 2025 09:12:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hAC-0000000Gpie-3Oc1
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 07:45:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3196A2116E;
	Mon,  7 Apr 2025 07:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744011899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWnS7ZQoISH7tTltcODp/HhWoPwVi1B6QySZDUbgnpI=;
	b=KWw8eIKCtEi99rzmP3dmIrV6GMKD+NbRqaxvDTU+D5roLq1UeFWsToryVty/wmVXDbT0N5
	IUgU86ddIBHgSRR/TC+PhczSxhDfeYD+J1wY0Y3LD6MzMzRjaLTCpsMbYEHlyAq/FsxLSU
	KPmGhJrO+bReE/X//4NPnnj84CYVuAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744011899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWnS7ZQoISH7tTltcODp/HhWoPwVi1B6QySZDUbgnpI=;
	b=AkW6oiU/kMw+TN56CfDRSBlXeU3rVTNyyw5U47Q+ChCNAjpeh6cbI+l529HIbcDZtdgU2e
	D8hw780qKDKSY+Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KWw8eIKC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AkW6oiU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744011899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWnS7ZQoISH7tTltcODp/HhWoPwVi1B6QySZDUbgnpI=;
	b=KWw8eIKCtEi99rzmP3dmIrV6GMKD+NbRqaxvDTU+D5roLq1UeFWsToryVty/wmVXDbT0N5
	IUgU86ddIBHgSRR/TC+PhczSxhDfeYD+J1wY0Y3LD6MzMzRjaLTCpsMbYEHlyAq/FsxLSU
	KPmGhJrO+bReE/X//4NPnnj84CYVuAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744011899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWnS7ZQoISH7tTltcODp/HhWoPwVi1B6QySZDUbgnpI=;
	b=AkW6oiU/kMw+TN56CfDRSBlXeU3rVTNyyw5U47Q+ChCNAjpeh6cbI+l529HIbcDZtdgU2e
	D8hw780qKDKSY+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E9013A4B;
	Mon,  7 Apr 2025 07:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QGtqA3uC82cKHgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 07:44:59 +0000
Date: Mon, 7 Apr 2025 09:44:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Message-ID: <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405130255.448345-4-nilay@linux.ibm.com>
X-Rspamd-Queue-Id: 3196A2116E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_004500_995249_D2E4865F 
X-CRM114-Status: GOOD (  14.11  )
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

On Sat, Apr 05, 2025 at 06:32:49PM +0530, Nilay Shroff wrote:
> Add a new attribute named "numa_nodes" under the NVMe path object. This
> attribute is used by the iopolicy "numa". The numa_nodes value is stored
> for each NVMe path and represents the NUMA node(s) associated with it.
> When the iopolicy is set to "numa", I/O traffic originating from a given
> NUMA node will be forwarded through the corresponding NVMe path.
> 
> The numa_nodes attribute is useful for observing which NVMe path the
> kernel would choose for I/O forwarding based on NUMA affinity. To support
> this, export the attribute in libnvme.map so it can be accessed via
> nvme-cli.

This one has the same limitation as the previous one. Given that libnvme
currently caches everything, we could just accept this limitation for
the time being. Any thoughts on this?

