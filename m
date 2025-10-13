Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDACCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PlBEysjjE37wP9lwjqUsyECeaGSphVUR4oADVX5jxbE=; b=AX5t+U2lB1fXuHhCRclD4oCJvr
	ziIr5S3EufLxmdYV0b24ct3016zG981zgjgoSOe+6rItU30ZNeNUMnX2NLS152HIOS9UOHzaq6ldV
	2ylMWZ7z210mrkozZacEMMzKgS12AELxVIx0s6ZCGb7NhKfqRKKh5CdrhYTCYxtpViqMmMhZyMywk
	si26u70mdD8zyo7+gVKg8VxCWM1xgbT75BPvO7iIPZjcGY3nzqJugtYlwj1e5ZQozsHBqAfHRlSRO
	2n8lgbFkoyjwitBQ4Sr9j0Ri4htWnZ5Lu6F0F0BQc6ccCQJTI+mysiBxu46fO9rr+YG4cSG8cMxTp
	nUEDFaeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8C6o-0000000COzs-0hDy;
	Mon, 13 Oct 2025 06:32:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8C6m-0000000COyx-1axA
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 06:32:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC9E1F460;
	Mon, 13 Oct 2025 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760337154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlBEysjjE37wP9lwjqUsyECeaGSphVUR4oADVX5jxbE=;
	b=Lfq0E6z9/eMc6muVvvWMjf75ZhY/yMyRh0hdjP7gUFVXS5AkIfIJ02S7XBB8blt9hXGcN/
	fsoBCqa00v1/dICTZwSV+r/iJ7ShXQY8P/lXstFNICzP5tkPV3wO8vCUIe7EQH8adimiq9
	+oydFGNE3S+KIbpQX/s6+MIgWkxpMU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760337154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlBEysjjE37wP9lwjqUsyECeaGSphVUR4oADVX5jxbE=;
	b=Ehy5TzmUH8Cswas+fbaVNc2m64WNjYktd+QmwO4HgjSKS75YSXSti0uDDtaQ1NkLfJQray
	g2DwqFY0FIhdJNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760337154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlBEysjjE37wP9lwjqUsyECeaGSphVUR4oADVX5jxbE=;
	b=Lfq0E6z9/eMc6muVvvWMjf75ZhY/yMyRh0hdjP7gUFVXS5AkIfIJ02S7XBB8blt9hXGcN/
	fsoBCqa00v1/dICTZwSV+r/iJ7ShXQY8P/lXstFNICzP5tkPV3wO8vCUIe7EQH8adimiq9
	+oydFGNE3S+KIbpQX/s6+MIgWkxpMU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760337154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlBEysjjE37wP9lwjqUsyECeaGSphVUR4oADVX5jxbE=;
	b=Ehy5TzmUH8Cswas+fbaVNc2m64WNjYktd+QmwO4HgjSKS75YSXSti0uDDtaQ1NkLfJQray
	g2DwqFY0FIhdJNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D83E13874;
	Mon, 13 Oct 2025 06:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6TlHGQKd7Gj4OAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Oct 2025 06:32:34 +0000
Message-ID: <cee6fe38-3c51-4000-b30e-b7336ee6fd13@suse.de>
Date: Mon, 13 Oct 2025 08:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 3/4] nvme: add generic debugfs support
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
 gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251009100608.1699550-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_233236_566121_5D4CE5CA 
X-CRM114-Status: GOOD (  10.76  )
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

On 10/9/25 12:05, Nilay Shroff wrote:
> Add generic infrastructure for creating and managing debugfs files in
> the NVMe module. This introduces helper APIs that allow NVMe drivers to
> register and unregister debugfs entries, along with a reusable attribute
> structure for defining new debugfs files.
> 
> The implementation uses seq_file interfaces to safely expose per-NS and
> per-NS-head statistics, while supporting both simple show callbacks and
> full seq_operations.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/Makefile  |   2 +-
>   drivers/nvme/host/debugfs.c | 122 ++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h    |  10 +++
>   3 files changed, 133 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/nvme/host/debugfs.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

