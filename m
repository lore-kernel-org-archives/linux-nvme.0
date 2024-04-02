Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93ABCD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAzvbbEkV0pHySk97X5s3fcUCaRnqRODx6gdMx+l/xk=; b=UFVMdhYdaXaowiSP1fetyKkITP
	vTTAGdbbHWyqtcymDuG4Kxx01tdv+/7gKu0Lbc0AL+/zH6OezK5Xj0YdNr7UBSfJdGCyUvb+dPyg9
	/Uo45KrFIMLslF/3WuXCUHfIPuLoCnNpOESvLoxgRG1Dd4+tgZh4Yp47nXU+X40D4hqe0PeRuzsc/
	2mncKNfEO5dkL5RFXIe9CJ0o1FmDW3r8aZlgYINbjicY03DO3FxZTG9nFMMceDMcBj/qx/0mqxO07
	zWAUV06tV/e8Tz21MdqN1+04rJfTYxTZJCcqT/yuPkbcnejkSyKgdlBJOMkmqEGHrti5QDplPhSUe
	34fA3hlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrYY5-0000000A4Sm-2hVp;
	Tue, 02 Apr 2024 07:27:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrYXy-0000000A4QR-1skX
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 07:27:10 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFE74343BB;
	Tue,  2 Apr 2024 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712042816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAzvbbEkV0pHySk97X5s3fcUCaRnqRODx6gdMx+l/xk=;
	b=vvDva3WGd/53+2bfcFXVLeVXoxAVYt3+HKSjIsmIULM5l0LdyLMf3VS6+H2YzrKkc9YEhu
	jHg8DVwho/hIro4ItY1ZBNTwvcRWJUJs00mYCTiY+FdYbnCx5vVONaOD17S6pUF737Pt6r
	qEN2Vvr5Z90bGgFYD+brlkZF3p/2U24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712042816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAzvbbEkV0pHySk97X5s3fcUCaRnqRODx6gdMx+l/xk=;
	b=hOBJeCVLIEhO4nK690MMd6Ma7pWzoHh+UjEa3zCzoZXyIZwElQy/kwEKDWb8PoWhPbWhwa
	DuWl0Mfa8FGpRCBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE27A13357;
	Tue,  2 Apr 2024 07:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Xki6LECzC2YKTwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 02 Apr 2024 07:26:56 +0000
Date: Tue, 2 Apr 2024 09:26:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: =?utf-8?B?xYF1a2FzeiBLb2rFgm8=?= <l.kojlo@sibersoft.pl>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvmetcli FC transport problem
Message-ID: <oe5bodi7vgcg2e5xux5tasusbgpcwo4um72q5gqevmm5egs2ka@bqgol4qhzm7b>
References: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
 <ak47crahgtdwhb2ecc22eseidltasw2sppbrq2ik57r6raal5f@n67q7wbbl7jr>
 <a6ca5502-d25d-4add-9a55-65c0f5baa78a@sibersoft.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6ca5502-d25d-4add-9a55-65c0f5baa78a@sibersoft.pl>
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.19)[70.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CFE74343BB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_002706_668572_255A1384 
X-CRM114-Status: UNSURE (   8.97  )
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

Hi,

On Fri, Mar 29, 2024 at 10:22:42AM +0100, Łukasz Kojło wrote:
> */ports/1/subsystems> create test
> Could not symlink test in configFS: [Errno 6] No such device or address:
> '/sys/kernel/config/nvmet/subsystems/test' ->
> '/sys/kernel/config/nvmet/ports/1/subsystems/test'*
> 
> Nothing in dmesg
>
> FC card I'm using it's QLogic QLE2740

I've tried once to get a P2P setup with QLogic cards but failed. IIRC,
I run into troubles with the QLogic firmware not be able to act as
target. I'd suggest you enable the debug logs of the qla2xxx driver.
There might be a hint what's going wrong.

HTH,
Daniel

