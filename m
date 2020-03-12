Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF6C1975A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150E1206F1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H6WrDqMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150E1206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GADsIKMFQLvy8ukuBr0qhbtlBBnUsB7vIVjMPoImR98=; b=H6WrDqMWIhLlES
	gvXJwLQBm7f4B8fBBzFMa6zgor6S+i+febN40KA8K6ERIKKfwCV8rd6t4avHuXut86ygHmGEMi1o6
	ve3jEEOVVHvZLSQ+DsA5JFC2WhkV9hGR2iQ0OYr0abOFm6kjXPNq3MwCq3tw4OdZHXQtZh4Grjhgb
	r3ULn6fBX1Zece4dYXXIe4UHvM8AnVAZpWvGTH+WtYVLuBne4NfBNktrCn1AdHxd0/vW/fIlT1XbL
	Nja43ILicSwoFIGVu/BsV3c+7i3sO3DfCYWvNeTVmRLhjDuw/2NT/2AUTrISzSGVo9B0mDehDpotW
	JBcyRfHAIBDawm2LfIcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCQe1-0000l5-AH; Thu, 12 Mar 2020 16:25:13 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCQdy-0000ZF-9m
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 16:25:11 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 09:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="322522522"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga001.jf.intel.com with ESMTP; 12 Mar 2020 09:25:05 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jCQdv-0092ut-3b; Thu, 12 Mar 2020 18:25:07 +0200
Date: Thu, 12 Mar 2020 18:25:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l, 
 b}e24()
Message-ID: <20200312162507.GF1922688@smile.fi.intel.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_092510_370376_AD06B56E 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: linux-arch@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 12, 2020 at 08:18:07AM -0700, Bart Van Assche wrote:
> On 2020-03-12 04:39, Andy Shevchenko wrote:
> > There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> > implementation. Provide generic helpers once for all.
> 
> Hi Andy,
> 
> Thanks for having done this work. In case you would not yet have noticed
> the patch series that I posted some time ago but for which I did not
> have the time to continue working on it, please take a look at
> https://lore.kernel.org/lkml/20191028200700.213753-1-bvanassche@acm.org/.

Can you send a new version?

Also, consider to use byteshift to avoid this limitation:
"Only use get_unaligned_be24() if reading p - 1 is allowed."


-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
