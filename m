Return-Path: <SRS0=WNIw=MR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D3C4338F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Jul 2021 09:52:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660D760EB4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Jul 2021 09:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 660D760EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strugglers.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=srGK3TSDHUAk87vMQqlY8MyYusFnoB7Mw7VVVN6JgnQ=; b=l0DXP9BzdGkhKu
	KN8pzI9oih+K3wv4wK/VfMCbKkLd1nQVdHP+pl+7h/n0mHZWtz50QJFNbtOJA0Y9eEHonTQDipgiD
	e6qpyfxk7UwtWKA0PZYleQCC1yfMYREV9ygkKIrxSKcQ/jAu8YZAUzsj1KhsiAyWTnMhEyT6XSSND
	3z6Ks4nD2bch9oegftEjWqSJRedhpJer4pV0fy+w4Ah370NBk5ErQbmF+ILD0tPbs/HzOvXfqgt5Y
	6yGSLye36NY7kkwq7T4CwpLHZ91pI7KIUSzEa20PNUkWiyrmK+hX6vpatqRMZF9/Wt6zMLbqL+JUV
	z6XcOShESo7lBYkF40uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m7aoK-008Suw-DE; Sun, 25 Jul 2021 09:52:40 +0000
Received: from mail.bitfolk.com ([2001:ba8:1f1:f019::25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m7ao9-008SuC-4v
 for Linux-nvme@lists.infradead.org; Sun, 25 Jul 2021 09:52:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
 ; s=alpha;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vKfqDcJnYRJQXhWHjF5rteDN+Q1VPPnjObjZgH3NJfY=; b=OK56MNvun+IDnTHLoJYzZm512O
 qu6J0XGx5FDhMKAoAG63+z2meyOLKokqgOo9AjJvY79upDHGUlMetk7YwYgK2nUR/w3/h1QDwoCCk
 u17qr+s8J9wYrX2G1HGfADPyUvGXLNA7Z3aiEQNBVnksVAnEtm+OY5eMrsv4jESz/7ufu18A4mgOj
 9mCkoR1oGEMs2zuC68+9bFOSxPdlNC/PnqjXA/1x6xqaURL4RIOoAdMCiliFyZdp2P5oAdGBiGc65
 2f3t+2PjrqDI4Vv35mYmlQxEyBVnEEmw45AzBGDhwLAm72hJeVszNbG+/V5c//4z0RSvbnFc99lxc
 Pha1vGSg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
 (envelope-from <andy@strugglers.net>)
 id 1m7ao7-0007Ab-PB; Sun, 25 Jul 2021 09:52:27 +0000
Date: Sun, 25 Jul 2021 09:52:27 +0000
From: Andy Smith <andy@strugglers.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210725095227.egskopcs3at6b3x5@bitfolk.com>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
 <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
 <20210723233519.aepsxdnssogphj53@bitfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210723233519.aepsxdnssogphj53@bitfolk.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210725_025229_395700_44F1D876 
X-CRM114-Status: GOOD (  12.07  )
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

Hi,

On Fri, Jul 23, 2021 at 11:35:19PM +0000, Andy Smith wrote:
> On Tue, Jul 20, 2021 at 05:34:34PM -0700, Keith Busch wrote:
> > Are you using swiotlb? If so, this recent patch sounds like it should
> > fix offset issues:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=5f89468e2f060031cd89fd4287298e0eaf246bf6

I found where this one made it in to 5.10.46:

    https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/queue-5.10/swiotlb-manipulate-orig_addr-when-tlb_addr-has-offset.patch?id=fc7b255bfae6e62091006146ca685a25ec6f69c6

and tried it out but still had the same issue.

The patch that Ming Lei suggested:

    https://lore.kernel.org/patchwork/patch/1442338/

does seem to resolve this issue for me. I see that made it in to
5.10.50.

Thanks!
Andy

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
