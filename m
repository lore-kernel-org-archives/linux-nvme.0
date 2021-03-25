Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FB7C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:15:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2619161A16
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2619161A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Uo408DWv3/hRad31lBcFRtoUSahRe46tk1HLMP5zRXk=; b=WInSuRc6Gn/EdIA4xUCtqMiox
	9eQBHaQGVcv7XhxJSRgiuFZlEEDoDaoCVxxj/CXTEeNbRrmymVyIvquf8d2NTsSeSL1LvkaG3k0K0
	4y5EyY7hH0R9+JzdcBhp0X4PTdIs5pkwPYWUmrRXRWgRt6ErLomqdZoYmIwNZu+9tPdnnLodOfd+0
	vudpKq61MRfzNgTIzD4XlpAtje14qpCLi3hfTjqm3+EJO8kzNeOshyWhmiBsDnso+t4RrRnh8qrFW
	C2wvmyDPxfrPVSYPCGeZBdLzcRhL54XoLRI3TfLLY75E7NyVfRNpntCAt5D+3NmFcC6EKzIlAuG7s
	QFiAJy5Tw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPRh5-001hGW-Io; Thu, 25 Mar 2021 15:14:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPRh1-001hFh-TJ
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 15:14:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92E8861879;
 Thu, 25 Mar 2021 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616685278;
 bh=EbycO/deHFM530+ruOu412p0Jfev3nG2KiWakLqetXo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dxlUVWMHYwvolg6D/CjQEqHhZ1nmoq17qMz33zAghoiiqto221fGWVmcGAplrNtoK
 FMSy00KeLMdiGsAQkfde4zgyl6QTJgk33R1t190q5furIs2W41ujDs+DRFrGr5FGbU
 m8BO7nNGIIhfTf8GFvPbvvmHYI67E5vQHhIY2ZGeqi8DxwMFvRHgCE0meXUhJ86VE7
 qBmQx363VMisDJL0QFDNfS9915xjXpvXdz723YeODrCj7KTtWBafBLOlGL/vQADyR0
 ZZVxpdDCmqNK/bDFLdD7VzSP/gau4R5mOOOfwgXovYPyYkDE6zcKEgcVQaf1bzVRhw
 HVyAzyDbCYWYQ==
Date: Fri, 26 Mar 2021 00:14:33 +0900
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325151433.GA31394@redsun51.ssa.fujisawa.hgst.com>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFyBM1qq+AmYQvdl@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFyBM1qq+AmYQvdl@x1-carbon.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_151440_151581_703A0F76 
X-CRM114-Status: GOOD (  16.37  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 25, 2021 at 12:25:24PM +0000, Niklas Cassel wrote:
> On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> > From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> > =

> > Create a char device per NVMe namespace. This char device is always
> > initialized, independently of whether the features implemented by the
> > device are supported by the kernel. User-space can therefore always
> > issue IOCTLs to the NVMe driver using the char device.
> > =

> > The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> > scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> > for multipath will follow.
> =

> Do we perhaps want to put these new character devices inside a subdir?
> e.g. /dev/nvme/nvme-generic-XcYnZ ?

I actually suggested the same hierarchy, but that was rejected.
 =

> Otherwise it feels like doing such a simple thing as ls -al /dev/nvme*
> will show a lot of devices because of these new specialized char devices.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
