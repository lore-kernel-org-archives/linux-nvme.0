Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF2C4363D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 06:35:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BF1206C3
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 06:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E77tEY7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BF1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UCzg9gC5cIo4nTGaEjSMKqolDsrqqX6zaT3n1sg31qY=; b=E77tEY7nrV88OeXsZLGt52Cwv
	0AQjK9Iq/RyoVNdnBjDYaEHbgJJbRJC6Twk9BL8Mf1OGf9IrTGxW+xyQzkTlaIu5a63EzszVTFYb1
	3HirQTnBr/ywjcnnxRrDzJXNmXxLea0mQ/ZTgulhVGnLhb/Is3NGSPkFBON5BunFQPEKFPaxUnIKg
	tGLReK+Hn8GeZNt7m5qdrhrfngWVEvNE9++qKSmjfkpmhTLP8YlOyT/hxvbiv8fuf/pVouISXx7ct
	fKo0a505URt/VPgJFzWz0VHkoTlphcImrN8CIqnunOEdK1v3/ZFsShXVJH7Yfpqb/PnOL9CFZq3ly
	yaa2FCRNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLhKY-0001J3-H8; Fri, 25 Sep 2020 06:35:42 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLhKU-0001HJ-Cc
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 06:35:39 +0000
Received: from mail-pg1-f200.google.com ([209.85.215.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1kLhKR-000123-Ie
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 06:35:35 +0000
Received: by mail-pg1-f200.google.com with SMTP id a129so1478043pgc.1
 for <linux-nvme@lists.infradead.org>; Thu, 24 Sep 2020 23:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Ln5tX4yeIXG1vWB0JQCDh49WVbM2bVqoaH/7mBdZWuQ=;
 b=RgoVRL+7KrGh6tRW9n8Gb5bTa846Ee5urWnjmebW7819UHo/dbIrZ7w9C4JqLEGrt6
 VGTPVAkXn+/xv5lqeJNj1CYhFR/yW7sNkN+V8+IUY3NLjOXtHNyqyFWzhDxMMnUZGPn5
 RM2my+L+NVKVEEE+vz9BMQ4TbeSztdJ9d5UvcGeU2fxkjl1rqRoNBuO1y/2f0K+S83vR
 mdzvxooy35fL1+v56NIMwaMWCMtr1Vpc9JQNPRac5Lbrxog/IqrXgndPgunYyBJ8VCwJ
 iRlfwaLnFXJ+zq7IZSXJV1gQl2dcM4+0TS5cUfefOEO6brjfr/wNXFMYxYqL5FoIva7H
 P7zg==
X-Gm-Message-State: AOAM533SuSyJlIKoTNmpHmjoQXKptdn6Pq8nCDAAQDedr3NB2NuSqrBs
 LomcgX0XX0cXtNQKI7ar+deYmC6WeJiCJDaHgoLrhsGDXRyyC05LmUKZwPUpihNOHar+/jH/++T
 FZar7Aa1ccp7NQ2/Vu6FS68ZM6tQT1ygSv037trgyOIPV
X-Received: by 2002:a17:90a:ead5:: with SMTP id
 ev21mr1194854pjb.188.1601015734204; 
 Thu, 24 Sep 2020 23:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8MuHBZgL02bSNP/wDMTZTXNVYn/hmwUmkftK3PiogMdGhitdngDJ/ZY9ist3OCUOawC5KxQ==
X-Received: by 2002:a17:90a:ead5:: with SMTP id
 ev21mr1194830pjb.188.1601015733835; 
 Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id s13sm1196585pgo.56.2020.09.24.23.35.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200924194437.GA85997@otc-nc-03>
Date: Fri, 25 Sep 2020 14:35:29 +0800
Message-Id: <085B7CD2-95BA-4540-8858-AB090463536A@canonical.com>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03> <20200924133938.6b93732f@x1.home>
 <20200924194437.GA85997@otc-nc-03>
To: "Raj, Ashok" <ashok.raj@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_023538_525225_5F3C4EB0 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Raj,

> On Sep 25, 2020, at 03:44, Raj, Ashok <ashok.raj@intel.com> wrote:
> 
> Hi Alex
> 
>>> Apparently it also requires to disable RR, and I'm not able to confirm if
>>> CML requires that as well. 
>>> 
>>> pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
>>> table, so i'm not sure why we need the other patch in bugzilla is required.
>> 
>> If we're talking about the Intel bug where PCH root ports implement
>> the ACS capability and control registers as dword rather than word
>> registers, then how is ACS getting enabled in order to generate an ACS
>> violation?  The standard ACS code would write to the control register
>> word at offset 6, which is still the read-only capability register on
>> those devices.  Thanks,
> 
> 
> Right... Maybe we need header log to figure out what exatly is happening. 
> 

Please let me know what logs you need.

As Bjorn mentioned earlier, there's currently no way to dump TLP header log?

Kai-Heng
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
