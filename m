Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFEFC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/79ihpy394aQuCVpnVhXdNNZMOBSt4MWkruU8LHELZo=; b=drH7U8h44trf5o6wRkFj9Ofpp2
	e6u7R9zLmHaz9w66BLXHxkm46NlwttpU3Thx2kXsZ1/VyqtQbxUwCJ9+tW9T+iwnt3UaZcpKxr4ZY
	S0oh/cjhBLDu+LNyfbHYt+JfH6QODopwduNL/ygN3TepBuX7Arkzku5ObmMar8wHyrUq3nHvKq49N
	Mz+KaZ5AH3ISUzOyoAL92vrMDy/bvT/O0rvMwLBIIh6VUVdcHHuOrIlQpfpPQjXu00Re9D9SDoJrR
	JGtSPJzvaVmqH2uDdV9PjT0M1LsUqKLqzRhCva4zEyCvSByBoMKJreloGzRzhYWVuJliamr7FAwC/
	AqNFKkAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx3lw-0000000Fp5E-329H;
	Wed, 17 Apr 2024 11:48:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx3lq-0000000Fp1k-2gWv
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 11:48:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6D121D16;
	Wed, 17 Apr 2024 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713354478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/79ihpy394aQuCVpnVhXdNNZMOBSt4MWkruU8LHELZo=;
	b=VhywpmIodySW7SmuIbcUnPuszr3DfoDRhKQlvB+Kui5W0c7b9129/RJy217qZtuxVr2hWr
	ZgdNLsWP+lZ+RzqDu/zT6bVFk4YlXIKQDfDXnUlysrfw4OTVPupoPgO1+44mGTmSHy9Ltk
	mkDg+Il+pGTT5ZjvYWQ7Zsb2A413mSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713354478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/79ihpy394aQuCVpnVhXdNNZMOBSt4MWkruU8LHELZo=;
	b=BTznl9lVf0TSjNPd0Jjl/A2cAFHYLYTikgNCdn7HG143BnweJBA5zYqZIIm9xa9iDJUtOg
	29DJqnGBFalQ4+DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VhywpmIo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BTznl9lV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713354478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/79ihpy394aQuCVpnVhXdNNZMOBSt4MWkruU8LHELZo=;
	b=VhywpmIodySW7SmuIbcUnPuszr3DfoDRhKQlvB+Kui5W0c7b9129/RJy217qZtuxVr2hWr
	ZgdNLsWP+lZ+RzqDu/zT6bVFk4YlXIKQDfDXnUlysrfw4OTVPupoPgO1+44mGTmSHy9Ltk
	mkDg+Il+pGTT5ZjvYWQ7Zsb2A413mSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713354478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/79ihpy394aQuCVpnVhXdNNZMOBSt4MWkruU8LHELZo=;
	b=BTznl9lVf0TSjNPd0Jjl/A2cAFHYLYTikgNCdn7HG143BnweJBA5zYqZIIm9xa9iDJUtOg
	29DJqnGBFalQ4+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E5313957;
	Wed, 17 Apr 2024 11:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6CbLCO62H2a2DgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 11:47:58 +0000
Date: Wed, 17 Apr 2024 13:47:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Brzezinka, Sebastian" <sebastian.brzezinka@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"Zawadzki, Tomasz" <tomasz.zawadzki@intel.com>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli spdk plugin 
Message-ID: <6ptveqelhggirg4qf2xi3ekayq5g5vno3z4ksuakhczmbfpjx4@rwkupvmn6j6s>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <2ed308dc-95d3-4f7c-8c3d-134f5ec56063@grimberg.me>
 <MW4PR11MB6909AABD66425491A12CA138ED0F2@MW4PR11MB6909.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB6909AABD66425491A12CA138ED0F2@MW4PR11MB6909.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3D6D121D16
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.11 / 50.00];
	BAYES_HAM(-2.60)[98.20%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_SPACES(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_044810_856874_4E4CFE87 
X-CRM114-Status: UNSURE (   8.81  )
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

On Wed, Apr 17, 2024 at 10:17:35AM +0000, Brzezinka, Sebastian wrote:
> > Can spdk emulate the way nvme devices expose themselves but in different path prefix?
> 
> SPDK right now cannot update sysfs, only CUSE in /dev/spdk/ is available.
> https://spdk.io/doc/nvme.html

But what about implementing a FUSE filesystem which mimics the layout
of the nvme subsystem as Sagi suggested. It would avoid all the special
handling in nvme-cli/libnvme and you get the 'nvme list' for free (sure
we need to parse two hierarchies but that's easy to change in libnvme).

