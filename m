Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1AC10F14
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3830222C4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 12:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CEiB/uQg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHwAeBZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3830222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7PMtMig5iRJleOhNST7Sa97UiLheFTXVDpfmU1WZUlI=; b=CEiB/uQgtHX6DU
	fG32xQKln0vwRbq5UinKbk0O0JCdhpp0H2wtyK5Mb909RUoDwvw0VpPe601wP3OMtVll/sftfq/fS
	BtUEJUXS/Wc0yY7C8li6kOmSp1lnV1H/q7KVlF2CG09xpTktxweTKd/woTLvuNcOZyypy7h8K2UsY
	9YjoWCeI4T1Y1leaXiUh6T/8f8bW9Nt94Y6MoYE0tjoGo/Sh3fbRRkt6QBrsE3t9XJP+E+XaIGiy8
	Se7HiYnI9MApUqEXzIhC4h7XpgyODeclAsdswey+X5J9tUKN25ByFlGQPwoU9p3JTU96uzfKH8/uK
	KkmUL3zBmXGx+7l/8kmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFzpi-00046z-GM; Thu, 03 Oct 2019 12:03:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFzpf-00046X-Kd
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 12:03:44 +0000
Received: from C02WT3WMHTD6.fritz.box (37-247-85-246.natip.skydsl.at
 [37.247.85.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4AAA222C2;
 Thu,  3 Oct 2019 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570104223;
 bh=c30LHNYp4RGmgI8zkhPQpsyj3fxSJmQCqW6HYUUbtwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cHwAeBZZ2IaBaazgcOOP9dcg8QcwGxXUOZ0OdRCTvhj6Zv+m5PVC8vgRyiQigKpvK
 5ENIKGdnoIxWlIfmharRUHsHshc0nLJll+X0oIwGEsETAaFAJPXa87KhTndcIaUHGY
 hqWJ/06xxTUI1ALItie+zsEZysUv5Y0X523NobQA=
Date: Thu, 3 Oct 2019 06:03:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] nvme: retain split access workaround for capability
 reads
Message-ID: <20191003120325.GB34459@C02WT3WMHTD6.fritz.box>
References: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
 <20191003114901.GA34459@C02WT3WMHTD6.fritz.box>
 <CAKv+Gu_YCRwvtc=QSu0V2i1GESxHv9ndkqe0cyJsDaL6LQATDw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_YCRwvtc=QSu0V2i1GESxHv9ndkqe0cyJsDaL6LQATDw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191003_050343_696298_B1796A02 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@fb.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 03, 2019 at 01:51:03PM +0200, Ard Biesheuvel wrote:
> On Thu, 3 Oct 2019 at 13:49, Keith Busch <kbusch@kernel.org> wrote:
> > On Wed, Oct 02, 2019 at 09:36:43AM +0200, Ard Biesheuvel wrote:
> > > Broken since v5.3, so if this gets fixed one way or the other, please
> > > add cc: stable.
> >
> > Since 5.3?! 'git blame' says the code has been this way since 7fd8930f26be4,
> > which was from 2015 during the 4.4 development cycle.
> >
> 
> That may be true, but the box in question happily boots a v5.2 kernel.

Looks like your observation was introduced with c0f2f45be2976abe.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
