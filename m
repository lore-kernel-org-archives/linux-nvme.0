Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB82CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5taNWXALnIhFrg1FxOI9ZSC3o+HWpbH+VC8CyiW8B9o=; b=DX6xkgaAaYiCjOK5YGGxwuFt/U
	LQcuFgV3YrCnTh1GDo5H+UEx+T5vry+4GevHOZgVAjT6ROztvDUIsfHatdhYLaPiXfFXvi0S5qJrd
	58IaOZ+0LfREcVdAbtizBSe0Cjy63jCRs/1cDgKUEG4p3KO3CfWy6UN9yAm6sbg7gZ++KfkV+nxCR
	9Q+pm9Yg0wdImGfnH9p/n3dDQ8GiT2TrtRTQwT4faqNO2mOe3Qobo9RtmC538FRtajeuDS6QKqI5I
	6eL/J8lMwDaUyuZAew1joUH9ekAiHZFRk4JrvTAhCt2q/I3CTNW+uvtKENUjJa3DP7Fm55nKAVb93
	AZiPNWbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUO1p-0000000CxGg-22PL;
	Tue, 02 Jun 2026 12:15:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUO1n-0000000CxG6-0POE
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 12:15:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68AF0423DC;
	Tue,  2 Jun 2026 12:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627A31F0089A;
	Tue,  2 Jun 2026 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402526;
	bh=5taNWXALnIhFrg1FxOI9ZSC3o+HWpbH+VC8CyiW8B9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EMTmpWwLDH7nghFbMUhVn93T/BriWNp/N53UUG6qn3cvCQmZ1kgE1jYjJUNE+3kE7
	 qYBfbjvXpqhS1rizCPGkzt1FuQ+JRGO67nSGhmjrGwiV2rx3vedHP6J/X2I1ZiwUKL
	 +qcLmgwORb8xP9ESuVgHnyLQ0QwpJYsJu1ztFc1ScWVk+qTQjCBW+ZUv1U0eyt27jl
	 lJj83mMuIGQsn74DGXCWXVmrM5HSIBOBKmu+yyj/oDzsi0zY/a5GhM6fZnoV8k7dX8
	 DHrWW6vGPMMsqTyUoVYSerkjz/Eta0xQQ20YRJxFt62INlQmm9n+HivyUvGuKSDVxk
	 xPD7HLAPTl1tg==
Date: Tue, 2 Jun 2026 13:15:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>,
	stuart.hayes@dell.com
Subject: Re: [PATCH] nbft: use the correct interfaces for NBFT connections
Message-ID: <ah7JWB1_K_-FBP7O@kbusch-mbp>
References: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
 <236bf316-edf2-4273-9dea-8b82235b9d22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236bf316-edf2-4273-9dea-8b82235b9d22@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_051527_157213_2A25FB5D 
X-CRM114-Status: GOOD (  17.39  )
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

On Thu, May 28, 2026 at 04:45:10PM -0500, stuart hayes wrote:
> On 5/7/2026 3:23 PM, Stuart Hayes wrote:
> > The NBFT specifies which network interface should be used to connect to
> > each namespace (using the HFI descriptor), but that is currently ignored
> > when "nvme connect-all --nbft" is used. If there are namespaces on
> > different interfaces, some namespaces can fail to connect, unless the IP
> > tables were already set up to route these in the desired way when the
> > interface isn't specified.
> > 
> > Add a bit of logic to look at the HFI descriptors in the NBFT and find the
> > network interface to use when connecting each namespace.
> > 
> > Signed-off-by: Stuart Hayes<stuart.w.hayes@gmail.com>
> 
> Should I submit this as a PR, rather than sending the patch to this list?

Maybe the PR is a quicker route. The mailing list historically picked up
these things too, but you normally need to alter the subject to
[PATCH nvme-cli] or something like that so it stands out separately from
the usual kernel patches.

