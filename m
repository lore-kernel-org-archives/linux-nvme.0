Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB49CD37AD
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESkhWvbG3A+XjwvKUYyxs6RdR4ihUgReJadYYox6gW4=; b=2kdj0Blhp7Es/8Ly49v0ApD2Uz
	1EkadATcEpI/sEn7kDnKXzAgZ6sNLoN7yXVvKv6yrYZ/RC3Q9PFHOoNTv8rkx2qH2vWbw9Q+TDX30
	b5Xk/TxBe7S/H424lxEnz2rO2PLhl0X9GNCFJrzBT9ZfIpk/MZ4yAUX8GscobxJd6+BF12Q7wZczh
	QJTko5uNXBhccGCeNv/sN49is2ZEiVS/Q58CpDPvhzzm5KDtiPwb0P1Uug9ILtv8HVRJZ+9ck6mEF
	CzsMllqdgATJA1tCF8i9Qj0BanF6rgAzK71NmyS5Xfyq+wM6skD63ZO68fSORK8lnaLL1vYZzCZig
	G96g0gdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOW1-000000073E1-0OBM;
	Fri, 08 May 2026 16:57:29 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOVs-000000073DQ-1c3R
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 16:57:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E1F05BF18;
	Fri,  8 May 2026 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778259436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESkhWvbG3A+XjwvKUYyxs6RdR4ihUgReJadYYox6gW4=;
	b=clQgteHFHwZxpHN3z1XEoHEQOYsaJxIC4cgR5TnGF2bmBLpyNMq6+2JJ9RKPnNXpWlnHW5
	2yW8ri1lYDsEHKOoTAU7DA6W/crdgxCYV9HaySaqz/mOijoZkCE3OScGahFaq0HWlpAet+
	F98ryu2Q8b1yYWeFYogU69ArSOJjTZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778259436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESkhWvbG3A+XjwvKUYyxs6RdR4ihUgReJadYYox6gW4=;
	b=78SKmedbe1ykOSEqXIVkP61ZYLw4RliEvuXZFDiSJ9MawiyEvC1ZseMChdNPdN1lJwuAui
	0yIUxDugyyYIGCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778259436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESkhWvbG3A+XjwvKUYyxs6RdR4ihUgReJadYYox6gW4=;
	b=clQgteHFHwZxpHN3z1XEoHEQOYsaJxIC4cgR5TnGF2bmBLpyNMq6+2JJ9RKPnNXpWlnHW5
	2yW8ri1lYDsEHKOoTAU7DA6W/crdgxCYV9HaySaqz/mOijoZkCE3OScGahFaq0HWlpAet+
	F98ryu2Q8b1yYWeFYogU69ArSOJjTZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778259436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESkhWvbG3A+XjwvKUYyxs6RdR4ihUgReJadYYox6gW4=;
	b=78SKmedbe1ykOSEqXIVkP61ZYLw4RliEvuXZFDiSJ9MawiyEvC1ZseMChdNPdN1lJwuAui
	0yIUxDugyyYIGCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 542A4593A7;
	Fri,  8 May 2026 16:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e8DoEuwV/mleXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 08 May 2026 16:57:16 +0000
Date: Fri, 8 May 2026 18:57:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin timeout
 per nvme controller
Message-ID: <9361f2c7-15ee-4ba1-9931-332354b04217@flourine.local>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-3-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_095720_574791_076547DA 
X-CRM114-Status: UNSURE (   9.04  )
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

On Fri, May 08, 2026 at 03:33:28PM +0200, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom admin timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

