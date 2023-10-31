Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DEFC4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Oct 2023 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SUSyMWoubFo1JlnewUQEtX0aacilks/g9wP8Qc5UNQ=; b=gpIRoduS88RVO3mRs9rm+pTSGz
	zRXJlLMnLk3DWDmOCWt99JS3BCBVUYn3+GJPa4uqTy5GQRBS9DtrH74FnihskvM+ruomvHectJuKc
	PcwWoNJX+a6GGMhZi7bLnEAxPDls9vmUYBMmw3vjHPoKXB8KASY8HOCrz7PfpMG7CtbYopCQv4nUG
	sPRerQWdbV1FzyODFMqFPRWyhXtVnj1q9ZDuTLGfxGIH1WX1lVad8wNgWtjztl43N+kYldR2xtjNN
	PwxJRaIP1aGQf2udkdTsb545DVt0fADi7xWol/M/ZiuBlEXjUEtY24NbeJxR0x9P6TgAmjMUqZO9u
	WldmV32w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxrGY-005ZtC-2K;
	Tue, 31 Oct 2023 16:06:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxrGV-005Zsa-2M
	for linux-nvme@lists.infradead.org;
	Tue, 31 Oct 2023 16:06:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 590161F38C;
	Tue, 31 Oct 2023 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698768408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SUSyMWoubFo1JlnewUQEtX0aacilks/g9wP8Qc5UNQ=;
	b=UPKzvkgtjQS3m1mGxy+kYGeRtEMoOjXSUHRXnFuBzFkHmnB6XcD0D8TqRYnQ4e+oqhRigV
	aKUZ8j/EU80zZ1t1R8wdUm+3XKCv0EcrX6xy2fb65HIXqu79iISjgVwE9GmnATVIKRWSRJ
	0sdrhuMDLn+ylq1BrqHOi5C7uHTOx74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698768408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SUSyMWoubFo1JlnewUQEtX0aacilks/g9wP8Qc5UNQ=;
	b=gLnaQ+oi5tEV+IsHABW78T+fAkyQw84ZxoFdJhzg/F+ngvHiP1GDJlHjqybxAokssQQXVO
	faXjNBBwVC37N6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49481138EF;
	Tue, 31 Oct 2023 16:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id C/7ZERgmQWXBSAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 31 Oct 2023 16:06:48 +0000
Date: Tue, 31 Oct 2023 17:08:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <krtenpf5lcrgujgvsuvolr2peszhnk5o4eoamwwp4f6hck5oe3@ozjmudep3qub>
References: <20231030160044.20355-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160044.20355-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_090651_930331_589433A8 
X-CRM114-Status: GOOD (  10.86  )
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

On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
> 
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
> 
> Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Unfortunately, Kenji is not able to post on the mailing list, so here his tag:

Tested-by: Kenji Tomonaga <tkenbo@gmail.com>

