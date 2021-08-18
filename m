Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC872C432BE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 11:43:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F536108B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 11:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96F536108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=12P3lGd//SVgjdcxIdhfdSY7/W7LTXlLgpXuVmhXCJw=; b=43/wBerfqepuf/
	LxtjcDT01975R8y+5dWPZZvt0wBE9xf7hPjGFgqaTP2l253PmLhy0pusG0pLAqDQPL7Gyb+uNDcXi
	qtCuuJZhLDwm04dlWcCFuwJjnBIKAnQsauCKAuOKHXLHtYEmnb/iuS86FijLNNbw4DyaxZ+W4+k1T
	TEvHPpsQNjxSA5kD08DcOPEuZCtHNuvQ010jopYTw0+Kk2R38IMmV0CRyaGBjECz+giuNF8ezkwyH
	snFZsJoSLoJW5DP0cQvysv5l/wnxNC3Veu1qzkPAEREyP1TfhgJa9UVMw0OxQyGvRtkt91RUfz8nT
	49vIUNPcuUu7T2gtaugw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGJya-005Nzd-G9; Wed, 18 Aug 2021 11:43:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGJyU-005Nwe-IF
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 11:43:18 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0F3721FE5;
 Wed, 18 Aug 2021 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629286989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDES0WgtFkq46xcCB56We13uRLgKpFMl/f/27zVfgWw=;
 b=NcZMCCuMYPjzQT1BFbim4flVCxORBu/2y/H2fYEoGs5IAgNr+xi91PHnKodoeILmkaoS12
 grs7WFQOUFg2uRjZMyB9P9aCih4CmJbwgl9Q9cqbug2QGTbZuDqQU0rkNizO5fpEHhuhWL
 gVzvvZHKVREa3Egcpg77JkSdRLkqFe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629286989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDES0WgtFkq46xcCB56We13uRLgKpFMl/f/27zVfgWw=;
 b=gC5wJcY7Y4JrJB8KXRt5htJGyS07xl/EoLBQ2r/BmV1hJky119bKwyWxXC08aRnf2dbmFd
 hFjP0n/YjZscNVAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DD941136DE;
 Wed, 18 Aug 2021 11:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id T5kvNk3yHGHgPQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 11:43:09 +0000
Date: Wed, 18 Aug 2021 13:43:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_044314_795412_A598B2B4 
X-CRM114-Status: GOOD (  10.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 12, 2021 at 01:03:07PM -0700, James Smart wrote:
> try this. Moves the location of the freeze and will always pair with the
> unfreeze.

Yes, this works. Do you send a proper patch out or should I just pick up
this patch and add a commit message?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
