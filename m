Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1CBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Ts48JWOtEFZypOohWxZdgGO3PH4P/qO9jzspa1c+mc=; b=tvezu4PmQ0kes586fnRe2O+RNC
	+jAXtGTtUrFu6M8nnzw2gpHlGUam6iEv4oeqeuAnsoFm8dIGd5C7LT40a/e5/1Zb/WpSV7I4kZzIB
	P+agr4b6D+RQ0pHXHpF/Z5E57/aviybTmi4jqk7lmE0RAWrwL1boS3y3hBNYJ1jLcXP6P0SLOocqt
	HJI+Avd092sDFhNwdYPoiv1ilZjiJPTYfilh09e/Jiyae2CYymg/HX+p/OVSDStydeGVZGffmtX+8
	s3/H9rEz075eRHN2oQtBrpEbMf10yKmVVimYDJ675dQPQG4DthbSlE95TQdJZNQlX0h4PEKojEN0O
	JpbiPqMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzbUO-006AaV-C2; Tue, 21 Dec 2021 09:31:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzbSZ-0069mP-JC
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 09:29:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAD691F388;
 Tue, 21 Dec 2021 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640078963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ts48JWOtEFZypOohWxZdgGO3PH4P/qO9jzspa1c+mc=;
 b=Im53AKAQRox1E29kg5HjSM6ivZ7D/hbxqbjXMqqcYw0ygj6PYTAUVQQt4oKVWyItwAbsyv
 sUSrFaZ2Bd3/ujTWUKB1cMAhzJsEnifBoTx8OQjQbl9G1BHLVdjPOJUy3qH5aZLJhC5Vym
 g/94odeI3gfXGXjyfn5i/vXdmcaCoEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640078963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ts48JWOtEFZypOohWxZdgGO3PH4P/qO9jzspa1c+mc=;
 b=QtWcfbmdUOMxLSZj+JaRT28/TTeH7V2hv4TzKLgNdWIakrxGdnhu7qmWnHfllj1yVkdpnI
 tCyMU2Y6HN5WjvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCA2113C26;
 Tue, 21 Dec 2021 09:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JHAhMnOewWGDQwAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 21 Dec 2021 09:29:23 +0000
Date: Tue, 21 Dec 2021 10:29:23 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4] nvme: add 'iopolicy' module parameter
Message-ID: <20211221092923.zenaaef5wkp3lj7v@carbon.lan>
References: <20211220125145.38146-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220125145.38146-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_012927_848471_D91BE160 
X-CRM114-Status: GOOD (  12.83  )
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

On Mon, Dec 20, 2021 at 01:51:45PM +0100, Hannes Reinecke wrote:
> While the 'iopolicy' sysfs attribute can be set at runtime, most
> storage arrays prefer to use the 'round-robin' iopolicy per default.
> We can use udev rules to set this, but is getting rather unwieldy
> for rebranded arrays as we would have to update the udev rules
> anytime a new array shows up, leading to the same mess we currently
> have in multipathd for configuring the RDAC arrays.
> 
> Hence this patch adds a module parameter 'iopolicy' to allow the
> admin to switch the default, and to do away with the need for a
> udev rule here.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


