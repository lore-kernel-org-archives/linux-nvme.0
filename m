Return-Path: <SRS0=3Z9O=BT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027FC433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2020 16:10:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CA42065D
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2020 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFa48Xob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl91ksXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CA42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/DDB5vml4k1HLMX63CaNkPMS/6h8iECd3woSIbImn3Y=; b=oFa48XobhtbEe00Tv5gFMb+fw
	Gmm4eHOPOwh8mmg3rxPhYVvijGs0MKpDzW2Vqr3bhSIkrmicB4qyFGHUEme/TKvIsad+4hrZ4cKVR
	zWBaMZ3Bts4CVZWZYQMtP8b3B3aE22sNw4j6rbfgeCKB4Fvezs+a8NPVLODb5JbAY1TIRxP/ybNMK
	OKeLMiYhhPwclrBOamVlsTuaZPBJnC/K9/EhlM/uRF82I8BBAPoD9HZkGFQUQ4aLXzbTAB0nMXUyn
	TgNXTBh/CmhNWnOrMS7wzFkVCAtwxwjeN7w1O+QTMYVfRD+d7Gw0KbTjV/I9DUw938b4LppSXV3+q
	U3RBE4upA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4ntv-0000en-Vk; Sun, 09 Aug 2020 16:10:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4nts-0000eG-P7
 for linux-nvme@lists.infradead.org; Sun, 09 Aug 2020 16:10:21 +0000
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5D67206C3;
 Sun,  9 Aug 2020 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596989419;
 bh=PaNMRqKlpjrq9bvFsjvOVi+nON5zPNh8boK2gtxxdDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gl91ksXAOqNjLinuNgwtzfljX9FGU1bAxq649AZQJkaG6l8Wq++66dS84RYyhUdpg
 UuHsQTFhjtrp8Ss2ei5/t6Vbx2sA2q3pkpHlvfHAn9SAwH7/TkMI+U2fEq+ulG4r8X
 21hK7X0MRKuNQIasMBqEnLFfWbPI9tRWYAk6NscU=
Date: Sun, 9 Aug 2020 10:10:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200809161016.GA63121@C02WT3WMHTD6>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200809_121020_977842_2C4C0798 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 05, 2020 at 07:14:22AM +0000, Engel, Amit wrote:
> What is the reason for setting REQ_FAILFAST_DRIVER flag in nvme_alloc_request ?
> The original intention was to mark only sync cmds as failfast ?

Special requests don't get generic error handling. The caller gets to decide
how to handle it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
