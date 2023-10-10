Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8096CD80BA
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTD3h1MzzURhTdsrWj1GSCizG5ibWTwE9JYUAonQMJM=; b=Jd4n1lV0BHVzVJaVQgztA9ybJV
	Wz3GjJPVaaEsBOu31le+zZS66M0CFtc0PcUJtH/W9uJSLFbmwjEdlZGmt5Gw6+VPStrEp3SSKAtke
	SgxI/skT9jQUFsCR0GnQwP4FwQbTRD94WeWjAZTzD4F7CjVr8UGzN9xiaWsUH2aThysgTDxQaepEI
	0Pus5TeFsHFC8kn0VKahBu5JcY8bP81UJ2ejgYuFmBzQWA4jv8fhGN72G4DQpBpV5wCLA6xnPM4fF
	SH3onyA4N2nA76FuJgvWvidjfbTpsBJU14yrM7LoyBxbmX+DyTxd700JcyAiAsgeqhLN9/EGpnL8x
	lXQYbXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqBgg-00DJd6-16;
	Tue, 10 Oct 2023 12:18:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqBgd-00DJbJ-0n
	for linux-nvme@lists.infradead.org;
	Tue, 10 Oct 2023 12:18:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7814B21862;
	Tue, 10 Oct 2023 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1696940282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTD3h1MzzURhTdsrWj1GSCizG5ibWTwE9JYUAonQMJM=;
	b=A91S2Db5Lr15IN7l/QjeAWm39sgne7+X80NhiG4yXFZBECf+wWvNokSfnSCN4BK3lePvHc
	ATunS5ccXytEvmeFBGwJz/8nz84lqgcbJmYNq+3j7DGTorA/reu4PbKPJrtfLUrrY0G3nZ
	fgA5z2Ea/rh64p9TT1gZW2L1fxman0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1696940282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTD3h1MzzURhTdsrWj1GSCizG5ibWTwE9JYUAonQMJM=;
	b=1OCfu/4JCTDQE6+y7I5LQy5QmCnCPseQLuxAogXpFxdKCsW8M+IIfoBnsPRM7wwQ2w8i6M
	tdif483be84Nm9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 683071348E;
	Tue, 10 Oct 2023 12:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jBrfGPpAJWXFSQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 10 Oct 2023 12:18:02 +0000
Date: Tue, 10 Oct 2023 14:19:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: mwilck@suse.com
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	"George, Martin" <Martin.George@netapp.com>, "Kumar, Arun" <Arun.C@netapp.com>
Subject: Re: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional
 authentication
Message-ID: <fklwtncxj2gmcbz6tfrltgop6opkgj6duzagbgelx4ivznk3vm@ygxf3ljbrjdn>
References: <20230904152638.28311-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904152638.28311-1-mwilck@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_051807_444236_60598CB5 
X-CRM114-Status: GOOD (  13.30  )
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

On Mon, Sep 04, 2023 at 05:26:38PM +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> Commit 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
> replaced the condition "if (ctrl->ctrl_key)" (indicating bidirectional
> auth) by "if (chap->ctrl_key)", because ctrl->ctrl_key is a resource shared
> with sysfs. But chap->ctrl_key is set in
> nvme_auth_process_dhchap_challenge() depending on the DHVLEN in the
> DH-HMAC-CHAP Challenge message received from the controller, and will thus
> be non-NULL for every DH-HMAC-CHAP exchange, even if unidirectional auth
> was requested. This will lead to a protocol violation by sending a Success2
> message in the unidirectional case (per NVMe base spec 2.0, the
> authentication transaction ends after the Success1 message for
> unidirectional auth). Use chap->s2 instead, which is non-zero if and only
> if the host requested bi-directional authentication from the controller.
> 
> Fixes: 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

Any chance to get this applied?

Thanks!
Daniel

