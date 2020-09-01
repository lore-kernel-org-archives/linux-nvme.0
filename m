Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696CAC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 22:03:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B59206C0
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 22:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8ahfUAL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vpIdXNNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B59206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UjCDEaMoGE+N2gqFePUyayOwrwAT0EUnmZr6x1JZGEM=; b=l8ahfUALj4vHZW7JugaNxxF0Q
	uevRmpSp3OytXOeUt0Cx3PZaN/PjYCuob+l7xQVeRdpYDkJWD9WE9ybPSFmJnLf74F3qUvUOdSTpk
	izGnSRHxIiuADYYMnZHOkmmf/s7iYSCulv0vYcmWzecMcwTfK764izn9xaiNQAaZDygOra4BdtpEU
	5Mb593vQbQqQX+MTTM7mtAjKsvsG4yJweacmMAU1zgzAWIlZccEkqUQpvoQylx86WMOf5ieVScLoG
	UNw+cuLU/DIkoaUl4Igc5cn/rdM35n+JhRqocBRzuP20rJc4RymfPz/LgE7lpl7kIjH0dMJNxN8sR
	iAfgHj2WQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDEMy-0007jH-QW; Tue, 01 Sep 2020 22:03:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDEMw-0007im-9o
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 22:03:11 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 987D3206C0;
 Tue,  1 Sep 2020 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598997789;
 bh=PhFwEjGUeUHzUmndHmllqr5l+6GZarOaQg7CbHEzAzE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vpIdXNNP81yzjs3KqtrUZiNJfM0Z7sYKKzqBoIerE/Jxb1P659JDzhZ+iNxz9uCPY
 TzuX2m4xG9LWn0ZJdSmbsnmDxiP7tLcvPVrajKEOCfJoeuIILgFuHq1nIPaNR/+WdG
 b+2fcUxtz/pJwE1d0tMKOTLj8SxUkJbhRDrjZ0ks=
Date: Tue, 1 Sep 2020 15:03:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V2 03/12] nvmet: use consistent type with id->nlbaf
Message-ID: <20200901220306.GA2926338@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-4-chaitanya.kulkarni@wdc.com>
 <20200901155557.GB2831246@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965C6CFC808F34EFAD4B44E862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965C6CFC808F34EFAD4B44E862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_180310_425173_3DDFEA6E 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 09:17:45PM +0000, Chaitanya Kulkarni wrote:
> On 9/1/20 08:56, Keith Busch wrote:
> > On Mon, Aug 31, 2020 at 03:26:58PM -0700, Chaitanya Kulkarni wrote:
> >> In function nvmet_passthru_override_id_ns() while iterating
> >> over namespace lba format loop variable is declared as int that is
> >> inconsistent with the id->nlbaf type which is u8.
> >>
> >> Make loop variable of the same type as id->nlbaf.
> > The loop is id->nlbaf + 1, so it'd overflow if the nlbaf value is the max
> > u8. Sure, it doesn't get that large today, but they're always trying to
> > make it bigger. And there's really nothing wrong with counting for loops
> > with 'int i' anyway.
> > 
> 
> In past when ppl run proprietary static checker it has generated
> warnings for such cases.

Sounds broken. Adding a constant coereces an int, so comparing with a
declared int should be what static analysis wants if they're being
pedantic about it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
