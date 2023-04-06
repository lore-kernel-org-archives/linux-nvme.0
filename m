Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC2FC7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfpjhQpsC7u5WfaLzcwUgQNwj9KAibrTmUK9wT2RG4M=; b=fY8gZWFy5IiD7rPGzlR0IyI3uq
	dCUre5kcxhzowNDmWLDVJvHtOg4VHM37Mpn+oVW7JEsGh7BsdC0mgaobv0wr2QiPVdgzXteCmn2rA
	2TplOAptnbKXBzyGNWk2+grT+yG58/Ksmlf14lCGPwEceK31Wk9qOFrdYsSMSCDoGUIlfGfzP/hTE
	bYXKkyT446NtQ3PEgcgfO+LCSVIMf6N+uQDvd11LRa5xY+L5yO9hszXiUatode51j3QMW61diN4h9
	uX1nL+5X2F8xQTSO+uzKeSEbnKTFKHsc8Q7Cw3hRpe8q2Brx6to+doU1CNJlK66CHU7krGuoL2Mmb
	9oe2m5CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkLdF-006puC-3D;
	Thu, 06 Apr 2023 09:10:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkLdD-006ptI-2y
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 09:10:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD1AB22836;
	Thu,  6 Apr 2023 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680772209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfpjhQpsC7u5WfaLzcwUgQNwj9KAibrTmUK9wT2RG4M=;
	b=jYhd60mgC1FpkNLNl9UYouHPEh/Yb1CFDpGzQFCucN5bIfYVvtodDRY0Ju/fdgfkyVuU3/
	C/rXgOxOF+N81yYFBHRdiERGwTYkBwDYbdnfINMd5bsmfFk/sHsfOSIKHaWhtObuJti5Vn
	PtRXPNdAJyscgFZvRxq9lHDkx7nlt7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680772209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfpjhQpsC7u5WfaLzcwUgQNwj9KAibrTmUK9wT2RG4M=;
	b=R8ESKdNDsYunS0R/fQNeZPl4WGWTw+g6slVnlj9vdTY2KsfFpKdIyHQNFI85Xx26OAkX2y
	uKqtiGCgBm6cAUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF3D9133E5;
	Thu,  6 Apr 2023 09:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6u6XKnGMLmRDewAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 09:10:09 +0000
Date: Thu, 6 Apr 2023 11:10:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 0/2] test queue count changes on reconnect
Message-ID: <ftljvb4alzxssqjzr5ik7pvatiwh25i4ftktvgvxzqxk76afew@brp7ch4v7wik>
References: <20230406083050.19246-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083050.19246-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_021012_101184_D117C74B 
X-CRM114-Status: UNSURE (   7.12  )
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

On Thu, Apr 06, 2023 at 10:30:48AM +0200, Daniel Wagner wrote:
> good and the bad case (rdma started to fail today, something to fix).

After adding the missing _nvmet_setup() call, tcp and rdma works fine.

