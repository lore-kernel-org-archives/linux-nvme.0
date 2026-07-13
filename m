Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823FC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yezZrL/XB4sWfCspZb88dUswE28pxgeU3kwnKzP3cGc=; b=vUQrzA4MU5ugX/MUNh76xOws9x
	Hbz/9vTCY3mvEF6gIeTLHOjgJobaAcXEcVTUpp6RqPj0yZBjxMCNTcR7L4Px2gAHappgJqZ9QWXE+
	GzHxrLRy8HusM+N+dJ36yP7H73T19/lHJHHrAyf5AaBxrgjlC5BbDe7lB7Ggjuu1yEXgNhoL5XPoA
	akxCetu6+hzJ3JOhg0E+sI4mf//sUVcT2mBMkso4Z1I/dqr/PZYDflYFMr0w0d6ebn3WTc9cmngMq
	/V27GyB8qbWKMaS+o9bFmfkjh57mhBzTKuj11vrAvID/7Im5MwDQgGRXuqqO+SxO0ZYMZTZHQ4o4L
	gwOqNXFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBC1-00000008Rvm-16Y5;
	Mon, 13 Jul 2026 07:35:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBBy-00000008RuC-04Yj
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:35:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01755777AB;
	Mon, 13 Jul 2026 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783928104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yezZrL/XB4sWfCspZb88dUswE28pxgeU3kwnKzP3cGc=;
	b=ewT5MxvAHpGI0IZRNLk17puJGisUJtG6qeC9PJ6j1xP109TEZAzRp4E/kevKbmuRXZkVhI
	Hqao0DYzqG/aG5QZZ/oBOxKucPxqeZb3N18qfkYaI1qObihV32cDXigXE38+ywsSk33hIi
	6KzPRrKjt9ZPEXDZX0pWXqL51jR00KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783928104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yezZrL/XB4sWfCspZb88dUswE28pxgeU3kwnKzP3cGc=;
	b=jZK3LKrgSr1qGK0K48oqXBfk5gRdcfnrHrnoO2KPH93xGCSjwdZU54FSVhojeWCuHv0lcB
	67106lpXDhyIvRAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783928103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yezZrL/XB4sWfCspZb88dUswE28pxgeU3kwnKzP3cGc=;
	b=WIATz83qhXp5RarDClpErypr3WhU1IP2Y2EOJvp98JMro5ZN4umh1LC0zwXI+egKUhVKZ1
	2KCGhGNaGnliVj66HSj07zSIaBdqv73BObejL6d3Nf9nCdTXhqFVBoJ3+q8ihNEKv8L2YX
	SXMYbGH+HsKWX1QUh55vSKmgvXWjMv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783928103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yezZrL/XB4sWfCspZb88dUswE28pxgeU3kwnKzP3cGc=;
	b=qZ12oq/X1qe313Qvrr0G8S4bjCpTS46kOsrx9cXHmYK37u+4mKis2ewqh/USTq9uyh7q9W
	hw7aj9KLWCosyoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 592D5779AE;
	Mon, 13 Jul 2026 07:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DFKeFCaVVGqubgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:35:02 +0000
Message-ID: <e7b14340-4345-4b30-8c83-4387deb0082c@suse.de>
Date: Mon, 13 Jul 2026 09:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/16] nvmet: Add support for CQT to nvme target
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Randy Jennings
 <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-16-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,purestorage.com:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_003506_218576_3B062A9D 
X-CRM114-Status: GOOD (  11.30  )
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

On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> time limit for attempting Cross-Controller Recovery. CQT is added as a
> subsystem attribute that defaults to 0 to maintain the current behavior.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  1 +
>   drivers/nvme/target/configfs.c  | 36 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      |  3 +++
>   drivers/nvme/target/nvmet.h     |  2 ++
>   include/linux/nvme.h            |  5 ++++-
>   5 files changed, 46 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

