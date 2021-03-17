Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0427C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:18:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C45864F26
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C45864F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qHNTY8gx/Ek/U2jCIF9cvj0lJpkcJyOxViCsQm5/Rd8=; b=Z/NPaXaaB0zaW2yVjFESTJCBY
	wil4i/vf2ylB5c+LuAIQsjSbJE6+GLoN3r56sFCigcf83FEVXW3hDGlX12fLn1OcXvdF8JxlEakxf
	jL8p428b39IoyiOBi6e+VgeUO9nYCY9SU4jUpr8oDazFmhPVoDeJGz6BXNAHkiO+VWtxWxBX9gMDg
	5IHOWJP/IVFZs9GJTBEkyTMOYoQ6WV9UYD4ph0bv83rvTByoxFz5LRSVESN2imnVVXkO11PtTzsTi
	Bc9/wwrAc6xZ6tmrTS16dC1wOtl0oqPO5g2KAGmkFLXLHV9cVpNxMacO77MU88rNIjsPh8rBi01hV
	qzwFjlF3Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMWza-003En3-NY; Wed, 17 Mar 2021 14:17:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMWzN-003El0-GK
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 14:17:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 924C764F26;
 Wed, 17 Mar 2021 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615990652;
 bh=5rxJMptHstMrIpXi8pkDZiHwDhBN/cQxg6prU85MNc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d8MQQLruQzpH2Wx1Fl22m1PfTVtm/UHF1CmcL2kn9FI04mo0mGNYzVH70mIJl1/3S
 5mvEP5/fHkS4zo5t4pXxUlsWqMF3qS93bLT1jCRpq/vJ4n9JbYfIlsBW/Fmxg9z4oR
 3pPHE5wuhgyzsvYKlQSXoY1Fa7StlFYL49KumOfBklQoAqkVKNUmml1/QabY7xIxFs
 cXk87Fhx9vlJWTToUt3L+ZvFxNc3WmtvAkt7co6eCXuoq08T4d41cOf/0jEW1sWeIh
 MKCewQ5gX7lIk3frxAENg9mhzgonpd2qK+yZuOisc4UwY0yRH1nBPYxs24cpRZ29AZ
 0shKMT9BuT2tA==
Date: Wed, 17 Mar 2021 23:17:28 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Selvakumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v3 2/3] nvme: keep nvme_command instead of pointer to
 it
Message-ID: <20210317141728.GC26641@redsun51.ssa.fujisawa.hgst.com>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6@epcas5p4.samsung.com>
 <20210316140126.24900-3-joshi.k@samsung.com>
 <20210316171628.GA4161119@dhcp-10-100-145-180.wdc.com>
 <CA+1E3r+vddNqqPh5=+U0v_mLA4=gUdJVhtv3PJzwXXtrfr2xCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3r+vddNqqPh5=+U0v_mLA4=gUdJVhtv3PJzwXXtrfr2xCA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_141734_354265_DC257F0D 
X-CRM114-Status: GOOD (  18.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 17, 2021 at 03:08:09PM +0530, Kanchan Joshi wrote:
> On Tue, Mar 16, 2021 at 10:53 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, Mar 16, 2021 at 07:31:25PM +0530, Kanchan Joshi wrote:
> > > nvme_req structure originally contained a pointer to nvme_command.
> > > Change nvme_req structure to keep the command itself.
> > > This helps in avoiding hot-path memory-allocation for async-passthrough.
> >
> > I have a slightly different take on how to handle pre-allocated
> > passthrough commands. Every transport except PCI already preallocates a
> > 'struct nvme_command' within the pdu, so allocating another one looks
> > redundant. Also, it does consume quite a bit of memory for something
> > that is used only for the passthrough case.
> >
> > I think we can solve both concerns by always using the PDU nvme_command
> > rather than have the transport drivers provide it. I just sent the patch
> > here if you can take a look. It tested fine on PCI and loop (haven't
> > tested any other transports).
> >
> >  http://lists.infradead.org/pipermail/linux-nvme/2021-March/023711.html
> 
> Sounds fine, thanks for the patch, looking at it.
> Which kernel you used for these. 'Patch 2' doesn't  apply cleanly.

I used nvme-5.13 as my starting point.

 http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.13

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
