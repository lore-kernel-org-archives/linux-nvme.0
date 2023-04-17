Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E113C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+TnSdp9D48294YIKeIBP/CLRispqHrXJQlficOpYis=; b=4eIMcjUo1SLQUUN5aLVYlv3NZA
	BQaCZZTAntqH92KFXjfOX7+/qg6KcuaGFZoQnT9+DxQc76XDt7DBcGT39nMe6BOiW5mQ6Yp7ICvHs
	FE2TwkQ0nKSVNC6X7Dp+Y6Abtuz/dghFxbYCNVDi8YVZ6Mm0lKYGUOzlH0VwmhU9mAQWmv1COBwfv
	R5yZNwApyHi42xlcZo2XjppC4Jy2RZzFfekMc02dvgQ2r7aSATxH6WiqdZGTMTlFHW+fLgm57goYv
	hNIPo7QrYxv1dADDW7xdB/RQGvJI7OUX+0pKjDLxTL7PqxX3OektQ8Ai7IBbvj8/3qiSGo+IOm127
	p30/N/JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poKwd-00FUQO-1g;
	Mon, 17 Apr 2023 09:14:43 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poKwY-00FUPK-2l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 09:14:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED4821A4F;
	Mon, 17 Apr 2023 09:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681722877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+TnSdp9D48294YIKeIBP/CLRispqHrXJQlficOpYis=;
	b=0rQbwB7b4Q1tieklVaAdzZxwMuLqaqauv4BkgmOqa10Y2odVqDMf9fkkkxCYFN3jLhuDq6
	p61iXdPvkVeIpjO4tGokaZ75HwRclk3qjsI9oi0cubSltj+BRYJLHDaFrjMSSeJCKnNTGP
	FR2+gOtY5WJZTROp8a7/0OTgWErI8Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681722877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+TnSdp9D48294YIKeIBP/CLRispqHrXJQlficOpYis=;
	b=tGU5n3yBpk8IGHnvNIWtcVF8qSPP9FUCwObR05DLRfQZylRhTjNNVPrLtUy8oYre4UFG8p
	fKdgRjiTpoTdNTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F39FA13319;
	Mon, 17 Apr 2023 09:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KCZ4O/wNPWROXAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 17 Apr 2023 09:14:36 +0000
Date: Mon, 17 Apr 2023 11:14:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <rjoeveo4f64f6hwdu65weljwbeceoj4h6eriiborxtnvfzmeqo@l3t5uh5s24rq>
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
 <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
 <sqrbip3dafgf4cnmmdziect6vem2msocsxqcqmnvyrlkartomj@ilwk43vyl53s>
 <c70e194b-ed19-7d0e-5976-477cfa74a716@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70e194b-ed19-7d0e-5976-477cfa74a716@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_021439_038934_C2B58D7F 
X-CRM114-Status: GOOD (  13.47  )
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

On Mon, Apr 17, 2023 at 06:02:24PM +0900, Damien Le Moal wrote:
> Not sure why as in Fedora, pkg-config is a shim layer on top of pkgconf provided
> by pkgconf-pkg-config package. But I cannot uninstall pkgconf-pkg-config as it
> is used by gnome-shell.

Didn't know about this new implementation of pkg-config. I found some explenation
here:

https://fedoraproject.org/wiki/Changes/pkgconf_as_system_pkg-config_implementation

> Looks like something is broken in Fedora Not sure what as
> /usr/lib64/pkgconfig/json-c.pc is perfectly fine, pointing at /usr/include/json-c.
> 
> But I would still say that it is probably time to update to pkgconf :)

FWIW, you can specify which pkg-config implementation meson should use via the cross
ini file. For example here is the one for using clang instead of gcc:

  [binaries]
  c = 'clang'
  cpp = 'clang++'
  strip = 'strip'
  pkgconfig = 'pkg-config'

https://mesonbuild.com/Cross-compilation.html

