Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23602C7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=anBXLsOH67TngonUM9cUYiFUalItWHQkLvb7KU6lRDA=; b=gXB4eJZ2tv5LGbD663dc37nbIQ
	yrMw/ETORS71r1bkDVykDqrXUu/17CFtKY6lqjHcgbuFUXoXu5djK40xl71rc73PAO0laJVOsAxjM
	AMOxm6TGpaFZvR4oSxrbU5014it2LWE9/sxpQwoPSFX2749V9LhfpuouKQz/zUyh3xIABnuy57JqS
	r9SSenzhu3xyjKPG+IqPs/JLKfKHdo/WCT/8fDfEI9EbcQn8k5MF7Ng8Kc4xy+wfPfKUQH4Fa1UyE
	B54g1S8OJ8pFOixVgT3W3erLHv8QpqAR15MUOAACpUyL2z2rd7FQKu7OmDa3IxDUdP6Y6WtCPoGhd
	SBjwW+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkJT-009pqE-0j;
	Fri, 21 Apr 2023 06:32:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkJQ-009poz-0w
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:32:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19B5A1FDDB;
	Fri, 21 Apr 2023 06:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682058723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anBXLsOH67TngonUM9cUYiFUalItWHQkLvb7KU6lRDA=;
	b=D62WDrk1RJWWq0aiGrAoYAmo2nJ0GNJ6eGwIrbMgTLkJD9M9sJKMMX27NPPYDqwkFp3h5T
	VGsyAC82LV58szBJb71TAA0l2XiLnwi6cUhN98Ju/gMqUKWfFGdMFctPGSO6OfMycCJJ1p
	y8+Frp+nLkdtI4kMKdXRzxUDz5dmHb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682058723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=anBXLsOH67TngonUM9cUYiFUalItWHQkLvb7KU6lRDA=;
	b=3eqQXoWEbG2YfRHwqH3zj0SEFPudsRJNVrH0gHtzoDIip4Sbrb55h8G07oYLT3pKE0t9cJ
	w1+q1kxgUhjFvsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0863B13456;
	Fri, 21 Apr 2023 06:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UF0LAuMtQmR+cgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:32:03 +0000
Date: Fri, 21 Apr 2023 08:32:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH 13/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Message-ID: <bp3sinhr2fgfooryjbiezzsyuz2kwarxhldsgsbhij5uk7suct@hrdupmuv7jpn>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419065714.52076-14-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_233204_473400_A5A20546 
X-CRM114-Status: UNSURE (   8.56  )
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

On Wed, Apr 19, 2023 at 08:57:10AM +0200, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

