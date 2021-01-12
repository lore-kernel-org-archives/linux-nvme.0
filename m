Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFEC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:33:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDC022D58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDC022D58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eTm2Cxq9O+zmOoTSuOEmRL5DqgQJ/vl6xYF4+hsuMBU=; b=cly8DLynAxVvg6AQhLXP5ETPm
	jWNJrLTt4beKsCMgKNb+KHaFSWpXk2sSj7BybRCXo2eipHAYri2loWF2pq3zvszXT2uV9qoM2HAPk
	cfyO5jbsxJmD49Rd5TyTN8ImctiLRZPzSUuOBlzjGX5f088cI4EI3+C+MZd4p1k8wxwMJDsr8ikPI
	OvLWU6f8nu4cAqyIRrABZXev3cJKP39xsBnwJlBYpAdyvuZSDWEqvePMIPUG6SrrQ6ZGx8T8CxP6W
	CEAnnqLnwASU7GJG+r7kYu9THkvnhIn58nl2EzuR3mTBejfmlqipxSOFSvljKsXxukatsyMP9Z1r8
	+5nYClVPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzF6w-0005RM-Sk; Tue, 12 Jan 2021 08:33:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzF6t-0005PS-In
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:33:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 84C3B67373; Tue, 12 Jan 2021 09:33:00 +0100 (CET)
Date: Tue, 12 Jan 2021 09:33:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michal Krakowiak <michal.krakowiak@linux.intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210112083300.GA25601@lst.de>
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
 <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4g3LKRmUOj1QHmkQ5rZ4BfH6TQaK6jKhXfb2DoBW-MoUQ@mail.gmail.com>
 <20210111175018.GD1458209@dhcp-10-100-145-180.wdc.com>
 <20210111201552.GA90320@michal-desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111201552.GA90320@michal-desk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_033303_771899_34BF3060 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 11, 2021 at 09:15:52PM +0100, Michal Krakowiak wrote:
> Like Dan, I really appreciate having the trace parsed in the kernel. I 
> understand the concerns. What about having both: detailed parsing and raw 
> bytes? It does not seem to me like a big deal to append a field with the 
> raw data even if detailed parsing is implemented. Let the parsing extends 
> the raw data instead of replacing them. This will result in the detailed 
> human-friendly output (which is nice to have) while not losing data in the 
> future (in the case that a new unsupported by parser field appears).

That is how the kernel trace events work, including for the block layer.
blktrace is a separate piece of software that attaches to the raw
tracepoints and adds its own handling, so I don't think it is the right
comparism here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
