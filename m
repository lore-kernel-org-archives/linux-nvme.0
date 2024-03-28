Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B66BC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSnZdHVfnPx494YGGGKwWjiltcljmn4gkqcrtxKv2r0=; b=eUFLWqksN6f07OAjpBjX6dpP+n
	kzK+WoHK/s3/qjCMq3Ct0kx9sp5qTgb/f7HxUsQFJtVeofUHBWfwHwO4kIDMfMGIKB/QXiB+DkwfQ
	MbHdjxyJqDDKAmI13SsEkLBRrTEhb2Z1oXBD3sLMhlVmQTS1O02dxxdHNJm08Y+7IZGzVXj4k+gAs
	LBEQ/LVQos9PgZW9AhPbpr0metUG/LSnnyF4XSDS1Pd4rhhYXn6wi0D2AgheZUqoA67oXuOOzfLz+
	KZmIz5jc8PPQxSY88m3q9rtTHSDpbFQJUHqk8oHg4scCd+C8H82fh9Jm7QehhnzPJweTMdnXZ2D3L
	Nj7FoM5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplUL-0000000DAHc-1zQ8;
	Thu, 28 Mar 2024 08:51:57 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplTt-0000000D9uR-2GcD
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 08:51:37 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D724205F2;
	Thu, 28 Mar 2024 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSnZdHVfnPx494YGGGKwWjiltcljmn4gkqcrtxKv2r0=;
	b=eh3L24HPFwc+JMKLm7CQ9fQ5RkYas7BTFCFvP6c9QWns1AY4LMEXI6udW+8a22dgH+4y4/
	zwAtowvpMfjdEJPv7ZJ+UIdw4kvgaUWPas3Ru+lkdSHvdfxTVCkmIqy0sa/+Ais4eOUQui
	NzMD1weGxwr+O9dtp0yp2WCCuwtppNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSnZdHVfnPx494YGGGKwWjiltcljmn4gkqcrtxKv2r0=;
	b=1mwSiUPA/MUT/xxzzqloVuynwy3+5rBy4pWUzTq3vphtd/ITzGAcflOjg7uyxcutYq3uXK
	fBtTq86XYvJHuKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSnZdHVfnPx494YGGGKwWjiltcljmn4gkqcrtxKv2r0=;
	b=eh3L24HPFwc+JMKLm7CQ9fQ5RkYas7BTFCFvP6c9QWns1AY4LMEXI6udW+8a22dgH+4y4/
	zwAtowvpMfjdEJPv7ZJ+UIdw4kvgaUWPas3Ru+lkdSHvdfxTVCkmIqy0sa/+Ais4eOUQui
	NzMD1weGxwr+O9dtp0yp2WCCuwtppNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSnZdHVfnPx494YGGGKwWjiltcljmn4gkqcrtxKv2r0=;
	b=1mwSiUPA/MUT/xxzzqloVuynwy3+5rBy4pWUzTq3vphtd/ITzGAcflOjg7uyxcutYq3uXK
	fBtTq86XYvJHuKAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C2EA13AB3;
	Thu, 28 Mar 2024 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bstoIY4vBWb+YgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 28 Mar 2024 08:51:26 +0000
Date: Thu, 28 Mar 2024 09:51:26 +0100
From: Daniel Wagner <dwagner@suse.de>
To: =?utf-8?B?xYF1a2FzeiBLb2rFgm8=?= <l.kojlo@sibersoft.pl>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvmetcli FC transport problem
Message-ID: <ak47crahgtdwhb2ecc22eseidltasw2sppbrq2ik57r6raal5f@n67q7wbbl7jr>
References: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
X-Spamd-Result: default: False [-1.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.02)[87.34%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_015130_095442_93B56C16 
X-CRM114-Status: UNSURE (   9.28  )
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

On Tue, Mar 26, 2024 at 02:44:41PM +0100, Łukasz Kojło wrote:
> I'm using nvmetcli version 0.7 on OpenSUSE  LEAP 15.5
[...]
> Can you please help me ?

You are using downstream version of nvmetcli and the kernel, maintained
by your distro vendor. In this case you should report the problem there
(bugzilla.opensuse.org).

Here on this mailing list, we ask you to try with current upstream
version to reproduce the problem, e.g. nvmetcli 0.8 and the latest
release upstream kernel v6.8.x. If you still observe your problem, feel
free to post your results.

Thanks,
Daniel

