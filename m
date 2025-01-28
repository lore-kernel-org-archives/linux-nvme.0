Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC7CC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rpSdR0uBhRphI/wuWnMmY4Un2x5yTM9tPeGLls7JB94=; b=RNTu/LIqVGceaSW6/6GTmBqddt
	ot1cuyiPLYJUlaceKefcwQrJBKk8J8z8FruTNTih58nKImG37BPjFpHR6hbi12kfH+X1ReDd2Vrsv
	qx76XKpMozxCz53PPWFKGFJTJef9FIuUKE2IjuYCqZvTIbKdFWeKr7UrohTARSaDj5/oWJOnUIGEH
	S1PUBfVrh0RQLeYoHYC4zX+7nDa0MgHO18c5ZftRq6fpvQFeeKuzYwGflsEd3GdSqsT3WTRdkp4Kz
	REETlWU1TVqhy7CRNsEBrzeLnmHAYwTmM7uUvmfYfwFWuDNx87sANbyIe6vDiL9BR+3zRYOwBFMpG
	yupnYmqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcl5Z-00000004uOq-3Gjy;
	Tue, 28 Jan 2025 12:53:09 +0000
Received: from mx.treblig.org ([2a00:1098:5b::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcl5W-00000004uOR-3zPL
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 12:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=rpSdR0uBhRphI/wuWnMmY4Un2x5yTM9tPeGLls7JB94=; b=JTXSM7EUv6uE+eIc
	93cPRwTsic33zKymbWTDw11/Vo3/Io38hVLekPq3vafpO2bBteZG5KNWG8fu/azc9VGwxyoo8+jaY
	yBBDxaBqqJ0gMe8bmnRpxApmVWSJ/of0UVCPdwrRI9tnqlze8qx4kSkX/77x+GaYcqJwgcz4dM6En
	7ZzqmWpZpfuZUef62IqLLc56C3ikY4TwrVjCliw4OxqSuvq51lGonnulxQrgAK3aBk2Ig28TTPk3Q
	RdsJAPG3E3q+ieqr4qPDy1DFYCcleYo6h05tXmnuxodEd7z0W8qmov5i/LZaP0RYAnIc6VMMWnEhM
	cnzjn6t4Q7t2Zb/69Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcl5N-00CT31-0U;
	Tue, 28 Jan 2025 12:52:57 +0000
Date: Tue, 28 Jan 2025 12:52:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stefan <linux-kernel@simg.de>
Cc: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
	bugzilla-daemon@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
Message-ID: <Z5jTKTfKUeLm4uJT@gallifrey>
References: <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de>
 <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:50:39 up 265 days, 4 min,  1 user,  load average: 0.01, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_045307_071187_DB449F19 
X-CRM114-Status: GOOD (  20.00  )
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

* Stefan (linux-kernel@simg.de) wrote:
> Hi,
> 
> Am 28.01.25 um 08:41 schrieb Christoph Hellwig:
> > So basically you need a specific board and a specific CPU, and only
> > one M.2 SSD in the two slots to reproduce it?
> 
> more generally, it dependents on which PCIe devices are used. On my PC
> corruptions also disappear if I disable the ethernet controller in the BIOS.
> 
> Furthermore it depends on transaction sizes (that's why older kernels
> work), IOMMU, sometimes on volatile write cache and partially on SSD
> type (which may have something to do with the former things).

Is there any characterisation of the corrupted data; last time I looked at the
bz there wasn't.
I mean, is it reliably any of:
   a) What's the size of the corruption?
          block, cache line, word, bit???
   b) Position?
          e.g. last word in a block or something?
   c) Data?
          pile of zero's/ff's junk/etc?

   d) Is it a missed write, old data, or partially written block?

Dave

> > Puh.  I'm kinda lost on what we could do about this on the Linux
> > side.
> 
> Because it also depends on the CPU series, a firmware or hardware issue
> seems to be more likely than a Linux bug.
> 
> ATM ASRock is still trying to reproduce the issue. (I'm in contact with
> them to. But they have Chinese new year holidays in Taiwan this week.)
> 
> If they can't reproduce it, they have to provide an explanation why the
> issues are seen by so many users.
> 
> Regards Stefan
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

