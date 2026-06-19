Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE7DCD98F6
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btTr9HA1EUrQbL3Hl4tUG3uH5CMvPDH+Ipr04oL573M=; b=aWOnZYHTCLfkG5yLQk0Y9AqUQg
	yt3bmjNvjSksxKghr3oj6SAJSK1fcm5c9t/All568o9e8GDs2QlDVPHEGgyxLSQngvPC2Nc0aDeCP
	rnPpjFDQwk0QwIvMNQP/y1NecnP68gxU0LbOi+qAdagh0G0d7f+WGj1exk4EbLnUViKUpLr4vd6Xk
	bTAr9Y8P+RQ63q53hhOifFMIfHHwYjfMwF9DQuTA9xPX1AsO2O+MIz8o23Vsq3vdriHCWNxiwCYl5
	som8xeNNcgiyUVH0ofUKXBxx0/ObuJ8VF169nHe8Nqcidul3rAvN755YZogDxvIPKZZr6MYBK8Bjg
	41A2IU/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waSEQ-000000021jY-26Ao;
	Fri, 19 Jun 2026 05:57:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waSEJ-000000021jA-3FyE
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 05:57:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BF0676022;
	Fri, 19 Jun 2026 05:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btTr9HA1EUrQbL3Hl4tUG3uH5CMvPDH+Ipr04oL573M=;
	b=RaBX+JxT5Qpe4xkrjPtidh6XL2VNn6ZT9YY4sgc03T8ija4rHXhgo8Ms3bLw6zg6xtc34h
	NwaCfjnk0N93/pI7w9hIG4KzUTp4iJixZjVH/fXEBl5kz4jonqCLjFDtQNiV2iTAsIaHI/
	PtMwWeRvY4zw0bRxC7MERRPIza60jDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btTr9HA1EUrQbL3Hl4tUG3uH5CMvPDH+Ipr04oL573M=;
	b=2glISELUVih2TUVhL3KuupF26ZQINeD8tDu8Eb5lu8ZqkHKi89pSAEGotJ/p+etfb5b9EQ
	2ik/nNWZFvikLsAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btTr9HA1EUrQbL3Hl4tUG3uH5CMvPDH+Ipr04oL573M=;
	b=RaBX+JxT5Qpe4xkrjPtidh6XL2VNn6ZT9YY4sgc03T8ija4rHXhgo8Ms3bLw6zg6xtc34h
	NwaCfjnk0N93/pI7w9hIG4KzUTp4iJixZjVH/fXEBl5kz4jonqCLjFDtQNiV2iTAsIaHI/
	PtMwWeRvY4zw0bRxC7MERRPIza60jDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btTr9HA1EUrQbL3Hl4tUG3uH5CMvPDH+Ipr04oL573M=;
	b=2glISELUVih2TUVhL3KuupF26ZQINeD8tDu8Eb5lu8ZqkHKi89pSAEGotJ/p+etfb5b9EQ
	2ik/nNWZFvikLsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C46779A8;
	Fri, 19 Jun 2026 05:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bICZGkXaNGpEEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 19 Jun 2026 05:57:25 +0000
Date: Fri, 19 Jun 2026 07:57:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH blktests 1/2] nvme/060: suppress state file write error
Message-ID: <79da1204-73cf-4f96-9c5d-25378f049812@flourine.local>
References: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
 <20260619013329.558580-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619013329.558580-2-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_225727_980325_F4016AB6 
X-CRM114-Status: GOOD (  12.90  )
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

On Fri, Jun 19, 2026 at 10:33:28AM +0900, Shin'ichiro Kawasaki wrote:
> The test case nvme/060 sometimes fails with the message below:
> 
> nvme/060 (tr=rdma) (test nvme fabrics target reset)          [failed]
>     runtime    ...  27.967s
>     --- tests/nvme/060.out	2026-01-19 04:30:04.820982813 +0000
>     +++ /home/fedora/blktests/results/nodev_tr_rdma/nvme/060.out.bad	2026-01-19 06:44:49.223643735 +0000
>     @@ -1,2 +1,3 @@
>      Running nvme/060
>     +_: line 1: /sys/kernel/debug/nvmet//blktests-subsystem-1/ctrl1/state: No such file or directory
>      Test complete
> 
> To reset the test target controller, the test case locates the "state"
> file and writes to it. This works in most cases, but the write can
> fail: the test case connects and disconnects the target controller's
> subsystem in parallel, so the "state" file may disappear after being
> located but before the write happens.
> 
> Suppress the write error message to avoid this sporadic failure.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for fixing this up!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

