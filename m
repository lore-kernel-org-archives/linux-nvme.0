Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A89ECE57B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=; b=NR30t7L+3Xsg2+CSwPErfw4AUG
	vuLM1jyeaJsR7OXzwYug23fqaFpC5pG+s+stl7TucjHs6zwdfV/+6vKKwY7asB9zEZODYDgMP/wuU
	TV6vHHBR6LXqxlNTi/q4QCMibmIMM81GQPFksDv7+0JLgvAYWAJtdBgLdF0Z5kvilwUWZN2eRqRr9
	w8t/cduCDf16OJoYBf+moC1g8mrpFQzdYrnRYZiYvbUdLtmrm7uKErEplT6O/rY4CniuFux4jSAZo
	GcdJXe0HkIINejQaN1NF9cM+DVJL70JGhsft7AP60ef5DS1Ge1s1KsC+KWT7zzhLBr5FwCYoPwrJR
	qB305CNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snbD7-00000001QVP-17qF;
	Mon, 09 Sep 2024 10:01:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snbD2-00000001QUL-2EkI
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 10:01:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F063A1F7AB;
	Mon,  9 Sep 2024 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=MHsQjt+ReDNfsgsi06k3PtR0GkEfDNf5vFKZYDkfWyNdqQN/feDhRzB7p9EkMKO6/Utoni
	teNYgxbFpfErWEIVE/yp6j64GglvW5LuckGh+D/GjgtcWGORWZbpDXiewwhI0rqYKeY0qY
	i6dz/t96GlEThMrZIupJWNefJOfPuM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=DNyiPN4Q9PQKzDshagegD7ELH/Bd6npbbuooBckzO2Sc62R5FoxYVWCLfzM7Jg+iXWrd9f
	7so0YSHyY0s8viAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=mYwBDBez8aVLaUHcRRYRxN9jJmAk9z/iMpSMMfaNy/7ArK0Dd0/iZTxCZYhaQMNjCqSpco
	jW+mws3L6lKQHIA3fsDhrOkNz9lozqYz6dznQTR2vDN7PBCeH9JZwdByzzNmOCidCogQ0b
	547SzIqT42LpnQYw0Y/VQ7KYHz6jzd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7EhZWDrSI3p9Cje6qqkawriCY1dLqf9xx5mmeozvg=;
	b=+hiw7bNsYZnHo9J1+ElYGCaJyMVTy1P/h8ULN4TIZVDJRE+CSsSJvlFNonJjLero2kZBw+
	cidwyd0X4XoAJ3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6D2813312;
	Mon,  9 Sep 2024 10:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1bwEMm/H3mZPDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 09 Sep 2024 10:01:19 +0000
Date: Mon, 9 Sep 2024 12:01:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3 1/3] blktests: nvme/{033-037,039}: skip passthru tests
 on multipath devices
Message-ID: <80e98949-875d-4754-a70c-851dd0549b41@flourine.local>
References: <20240902142748.65779-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_030125_085665_4E977E00 
X-CRM114-Status: UNSURE (   8.47  )
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

On Mon, Sep 02, 2024 at 04:27:45PM GMT, Martin Wilck wrote:
> NVMe multipath devices have no associated character device that
> can be used for NVMe passtrhu. Skip them.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

As far my bash scripting foo goes, looks good.
For the whole series:

Reviewed-by: Daniel Wagner <dwagner@suse.de>

