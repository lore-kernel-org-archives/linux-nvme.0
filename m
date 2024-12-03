Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29783E74AC9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHZEHmQZ0E/aqkyDQYEiwHWdkZ//1hN2tUpONMLCRaU=; b=Z5N95XpZQUgVtXYd3lx4XFDk4k
	jr+hWTAZSJBXFbuCL+vDvdr/5YnhbF+6YmxVQwoh2+aC+eqGKry16deCdFzj+Xsma1PMXdAvrIF4P
	HXE1m0I0N7qTN6G9m0HmY9W3eOZzCHPzz6V2CzDFylWB8vmAx61dysAqGnoPcwJk0PpNdZAbI4xcF
	QdDM7RSx55XbNTKYECLyO3iFTIYmm43yOLP4oJJqRBowUGi12cUtC+JbcO3L5xUyk/wBYO3uN13jF
	WceTlE3sNba34czz1vRcYe1mO3xLbOm2t3oj74iE051QgkxozdSZfOP0VVuw87giVxaqObUEplFOf
	FG2uD3AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIYNB-0000000ASAO-0DaQ;
	Tue, 03 Dec 2024 19:15:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIYN8-0000000AS9w-32pT
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 19:15:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 19AA2A40C0C;
	Tue,  3 Dec 2024 19:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2D8C4CECF;
	Tue,  3 Dec 2024 19:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733253345;
	bh=ZHZEHmQZ0E/aqkyDQYEiwHWdkZ//1hN2tUpONMLCRaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUd6+xwdvSvJ43mM/Yqh6lK7voEU3j7xAwFVPRjeAse9RiX2NsJW9Fyt+FUsTMOEH
	 Da+3r/ecGRduVVr1zdB9TaDfvA/1/HyLQLEexyB9if62vocRb0/nTqZKDI/dkxvzuk
	 TYcYuHhCgtSfMogMMX1w2z/5h8fwbG0qeKr7seyb4xSF22DekjdWfnofh11g9dJKpy
	 t1Bl09lm05c9gpma2u3lYvcZsyaCJraFoyGBoG0g3JcjMLajp1E+Xv6G14V+ueke3e
	 nGd46Mpe9GYpTudfdsveRnE+Ie4dPRGUDlsfwFVH+26fRulOtLsxkBXY+lMPvxBWwJ
	 s6G4mwZLzqDng==
Date: Tue, 3 Dec 2024 11:15:43 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
Message-ID: <Z09Y30pUtAg0xwoR@kbusch-mbp>
References: <20241129140608.115282-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129140608.115282-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_111547_441408_D0FCF51B 
X-CRM114-Status: GOOD (  13.39  )
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

On Fri, Nov 29, 2024 at 03:06:08PM +0100, Hannes Reinecke wrote:
> When a namespace gets unmapped on the target during scanning
> nvme_identify_ns_descs() returns with a non-retryable error.
> With the currrent code we will ignore that error on the grounds
> that we failed to get information, and hence cannot make any
> decisions whether to keep or remove that namespace.
> But a non-retryable error implies that the namespace is _not_
> present as we cannot retry that command and will never get
> information about that namespace.
> And we need to remove the namespace during scanning, as otherwise
> the AEN informing us about a namespace change will find the NSID
> present, but nvme_validate_ns() will fail, and the namespace
> will never be updated with the correct information.

The scanning only checks namespaces returned in the "active" namespace
list. Every namespace not in the active list gets removed already. Why
is this unmapped namespace appearing on the active list?

