Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A340EECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4s/qAb7GMkAWmPpDsxHbPzlgPlt+X8LjKMU8XtxpQY=; b=1TX1J6f8vZSaC5HZFOTcCSRyVS
	tzDJ8JBweP8aHRXXsGJM3sebfNqVXKt/UkNWXS9NMGIPPoQF8WKjUUTMyAyRJ94ikyx8mNv+ftaOu
	caGeYeG2BkOFVZ2ZlsNzesxmkgfXFmTRFf0faeHosTjcsI5pRSH/MWlyzQ1WqgeVFmGPxOVV2XyFx
	S7Gp2Eom6TnxUKqobVX1v17v9xWUVeRYo20j6FDV5ONwr42CnRSY1KS1CfZDr4EtEFy4ko8baRgkQ
	YkUj55M30IBh0aOPoVE52rcWM44UhmTDhVrD+0fL7UyGGK/cthYR55QeU7kLUb1LyD0WPm+HeZIUM
	ETddwD+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXkHG-00Aa3G-GQ; Mon, 12 Sep 2022 14:19:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXkHD-00AZym-ID
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 14:19:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4927733903;
	Mon, 12 Sep 2022 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662992342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4s/qAb7GMkAWmPpDsxHbPzlgPlt+X8LjKMU8XtxpQY=;
	b=bq95XpjxAHFOXv8KcQ6xAFGzJXpGowEv32zn6KzIxi7K0a4zaD3+zIBkc/A4yZOBJDgo4s
	apyUeBqEQjaXQ/jyYuK73Wmy87YCAW8iCqbXu1Khg2nniOBlRqIpOgHM9Xtz/lzTDKxNNO
	caEgVspBD0sepYYeB9uM5aeQ5HxVaNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662992342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4s/qAb7GMkAWmPpDsxHbPzlgPlt+X8LjKMU8XtxpQY=;
	b=HpVuTLCCYbUSSjRGEEZluSwW3fLPJmGJXnBbq/uZdxWYbiKqhNlpM1Dzvw0omc/xI/9KKF
	xZ09rdeGo716mhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC8A139C8;
	Mon, 12 Sep 2022 14:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /TeUDtY/H2NtRAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 12 Sep 2022 14:19:02 +0000
Date: Mon, 12 Sep 2022 16:19:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH libnvme 2/1] nvme: Add generic connect parameter support
 detection
Message-ID: <20220912141901.xednd4g55hr6e46h@carbon.lan>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-3-sagi@grimberg.me>
 <20220909065657.vnf6lzzfcs7y5nis@carbon.lan>
 <b709468e-56ed-a7af-6556-7ddfc4c3fea7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b709468e-56ed-a7af-6556-7ddfc4c3fea7@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_071907_764090_39E75316 
X-CRM114-Status: GOOD (  17.37  )
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

On Mon, Sep 12, 2022 at 03:32:01PM +0300, Sagi Grimberg wrote:
> > > +int nvmf_check_param_support(const char *param, bool *supported)
> > > +{
> > 
> > I was wondering if t would be better to return all supported features in
> > one go. Not really sure about it though.
> 
> Why? it is already held in the kernel, why hold it again?

True, I am probably making it more complex than needed.

> > This triggered my question above why we don't return all supported
> > features up and have the caller added something like this?
> 
> Why? the caller doesn't need the entire array, it is just looking
> to check if a param is supported. We can move this out if someone
> actually needs the entire string or set of caps...

Right, let's address this when there is actually a user for it.

