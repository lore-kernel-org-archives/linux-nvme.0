Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A72C55179
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916D82242F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 17:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBr8g9eG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DVzkzBJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D82242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DcTT5un84A5radiQoelPOgHRPyaSJptA42W0WaYWPEQ=; b=vBr8g9eGZsoCIagiu3NJPsH6U
	6wnGr3N+d52nyH2qfkccdFoyiYHAmXEo3GMI4iEiEUfgQ2pGGm+3zHFQhQ5JhJyUD552IoYKR+thm
	J1s+LLSShyu/49+g+Z6zVGl3qGjt0hn0r+2Z0P9loKlm78qni0f8pb1IeqrjCZpsHS0TCqX+9DR1o
	QLElHD1PwLyB97dYzazRiyaCxc1LVFoN1bmyAPBVZIEPeZXyK/eDXnCbgI2Vrhq1muSqOPexNGBJ0
	YOWbroqzCG64Jr/fJBowPQiaeoHMwyyYsiJWl7eb422Dzxq/SxpLsvaTA6W20I+xqCyE/VOItMsoV
	OHlpj+vbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVIE3-0007Iq-TH; Wed, 21 Oct 2020 17:48:39 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVIE1-0007I6-5a
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 17:48:38 +0000
Received: by mail-ed1-x541.google.com with SMTP id bc23so819725edb.5
 for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2020 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
 b=DVzkzBJthtEEE9BytDByy1Zyi6AvIrMMfqilJKnpXorOKZpcoMkmRc0+51O1rnlt68
 bMY0od0cPkgr22Fq/K+EKbRk9QUUZlKvr9mGhIHdkRS+RFdmguKEoaDMpwVT2MTekysU
 aICew+9IVF+RRyoiu/PaGJVFHpxpM2ZfnviDOpSraD9hqMuMque7/usM9pzF/eaK9iyi
 qZF3JdUTjmf2nLs5oVUYf43A1aDD3wYoYI9oxDRZY55ia14p0XqJNtzi/CDl0A92VIsH
 Ytn7i5HZw9HsfFtKjUgs2Sf+IlYn4ti3aGTMDIrNugvXoKAtZI0M50rVaCu67NNkO/yB
 jfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
 b=hzYIgqWeUP0ejF+Jo014G1yvWHavP3yJ1L97rf2koxtDC+yfjKwgdKm17RcjTvx0V7
 qEkOAcDmqHANxGn6/EXzT7HF6FfmRuSXclJypyMQ01wiM2PZ3VdthhBXI+SSmr+Fgfz6
 B+50+XBDWWyyQ/cKdwIkhR6CHHabcgVnnPSjyHJxgMmHDGBw86AH2ftmOli1fOh4mQQZ
 c/RKiHHCD0ZomdJqZxdcFZCMLmAj83oeWLwDAOiKnkuR4/VLb+yUAWAUX0GmxdaEMbVq
 O1B+fQbYbBhkdzkcPXlUNpVQzIc+qXC1qaRDnmaxTs2Bilsl6BNROwOdxaG04MsGz1AU
 NRog==
X-Gm-Message-State: AOAM532w4unL2xyXaHID1CgjvOM+o3VnMNvWDUr7UFXVLPBprnnsX16K
 n3R4vneNXJv9xm3LweSUiGnJc0md1AOxipYMHy6APQ==
X-Google-Smtp-Source: ABdhPJyjfO8m3iOuqLFtlf+FomXd1BC4F7cQcApVrqZXlZQ1jUukEoyZcjOKoq++KT+r97hpdUtXqWK1yOAZ0wQ8O8o=
X-Received: by 2002:a05:6402:31b3:: with SMTP id
 dj19mr4292662edb.210.1603302515911; 
 Wed, 21 Oct 2020 10:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
 <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 10:48:24 -0700
Message-ID: <CAPcyv4gOGi392Q3knF=cAuvKONnmp2AoKX82VQEQJU0c7o7AKA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_134837_344298_7BC40370 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Steve Moyer \(smoyer\)" <smoyer@micron.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "John Groves \(jgroves\)" <jgroves@micron.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Pierre Labat \(plabat\)" <plabat@micron.com>,
 "Greg Becker \(gbecker\)" <gbecker@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 21, 2020 at 10:11 AM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Tuesday, October 20, 2020 3:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >     What does Linux get from merging mpool?
> >
>
> What Linux gets from merging mpool is a generic object store target with some
> unique and beneficial features:

I'll try to make the point a different way. Mpool points out places
where the existing apis fail to scale. Rather than attempt to fix that
problem it proposes to replace the old apis. However, the old apis are
still there. So now upstream has 2 maintenance burdens when it could
have just had one. So when I ask "what does Linux get" it is in
reference to the fact that Linux gets a compounded maintenance problem
and whether the benefits of mpool outweigh that burden. Historically
Linux has been able to evolve to meet the scaling requirements of new
applications, so I am asking whether you have tried to solve the
application problem by evolving rather than replacing existing
infrastructure? The justification to replace rather than evolve is
high because that's how core Linux stays relevant.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
