Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4538AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEKJmT/L7OaBdcYwIyqW3X803o4P9kzHPY12YRCicU0=; b=OuahgDg3OuwzgwozD9zVOpvF1M
	ndWnBdneW9FI204J4UohoiZM7HV/MtXpJHt9udnisidtUFwYQXprrmuXEf2YxctgW+q5N4d3SOOZU
	C6lwz8S0WOX1MiW0GIug9geRH0ddIFVUGQHg8UDnuHEr4xDtYOIF+fSUFxfcCmYxpzC4/4SST1mza
	h7swSIb7QaapBmnpEssLSCXvx8k4aHgd2gor0dYLAQF1+F01K4CtOLWBIMTSQl8WgMSl2S8upId5+
	qf26pi32hwbcJ93KFaTmi1DV3nuPot2oiR+9v0GJgxlRkYjNVSyr2+N95wewSpN11dJFpVnOYYW4z
	JMOToQlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peHKx-009WIB-0p;
	Mon, 20 Mar 2023 15:22:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peHKu-009WFv-0n
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 15:22:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA6561F88D;
	Mon, 20 Mar 2023 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679325724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEKJmT/L7OaBdcYwIyqW3X803o4P9kzHPY12YRCicU0=;
	b=K/0Xku7eHCj170wWT2bcanwVQ74oNlPmqaCgOdFha1uWulQD+QlHhaFPALHDkPq1GrsTb9
	2wzApde4neelkUnjJfkyKXoyNTXcMIUK6J6SlHKE5Fi5UUpB3X3c7aN98tShN9uB2SMWJf
	cmYjxAVar/3/avb36G3+znABA+4N1mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679325724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEKJmT/L7OaBdcYwIyqW3X803o4P9kzHPY12YRCicU0=;
	b=cYB9AC6v6/UH/1iv+PBylegTkh2heo87MopQ1c6X60D+qKwFdhjruz1cYGVeXlPMdtLiiX
	m9tIETn9KJrlHWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB63D13A00;
	Mon, 20 Mar 2023 15:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ADSjLRx6GGQbQwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Mar 2023 15:22:04 +0000
Date: Mon, 20 Mar 2023 16:22:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp poll queue crash
Message-ID: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
 <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
 <20230320145113.md6dcyv22yqhppmz@carbon.lan>
 <ZBh2bCPAnShTMxoF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBh2bCPAnShTMxoF@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_082212_427905_0B3F3045 
X-CRM114-Status: GOOD (  11.52  )
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

On Mon, Mar 20, 2023 at 09:06:20AM -0600, Keith Busch wrote:
> It just happened late last week, so no worries.

Didn't catch up yet it seems.

> I believe we can get rid of bio and bdev dependency, and I am working on
> detangling how to get the cookie through without these.

Alright, I try to figure out how to add a test to blktest, as I can use it for
my work as well. Though I am not sure how to add yet another parameter to
nvme_connect_subsys() helper. It is getting a bit ugly. But this is a different
discussion.

