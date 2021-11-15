Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A74C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA561ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 09:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CCA561ABD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fmPGLpebiLoRVmB1oFKHrPfJczjcI94VaqjZNKKYyPI=; b=tCI8cP1Ya0H9HtODw2SYw43Bx/
	6kzOz7cKlsj50Qxpvnod6cKT0sxaQy5ZKWG4/NM53BpugtjAidsrbnbAzvVTjqQ5Tvr7L57eNzL9h
	qihsn2A/4MW2HKMCNRNaCCdYM1XtLkJ7IqOQfNCS6B/sKKAj1DoDf7qRgQ8mSZg54fC08LIDC1kwh
	oEyHYDEIhTF5Wp3W5/bgKV5ddDNqICjibR60j51xD0Xda7YlL2BaPPLjGmVAzcbtVV3gvNuy8YyPh
	EJ9lIg/O3Kb2Saob3g1hJJWmz20zhKlqRw+NYjlBDkHrrtKlS7PtzSBd3FW57IFDE4BCB27UR9XDl
	ZGhJnMPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmYOP-00ExD1-Ru; Mon, 15 Nov 2021 09:35:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmY0q-00ErC6-Cn
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 09:10:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13AC9218F0;
 Mon, 15 Nov 2021 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636967449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmPGLpebiLoRVmB1oFKHrPfJczjcI94VaqjZNKKYyPI=;
 b=ddE8eYJGUJpDoM7Fx0npvpCqCWlJmBM0BtDmTUwVJM/YkEmOtUTRj3XtYT5j6Vne5R/7qw
 lYc5QAwaaTF6OY4N6n4tc5W1wBAsKlSxMaKhhM3bKMMLKRu/CstwwK+9z+aGQ0bOfakZKt
 XBUmu2/R1iChx4/F4BfAQb6Q4p6dUkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636967449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmPGLpebiLoRVmB1oFKHrPfJczjcI94VaqjZNKKYyPI=;
 b=AqWKYNXEet6R8RNwdkYh/ebtQnTdF35udvIEbPnndHpYkIeAbX0bVOuekv804tjZMBcsN9
 LxBh2M1DoOsWRVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 036F513C14;
 Mon, 15 Nov 2021 09:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H1rPABkkkmFWfgAAMHmgww
 (envelope-from <dwagner@suse.de>); Mon, 15 Nov 2021 09:10:49 +0000
Date: Mon, 15 Nov 2021 10:10:48 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add sibling to list after full initialization
Message-ID: <20211115091048.24immqc3b4b4oan2@carbon.lan>
References: <20211111130603.16547-1-dwagner@suse.de>
 <bf2ad20e-5c79-54a1-05e9-057f36901990@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2ad20e-5c79-54a1-05e9-057f36901990@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_011052_649528_C5F0E2BB 
X-CRM114-Status: GOOD (  13.14  )
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

Hi Sagi,

On Sun, Nov 14, 2021 at 12:56:55PM +0200, Sagi Grimberg wrote:
> > Adding the newly created namespace before the object is fully
> > initialized is opening a race with nvme_mpath_revalidate_paths() which
> > tries to access ns->disk. ns->disk can still be NULL when iterating
> > over the sibling list.
>
> But ns->disk is assigned before nvme_init_ns_head is even called.

ns->disk is NULL, but we are missing 5f432cceb3e9 ("nvme: use
blk_mq_alloc_disk") in our kernels. The commit moves the ns->disk
assignment in front of nvme_init_ns_head.

I didn't spot the code change when I forward ported the patch.

Sorry for the noise and thanks for the feedback!
Daniel

