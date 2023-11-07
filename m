Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31851C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qZDMSBtWVAg504seqHWeihkTrETvOme2JYvTzx0yJ0=; b=qXJVl9YIVVjzOTTdB94WlpGH+q
	FvJTdCHBSJu8m9Yt3x641nVOsnSKW2YA+5Z38FDNJNRTjwRX9bTvYy/bLO4aMypMbVSjAN3vPEuhs
	RQotQ3FyZk+qo8rof55K+PjHA4NgNskMxIp1U8ArASy1f2va1mWEX07921FzecvIpBDo25Q5NCHDU
	/kaWSE4oBcv5ey/qNNLrKTDYyYFtGQ/jZw4Quoux+tsDe8yNFmsjlfTmj5LPjEWdQLE4lLIMxZ0Xz
	G6v2Y9NUW4QLNc3BIrquvFvkbcgcz0iibKljB0lSAwABaJZ48tHEtbS/buS4YXGGSYXw6dMVrF9aW
	9uYUDqaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0HST-000os0-1t;
	Tue, 07 Nov 2023 08:29:13 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0HSN-000orB-24
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 08:29:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B406C207A4;
	Tue,  7 Nov 2023 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699345743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qZDMSBtWVAg504seqHWeihkTrETvOme2JYvTzx0yJ0=;
	b=sQGfc5PT4wIIiM9QDzcassLKWuWC2T86hmPiHklapCk/Eedl+ICIaz6GDrF9EB2lx28vQY
	5Mj2Ps+dGCl9DFDPdW9c5rIMtY/WIR/4sq6wqDOR0NRyLowoKqn7Z/+/peF+XDaQyybfbq
	3P9kIlGHsuNZgLakSSqXxQywXgqxjpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699345743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qZDMSBtWVAg504seqHWeihkTrETvOme2JYvTzx0yJ0=;
	b=onvCTtiIJ5BEEOdSVi5pVtCTC0ITutYkL5emTD58dH+vOhP21GM9qLJiC2uaeksvShoiKU
	Myz5UYvNPiNrG5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A25DC13907;
	Tue,  7 Nov 2023 08:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LYaNJ0/1SWU0UAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 07 Nov 2023 08:29:03 +0000
Date: Tue, 7 Nov 2023 09:30:48 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <zwmkbfmmdcdppgjncy4bwhlvwbhrlmiwsdgp3n4bumpq6ramtt@7mplbzszzboo>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
 <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
 <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_002907_842617_EBA50651 
X-CRM114-Status: UNSURE (   8.21  )
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

On Mon, Nov 06, 2023 at 09:44:39AM -0700, Keith Busch wrote:
> Fixed up inline when applying the original patch. Let me know if you
> have any concerns with the result, currently here:
> 
>   https://git.infradead.org/nvme.git/commitdiff/983a338b96c8a25b81e773b643f80634358e81bc

Looks good. Thanks!

