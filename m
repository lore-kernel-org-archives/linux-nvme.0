Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BFC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OiSoKR8SyN3tZT+7D38+1f+jEW1eOQvZVlnkpEXOcqM=; b=EozL9WN0SP0368RMuGRUzX32ij
	/GTH5w0PLI6A6ZbYBnJZyvPlTQYLiLRUne/SyW+8d/MoTRAouvq3Gg4YS2xYF7qa4uTirtHpAvq/x
	dn96XLnyMClp3hji63HgDVb0zoVXp9Ei/1d4H6k+b1a/atnetO/sIgVXlaN/wyWiJ2o1GGh5ckXDW
	06dhjbzuh8tqpZcgwGApPF5KbIjH+YsR92B8kmv6mIiLNMWiXtQBi61Lxcy0wiejs/CiYiSVXo6dm
	GO4ljDdv45X0WiX/CDyTjyMRDtYHRfNeKX7nslClSnXPBY25Tv3z69T4o0CdxHrZolrJbB74YoopL
	Q4UMCkFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrWb-0000000G9IC-12YM;
	Mon, 08 Apr 2024 16:07:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrWV-0000000G9FT-2p4G
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 16:07:11 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 444E120444;
	Mon,  8 Apr 2024 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712592423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiSoKR8SyN3tZT+7D38+1f+jEW1eOQvZVlnkpEXOcqM=;
	b=NaLqAYL33xLwWbv+HjwptFIQP7ieu+MhDfPrQTUHlYSwSJL6aJhGIY3iUHoJjWEJrgllGm
	UfoHVqZKM8UzEhYX81FE37hvBsu8Dgry8+6+a1Xf2j+zAvoCFw3zgtL3IXk8phkIj/3OKK
	zzcD+95myFI+sH4MnyB+I/oQBL36c1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712592423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiSoKR8SyN3tZT+7D38+1f+jEW1eOQvZVlnkpEXOcqM=;
	b=Xp8BtpgtdjVqYNv3fXI1oHJsba9NFSd3gtJ58eucViHMEPl02P0zMcOt4VIrBOfZqwsgCx
	zuECQ0UxAvmdl5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712592423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiSoKR8SyN3tZT+7D38+1f+jEW1eOQvZVlnkpEXOcqM=;
	b=NaLqAYL33xLwWbv+HjwptFIQP7ieu+MhDfPrQTUHlYSwSJL6aJhGIY3iUHoJjWEJrgllGm
	UfoHVqZKM8UzEhYX81FE37hvBsu8Dgry8+6+a1Xf2j+zAvoCFw3zgtL3IXk8phkIj/3OKK
	zzcD+95myFI+sH4MnyB+I/oQBL36c1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712592423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiSoKR8SyN3tZT+7D38+1f+jEW1eOQvZVlnkpEXOcqM=;
	b=Xp8BtpgtdjVqYNv3fXI1oHJsba9NFSd3gtJ58eucViHMEPl02P0zMcOt4VIrBOfZqwsgCx
	zuECQ0UxAvmdl5Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2810C13A92;
	Mon,  8 Apr 2024 16:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +tVSCCcWFGaJBwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 08 Apr 2024 16:07:03 +0000
Date: Mon, 8 Apr 2024 18:07:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Message-ID: <uvkgxqndcvgkphwuto7o6nimdsria35hc27v43zzo2h7kokor4@5olfmdazhi4f>
References: <20240326120342.105740-1-hare@kernel.org>
 <p6epmhukqjaiomqvxwgpwkoisg25yt46d5texh3sm4lkoump6h@b6ovzgutko77>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6epmhukqjaiomqvxwgpwkoisg25yt46d5texh3sm4lkoump6h@b6ovzgutko77>
X-Spamd-Result: default: False [-3.72 / 50.00];
	BAYES_HAM(-2.92)[99.66%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_090707_973640_1ADCACC7 
X-CRM114-Status: UNSURE (   6.97  )
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

Any chance to get this picked up?

