Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C03EB64D7
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jun 2023 06:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vg8m+gOZo2Ctnm5fYV5c15KXIq2TPvxLX6VNN6h6fHI=; b=3K190x+MRiQReTKVcDM8ybq9WR
	+KU1wH/xLON6pPjkEhh4e6/D8pGHlWXZkseUC56TLZQO7m4uzIgMjmQsIV3l4yKbFrFQgA0HxuDX2
	pzZTwYU36TzNQTCYXupEpIcAqiuAJ4d7mdtV0YnTe53WkWXqn8anJb0RzUmmCu94/idet1g/jQ8Ox
	Z/e8shMhq6U8UwIiWRZ+OAq9mvxOVVHOPltTzmvBLjh/DorJOFA+wwofYcaCCu4idz9WTl9ZR2Yar
	QhyjU6xEnQLMOstnGGZQnQJV5eNrg0vLG8De5vQ2lCNxbMnVtIfLm4LFlTptAdz+YrbEw01GnI0Az
	jYlg0h5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDfcb-009USZ-0f;
	Mon, 26 Jun 2023 06:22:45 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDfcY-009URe-0b
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jun 2023 06:22:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A9E021869;
	Mon, 26 Jun 2023 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687760556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vg8m+gOZo2Ctnm5fYV5c15KXIq2TPvxLX6VNN6h6fHI=;
	b=mcs8l5h+UZoW3kYhqFvGfJCIfZmclnIGjQN8F8rHSYN5k8/d2Fx3U1ijB2ukJDSMay1anE
	p9hS4iAyucwbGNAtftQuGlAk/g0uWUwcNHWT3Bm5cRJr208dJjmKVoQEPeJP+WlLOC7tcw
	F51FjyQH+5wPHod9VphI/UkRWtQCtvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687760556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vg8m+gOZo2Ctnm5fYV5c15KXIq2TPvxLX6VNN6h6fHI=;
	b=TBwmIDqKRWgASxHvxuojaYX+XrMtpWojde10yrGuBMtdbhsZut4HMzMFfGTCZ8EbEziipR
	6S8Z2s203gzNxoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AA6813483;
	Mon, 26 Jun 2023 06:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZdKOAqwumWQwJQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 26 Jun 2023 06:22:36 +0000
Date: Mon, 26 Jun 2023 08:22:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "smith, erik" <Erik.Smith@dell.com>
Cc: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rose, Charles" <Charles.Rose@dell.com>, "Belanger, Martin" <Martin.Belanger@dell.com>, 
	Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: Re: What's the upstream disposition with nvme-stas?
Message-ID: <3cjas7azth362niaosfcanhvflfewbmeoccvcjvpzfjsphpqm6@yqzh55jytrhj>
References: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
 <ZJW+toS0tyjMsJf+@kbusch-mbp.dhcp.thefacebook.com>
 <BLAPR19MB4228E1B24E91404BB3E02F86E423A@BLAPR19MB4228.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR19MB4228E1B24E91404BB3E02F86E423A@BLAPR19MB4228.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_232242_408647_14A96213 
X-CRM114-Status: GOOD (  11.13  )
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

On Fri, Jun 23, 2023 at 03:56:07PM +0000, smith, erik wrote:
> With regards to "stas can break things that don't subscribe to their way of
> configuration" We heard this feedback clearly last year and Martin updated
> nvme-stas to make sure it doesn't remove connections that it didn't establish
> in the first place.

BTW, we just added a way for nvme-stas to tell nvme-cli which connection is
managaned by nvme-stas and thus should be ignored by nvme-cli. This should
also help to make these tools to coexist on the same host.

