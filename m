Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD92CC197A0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49f5JUqGFben3q86pZffwvso36o9zIB88RW9YbLwa54=; b=Uez9dPLRdoHnmszNm4UGsoZcf9
	FPaxHQvW7XfroMdofXX2nP4zWV4BvKd21YtgKWE0eqagsPjp4xS2v/tR00rOiRHe+Y8TZwv+2+tgE
	AhEQAM5cAreUP+oE01l5U/zntcfauQZffpu1m9tgtFmYE7yRFI6STj5h198qUx4pLkL/rHkGHRzZZ
	WaG1n3yEHM7Gd7njieC7F1rRAnNoE0Sw+yJIalOCaK6b97p4RZLN2Y3TGiQ31s7/HVJKiAyLa0OuC
	yZUfoY0kMMBh2L1wFTA9satxiFVi7D4AEyLXfF7m0hhwCiI27wRlpQyLYNCu4tBLIJQeySgRF4lN+
	za6sM1iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bJS-003SaX-0O;
	Thu, 16 Nov 2023 12:17:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bJP-003Sa1-2F
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 12:17:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CCEB22949;
	Thu, 16 Nov 2023 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700137053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49f5JUqGFben3q86pZffwvso36o9zIB88RW9YbLwa54=;
	b=EgSFfle3H/+BWefnkEtEaM8zZmsjU5HxYd4++xWmietIBx8AhKTtYIZNA6ErlizXFhw07p
	CGmYoiygh3joP0WEEUiVrPxDXxAEJSc5pRo7pvVaTu9QumGTDgsqVLW2c0xIHbsQbxcJ6Z
	YZHNTZWEP39tNyF5emFp0EWfV1xUis8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700137053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49f5JUqGFben3q86pZffwvso36o9zIB88RW9YbLwa54=;
	b=RBa5Ukd5i507mTLgW6KzxquqcjTLsy1ixT8lDL66s+xoCebC+klmSHJ0fBXrD3pZ2ucXmV
	eNJbnLRTrlGtDOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B57D1377E;
	Thu, 16 Nov 2023 12:17:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oMkhGl0IVmXeZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 16 Nov 2023 12:17:33 +0000
Date: Thu, 16 Nov 2023 13:19:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2] nvme: blank out authentication fabrics options if not
 configured
Message-ID: <7qb75jmwohmeb7jqinaljio46iesdm45uy6codxfvviz7htcy2@zuh2lpinebn4>
References: <20231116121435.17340-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116121435.17340-1-hare@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(1.05)[82.11%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_041735_885028_C5193578 
X-CRM114-Status: GOOD (  10.21  )
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

On Thu, Nov 16, 2023 at 01:14:35PM +0100, Hannes Reinecke wrote:
> If the config option NVME_HOST_AUTH is not selected we should not
> accept the corresponding fabrics options. This allows userspace
> to detect if NVMe authentication has been enabled for the kernel.
> 
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

