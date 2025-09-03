Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB4CA1012
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=; b=17yzcltMRKfRF1oHXo+JtXc/O1
	EiT/2WvkvZe23os8O0sgIRIBOY6jJRQ4PkcbJjjvLmwshxzlU/WpQIb6Gc96yWsY7YkWM1ivqcQZk
	DT+ZLXwVdksb3wbG3KQicSNyslK47uISChrUgjbW3mOqV8PKl5twZHcALXpN7ABJVPz02cEMvzbvL
	6O1ErFA0ObOm9I7K/R4amDIRpveoH52gfCr0qSYoWOJXilBvoI3KWD+VrkAuQjGwCC6QrT4tPPvGa
	JJ7gEKe6QHSXMLsvx2UXr56KZlQuhBhLJRmCLrioIOzbwlflWZ7R5y7WBebnDYWbFV3FWtPr/tPfz
	kArlCckw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utiSa-00000005NLt-23aC;
	Wed, 03 Sep 2025 08:03:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uti0i-000000058pE-2bYy
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 07:34:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5BE2211B3;
	Wed,  3 Sep 2025 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=1N/UGSpOow3koVOihoBs5joFlouPxI3j9zWWmpKex1XtbObd293BI2y8KgJUrkZwSTNzDR
	HnCPPG9wyhmrVaEPQL2VUeZNfaM2MAUSWT7r48Uvd7qTLhg13BRJPqEBRL5ARTsd8s6bLE
	UPo0tEQPSTgvWMt9KnTkZ3eWIc2AUn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=nuw7ZXz0XKmdidOGse8byaHKawQvJ0Mq1GYbCxUKbHojH7hjAVXfGUjznPpTCQF89hg2VA
	cn3nOQ/XAtXFJdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=1N/UGSpOow3koVOihoBs5joFlouPxI3j9zWWmpKex1XtbObd293BI2y8KgJUrkZwSTNzDR
	HnCPPG9wyhmrVaEPQL2VUeZNfaM2MAUSWT7r48Uvd7qTLhg13BRJPqEBRL5ARTsd8s6bLE
	UPo0tEQPSTgvWMt9KnTkZ3eWIc2AUn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gmnS8Lbbr5tva5ywgmmYTsBeEoqfSHcdoFxLATTI4A=;
	b=nuw7ZXz0XKmdidOGse8byaHKawQvJ0Mq1GYbCxUKbHojH7hjAVXfGUjznPpTCQF89hg2VA
	cn3nOQ/XAtXFJdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B036413888;
	Wed,  3 Sep 2025 07:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KyawKoLvt2ivQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 07:34:26 +0000
Date: Wed, 3 Sep 2025 09:34:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Daniel Wagner <wagi@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
Message-ID: <3b3bf8fc-592c-4732-8985-629e3baeaa34@flourine.local>
References: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
 <202508310442.lBWBZ5AC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508310442.lBWBZ5AC-lkp@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_003428_841949_16C44125 
X-CRM114-Status: GOOD (  19.65  )
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

Hi Dan,

On Mon, Sep 01, 2025 at 02:46:07PM +0300, Dan Carpenter wrote:
> Hi Daniel,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fabrics-introduce-ref-counting-for-nvmf_ctrl_options/20250829-234513
> base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> patch link:    https://lore.kernel.org/r/20250829-nvme-fc-sync-v3-2-d69c87e63aee%40kernel.org
> patch subject: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup code
> config: x86_64-randconfig-161-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310442.lBWBZ5AC-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508310442.lBWBZ5AC-lkp@intel.com/
> 
> New smatch warnings:
> drivers/nvme/host/fc.c:1492 nvme_fc_match_disconn_ls() warn: iterator used outside loop: 'ctrl'
> 
> Old smatch warnings:
> drivers/nvme/host/fc.c:3180 nvme_fc_delete_association() warn: mixing irqsave and irq
> 
> vim +/ctrl +1492 drivers/nvme/host/fc.c
> 
> 14fd1e98afafc0 James Smart 2020-03-31  1465  static struct nvme_fc_ctrl *
> 14fd1e98afafc0 James Smart 2020-03-31  1466  nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
> 14fd1e98afafc0 James Smart 2020-03-31  1467  		      struct nvmefc_ls_rcv_op *lsop)
> 14fd1e98afafc0 James Smart 2020-03-31  1468  {
> 14fd1e98afafc0 James Smart 2020-03-31  1469  	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
> 14fd1e98afafc0 James Smart 2020-03-31  1470  					&lsop->rqstbuf->rq_dis_assoc;
> 14fd1e98afafc0 James Smart 2020-03-31  1471  	struct nvme_fc_ctrl *ctrl, *ret = NULL;
> 14fd1e98afafc0 James Smart 2020-03-31  1472  	struct nvmefc_ls_rcv_op *oldls = NULL;
> 14fd1e98afafc0 James Smart 2020-03-31  1473  	u64 association_id = be64_to_cpu(rqst->associd.association_id);
> 14fd1e98afafc0 James Smart 2020-03-31  1474  	unsigned long flags;
> 14fd1e98afafc0 James Smart 2020-03-31  1475  
> 14fd1e98afafc0 James Smart 2020-03-31  1476  	spin_lock_irqsave(&rport->lock, flags);
> 14fd1e98afafc0 James Smart 2020-03-31  1477  
> 14fd1e98afafc0 James Smart 2020-03-31  1478  	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> 14fd1e98afafc0 James Smart 2020-03-31  1479  		spin_lock(&ctrl->lock);
> 14fd1e98afafc0 James Smart 2020-03-31  1480  		if (association_id == ctrl->association_id) {
> 14fd1e98afafc0 James Smart 2020-03-31  1481  			oldls = ctrl->rcv_disconn;
> 14fd1e98afafc0 James Smart 2020-03-31  1482  			ctrl->rcv_disconn = lsop;
> 14fd1e98afafc0 James Smart 2020-03-31  1483  			ret = ctrl;
> 
> There should maybe be a break statement here?

Hmm, the commit 14fd1e98afafc0 has a break after the spin_unlock.

+               spin_unlock(&ctrl->lock);
+               if (ret)
+                       /* leave the ctrl get reference */
+                       break;

And since then there aren't any changes applied.

> 14fd1e98afafc0 James Smart 2020-03-31  1484  		}
> 14fd1e98afafc0 James Smart 2020-03-31  1485  		spin_unlock(&ctrl->lock);
> 14fd1e98afafc0 James Smart 2020-03-31  1486  	}
> 14fd1e98afafc0 James Smart 2020-03-31  1487  
> 14fd1e98afafc0 James Smart 2020-03-31  1488  	spin_unlock_irqrestore(&rport->lock, flags);
> 14fd1e98afafc0 James Smart 2020-03-31  1489  
> 14fd1e98afafc0 James Smart 2020-03-31  1490  	/* transmit a response for anything that was pending */
> 14fd1e98afafc0 James Smart 2020-03-31  1491  	if (oldls) {
> 14fd1e98afafc0 James Smart 2020-03-31 @1492  		dev_info(rport->lport->dev,
> 14fd1e98afafc0 James Smart 2020-03-31  1493  			"NVME-FC{%d}: Multiple Disconnect Association "
> 14fd1e98afafc0 James Smart 2020-03-31  1494  			"LS's received\n", ctrl->cnum);
> 
> ctrl->cnum is always an invalid pointer on this line.  Another
> option would be to print ret->cnum instead ctrl->nmum.

Yes, this makes sense. I'll send a patch for this. Thanks!

Thanks,
Daniel

