Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C107C0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8mScd1D+wMKx+9Ennku1g730Ct4Z30SdztBFbVr5/M=; b=OOnWqkG50gdJWZas8OWjC/zGct
	uJ/Sa9r6fCRy4eNIYLt4+TSrjQg0hmiP9FNsTUWfDQ8mp00vY/WTFhv1Sz0W2WHXI4Q2zgbQ84qob
	xzo9TqXjAm2KVO8dqS4M5mjE8w8i93Bl6rgtCLfzZxqzKcLenHMR42i87YkVjZcSlLnvrEZft5RmY
	nOn03BJbIm7KMZEm/jRUOF33xb6cZs+oiUWE3K0Nlo7BnYILXeP09IUnkg0KC/7qTppXDani8hK5D
	cU1T97S4MI9WbChEEwkoxM35kHVJNr1hifLUSoB1uVlDiJqWIuMq49hK3AFA8EVAqftsgFnNDTNSw
	ApnBxcdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDIG-00000007eOj-2Qwk;
	Wed, 29 Jan 2025 19:00:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdDIE-00000007eNu-10EI
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 19:00:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 76E4BA402B7;
	Wed, 29 Jan 2025 18:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A204FC4CED1;
	Wed, 29 Jan 2025 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738177204;
	bh=DdYzmjeV/9icQoYXsznAF3pTwcZMKhok+njvTdwWX2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gn5gAmS+DPGbSEcDKuauxmPiSSlkZFZ4AAIU11tpuIIjEvmmr2LukkZMhADxAaF8E
	 6BCxVdzxIt7Vcu9UXCxCvAGh3sBY3CMh53qwvII0zAbzOb8aVeCeLwJwGfkOpcw/iV
	 /5OjRLGs5h7Yzq0L21i5CwCJ0o6YhwMrW206KcGOYLyBQqZFCsidWq1ixS5YisLvrN
	 MIUU2yNo7IDwbtMJ7g5o3j5MMYb14y7UA4nOp37B1Jz/Bj4z/f9UVRLVLZCkKpThZC
	 OYt7Rp4I/cROWJsd6/1x1E0uylnwiIgEiHxcvW5qCIbZgdoGplNLxm5/olPBmWG3Nf
	 dOtfgSUOumlLg==
Date: Wed, 29 Jan 2025 12:00:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: New warning `nvme nvme0: using unchecked data buffer`
Message-ID: <Z5p6sruLjO9VZ_mS@kbusch-mbp>
References: <20241118155738.2737423-1-kbusch@meta.com>
 <20241118155738.2737423-4-kbusch@meta.com>
 <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
 <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
 <3a851b3a-dfad-4796-94cb-42ced213e901@molgen.mpg.de>
 <Z03XGL6wh1xV2zx5@kbusch-mbp.dhcp.thefacebook.com>
 <333105a9-3480-4694-93d6-0e092dda3751@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <333105a9-3480-4694-93d6-0e092dda3751@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_110006_342389_09F2F1D1 
X-CRM114-Status: GOOD (  15.39  )
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

On Sun, Jan 26, 2025 at 09:37:09AM +0100, Paul Menzel wrote:
> Sorry for not proposing something. Linux 6.13 was released with the warning
> above. As nothing can be done about - it´s unlikely the vendor is going to
> enable it in the firmware on released devices - I propose to decrease the
> log level to info, and rephrase it:
> 
> nvme0: Using unchecked data buffer. The passthrough interface was used but
> the device can only use implicit transfer length. Improper use might be
> cause for memory corruption observations. If in doubt contact the hardware
> vendor.
> 
> It´s much longer, but helps the user to understand the situation much
> better.

That's quite verbose!

Let's take a step back a moment. This is a transfer mode the Linux nvme
driver has always supported. It was afterall the *only* way for the
first version of the protocol. I don't want to unnecessarily call
attention to hardware vendors who adhere to that version of the
spec; this is more of a notification to the people who think this was
worth making a CVE out of it.

So let's turn down the level from warn to info. Maybe remove the check
from the IO path and just print out device interesting capabilities
during initial enumeration:

  nvme0: SGL+ MetaSGL- Etc...

