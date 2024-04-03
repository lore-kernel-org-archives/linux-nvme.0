Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0My7dzWEO+poPI2BYec1IH3TyCjpiNaUzdlILeEaZSk=; b=t3L0yW3Fw/zNa2Rm40CL/E3bCj
	Cx2Cpq6wNelnYecawMJgTxqSxypqpKfozvvM5kLw9TtQGYKV4dFUUBWJijf59LrdCU/bwJ2RBMY1X
	uDiTsmloj01+dPFELjO+0hgkHyI2OLNHCUZUdJ9gzNMY3EFP+VXCM10C5T/t1EjKRUjRj75fFWNgH
	GJg4mTzY1tgTjDD5DbjyRdbLLqPlA62q2BOWu9BcGnIRXOx0hesje9ug+kn3XxJ52cSzPZrINheo8
	pfZzjKCMQK1lB2Rpte7iw0sdSF6OBfSWrytFo0yKCf5U68JWU7/IA2TaF13NvKIRHUumnTBxYQW/H
	DXA3h5fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrqyq-0000000DjPN-113d;
	Wed, 03 Apr 2024 03:08:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrqyl-0000000DjOZ-2dCi
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:08:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D82A960DBF;
	Wed,  3 Apr 2024 03:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8FC433C7;
	Wed,  3 Apr 2024 03:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712113678;
	bh=6KCuRKqfBSyUGD9wEHT51sa9m5PJxRwSYfOSb1tiW3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb0X0Vj+U+f8ypJ33tvkOQomGTgWl9750eufi9XP6zXX6ANDmep652ynV7zUOvqzX
	 5Dsvz3MDFO1PGF1BC+IjpR7DYg5KS14JfpY4K0UIpI793TjOnDCndRnxqgf+rfl4Pa
	 wW3fjxu/mbwis+LqboxFJ1Q8fYaieQMX/dOeY+g89YAiBweyS5/oSue7Ik/YHEaQHw
	 PJih4yS3uTLcLTaoHmgfKoP8vcFh02iEAasgWuz10O1xxDaGpR9uGVyWsklAsZh5c/
	 Buc+py1iOZo0TifIBi67c19X7/OIpH2xZCrcK79mOros6gZyWGfETtYbjZq32L5iFy
	 IDelnkdpztiAQ==
Date: Tue, 2 Apr 2024 21:07:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, Gregory Joyce <gjoyce@ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Message-ID: <ZgzIC-9buT_UKaeW@kbusch-mbp.dhcp.thefacebook.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
 <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_200759_742462_782CEAC1 
X-CRM114-Status: GOOD (  13.78  )
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

On Tue, Apr 02, 2024 at 10:07:25PM +0000, Kamaljit Singh wrote:
> 
> Hi Daniel,
> Your question about the nvme-cli version makes me wonder if there is a
> version compatibility matrix (nvme-cli vs kernel) somewhere you could
> point me to? I didn't see such info in the nvme-cli release notes.

I don't believe there's ever been an intentional incompatibility for
nvme-cli vs. kernel versions. Most of the incompatibility problems come
from sysfs dependencies, but those should not be necessary for the core
passthrough commands on any version pairing.

And yeah, there should be sane fallbacks for older kernels in case a new
feature introduces a regression, but it's not always perfect. We try to
fix them as we learn about them, so bug reports on the github are useful
for tracking that.

> For example, I've seen issues with newer than nvme-cli v1.16 on Ubuntu
> 22.04 (stock & newer kernels). From a compatibility perspective I do
> wonder whether circumventing a distro's package manager and directly
> installing newer nvme-cli versions might be a bad idea. This could
> possibly become dire if there were intentional version dependencies
> across the stack.

The struggle is real, isn't it? New protocol features are added upstream
faster than distro package updates provide their users. On the other
hand, distros may be cautious to potential instability.

