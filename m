Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF2C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B7C2078E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yHxPQglZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbgCHJYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B7C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t48XF3JcT86/dnqPVzMSGrBVUw7zopfuGWTL+LgWVHg=; b=yHxPQglZ9CkqCMZRlf/xmh7/t
	dmETuxKiEBV5fRbTn4pov36guahFPRHDNbDrqFnX6CINwqu4FBYuAkI39bum6diUgL+vMeQ1r8j/0
	mIW1ShcDRMNFsJIDX7hCTevbeXvzOtiaXaSTnY8EhdzZDAAYbaLhAxkMHl+oZ/8GFxika7KyPuiNw
	4vPgDDSih30A5KYloLhKjhguyMzRuIlmQw5Fci5Ni8/pUMXJn04N1n5JianFBnS50t2axrC71ndWm
	oEfJ2DajznynjE4IyN++ClccEkRmqyzdjR4mTKEb3aNmEr9eIBwxpKQ7hgDaJa9LQIzQuFKuwekR+
	XG8mU5biA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5A2d-0007o9-IK; Mon, 10 Aug 2020 15:48:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5A2b-0007nZ-Lb
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 15:48:50 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 681F02078E;
 Mon, 10 Aug 2020 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597074528;
 bh=ccN/cgu9VhoFFlzBxPu3ffwwBGN5AaXRs0XpOK15t10=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LbgCHJYCm0up+jqu4HVvLPeg/sK2zbVVk2M6vmeCLTaxyvYbJThD9WXDS7fhrSkB3
 vHAGQe3Dm8PVhQHOtCE4QrKSJ9KkBudeML8KeXDMKGk9LLmjksndllA/PwWZqUcxT2
 aERU2Rl4WCl9FTwA50uB2UhuulJ0+NlAPGLE8A0o=
Date: Mon, 10 Aug 2020 08:48:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Engel, Amit" <Amit.Engel@dell.com>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_114849_820354_6E44FB7D 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: Christoph Hellwig <hch@infradead.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 03:13:16PM +0000, Engel, Amit wrote:
> We saw that in case of path error, nvme reservation cmds does not get error handling.
> This is true via the blk layer as well as nvme-cli.
> 
> We are working on implementing nvmeof stack and 
> this current behavior is blocking our host from running nvme reservation cmds during path error.

What's blocking you from retrying this command in your host software?

If we truly want to provide a way to hide intermittent errors on
passthrough commands via automatic retry, it may be a little longer
before such an interface hits a released kernel.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
