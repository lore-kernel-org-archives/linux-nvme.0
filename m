Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D14C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNxrwakObpFzUmft/BZ2IT2QRV23ZyzZGYYhqP3ij20=; b=aXHzea7y3FuAW/ekQueHTKziUq
	wrpEX5wItv82qGXni8pJ0S2RsIca+QI16wyzwebpFTBweO0uujDJ9FG3z2yygxdQMSgKTI5mrnKLT
	crGPbWGkbj/uG6SN1xI22lppTHOu6EDwVQniSRyIo/VNIsS00QYg8z1TOEP+RWcCpKUBF4Embuw8R
	wiJbpVb6E1iuqz1bHu798YCLwqUZalNmuBnlUlJ7RiPlDngEeRodBr7bTfRy4/af0DlKuTEfKMuQ0
	fIRKsfZVtNh+OcO40bgKS8t+WYoWyxiSh+YcFM4g0DeH1Nko7NIJaNAuPNNyPoEEnfYiXYs9sx2+g
	9fYj+4Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peYFm-00BsWM-2J;
	Tue, 21 Mar 2023 09:26:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peYFj-00BsVE-2k
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 09:26:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C46EC1FD6D;
	Tue, 21 Mar 2023 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679390757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNxrwakObpFzUmft/BZ2IT2QRV23ZyzZGYYhqP3ij20=;
	b=VzOMMezhwXXw5M5lbPirOTbAuGg20erUz0LnQ67YNSr1DiiPm1nfGeiokxnsuWMantuCrY
	KA5XahDjpBSBgSEkKm/Ftc6lUNK7sPaFLV6zBuwpJsO/UoQX4QCfmbtqi0xau2813sClJY
	vu6vJBbWymXJYnbQKvOQEmyvCGUY/PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679390757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNxrwakObpFzUmft/BZ2IT2QRV23ZyzZGYYhqP3ij20=;
	b=w4z8PHJm50WdINFszcO9mYL7IyQ15zYg1mRuuBvd5Yx+w1RZenkdb6JIAebL6vluHTXIzS
	Y1ea++gmmBDs/jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A922913451;
	Tue, 21 Mar 2023 09:25:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EHJ2KSV4GWSCCQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 09:25:57 +0000
Date: Tue, 21 Mar 2023 10:25:56 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321092556.7m3etb25jnd4sfj6@carbon>
References: <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_022600_037121_F4E2BB71 
X-CRM114-Status: UNSURE (   9.47  )
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

On Tue, Mar 21, 2023 at 11:15:53AM +0200, Sagi Grimberg wrote:
> The admin tagset does not have a polled hctxs map to begin with,
> so I'm unclear how any fabrics or admin requests end up polled...

Hmm, if no map_queues() callback is provided for the admin tag set, isn't the
default mapping function used and this would add the poll hctxs map? Let me add
a map_queues() callback and see what happens :)

