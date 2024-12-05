Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCDE77170
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEn1gwd9ieef2N484+uuscW+2zBgjHLjMzojLKkJgsQ=; b=yxXOo9azrEjSTuo1GtqCga928C
	ZBXbXYe6cm1epsYfZjhmqIiBRsHalDJk2EBcxbBpK6oO63JZQI9JqetYyUAVJYt0OjDuob1WzUJDW
	YAxuHEFnwFqr1JNyunCHv/HcOArVazp4/G0OwGRy9UL3j2R9qIZ0nXM9XND8lm1rFPkzDNyPgbn+m
	uzicB5A8euj3YPkBBy6PS/PhEUCBtJc72pr6Yv0rISgKRf3keNG1lvbyNK+qUq4WugbyRvcQexiGa
	y8IcNtTE/nq8gPBo4igu5o5Ohnk0UlE00Jj2lf5r9Uy8nf/fOhzExN+a5moQox+0qXw/LpQHYWDzw
	6Y7h479g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJAEL-0000000FkuV-1W4Q;
	Thu, 05 Dec 2024 11:41:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ9uV-0000000Fgse-1VPA
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 11:20:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B033210EC;
	Thu,  5 Dec 2024 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733397640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEn1gwd9ieef2N484+uuscW+2zBgjHLjMzojLKkJgsQ=;
	b=EB/IdaINmergIJ6Iu3WSUU+wWMdtbdikdCVk15HDQ/xBT7x2f6qHVG1wTZ1is+ArUfT34z
	n2SQytsiY2+vt4XZ04DfjLaNuXCNeBnjOp0M8/Dsh2fM8CahUfVZ/z8ZkZZ2ETrLc3iGOf
	1CyMp8CJHejMpPh/TjGTN2bBHd+9W24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733397640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEn1gwd9ieef2N484+uuscW+2zBgjHLjMzojLKkJgsQ=;
	b=GF1k0echYfMqVkxmhkNBfu/1MMkFLjfqm+GPYEGeWDYEVXvt28LA/QUG6pCrVVtRp+fXLQ
	+TUYXLyluA7jtMDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="EB/IdaIN";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GF1k0ech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733397640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEn1gwd9ieef2N484+uuscW+2zBgjHLjMzojLKkJgsQ=;
	b=EB/IdaINmergIJ6Iu3WSUU+wWMdtbdikdCVk15HDQ/xBT7x2f6qHVG1wTZ1is+ArUfT34z
	n2SQytsiY2+vt4XZ04DfjLaNuXCNeBnjOp0M8/Dsh2fM8CahUfVZ/z8ZkZZ2ETrLc3iGOf
	1CyMp8CJHejMpPh/TjGTN2bBHd+9W24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733397640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEn1gwd9ieef2N484+uuscW+2zBgjHLjMzojLKkJgsQ=;
	b=GF1k0echYfMqVkxmhkNBfu/1MMkFLjfqm+GPYEGeWDYEVXvt28LA/QUG6pCrVVtRp+fXLQ
	+TUYXLyluA7jtMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87CDC132EB;
	Thu,  5 Dec 2024 11:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FfLIH4iMUWeNJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 05 Dec 2024 11:20:40 +0000
Date: Thu, 5 Dec 2024 12:20:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns
 just after disabling it
Message-ID: <7775ee47-980f-4f2f-8642-cfbeb984df30@flourine.local>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
 <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
 <adbeb95d-40aa-44c3-bb63-01c0a49f5182@flourine.local>
 <fb1058c3-ca47-4a54-8c1b-7eb9fa449fa0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1058c3-ca47-4a54-8c1b-7eb9fa449fa0@linux.ibm.com>
X-Rspamd-Queue-Id: 9B033210EC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_032043_543565_2D193D7C 
X-CRM114-Status: UNSURE (   8.11  )
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

On Thu, Dec 05, 2024 at 04:36:26PM +0530, Nilay Shroff wrote:
> Sure, you may refer "5.27.1.8 Asynchronous Event Configuration (Feature Identifier 0Bh)"
> in NVMe base spec 2.0. And then refer Figure 236, Namespace Attribute
> Notices:

  Attached Namespace Attribute Notices (NAN): This bit determines
  whether an asynchronous event notification is sent to the host for an
  Attached Namespace Attribute Changed asynchronous event (refer to
  Figure 151). If this bit is set to ‘1’, then the Attached Namespace
  Attribute Changed asynchronous event is sent to the host when this
  condition occurs. If this bit is cleared to ‘0’, then the controller
  shall not send the Attached Namespace Attribute Changed asynchronous
  event to the host.

I agree, doesn't say that the controller always has to send a NAN AEN.

