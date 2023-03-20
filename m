Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEEEC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wr7pmrvOVsU195mFORYi9q9wFkbm+w5svC/aq1uzb/Q=; b=uIpEsGmPw0utP0k5dcHLSEQFQ1
	RB01vsgMJcB1CVu5PpEvK5mFCa/5Rpdl51Y6XSi6tsm6Dy5+UNZRuhuUN6F6gB3Fq4trj0blyavEM
	qWyvPEIm2ZFInWJk5RQOdOc9aiNogx1U1t9UW7zdAnX8bzIDf2Ii3KbVLZjBQ5SRcsxpEmOVuW+1a
	R+vG2WER9oUIyDSCGsnBaFG3dmMG97HpQOjbd6Ir0mR5uUthWqn1u35oDZBbR1cos0UGvgZqonjlO
	vTJgSn1vcfhG0/S/MzQVt2v4SmyDQPvmfaOl7XHePdM+6Kc/fUG+tvJymLqGnP3XXt6vUKCXq8eRV
	RWoaVTYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peGr2-009O2g-15;
	Mon, 20 Mar 2023 14:51:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peGqz-009O1C-2A
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 14:51:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BC8721A06;
	Mon, 20 Mar 2023 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679323874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr7pmrvOVsU195mFORYi9q9wFkbm+w5svC/aq1uzb/Q=;
	b=URWo2yEdwRWl2TZTsLWLlS13PsqMYB1zxQmDVhHzsz1fkJS18OKNIVXi1A3StXcjvGL61O
	BKTHvUjliIeChJM9wHjWFKQrJKvbSNPsT5tckSJWrxER1pHMnhZ0Le6QEEzzgX1dShC2wK
	uDQceCX3aCPQMX5o0AVkIuDRI7/9G2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679323874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wr7pmrvOVsU195mFORYi9q9wFkbm+w5svC/aq1uzb/Q=;
	b=F/jOekUmTbLPgUM+8nSpx4Zx8zsFv/sXT6UQlGX03Ww6w14MkLOHChg3/pdffEmeHSHHxL
	oK+EwOASw41YqHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EAC513A00;
	Mon, 20 Mar 2023 14:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mdbqHuJyGGTxMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Mar 2023 14:51:14 +0000
Date: Mon, 20 Mar 2023 15:51:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp poll queue crash
Message-ID: <20230320145113.md6dcyv22yqhppmz@carbon.lan>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
 <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_075117_859876_6D231662 
X-CRM114-Status: UNSURE (   8.26  )
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

On Mon, Mar 20, 2023 at 04:36:58PM +0200, Sagi Grimberg wrote:
> This was reported and is discussed in thread:
> nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034

Thanks, I couldn't remember this discussion.

