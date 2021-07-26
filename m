Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC75CC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 20:17:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B7260F8F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 20:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80B7260F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8n61BPy2A5vhVbEfaeG22XNtC5k3yJLZkhli87payyU=; b=SUGvPsgAe44To0
	fIKWBUxC23TgEqrbAwD6r8m/U06xNiGuOhQtFZcx9dPayP2uDgOvD0J5SnwcZJKu2a0jWinzzn4of
	PaqHveHwcjlNHez8a/lJTHfKKE9SpmG5641xX2yPaVgcUQfY3KDWMoZFpzPuh/DW6uoOLLbeDXm0J
	eg0Sey0pYtgJ9soPa9vT8/CAhM9DZzGruR/hMIO5+B3M+5c0oKGu5BC40NrBmF5LSU3ngrSVP7z+G
	tg6RAICotjEH2sk9xTKxGhXq1vqtp1nZDqhs/7ipaKKeDxWKB79xjKXFZdZjEF0KYdRp0xXPmrdPH
	h+JkB3d2ntyyXPCyQdRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m871x-00CQ2Y-CA; Mon, 26 Jul 2021 20:16:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m871u-00CQ2A-32
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 20:16:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE98760F8F;
 Mon, 26 Jul 2021 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627330609;
 bh=Z4hwq6b440OkyWGYI3HMsBLmFm75Y/asw4v0/OVEDyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sEREw4glvypOLeWWc3l0NhaVgTrSd6R2J0yIzBQWNnscjxyEhYJgBFBvK2p6Ax6H7
 etXE3FYYDnwHSteOa7Xy1IKLPu4GEMOSt6YL2BgiQFX+jl2U0VwSmgzFI10PuXJAaL
 l+0p+2y/+qUveODb7rEIstqeC9hQ3Gwi+iBl3xsJq5JkgNAoMQfnONgQ5DK9HGNeQc
 Vux6h1JZ17eGPx52tD/kN2bVNnIygn7j1nE1W4l+OEKD83h3Si5/vBbuMS7PsybLhV
 hzMGMetMPudou0k9mz89KwpR8wJjMTUrjglURibH3wIp5rVYCCyvanfPoUj7Lj+F6e
 1PKtHj7LEAwtg==
Date: Mon, 26 Jul 2021 13:16:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: shiva.linuxworks@gmail.com, rjw@rjwysocki.net, len.brown@intel.com,
 linux-pm@vger.kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v2 1/2] PM: enable support for imminent power loss
Message-ID: <20210726201615.GA2025233@dhcp-10-100-145-180.wdc.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
 <20210726132223.1661-2-sshivamurthy@micron.com>
 <20210726194146.GA3986@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726194146.GA3986@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_131650_209915_819C2276 
X-CRM114-Status: GOOD (  14.75  )
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

On Mon, Jul 26, 2021 at 09:41:46PM +0200, Pavel Machek wrote:
> > If the shutdown is pwerformed when the platform is running on the
> > limited backup power supply, some of the devices might not have enough
> > power to perform a clean shutdown.
> > 
> > It is necessary to inform the driver about the limited backup power
> > supply, to allow the driver to decide to perform the minimal required
> > operation for a fast and clean shutdown.
> 
> If you can do shutdown that is fast & clean, why not do it always?

At least for nvme, I don't think this faster shutdown qualifies as
"clean". It's just a little better than removing power without telling
the device. Typical implementations take longer to become ready on their
next power-on following the abrupt shutdown sequence.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
