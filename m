Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9892AC27C75
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=; b=DfPVRDDscNFFkeXMNu/9XXr67+
	IQMBMcGQFJHgufmZMuHHYddOCrUcdyBxhKq357NzhN1GnHcwaiNmvlg92EmU6kWl3FASFGjNHCS/O
	58T25Ecbac/kZTSSs3tHZWekik1RtCHJzyedAj3FstHGWZXp8WT3QJK8ua2Gebj17RlN9JjeJNokx
	41ZNyE2OORCnrMkJ7LZa1ltm+U/JMeMP6sTzM1VNzDy+Xg+rgw2/Cx+ZjvrEXvxNCYrITRcfm6Mkx
	AWsxqET4ooQ1KfAijNkAuf7WNbJUvwPCyDRr5X0LjdxqSkARXOSMuhkYhJGqybw2r3LlN9EjRBISF
	SQcNQ8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH0Dc-00000008ls3-1kMO;
	Tue, 11 Jun 2024 12:03:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz4G-00000008Vse-2xx5
	for linux-nvme@bombadil.infradead.org;
	Tue, 11 Jun 2024 10:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=; b=kLOjIRJri4ZvuGGWGRELxYFpfL
	coD69q4ZOuc9U5dNASV5aBgNrlXjE0UccYXs+7Y3m9I7FBXoigesgXNQ2l9g57dfpCGwwbTACooE4
	Z38W4fP444sI476a5C0Z70lCRkc4N6G7DJBnRXmOJKTgzRO6mfF545ICe+FJJgUUdTs7YMY8QF5VO
	dwqQmuhq3raJjmoUj1aZwbZ47XPcAzSV7UIv7bXw+yKWKWEp6ECfDYRp0f6idcEdtQMPX7b1KDOkl
	GrVWVql1EMCwe8uUAsTKh062wf/CI/OyQ59RdbQcdnvnX3wygRr4CVbX8jVXG+Kfbw8WDIxD/pfJY
	hJGv+fcg==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz48-0000000267o-47mD
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 10:49:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D5CD1F8B8;
	Tue, 11 Jun 2024 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718102964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=;
	b=Y28rrYX0D2ph9kZBobJdflOWcDBzzsehoARXSIb1WpGphWvVuABIDFybdqkWUOljiF4Gcq
	AfGPB646Mrd036c09GkZVPnZVHgJSEnnkmc4wJVdk83KOfCTyg9Hqm6w4NF+R1wE7oz/NE
	/iYdlrJgNBzF3vb7dFcjNeR2qo2YdsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718102964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=;
	b=9GIY2cEGRX0cVf0PlSeIpj+uaauOat9x2FN8EKbSser8iFtoro4hbjBr+wOa+57pfChcEe
	vvLEvYnShw6qA1CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y28rrYX0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9GIY2cEG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718102964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=;
	b=Y28rrYX0D2ph9kZBobJdflOWcDBzzsehoARXSIb1WpGphWvVuABIDFybdqkWUOljiF4Gcq
	AfGPB646Mrd036c09GkZVPnZVHgJSEnnkmc4wJVdk83KOfCTyg9Hqm6w4NF+R1wE7oz/NE
	/iYdlrJgNBzF3vb7dFcjNeR2qo2YdsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718102964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIuM4hYJTHlXn1mh2+6ewPv8lHKMoMXRH9iF4/GhSc8=;
	b=9GIY2cEGRX0cVf0PlSeIpj+uaauOat9x2FN8EKbSser8iFtoro4hbjBr+wOa+57pfChcEe
	vvLEvYnShw6qA1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DBE137DF;
	Tue, 11 Jun 2024 10:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AN/VFrQraGauDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 11 Jun 2024 10:49:24 +0000
Date: Tue, 11 Jun 2024 12:47:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/7] nvmet: debugfs support
Message-ID: <f6mwgpmbnmi7gwqgkmkkfmjjqvbakyo6nwqoxnthlynklby5iy@sidqfk6co3c7>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7D5CD1F8B8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_114928_445608_3BC495F4 
X-CRM114-Status: UNSURE (   9.45  )
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

On Mon, May 27, 2024 at 07:15:18AM GMT, Daniel Wagner wrote:
> I've picked up Hannes series, because it allows to reset a controler which is
> very helpful to implement failover tests in blktests.

I see that the nvme-6.11 branch has been created. What about queueing
this series up?

Thanks,
Daniel

