Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37899CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWJ8tXB7U/J3RvmIf2ZKBsVr78qVoj2Vn5PRPGC0h5U=; b=djteP26hOY8YDoyTI7jYITpHnz
	NgEar3AY5Q8c+DHxkEVUDisi4bebuQClPXpcRZiaiyFX96gh2cCW/fF1Vkzx6CNKZKVR56QnjtFM7
	zjxHa2jARIV8UqGvFiVKYWQPrQvBAbHwOmWbZb+jR4VqUqDdl9M2hWk0QBJV8m6Ma7irDLWuBnIvF
	3XIIuvEpX8cbGk1cKeshINMe62J1zXO4CwubrSeWcdPFYpjXoWzN0q7ZuRQFc+EHioQO5PjM0VZXc
	MXBwcw+aHAV6IuCvZUPqQmq2gh0oO+uMR/zvbgLrtkINpvT0GSX9dXqtUZKYFoTqm2TbmrPbJ32P6
	qBBhqKtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8VP-00000003Rxi-2NrY;
	Wed, 27 May 2026 07:16:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8VM-00000003Rx1-3GPn
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 07:16:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DED7D66D32;
	Wed, 27 May 2026 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWJ8tXB7U/J3RvmIf2ZKBsVr78qVoj2Vn5PRPGC0h5U=;
	b=2Iw3iaYbGV71/DMxIpd0PjEFmC6f2ala/T4UeViiSQhvdj3ardxqmyoFfhNUDY65mpjs9S
	4k5HSAAl+R4Lye/p5EPWtRee67x+hrZPp1fgIm6EVrzv5cXAUrinL2DBTOLmSErf3Bdpz2
	ppDXWuy8yh1SpsrpL6bNzaKoMSTTfHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWJ8tXB7U/J3RvmIf2ZKBsVr78qVoj2Vn5PRPGC0h5U=;
	b=N3BVKHucZKPTaUrOhSP5hJiUzHaJNKeLyEd6otM0xNLPk8C530sNgT3jXtHs050HG2ko3t
	1+xCN652peBvnkCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWJ8tXB7U/J3RvmIf2ZKBsVr78qVoj2Vn5PRPGC0h5U=;
	b=EQRxVIxThQeA7MVFUQ+1GeTD9Qzuzapi7TFPpTey2FWxW0gD8jQL0xyuCPQ2IJGdY3QLyb
	Y6sQ7YMMKoOKibx3WtG66eqaGrpvKWpHdt16C2aDR9PfEmPD+qu+2cw2ErWj4QRppddecA
	SMRvraUy1XAeOPhi0NdnsNHd4XQTnJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWJ8tXB7U/J3RvmIf2ZKBsVr78qVoj2Vn5PRPGC0h5U=;
	b=nmLDnaEJXxGS7DyqdHLkW3HpELYSdkOYLpOQ4fqcJsq74ksSEBfs/Jd3WZVKS1DfQ+anKl
	WwLDR9Dw9OvRbdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98D475A6E7;
	Wed, 27 May 2026 07:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/4tJFaaFmq5KQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 07:16:38 +0000
Message-ID: <fe016658-05e6-4563-83e6-d18a53016bb6@suse.de>
Date: Wed, 27 May 2026 09:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/8] nvme-multipath: pass I/O type to nvme_find_path()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260520182112.863076-1-nilay@linux.ibm.com>
 <20260520182112.863076-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260520182112.863076-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_001640_964307_F627AA05 
X-CRM114-Status: GOOD (  10.54  )
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

On 5/20/26 20:20, Nilay Shroff wrote:
> Currently, nvme_find_path() only accepts an nvme_ns_head argument.
> However, the upcoming latency-aware I/O policy also needs to know
> the I/O type (read/write/other) associated with the request in order
> to make path selection decisions.
> 
> Update nvme_find_path() to accept an additional argument describing
> the I/O type. This patch does not introduce any functional change and
> only prepares the interface for subsequent latency-policy changes.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/ioctl.c     | 38 ++++++++++++++++++++++++++++++++---
>   drivers/nvme/host/multipath.c |  9 +++++----
>   drivers/nvme/host/nvme.h      | 19 +++++++++++++++++-
>   drivers/nvme/host/pr.c        |  6 ++++--
>   drivers/nvme/host/sysfs.c     |  2 +-
>   5 files changed, 63 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

