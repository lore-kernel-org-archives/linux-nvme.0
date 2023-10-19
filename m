Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8615DCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFaD2/Bbp7fdLDpcfhgbioHg29f6K9cRBet8ttleAFc=; b=onSFxpRxAUEeTN7bZ4UYHAYSee
	uvs4OicelPUgC2MQJmpkk+fSHWsKf7V+IMsNOyYrI0nvRvmgyXYkpnuOHlqGYMtV6XfvjMiCdTJqu
	NgcXrUjTM1gz2ZMJCZHZ6+jiEVqC5oGoFuzbt6Fqal0lMTk70m1b/xGOKSiuMFUsz8MkmLkrZdqks
	9HDgMsDbLVlVKIJjBDpJA/Ybt5NPfgzG075jBan0zPqg3YqbB8DqzW/Ac/paM7VhoxLF5b5PXc87z
	AhfLXATvX0YyDuSql5n8S4y5tRN7nhU3CZsfAcuUWdFevwXi9f7LDmXephJa6giivV3QIc2f54grr
	LFly4Eag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtSkn-00HUFE-2r;
	Thu, 19 Oct 2023 13:07:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtSkl-00HUEn-0B
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 13:07:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8327C1FD76;
	Thu, 19 Oct 2023 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697720873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFaD2/Bbp7fdLDpcfhgbioHg29f6K9cRBet8ttleAFc=;
	b=zBk9ziKTkIOHUjvMyz8Vujc2NpeNgUaOOfFa7ZYI53YhgdiIvdoszUFD9BY7/6rZp9rlza
	c9EG8oGYCwg0Bgv4b7XA86Mltes7d3FRnJLcqtfBNuUr/cCXmnE6i4taX1RUPGIPvDIu7a
	mLt4NRjBwdhi7XPXnLx4irPJ2Io8FW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697720873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFaD2/Bbp7fdLDpcfhgbioHg29f6K9cRBet8ttleAFc=;
	b=qaHMvMs/aVFfBcI2Q9XIHiJQTvsSiIDfL+g5+hgXl2AzpPw5elviSAiqFirCBxKXcplkV8
	940NgAhd/5xeryAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 343101357F;
	Thu, 19 Oct 2023 13:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WOecCikqMWUnVAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 19 Oct 2023 13:07:53 +0000
Message-ID: <09ea6825-e73e-44a7-8540-ea92907eb858@suse.de>
Date: Thu, 19 Oct 2023 15:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: do not try to cancel uninitialized
 tls_handshake_tmo_work
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20231019125336.138578-1-hare@suse.de>
 <61a4991d-1ad3-4c7e-8629-ac3100a0f745@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <61a4991d-1ad3-4c7e-8629-ac3100a0f745@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.94%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_060755_246694_16B8C8AD 
X-CRM114-Status: GOOD (  10.83  )
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

On 10/19/23 15:01, Jens Axboe wrote:
> On 10/19/23 6:53 AM, Hannes Reinecke wrote:
>> The TLS handshake timeout workqueue is only initialized if TLS
>> is configured, so we shouldn't try to de-initialize it
>> unconditionally.
> 
> What about the one in nvmet_tcp_tls_handshake_done()?
> 
That already is encapsulated by the config variable, so nothing to be 
done here.

> Please include a fixes line.
> 
Oh, sure.

Cheers,

Hannes


