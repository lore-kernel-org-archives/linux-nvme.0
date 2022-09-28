Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595EAC04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QThFN93O3n/qim+P0KBKy0IkOhnwxL7zSu1xtVZm1wg=; b=263ceGlDEGKpITlgIlzACrg2l7
	i96Qnl+sj92BWHTgdFo9/sFG09PCI0bOapr6FwSY2NwbdCkxEGwL6Q0j6Fdn6jo3JYvvamWfE7z4z
	oi2I7rRZBbBLLccQBahsrD1QWv7PP679LDR0LODk9uIOZQ6dUOGlOrz7n3qjbcpcG18Py/t3Di1kE
	SgmWUmPjodTDrvB1PzeH1j4wDhVpuv/B1b+M26lOGHmdGj6mlb2a1rJYEad5rTc5gW5Bvcnd1MAMC
	SGpzoy+X3o2fbYv/j5HYNaukBKiKJ1hroKc1AUmMSBTcC73IbOnsmRbJjanjaR7lawjbV2GsCGWz1
	Io82oRJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYx4-00GtSE-Ln; Wed, 28 Sep 2022 15:26:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYx2-00GtQo-FQ
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 15:26:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D85E71FA3A;
	Wed, 28 Sep 2022 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664378776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QThFN93O3n/qim+P0KBKy0IkOhnwxL7zSu1xtVZm1wg=;
	b=Y2xw+ycR63vw3WvM672YhD5G2DrwJ4dqzQlaxzaYvKJQNwqlww6Nllpu//XXVK1ywV2pO2
	0aK+K0h3nHxPGkzi4/cJ6i/vwOI68jXylzzJqREl71J5y4RR4J+K8n95i3EI0/25AyJ2r+
	hZL4ZsxXEbAqW9lAa7ULyPWWhK4ogK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664378776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QThFN93O3n/qim+P0KBKy0IkOhnwxL7zSu1xtVZm1wg=;
	b=klK82r1Huo4ZjDzt9//Kh/DXHCKZ99sTeF0VeDxJNo5F/FizdIuBJuKtZx6hAQdFS92gYl
	TyIbbB8wJ8zGAcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA44E13677;
	Wed, 28 Sep 2022 15:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gWo8MZhnNGPvDgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Sep 2022 15:26:16 +0000
Date: Wed, 28 Sep 2022 17:26:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "Knight, Frederick" <Frederick.Knight@netapp.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_082620_676776_632A5AF2 
X-CRM114-Status: GOOD (  10.37  )
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

On Wed, Sep 28, 2022 at 11:01:00AM -0400, John Meneghini wrote:
> So this is one place where I think we conflate NVMe-oF with NVMe in the
> specification.  If "reset" == "disconnect", then Daniel's patches just
> implemented support for something which is forbidden by the spec - a
> controller that changes the number of IOQs between resets.

FWIW, the scenario I described is from a real world experience. So even
if it is forbidden by the spec, it exists.

