Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB466CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxH/K4xBnPW3Iqo9dVisbX3HnJSJaYk0+vOsyJRDm54=; b=GxY8iJETXlOQ0WalDITIviGfQg
	LSTKhY1xNpacWSuenzk6jIw9ET2+eyPBC3cIPap7xg/DGFTIk6du1nko4LTo48OA1fKqpAQ8vOO3J
	NNIgfXzZzSoepQhp4UgtbEQvKpmyIQ1kg0/t9fHBBYlV3JZ3q+fPa4+et+PBDiLflf1lBXBLNhMus
	/nvxfyaW7/oRnmE/3fBs/T4Od4pQRZfWLTBL63UMjAP5MB8aFTt4C+b0o69rxOi4BzTnkcOuSrGkE
	tl2iQdXFtg7TM9bJ+O80ZClLiEIHbmpWUQ2h7RjhqHsLDKk3UY+PLVkXGoPwOJsd7r9/wyCpkOV9C
	HMvULxOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOW6h-0000000G5Tr-0Koq;
	Thu, 27 Nov 2025 07:07:59 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOW6e-0000000G5Sd-0fXZ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 07:07:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 247735BCC4;
	Thu, 27 Nov 2025 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764227274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxH/K4xBnPW3Iqo9dVisbX3HnJSJaYk0+vOsyJRDm54=;
	b=P+Gaf5wcjYAsVrFWf/W+zBNHIGQrKRDpztAkgHv1Kok+RNLSFqQTsBzRrdvE/hwct9pg/b
	2u2GmhTMG9MI9XWcdhwZtup6mZ+kOmWUEnOXpCoqf2eFMajgWW3+Z4U/MWEIqHN72TlHlm
	64IGHdGEDvx3Bh8husmKUNVEMieRVXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764227274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxH/K4xBnPW3Iqo9dVisbX3HnJSJaYk0+vOsyJRDm54=;
	b=TTYm7y4GhTBLXldK7PxlSrKL9IjT2R8fUwB13oCOrkEWk/tzqoXWjC+K+ggrBjl8vfvKQQ
	pxMLQaI4W0GfOnDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P+Gaf5wc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TTYm7y4G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764227274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxH/K4xBnPW3Iqo9dVisbX3HnJSJaYk0+vOsyJRDm54=;
	b=P+Gaf5wcjYAsVrFWf/W+zBNHIGQrKRDpztAkgHv1Kok+RNLSFqQTsBzRrdvE/hwct9pg/b
	2u2GmhTMG9MI9XWcdhwZtup6mZ+kOmWUEnOXpCoqf2eFMajgWW3+Z4U/MWEIqHN72TlHlm
	64IGHdGEDvx3Bh8husmKUNVEMieRVXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764227274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxH/K4xBnPW3Iqo9dVisbX3HnJSJaYk0+vOsyJRDm54=;
	b=TTYm7y4GhTBLXldK7PxlSrKL9IjT2R8fUwB13oCOrkEWk/tzqoXWjC+K+ggrBjl8vfvKQQ
	pxMLQaI4W0GfOnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36823EA63;
	Thu, 27 Nov 2025 07:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NpkXJsn4J2mkWwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 07:07:53 +0000
Message-ID: <1379c3f9-cdde-4733-b1e9-7e761628d0d3@suse.de>
Date: Thu, 27 Nov 2025 08:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: add IOC_PR_READ_RESERVATION ioctl
To: Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Mike Christie <michael.christie@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20251126163600.583036-1-stefanha@redhat.com>
 <20251126163600.583036-5-stefanha@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251126163600.583036-5-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 247735BCC4
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_230756_343362_D9D21F99 
X-CRM114-Status: GOOD (  13.62  )
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

On 11/26/25 17:36, Stefan Hajnoczi wrote:
> Add a Persistent Reservations ioctl to read the current reservation.
> This calls the pr_ops->read_reservation() function that was previously
> added in commit c787f1baa503 ("block: Add PR callouts for read keys and
> reservation") but was only used by the in-kernel SCSI target so far.
> 
> The IOC_PR_READ_RESERVATION ioctl is necessary so that userspace
> applications that rely on Persistent Reservations ioctls have a way of
> inspecting the current state. Cluster managers and validation tests need
> this functionality.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/uapi/linux/pr.h |  7 +++++++
>   block/ioctl.c           | 28 ++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

