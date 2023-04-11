Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFA0C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EV8e+y7eNRKrFN0k8UGFpRSD2keQGbtk2Rp81PGmh1o=; b=s6wnqVdPTEkV/E4R9T6LLjsboI
	jKccba2yP/IfMK683YOHvU8MnuoiaeZa4eHtLZSf/lASi9sISODFnbWdAKbKNLRts5GeNYHcrheFa
	cCHT9p0LdHvpR/D65u/0D9HN4+R0kSOS73LsrGHSi8Tghb/wpSsDpGwr/oIE8c7V3Hp9lxfDsSGWI
	2hyksLW2Qp5ZdeZS9k/pSybJXkqz8q4clgkCmoRu0oGwjy/5KxcaifsvqLkWorUuf8miL91x4NGWk
	iJqvaxGK5Qt4NpGkidMRR0Pbr/jZux6xJNu+h5+m0gNbbE0CjEF5nARE1gLF+dRaYRAjHRD6yTMkc
	iuYpMTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmAwV-00HBqQ-2k;
	Tue, 11 Apr 2023 10:09:39 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmAwS-00HBp5-2t
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 10:09:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE4ED219FE;
	Tue, 11 Apr 2023 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681207772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EV8e+y7eNRKrFN0k8UGFpRSD2keQGbtk2Rp81PGmh1o=;
	b=uPr2HSiN9KFEGP474YkBadjLab0gOtMS+1OSfO25IayTA0yjUfwB9F1Dx2ICgpPZVLMrFR
	mULtYW+rQYwIyySAdhvmHkpkQWJ4m3bd//cFUspraXLk+5QHy9SWB1PgIocOfFyBtj0lC1
	XJBDVyMTXGQjsZ/+yJkfKFJ7zFFQnSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681207772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EV8e+y7eNRKrFN0k8UGFpRSD2keQGbtk2Rp81PGmh1o=;
	b=BHQ9Gw2QP0Q7LUnJEEGkp5RgzyqBtc5tCALhs7YVgVkKISbNPTlHSK/w0kwzHx3NBuU+Xc
	XNsyb+MIEpZS0HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF90E13638;
	Tue, 11 Apr 2023 10:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6ruhMtwxNWTRQAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 10:09:32 +0000
Date: Tue, 11 Apr 2023 12:09:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] rvmet-fcloop: Remove remote port from list when unlinking
Message-ID: <r5hxrqiiqfsj27f3jlb2avq6wulg3ksnuf5zg6xrgkdprgrpxy@ssusv6tvghqy>
References: <20230411092209.12719-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411092209.12719-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_030937_075206_B0CB6F2E 
X-CRM114-Status: GOOD (  12.14  )
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

On Tue, Apr 11, 2023 at 11:22:09AM +0200, Daniel Wagner wrote:
> The remote port is never removed from fcloop_nports list. During module
> unloading it's possible to end up an busy loop in fcloop_exit, because
> the remote port is found in the list and thus we will never progress.
> 
> The kernel log will be spammed with
> 
>   nvme_fcloop: fcloop_exit: Failed deleting remote port
>   nvme_fcloop: fcloop_exit: Failed deleting target port
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---

Found a bunch more problems which need to be addressed. I'll collect all
changes and send them as series.

