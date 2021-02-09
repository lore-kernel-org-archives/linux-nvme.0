Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2227C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 03:28:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490A1601FD
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 03:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490A1601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FnNwrJ6r43t1NiUSUdqF/UCqiNAbd0KD8F2MMVGeEJg=; b=sRCBHmiy1IAG0qo+uVylLbdhK
	v9bUJ70o8z67mopF20eR3gsYzTDCKSsDiIWNoLw3YFDN3bsp8n5M84tTlCtdwezEF7S4IO6MwK0P+
	N4rAwuh1telFdW2JYH81gW6Duy+Hw9YBzguDL+RgOLiqRub5hlo32Lztebj97CT28gp0QNS2n3XCE
	J/Kotv2E6ercBrYPOzeKT7zGG3n2ooDZHvQWsDzSkElsHPNJqYMeon+YtCajxSN80qvSpnxGATRv7
	rRhR8M7yRcyK7HXlGy0JZCbLDP2jTHn09LW2M7vPW7qfBr3rFgHtEUlkE/81S77lIJ/nSph02b5zy
	0/0j5NykA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Jhk-0000xy-AM; Tue, 09 Feb 2021 03:28:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Jhh-0000xR-Ox
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 03:28:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBB264EB6;
 Tue,  9 Feb 2021 03:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612841320;
 bh=FwRbGDEs9rOm2PZipunUc9/GsavFfsjsG1xWvrYRX7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q3S9ECGdJYRF5CXffMi7y8AnFtOBPBfTXM4NX7I239WYQDsXqiM3I1CJECuI2aSjk
 CQdyLrQz3Qqz3FO3ljvSYYMlJwRQ2h0umyRKoT6okOuXcarhMHFFm5fyAQ3B4w+uXe
 jRoGZk2CByt7B59CWZEQm8zep5YFKQuEhZRRRMXdXscXh8v04T+//NGpD7HyQoKl8+
 wCeoT90Iodz7CYh1bLZFnC8VzHepjiu6ZtPPq5JnpKcLhV3jyu2vt4rR+44U+k5gCP
 MskMpPPujeH4WYzUtbVQdE3vlctyCWuXdWeWFpVILjM0v5NOERbJl867k1WXYX64ND
 NnCo0bQmiS5MQ==
Date: Mon, 8 Feb 2021 20:28:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
Message-ID: <20210209032837.GA99682@C02WT3WMHTD6>
References: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <4608296a-6c45-a252-8b49-88cf25cd7365@grimberg.me>
 <SJ0PR19MB454412891E589E03EF8DB948F28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <c02ae0ac-ce0b-7081-9759-8c3751510ca7@grimberg.me>
 <20210208190458.GB17042@redsun51.ssa.fujisawa.hgst.com>
 <cbf91356-e2b4-692b-38d8-22ec00359b8e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cbf91356-e2b4-692b-38d8-22ec00359b8e@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_222841_926794_49EEE8AF 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 08, 2021 at 03:01:28PM -0800, Sagi Grimberg wrote:
> 
> > > > Hi Sagi,
> > > > 
> > > > Yes. The Discovery Controller currently allows it. The problem, however,
> > > > is that the DC seems to be expecting these values to be non-zero.
> > > > 
> > > > I tried setting IOCQES=0 and IOSQES=0, which the DC allows (i.e. Prop
> > > > Set return status=0). However, when I follow this by a "Property Get -
> > > > Controller Status", the Status now shows "Controller Fatal Status (CFS)"
> > > > (see Base specs - Figure 79).
> > > 
> > > Yes, the oversight extends to the target that expects it (shared code
> > > with I/O controllers).
> > > 
> > > Does this fix your issue?
> > 
> > Seems like the Identify Controller SQES and CQES fields ought to be
> > updated too, but the spec isn't clear on this. Feels like ECN
> > material...
> 
> Yes, we should start with this patch though right?

Yep, your patch looks good.

I was just thinking a generic implementation could align the CC settings with
the ID_CTRL values rather than checking for a discovery controller, but I
noticed the spec didn't provide us that opportunity. That was actually a
misguided thought anyway since we don't even have ID_CTRL data on the initial
CC setting! :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
