Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4590BC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lASeQIjEdjHlR2ZzWZPvCQTIa/JTjUqXTPhq+3+cn0Y=; b=V08en7VsunCWRiRtdk+Ej/mtYx
	ReiZsreed1sDc/tsVR58shzlrM1jnnOARLEQi8ScurAbAnGcP1nJ3mBoE7cH8MxOjHR+kbhTQF45c
	CctwMCD5adTz4Hz1urQFahNYPsH8tAb0f0y8fgw9tMoCF6Wmw3rV8zsfr7+NyTrL95DE9Ftjuj53R
	m0g4Un8hAbfb1KrYzK62JDJbDmfNl01BVMecHaIDdQRZ6RbEX+U3I+bEj/3M56BwOZiAS8lBnYiiV
	5O19w4mpmJUxzz3w66hDfLJaRsdapGkUhTer8gngZJ0sw9h/oaECcNIx+ZJwiE72AG/5TA84Z0P0v
	aKUxJ9ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbpH-00FuSU-0u;
	Fri, 05 Jan 2024 04:28:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbpE-00FuRY-39
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 04:28:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40B0B68B05; Fri,  5 Jan 2024 05:28:42 +0100 (CET)
Date: Fri, 5 Jan 2024 05:28:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jra@samba.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <helgaas@kernel.org>,
	Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <20240105042842.GB23630@lst.de>
References: <20231227203337.GA1509884@bhelgaas> <1f55f4a5-24d4-437d-b2d7-5caecce3959f@grimberg.me> <ZZSYTUuQAZtUBMT8@jeremy-HP-Z840-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZSYTUuQAZtUBMT8@jeremy-HP-Z840-Workstation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_202853_181663_BA4DCB35 
X-CRM114-Status: GOOD (  10.50  )
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

On Tue, Jan 02, 2024 at 03:12:13PM -0800, Jeremy Allison wrote:
> It's not exactly asynchronous when paired with .shutdown_wait().
> That's why I used the phrase "two-pass" instead of asynchronous.

Yes, that's actually a much more descriptive term.


