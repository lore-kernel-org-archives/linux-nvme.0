Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC197C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 06:32:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D06F64E74
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 06:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D06F64E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PHfiS5twglbvjBO+/uELln1Smjp/uAFZIZILCD6XS20=; b=j1tBqZtquicnN6nY0v93uvo2U
	TwLJ/UnT2QvAKLQ9Tz8un6Y0zLm7tfTRlnGkLBuTvdQPfmi7xrWttaY709TEV0NUxkwMX1ideu3kE
	DMgwhD6Ef6l+nELPmfPs511KwlvNo2MmVziBdE1aegYDTWexpEX+KzwCbbTAIqGtyEU5AvZH4Ji2T
	IicfDoyxnG0k+Vv4Q2no07iaSIgrQgxs3CZt9NTN8ZMepsoRKkOyIXMFOTiqH6YDQjUUHL+0OX/Cd
	kZDz7uDJbCOd/oFDqwhvKOKffwd9I+lOHi2k4PLBDJMH4+AogkWlIPYGl7S3V6Hxd73G7K9WrGuuV
	mdZEIF+gA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI40v-00DK06-TJ; Fri, 05 Mar 2021 06:32:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI40t-00DJz0-KF
 for linux-nvme@desiato.infradead.org; Fri, 05 Mar 2021 06:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=tdFxh/IwKko7eX7MerJN2XbKYLdydpO1wGbVuyNdGhE=; b=fAUACFpTj8Hr1Wo/nG0F4XuHSD
 2+vduQEJY942YMgkKLrd4aUNSUHGjkh406JnJIeHoNuxyGxEKtokfjQbX27gou2sRxgV9UZDiJZVL
 wdb3HhwmrI1NQVGv4l9aQKZeR2U84B/JPOx2mipjVDR3FAWHf42BHF+znovlTUBEeA5hV7UzQc9H2
 asEPBvdtN21bps1fTfRvil9CsdRffFKYAsZIqrCrUGPfz+9KrZ11uhEAr4zKaWhy0s19ddxo3wu2W
 70kXVXYg3ztm58JTl5qBJ7bphw1q5bJtyT0pQPPi0LUK6v5p+vlVxVlmuVwSH9xmRCt9zZnP410lN
 RwSD+ooQ==;
Received: from mga07.intel.com ([134.134.136.100])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI40c-00ASZq-KS
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 06:32:31 +0000
IronPort-SDR: qxiOaixEXvHC2zFHrEv38UUGekQ4zrzhTzcX/fFl6dr7o3ajtlfu+opmqy4a7NxiqvlEmyOiqX
 xhcSnYBA39rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251623272"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="251623272"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 22:31:18 -0800
IronPort-SDR: laO2wS6zQdoZxcI1KvIlnFHd63esMY/7AIvcOri2E+aubwcnjMamRQ5nhs6Fzhn9R/snSZg9Rz
 /U1oe6BHRQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="368473558"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga003.jf.intel.com with ESMTP; 04 Mar 2021 22:31:18 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 22:31:16 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 08:31:14 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2106.013;
 Fri, 5 Mar 2021 08:31:14 +0200
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Arnd Bergmann <arnd@linaro.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>, "joakim.bech@linaro.org"
 <joakim.bech@linaro.org>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "ruchika.gupta@linaro.org"
 <ruchika.gupta@linaro.org>, "Huang, Yang" <yang.huang@intel.com>, "Zhu, Bing"
 <bing.zhu@intel.com>, "Matti.Moell@opensynergy.com"
 <Matti.Moell@opensynergy.com>, "hmo@opensynergy.com" <hmo@opensynergy.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>,
 Arnd Bergmann <arnd.bergmann@linaro.org>, "Usyskin, Alexander"
 <alexander.usyskin@intel.com>, Avri Altman <avri.altman@sandisk.com>
Subject: RE: [RFC PATCH 2/5] char: rpmb: provide a user space interface
Thread-Topic: [RFC PATCH 2/5] char: rpmb: provide a user space interface
Thread-Index: AQHXET971MxOa6n++U+sE8HjESAciKp07J+A
Date: Fri, 5 Mar 2021 06:31:14 +0000
Message-ID: <02dc8b75f0344c659e85ed4267d66102@intel.com>
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-3-alex.bennee@linaro.org>
 <ff78164cc13b4855911116c2d48929a2@intel.com> <87eegvgr0w.fsf@linaro.org>
 <590e0157d6c44d55aa166ccad6355db5@intel.com> <87wnumg5oe.fsf@linaro.org>
 <baa46857daba4bb685491ea9323fe45f@intel.com>
 <CAK8P3a0ATHxzS02_5kypbGwHYLaWZmEPG8xtZchWuuM-93o8CA@mail.gmail.com>
