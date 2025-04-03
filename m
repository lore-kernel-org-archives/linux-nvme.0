Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46400C3601A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NnROBMfB9H0SrHD6swU7u4FYUHn8/b+CQiOP+jUXhc=; b=iya0eSLisUuZxjQq2XOg55r59q
	p3sK/gpcX/7xNIpyr69LbwOZrTYJHMkEK8gx1G5wNEfjH0jT2L/pGe5ygLLLteX9u/ClnJ/igXApR
	XaCiOufH0rVPiYJnRB6fh3FfOojh3b/QUNxaY7CMi9pFnVO77PcPr5k2gUu9DNh5yYF74bGAKelHE
	caCVXnVFdav1Vn3/usMG8LCyxVHt89NKpcXPabh904+L07JZ32j+YN1IBriMFohNYSTquH12GlCL+
	ghdre6kXmDQ9pvoVWdwBg8pdd/AnkwIiGWwXZQrnxxOBjicIEQupdKuZTkMVI4+v9m3x4SwMPp5om
	yf4k+bcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OJz-00000009Rxf-2o73;
	Thu, 03 Apr 2025 17:25:43 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OJZ-00000009Ruc-1emB
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 17:25:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33454211C6;
	Thu,  3 Apr 2025 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743701114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NnROBMfB9H0SrHD6swU7u4FYUHn8/b+CQiOP+jUXhc=;
	b=uZRV4fq3fLTPXlSOZTApfecvT619p+txL+8hbIKCLGQ6n5b1VdpNWNL0TePmADTTfJje2W
	6Wqpj4QIrpFIU+9Ugruwr2bGpUTaAJmzXiQwLIx7msU4M5tTo1XK8Qx06MNfoYnXEispUc
	Zi5FyKKfjAguMVXsiAP3lGsJKwD5kmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743701114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NnROBMfB9H0SrHD6swU7u4FYUHn8/b+CQiOP+jUXhc=;
	b=Wf/DSKcmRBry4vjit1nly39AEVwbi4/oXtVsVI/OLH3sqDAPfc0HG1c6t+yms4a43uuRD1
	rCQ33wpbBrVqlWBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uZRV4fq3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Wf/DSKcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743701114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NnROBMfB9H0SrHD6swU7u4FYUHn8/b+CQiOP+jUXhc=;
	b=uZRV4fq3fLTPXlSOZTApfecvT619p+txL+8hbIKCLGQ6n5b1VdpNWNL0TePmADTTfJje2W
	6Wqpj4QIrpFIU+9Ugruwr2bGpUTaAJmzXiQwLIx7msU4M5tTo1XK8Qx06MNfoYnXEispUc
	Zi5FyKKfjAguMVXsiAP3lGsJKwD5kmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743701114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NnROBMfB9H0SrHD6swU7u4FYUHn8/b+CQiOP+jUXhc=;
	b=Wf/DSKcmRBry4vjit1nly39AEVwbi4/oXtVsVI/OLH3sqDAPfc0HG1c6t+yms4a43uuRD1
	rCQ33wpbBrVqlWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 193EA13A2C;
	Thu,  3 Apr 2025 17:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7+jlA3rE7mdGDgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 03 Apr 2025 17:25:14 +0000
Date: Thu, 3 Apr 2025 19:25:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, wagi@kernel.org, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] libnvme: do not byte swap command dwords
Message-ID: <315bb015-66e3-49cd-be3d-a93b97846617@flourine.local>
References: <20250403144315.2576523-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144315.2576523-1-kbusch@meta.com>
X-Rspamd-Queue-Id: 33454211C6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_102517_633088_A3481D07 
X-CRM114-Status: GOOD (  15.79  )
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

On Thu, Apr 03, 2025 at 07:43:15AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The dwords always need to be set in the cpu native format. The driver
> will handle setting up the SQE in the nvme little-endian order, and big
> endian is never used, so this byte swapping was wrong.
> 
> Link: https://github.com/linux-nvme/nvme-cli/issues/2761
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  src/nvme/ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/nvme/ioctl.c b/src/nvme/ioctl.c
> index 18b228d9..86c2b702 100644
> --- a/src/nvme/ioctl.c
> +++ b/src/nvme/ioctl.c
> @@ -1920,9 +1920,9 @@ static int nvme_set_var_size_tags(__u32 *cmd_dw2, __u32 *cmd_dw3, __u32 *cmd_dw1
>  		return -1;
>  	}
>  
> -	*cmd_dw2 = cpu_to_be32(cdw2);
> -	*cmd_dw3 = cpu_to_be32(cdw3);
> -	*cmd_dw14 = cpu_to_be32(cdw14);
> +	*cmd_dw2 = cdw2;
> +	*cmd_dw3 = cdw3;
> +	*cmd_dw14 = cdw14;

in this case shouldn't we use cpu_to_le32?

