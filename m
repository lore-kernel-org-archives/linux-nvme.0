Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17217C4363D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:55:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FAE20727
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qk5PhsNo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmV7qFU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FAE20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ba4CyZCzKXd512i/Y6Rgl/nSH8N9ZtyQU4bS4mx6jic=; b=Qk5PhsNouQf8ZUSsyW8KCFPCZ
	32HCyisLXi5nq8pYW7g/g2cORak90fY2XkNrRXR13NeaJKhT+ZsN/fU/YYeYRBk9dH0b4uJpXeUBP
	Vi64bsB0muyj4CX6nzQ+8EjbfZgM3ZZf+P/A2VM8DHEHVvUIxvaofMlWumCUdx2hF2u0pQEGMhvd9
	XNV67TcD92t+HlRk53H+IP60U2XtxL+wmZyzMv29XPwCw+LBHFrOa/Hp1IkZS0A7gpg+BcDhWEo5G
	cpeHlFALcvAnbMsXhQwL19aJHoB9tUEbjIWJWsZ2c/rUDvocu6faNQ2MnxmRy7ols7ukkHNDEWwpS
	f5Kc7d4iQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV1T4-0004FU-U0; Tue, 20 Oct 2020 23:55:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV1T0-0004F6-Uy
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 23:55:00 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D21120727;
 Tue, 20 Oct 2020 23:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603238097;
 bh=Y1HeoYG3Oa1hqnVRQ2ldE2bCfCK606L2v8r2u/i5UF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZmV7qFU7760AEvd90PNrqD61uWeZo1xmJNSQ1PLfP2+QYJeUN9dX8Ofdv1AmmDbCh
 36GJ+hzJzasV1I0j5Z0rYbItLxyeVOkhfK6KrrqGgkXPf3S6WcSeg1CQ19x1Mfv8cY
 Sf6EaBwyZVhkkfYmzlN3gNxzJ8ayOzFQOJ2qEAFM=
Date: Tue, 20 Oct 2020 16:54:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: NVMe CLI Version Tag
Message-ID: <20201020235454.GB1438267@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20201020175017.2avzkm2bwyeg2t3a@beryllium.lan>
 <20201020175644.GA1438267@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020175644.GA1438267@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_195459_108352_F73E060D 
X-CRM114-Status: GOOD (  16.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sean Brownlow <sean.brownlow@wdc.com>,
 Randall Bates <randall.bates@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jeffrey Lien <Jeff.Lien@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 10:56:44AM -0700, Keith Busch wrote:
> On Tue, Oct 20, 2020 at 07:50:17PM +0200, Daniel Wagner wrote:
> > On Tue, Oct 20, 2020 at 03:52:25PM +0000, Jeffrey Lien wrote:
> > > I'd like to request that the nvme cli version be updated to 1.13 and
> > > then tagged.   It's been 4 months since it was last changed and
> > > tagged.
> > 
> > FWIW, I would also appreciate to have a fresh release of nvme-cli.
> 
> Sure thing, I'll just run it through some sanity tests this afternoon
> and set a new tag this evening if everything checks out.

Looks okay on my end, so v1.13 tagged and pushed. I didn't pull any of
the pending requests like I usually do for this release as that
inevitably leads to breakage right before a release. I'll start pulling
new stuff in now that this is hopefully a good stable point with ZNS
support and all the other recent goodies.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
