Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7eNp1gEw2hpWuUWoAScdJr9txq2r0vcRb7Wbfu0vys=; b=c4CWE+WNUYR+Gram/ZJGJocMDx
	3v6tcpmZgo+ebBmIaNudqQPdB4+utL76wij+DX62a2RKke5YKBySLvk/kSVk4CLYJS2mLustcGFUN
	gE3ot7P0CTTGBlV3TwEodk+GwogyuWvjsRtaBPzPpK5LJRhve9FDvPGuS015NTlXUeRR9Ni1fcZoe
	+vg9rJKAYTSc/ISZ5RDQCOkLd0C1R8VDxqMbfHd65D6OR0dpUlfOzmW4MtTlnY/dl9laa6ZOMzsnB
	adrxX6vo0L+rhk07G6CDo2WbFm3JBm6aNJCjYrxlWTRqk8HCZzezO0d+HCoReyRXzvDOBRKUUWaY1
	uDww0amw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naFQo-005N0w-PO; Fri, 01 Apr 2022 11:27:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naFQl-005N0F-0y
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 11:27:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A682E67373; Fri,  1 Apr 2022 13:26:49 +0200 (CEST)
Date: Fri, 1 Apr 2022 13:26:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Message-ID: <20220401112649.GA14810@lst.de>
References: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_042703_257890_2D3D6DF0 
X-CRM114-Status: GOOD (  14.84  )
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

On Fri, Apr 01, 2022 at 09:55:14AM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. Mario, could you maybe take a look at this? Or is that something
> for the NVM or ACPI people? Or was this discussed somewhere else
> already? Or even fixed?

I've not seenthe report.  Looks like the BIOS sets the StorageD3 flag
in the ACPI tables in this system but doesn't actually want it,
which is really strange.  We could add some kind of quirk based on
DMI matching, but this all seems weird.

