Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF1CD5BD1
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLihbXa2a8fNDEP2OqjZaOtL61+yK1pr+dLDttThCdg=; b=W6HUuRzyFvBdsB7G3BfRs3QPwk
	oiD2Z5SwhrynjhTlB3B7yHsdzGtPyyNJ6NzAY7mF43QirmMcmupnvVMQwRmUTCM8lghhxxYdvz2Et
	JCVdHz0Yrnt+eB4IlYLC7zS9c5wDchoySp5JswQt/ZturPv6au4iZ755BWb1yaq97mXJu+WEfkdE1
	tXgKr9PoDR3zfR+KxQPYCMg5FSdFrhNV5rsWHuCdVTtVrZ7hWrUnjtlD3Txl60EJ9Td2dLHHeRkb5
	KjjJSV2Iub/E6yUaKeZU8bmK7D761zesNIeWD/fUtTok9j8O09JDZlxMv4UZOrbmbW9JAj8FRThhV
	GSPqdb5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUTDh-0000000DbnQ-2lFs;
	Tue, 02 Jun 2026 17:48:05 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUTDe-0000000Dbmg-40PX
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 17:48:04 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFA20DACCF;
	Tue,  2 Jun 2026 19:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1780421984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kLihbXa2a8fNDEP2OqjZaOtL61+yK1pr+dLDttThCdg=;
	b=MkBfHGYpD1UT5NzMccecW8oUMloL1heogWCIYgAIqUhKhRyHqX7tH/7+4/ML0iLsvg5kRo
	e90vMhdOB663p910FBv2QqRcW0sLuncJ7gLVhnH9qz6ALZ4ACBPaNkgXySGE91kV80LJ4Z
	+I9KkM3KmQazsHrPTNKLxSmUB4IWvDcNYPqjKZkbHjc9hm8md4R2BoaAaDn4FHuGF6DeU9
	wkO5IwsY8zwYu5UCVCwb/igH7JDiAmFThdtPoVejlfki/4SyF+EH4AV21DJbIG/Eey0pCN
	XfTPK/LWZQRawICfKZWgHEzfP7/imBF23oKbBNyPkf9DKZAmUBpdu1AS5pvAPw==
Date: Tue, 2 Jun 2026 19:39:29 +0200
From: Daniel Wagner <wagi@monom.org>
To: Keith Busch <kbusch@kernel.org>
Cc: stuart hayes <stuart.w.hayes@gmail.com>, 
	linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>, stuart.hayes@dell.com
Subject: Re: [PATCH] nbft: use the correct interfaces for NBFT connections
Message-ID: <9b1cefd7-5998-427f-a570-cb34f2267364@nitrogen.local>
References: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
 <236bf316-edf2-4273-9dea-8b82235b9d22@gmail.com>
 <ah7JWB1_K_-FBP7O@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7JWB1_K_-FBP7O@kbusch-mbp>
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_104803_264773_B5854B15 
X-CRM114-Status: GOOD (  11.11  )
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

On Tue, Jun 02, 2026 at 01:15:20PM +0100, Keith Busch wrote:
> > Should I submit this as a PR, rather than sending the patch to this list?
> 
> Maybe the PR is a quicker route. The mailing list historically picked up
> these things too, but you normally need to alter the subject to
> [PATCH nvme-cli] or something like that so it stands out separately from
> the usual kernel patches.

Sorry, didn't see it because focusing a bit much on getting nvme-cli 3.x
out the door and not scanning the mailing list closely. But this is only
temporary, promised.

