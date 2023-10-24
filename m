Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94681C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsXBny3VyY1NtZC8aBRc59dG1U7MZYuotXskuapWv+M=; b=YyoV7FANWdpsGunBmzH+1zt/wJ
	xTObHNyIfD2ahGrAPPLnCHs1PN5j7qa0/JBxpfWedYW7DuUR3b/KlHPfH4vzOVFLCibMU2havAmRH
	ocLSzviS8/alxqw/DwEOb53/bEweNc+SQg9MqgekfhZDmtW9FwrutcQntFJZTfLIUosERaK6iY4nU
	s2gzoDW+Ol4Ya0zX4cTK5sISUsaW3aecVYvPpq8YgkeE0uXLRh967xFd8W8auw5FgRR9E+fDuZ4la
	uqHUxhiUWAg8///SO8H8hUghy2Z0QQLc4IFuz5v/6EoV6g2QAqumtREijmPVPghKGfE3y5VloBKMn
	YSQIn6uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qv9zu-008tR2-1v;
	Tue, 24 Oct 2023 05:30:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qv9zr-008tQc-2f
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 05:30:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5650621B65;
	Tue, 24 Oct 2023 05:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698125430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsXBny3VyY1NtZC8aBRc59dG1U7MZYuotXskuapWv+M=;
	b=fyfcRqg4laVWzE+9rK3DZ1QrqZkpmUPqvQOUi+BGjpXWLs8AfD4ksh7UsWeyq/zBHkK609
	GssnhmrPgZONoqMuneUCxCvInW/vHKjxZDo/uINZ7LdfTFXyMKQMynnFIUztc4QENmX6yr
	FFmfAE4RnnuaRDox7DrpS1nDQ8+Ap1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698125430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsXBny3VyY1NtZC8aBRc59dG1U7MZYuotXskuapWv+M=;
	b=trdSOgeE0k3w5G5Ht25IedDNNgjBJe5XXriK0JWd/SKznDVhuapfZrBvS4GMhJxjs8ptXR
	uQTDFX4z4/Z46GAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32ED01391F;
	Tue, 24 Oct 2023 05:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pE1dBnZWN2V5BgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 24 Oct 2023 05:30:30 +0000
Message-ID: <afd51c19-7b3e-4f0b-8872-4eb3ebd32296@suse.de>
Date: Tue, 24 Oct 2023 07:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231020142600.47246-1-hare@suse.de>
 <ZTKdFHTw3949UKTv@kbusch-mbp> <94326b59-60c1-4d0b-863b-cec0f9bfe1ac@suse.de>
 <ZTb-1XJyQfLrSC1a@kbusch-mbp>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZTb-1XJyQfLrSC1a@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-2.69)[98.66%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_223032_017534_9715F3A4 
X-CRM114-Status: GOOD (  15.23  )
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

On 10/24/23 01:16, Keith Busch wrote:
> On Mon, Oct 23, 2023 at 11:54:37AM +0200, Hannes Reinecke wrote:
>> But we start keep alive unconditionally nowadays; each and every
>> host driver (including PCI) is calling into nvme_start_ctrl(),
>> which calls nvme_start_keep_alive() without any checks.
> 
> I see nvme_start_keep_alive() is always called, but that checks
> 'ctrl->kato' which will always be 0 for PCI.
>   
But it also means we don't have to check for fabrics here...

>> Be it as it may, tying it into the state transition won't work
>> as the 'CONNECTING' state is entered _before_ any queues are setup,
>> so starting keep-alive here would be too early.
> 
> That's just IO eueues, right? Keep-alive is an admin command, and the
> admin queue should be up in the CONNECTING state.

Nope. 'loop' creates the admin queue after setting the status to 
'CONNECTING'. So there is no clear rule when 'CONNECTING' is entered.

There is a valid point to be made to enter 'CONNECTING' only when the
admin queue is setup, but currently that's not the case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


