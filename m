Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C71CA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSot2kRSxSgvm9/FSjSEsFp/ryph15TSAsJSkcNEn1A=; b=fZPMDz+xdxlbk9NTAm8bEWFqc5
	ivDjzKBA33QQzw0VdemOexqnGuVDYX7C9v8p+7lQQ16iB0+Oq3OcQGTQFhx6CzOVQawmmRKc990zx
	czOU6iAASSNCdyMlI+Q1lqmFsaJ5mQ1+AHIaTbVH0CbBN1mvIz84a/xklZa7IB9/A+kZyh+xNs2+A
	OEjlCBBO5XyZdsNXRnRg3Jv6Tsg6ioqtWTdDS8H7PB8E4J2jxLev/Z2tvjhUVlgeFCu29CTOF+FQa
	BcXG+CN/ZWVDbQSGPHkpqC1QPvZgcxqy0z8xlBlG2BIi/QPQ6+i8cbF9Eo7Q8K+N5dp05Amq12P3a
	4NWPkbaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n7L-0000000BRtZ-3JA3;
	Mon, 22 Sep 2025 20:26:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n7I-0000000BRt9-3a5M
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 20:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83359405D7;
	Mon, 22 Sep 2025 20:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A5C4CEF0;
	Mon, 22 Sep 2025 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572792;
	bh=8oWJdKf/4213hglSrCtvGHw3q/14fgSfvO4+9cSDfzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY0Rf10LOyLy9fSJ6oXAM8+AYeRzhvYk3StGONj6sjTDBst8MQjcCJT704gzAb7U0
	 A0G/nHFM2xPa8Mmh+g+MSyYa73omhh5h8KWvN6VC6zZuCmKZ3rrAtRAEyzLLQjZokv
	 GoDAhJwKz50kBADQ+XH42fZEfrBvH+mZX70dpBmQgy/pwiP5ySgTlRxnZACe6khbwj
	 po8PM8/ZF3pPVg3YEPV4WhNbuAjzyVR+qdDkhvmhWxO3B1UbJXUVNpNCwESMfF//Gy
	 /SKNXklDqLhdtbxn/79xyg02tpQ1SoHqrkbvq1VA2Iq1ohh+gYNzl/lQ1hcC6NWYBE
	 rZ3p+un10Bk4g==
Date: Mon, 22 Sep 2025 14:26:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
Message-ID: <aNGw9mXBcx1-g0ee@kbusch-mbp>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_132632_910164_E7478D00 
X-CRM114-Status: UNSURE (   9.83  )
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

On Tue, Sep 02, 2025 at 01:52:11PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The NVMe Base Specification 2.1 states that:
> 
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
> 
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a non
> zero value to avoid continuous timeouts on the target.

Thanks, applied to nvme-6.18.

