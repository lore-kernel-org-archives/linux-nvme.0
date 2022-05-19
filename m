Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJUn0156dNBA9QWjnnlZsg1+Sz3Q9AVMXuSbBo8TWP4=; b=guBZ1VhZRslPaOsi150bT+p6x7
	5I6wvXaOI0dMmPeXrMZqU3XlF1Cy7hdRWj3kz0IlVvb/oOW1kdz3U9N63q1UVePE41m6ksZEWUGkS
	1jE5bLnjmGxyktr7RcOWL25sA3sObPsBZqli08XcmnExaCgVM7/20v9FAYWMuyt2h88HKNJmgmBRR
	xYktQ2rbiJMmQyL2kpHSJUoJBM2/tDimLJglxdb4RPr5VI8/UrglS83nYgqik0G3Rmcyn+jCAvPDd
	h8xz3ud4J+dRU9FTtRjZ5YSuFBZe+tTpX7/gpu64ChbAlSPBb6PDmfQFIBUdOgaZkV4wHqUuI4rmB
	xgLnXHwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrl8G-008xD2-Vz; Thu, 19 May 2022 18:44:21 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrl8B-008xBJ-Fw
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 18:44:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 5CFBACE270A;
 Thu, 19 May 2022 18:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20673C34100;
 Thu, 19 May 2022 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1652985851;
 bh=LV7LTnAH/p1rCGESk6oys94gfkqXoBT21ZKPBvHkVag=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PJntBITtl+Ix70J0sB1XcPAphJMOsg4aFBWMHvc0SY2z73uU+bdYPDEbFBi+d1k76
 ysN5otvLvJDv0wXhWJUhkShJ6y0IswWrsq/4D0zNAN/gjfwPvXK6nuH5Fo5/HvjFsM
 DcteBtGl6sEhkNPBAN1XO2L3TUlpiYC03t69XjLY=
Date: Thu, 19 May 2022 11:44:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: kernel test robot <lkp@intel.com>, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-fbdev@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Linux Memory Management List
 <linux-mm@kvack.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
Message-Id: <20220519114410.638baa38ab2067884600cb72@linux-foundation.org>
In-Reply-To: <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_114415_765912_11BF771C 
X-CRM114-Status: GOOD (  16.32  )
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

On Wed, 18 May 2022 20:41:27 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 5/18/22 17:55, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3  Add linux-next specific files for 20220518
> > 
> > Error/Warning reports:
> > 
> > https://lore.kernel.org/linux-mm/202204291924.vTGZmerI-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205041248.WgCwPcEV-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205122113.uLKzd3SZ-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205172344.3GFeaum1-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com
> > 
> > Error/Warning: (recently discovered and may have been fixed)
> > 
> [ .. ]
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    unsigned char
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    void
> 
> This is getting tiresome. Every driver using outb() on m68k will
> experience that "problem". As far as I can see, it is caused by
> 
> #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
> 
> in arch/m68k/include/asm/raw_io.h. I have no idea what the
> "(void)" is for, but removing it "fixes" the problem.
> Either case, this is not a problem with the nct6775 driver,
> nor is it a new problem.

(cc Geert)

