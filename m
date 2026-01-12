Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009B2D25046
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbQKFXf75/9z+KsVmUVjAw2+bYHqvjMxoGvu5Jn9ktQ=; b=1CWOfRJ/xlEsBKyt04xics4U9H
	q1bie/UhQdXWI7LB1p3fBL/RllmiZg4qt0nluY1yf7gWwE4PboKdVE1wDxl4mIZNJQwWo6bolueat
	2m3qGFfFiKbK3dAxwEv1YxsrOA4dVZ+FnU/e3E7wXwzFMkVgY2AmeC2ThEqm9AOz9DeimCpjN3/ti
	U2Ne5oCrNExjP6keyx0+gefMDDQUXPs76A4gOdsId9GMNRDJtjmm3fBPskDs7x3363KeNJYSODUsG
	oiUU5xu7/FJdynrqsouxKgvPbqRmDoBYv+ripsC3qQzk5XBAZmKuCEu+5KRbLHAGI5M1EjZghjG4J
	CY1h+DJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfD4S-00000004xkm-0jcZ;
	Mon, 12 Jan 2026 08:14:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfD4P-00000004xk2-1n9p
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 08:14:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 051323368A;
	Mon, 12 Jan 2026 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768205674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQKFXf75/9z+KsVmUVjAw2+bYHqvjMxoGvu5Jn9ktQ=;
	b=GYTrSpdAu+EeKlgtejFsE1D1RTqtDNpVm7fz4FqPgTiPcxbZsAMDqPG4SmiLtvf36HZL7Y
	0sh80/11ub2H21k7Y1p0guuAgbSHIXiBekVXMH99/hW2fpmFeD0gaRAUNCYOdcLftp2+Bo
	M3M+3sy9KvOVOnnJpU/Hz9ONZGITG/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768205674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQKFXf75/9z+KsVmUVjAw2+bYHqvjMxoGvu5Jn9ktQ=;
	b=Fv82jdWZlSNKj2P3mltQtd7tb2Z3Dcc8AVIdA28Pfyhumd6XEnwLXYksP69N09MVxfkxD1
	5wxwGBmoatS7DsDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768205674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQKFXf75/9z+KsVmUVjAw2+bYHqvjMxoGvu5Jn9ktQ=;
	b=GYTrSpdAu+EeKlgtejFsE1D1RTqtDNpVm7fz4FqPgTiPcxbZsAMDqPG4SmiLtvf36HZL7Y
	0sh80/11ub2H21k7Y1p0guuAgbSHIXiBekVXMH99/hW2fpmFeD0gaRAUNCYOdcLftp2+Bo
	M3M+3sy9KvOVOnnJpU/Hz9ONZGITG/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768205674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQKFXf75/9z+KsVmUVjAw2+bYHqvjMxoGvu5Jn9ktQ=;
	b=Fv82jdWZlSNKj2P3mltQtd7tb2Z3Dcc8AVIdA28Pfyhumd6XEnwLXYksP69N09MVxfkxD1
	5wxwGBmoatS7DsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4B5B3EA63;
	Mon, 12 Jan 2026 08:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4HcIN2mtZGnscAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 12 Jan 2026 08:14:33 +0000
Date: Mon, 12 Jan 2026 09:14:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <wagi@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Hannes Reinecke <hare@suse.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Wen Xiong <wenxiong@linux.ibm.com>, Narayana Murty N <nnmlinux@linux.ibm.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Ewan Milne <emilne@redhat.com>, 
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <d8512cdc-bdcd-44ff-a56a-974b4464a7a5@flourine.local>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
 <833fd772-da6c-4f91-87e3-e13883f1815d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <833fd772-da6c-4f91-87e3-e13883f1815d@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_001437_620358_B331900F 
X-CRM114-Status: GOOD (  24.53  )
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

Hi Nilay,

On Sun, Jan 11, 2026 at 03:03:43PM +0530, Nilay Shroff wrote:
> This was broken because with this commit d2fe192348f9 (“nvme: only allow entering LIVE
> from CONNECTING state”) now we don't allow changing controller state from 
> RESETTING -> LIVE. I saw we also had similar state change issue with firmware activation 
> code which was fixed by explicitly transitioning the controller state through RESETTING ->
> CONNECTING -> LIVE. We may employ the similar solution here for subsystem reset case as well. 
> 
> Currently, the NVMe PCIe subsystem reset code performs the following steps:
> 
> 1. Sets the controller state to RESETTING
> 2. Writes the subsystem reset command to the NSSR register
> 3. Attempts to transition the controller state directly to LIVE
> 
> This effectively bypasses the CONNECTING state. The transition to LIVE is artificial but
> intentional, since writing to the NSSR register causes the loss of communication with the
> NVMe adapter and the controller must be marked LIVE so that any in-flight I/O at the time the
> subsystem reset is issued, or an explicit MMIO read, can trigger EEH recovery and ultimately
> restore communication link between the NVMe adapter and the system.
> 
> With the stricter state transition rules introduced by commit d2fe192348f9 (“nvme: only allow
> entering LIVE from CONNECTING state”), the direct transition from RESETTING -> LIVE is no longer
> permitted, rendering the current logic ineffective.
> 
> Taking a cue from the firmware activation fix, it seems reasonable to explicitly transition
> the controller state through CONNECTING in the subsystem reset path as well. So how about making
> the following change to fix this? 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0e4caeab739c..3027bba232de 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
>         }
>  
>         writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
> -       nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
> +
> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +               goto unlock;
>  
>         /*
>          * Read controller status to flush the previous write and trigger a

This seems to be similar to case where the firmware update got stuck [1].

  650415fca0a9 ("nvme: unblock ctrl state transition for firmware update")

From my understanding this should work, but it's probably better to
double check that this doesn't violate any assumptions.

[1] https://lore.kernel.org/all/aBJJQoOBhaXj7P36@kbusch-mbp/

Thanks,
Daniel




