Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D8606BF89
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TGktupFS;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xm+ZD5FP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aj0yiL05;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xm+ZD5FP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aj0yiL05
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r04BRANH3wA40eTW8cvzPE5uiLd4nzgJ0JFGLGeCZqc=; b=TGktupFSwzV4klWj60CUzgFMv1
	edcHy4nlZGTFcqTjE/+8+DgCIHBhxlvjUDEb+C6Nfl3Z0rtzh175C/lh7QQiCHnalY/OY1D/dyfms
	ZfDnc/Vyd3ISGEOiOvd0VCSqjCLMfTAlMBATdjtDAiZrFAcboXW3O7+yLBGi+ypLbZbkIpUh5epRo
	wB+1ykKiGar70d60pzJu+vQ9qGLGZy6AFC8ZTilyhoE7qPDE38L0i0xIVrHnu0prBEXRrwyFGr+YX
	UeDzzgC/2kUs2i5r8lGGoEKtNHD9HbYfiXETOISeC15lbDBu1+B+owrNXXwt/MUHW/BvkqangaSSk
	0wlzmX0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBTf-00000001tDM-2i9X;
	Tue, 03 Nov 2026 10:10:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBTd-00000001tCL-2StM
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 10:10:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A9A9220C6;
	Tue,  3 Nov 2026 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793700646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r04BRANH3wA40eTW8cvzPE5uiLd4nzgJ0JFGLGeCZqc=;
	b=xm+ZD5FPPFAgTeTFjMGampp+v/PXrz1CkUiQloTBwujI5StJ1d1ZKUCMdrKtzNssvvuLlH
	SvZjeWsaH+llZjTyrcxDik+tbLY5We3A//Lp5x0Q5PNRPMJL2SvoLufh5qVcPuLI8XY6mD
	nn8FZTGNCPqIIoqj1hTSuU42BfCRPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793700646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r04BRANH3wA40eTW8cvzPE5uiLd4nzgJ0JFGLGeCZqc=;
	b=aj0yiL05xQ/GHHdph6kT2QTsXJlnxQ9GsSL3DVSppqsgsBVIffZibCddFW29782MOGV6Jc
	uOh9PKJmAKUKykDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793700646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r04BRANH3wA40eTW8cvzPE5uiLd4nzgJ0JFGLGeCZqc=;
	b=xm+ZD5FPPFAgTeTFjMGampp+v/PXrz1CkUiQloTBwujI5StJ1d1ZKUCMdrKtzNssvvuLlH
	SvZjeWsaH+llZjTyrcxDik+tbLY5We3A//Lp5x0Q5PNRPMJL2SvoLufh5qVcPuLI8XY6mD
	nn8FZTGNCPqIIoqj1hTSuU42BfCRPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793700646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r04BRANH3wA40eTW8cvzPE5uiLd4nzgJ0JFGLGeCZqc=;
	b=aj0yiL05xQ/GHHdph6kT2QTsXJlnxQ9GsSL3DVSppqsgsBVIffZibCddFW29782MOGV6Jc
	uOh9PKJmAKUKykDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC4C134B8;
	Tue,  3 Nov 2026 10:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HQBCAiaz6Wr9cgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 10:10:46 +0000
Date: Tue, 3 Nov 2026 11:10:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-rdma: remove dead allocated field in nvmet_rdma_rsp
Message-ID: <45a42b0b-a018-49a4-86f6-75d70600f663@flourine.local>
References: <20261103073307.2588945-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103073307.2588945-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alibaba.com:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_021049_775302_6CCAEB2C 
X-CRM114-Status: GOOD (  10.30  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 03:33:07PM +0800, Guixin Liu wrote:
> Commit 40f0e5dc2f3c ("nvmet-rdma: use sbitmap to replace rsp free
> list") replaced the ->allocated flag with the discrete tag value
> NVMET_RDMA_DISCRETE_RSP_TAG, but left the field behind. Nothing
> references it anymore, so drop it.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