In-Reply-To: <CAK8P3a0ATHxzS02_5kypbGwHYLaWZmEPG8xtZchWuuM-93o8CA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_063226_127761_F2300B29 
X-CRM114-Status: GOOD (  37.18  )
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

> On Thu, Mar 4, 2021 at 8:54 PM Winkler, Tomas <tomas.winkler@intel.com>
> wrote:
> > > Winkler, Tomas <tomas.winkler@intel.com> writes:
> > > >> "Winkler, Tomas" <tomas.winkler@intel.com> writes:
> > > >>
> > > >> >> The user space API is achieved via a number of synchronous
> IOCTLs.
> > > >> >>
> > > >> >>   * RPMB_IOC_VER_CMD - simple versioning API
> > > >> >>   * RPMB_IOC_CAP_CMD - query of underlying capabilities
> > > >> >>   * RPMB_IOC_PKEY_CMD - one time programming of access key
> > > >> >>   * RPMB_IOC_COUNTER_CMD - query the write counter
> > > >> >>   * RPMB_IOC_WBLOCKS_CMD - write blocks to device
> > > >> >>   * RPMB_IOC_RBLOCKS_CMD - read blocks from device
> > > >> >>
> > > >> >> The keys used for programming and writing blocks to the device
> > > >> >> are key_serial_t handles as provided by the keyctl() interface.
> > > >> >>
> > > >> >> [AJB: here there are two key differences between this and the
> > > >> >> original proposal. The first is the dropping of the sequence
> > > >> >> of preformated frames in favour of explicit actions. The
> > > >> >> second is the introduction of key_serial_t and the keyring API
> > > >> >> for referencing the key to use]
> > > >> >
> > > >> > Putting it gently I'm not sure this is good idea, from the
> > > >> > security point of
> > > >> view.
> > > >> > The key has to be possession of the one that signs the frames
> > > >> > as they are,
> > > >> it doesn't mean it is linux kernel keyring, it can be other party
> > > >> on different system.
> > > >> > With this approach you will make the other usecases not applicable.
> > > >> > It is less then trivial to move key securely from one system to
> another.
> > > >>
> > > >> OK I can understand the desire for such a use-case but it does
> > > >> constrain the interface on the kernel with access to the hardware
> > > >> to purely providing a pipe to the raw hardware while also having
> > > >> to expose the details of the HW to userspace.
> > > > This is the use case in Android. The key is in the "trusty" which
> > > > different os running in a virtual environment. The file storage
> > > > abstraction is implemented there. I'm not sure the point of
> > > > constraining the kernel, can you please elaborate on that.
> > >
> > > Well the kernel is all about abstracting differences not baking in
> assumptions.
> > > However can I ask a bit more about this security model?
> > > Is the secure enclave just a separate userspace process or is it in
> > > a separate virtual machine? Is it accessible at all by the kernel running the
> driver?
> >
> > It's not an assumption this is working for few years already
> > (https://source.android.com/security/trusty#application_services)
> > The model is that you have a trusted environment (TEE)  in which can be in
> any of the form you described above.
> > And there is established agreement via the RPMB key that TEE is only
> > entity that can produce content to be stored on RPBM, The RPMB
> hardware also ensure that nobody can catch it in the middle and replay that
> storage event.
> >
> > My point is that interface you are suggesting is not covering all possible
> usages of RPMB, actually usages that are already in place.
> 
> It turned out that the application that we (Linaro) need does have the same
> requirements and needs to store the key in a TEE, transferring the message
> with the MAC into the kernel, rather than keeping the key stored in user
> space or kernel.
> 
> However, after I had a look at the nvme-rpmb user space implementation, I
> found that this is different, and always expects the key to be stored in a local
> file:
> https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L878


This doesn't make it very safe

> This both works with the same kernel interface though, as the kernel would
> still get the data along with the HMAC, rather than having the key stored in
> the kernel, but it does mean that the frame gets passed to the kernel in a
> device specific layout, with at least nvme using an incompatible layout from
> everything else.

NVMe is not by JEDEC so this layout is different and there are some changes but the overall storage operations are the same story.
 I do have a solution also for NVME inclusion into the framework. I haven't published that part yet.  
It won't support virtio part,  as this requires some legal work to include that into  virtio spec.

Thanks
Tomas


 
>         Arnd
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
