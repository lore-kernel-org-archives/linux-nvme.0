Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80506C54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Igq7nAhmQn9eZ8xJCENwSnbrfhfka/XTrd5l9aGUgbI=; b=JPY2yAjgiW45HfdbtimCuHtI4I
	eyboLTlSYEnfuCxSpsSs+lbL9B7jSiAZyQCuFinBmof23iubzdoHDU1XK1y2OWdhRVjMQ2IAZOjn7
	Ssg+Umiqfls6vUWmakJYIu7u5Tpx9mRKFFzkEgcqS+ngNe9xGPa/cdrGqpb2m1UoUsflpkP030SdD
	XJb/UqEYlbfQ0cEMjed8tzO3HDCpYL93RBaiuLHwBdap8fk57guglAEoKt6KeijHseV4pkmF3i9Ix
	rtKNaJ72TLdlf1e3sIEL2KA/nWEG752w4RsA+kLAcUK/F4Zzz1qClVEnI85uOfzJthjlcGKWGL/Gq
	t0TuPrUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmqBp-0000000FsZw-3F5U;
	Wed, 20 Mar 2024 07:16:45 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmqBW-0000000FsWb-18Q3
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 07:16:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EF2520993;
	Wed, 20 Mar 2024 07:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710918982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igq7nAhmQn9eZ8xJCENwSnbrfhfka/XTrd5l9aGUgbI=;
	b=LzsMPorDMSUQgclkpuUUZMYE8EW+Yo2qIGXHa3qxAusrl73FzWDGxa7FFPZ9KdSeowPEEZ
	EnwdFk/EZQmXa2E0OJvxGXM2o3yFmWsL/8Bqzx2JjZnsGuWbdD2M2aWQ9XOaNbx1SEdhTl
	NhjHu5qMN8U+kyJy1snCtSO1Z0dY70Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710918982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igq7nAhmQn9eZ8xJCENwSnbrfhfka/XTrd5l9aGUgbI=;
	b=MpgkWrnbxD0kjRT9o1NQFeoSmwq4l/mc2SKMo6pcptcNH/fkVKUbZAGZAs1/wZbmIBVAxf
	uhgSSpCbCpBRHNBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710918982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igq7nAhmQn9eZ8xJCENwSnbrfhfka/XTrd5l9aGUgbI=;
	b=LzsMPorDMSUQgclkpuUUZMYE8EW+Yo2qIGXHa3qxAusrl73FzWDGxa7FFPZ9KdSeowPEEZ
	EnwdFk/EZQmXa2E0OJvxGXM2o3yFmWsL/8Bqzx2JjZnsGuWbdD2M2aWQ9XOaNbx1SEdhTl
	NhjHu5qMN8U+kyJy1snCtSO1Z0dY70Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710918982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Igq7nAhmQn9eZ8xJCENwSnbrfhfka/XTrd5l9aGUgbI=;
	b=MpgkWrnbxD0kjRT9o1NQFeoSmwq4l/mc2SKMo6pcptcNH/fkVKUbZAGZAs1/wZbmIBVAxf
	uhgSSpCbCpBRHNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ACE0136CD;
	Wed, 20 Mar 2024 07:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sa5JHEaN+mW7KAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 20 Mar 2024 07:16:22 +0000
Date: Wed, 20 Mar 2024 08:16:21 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCH nvme-cli] nvme : Don't seg fault if given device is not
 char/block device
Message-ID: <doqj5ci7aokhxugwu5jul7h6scnl4dt5cukq3gkj7tput5fn5o@f72afjmdejx4>
References: <20240317113758.3055071-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317113758.3055071-1-nilay@linux.ibm.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.88%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_001626_496872_622349F6 
X-CRM114-Status: GOOD (  10.09  )
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

On Sun, Mar 17, 2024 at 05:06:22PM +0530, Nilay Shroff wrote:
> If the given device name is not char/block device then in
> open_dev_direct() set errno to ENODEV and err to -1 before
> returning to the dev_fd(). This would then ensure that in
> case of error, dev_fd() returns the corerct negative error
> code back to its callers. So now the callers of dev_fd()
> would handle the error appropriately instead of try
> accessing the nvme_dev which would be NULL.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Patch applied. Thanks.

