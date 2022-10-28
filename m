Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025EECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8XwIILHF95ZyNJfx0L5QKq81Sq7msMrSv/FAliTVdo=; b=QCoPEsxK4cwIqXvkglcrPbLWCc
	7ZXCEn6Vk83ooV+1PkWntekumKg5jH/L3379EQNT4zTwFlk1tmPoV0pPyUyKnC8U5qhcDT7unIr8Y
	RCxNdomExHwtoFHGCSJdQ9z5YPSz/7r4bPwx4B+YieGZVyCUJbh5bBbpwfbIFNM3KA8omEScOvhHP
	LabiKoy+5lNxLOEw+udb/iqwM8sZ6Qnq0ixWqPeVvsL50k3Mov/oDf+p2gCCqNBmjm0nK64N4diVY
	2C6LtaZi+s6I3kRPMKG9W8/XXPXUPyi1F0DX4mw73spo94WVdlmObituzXJTTT3ZN1YWPtBiAKSrn
	BjlHgjdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooNcU-00GxkH-7b; Fri, 28 Oct 2022 11:33:50 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooNcQ-00GxgB-5A
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 11:33:48 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 8851E41209;
	Fri, 28 Oct 2022 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received:received:received:received; s=mta-01; t=
	1666956816; x=1668771217; bh=glwCP650qycqQJv5FySHUCRgUrpEFqdGHAG
	vD3nQTB8=; b=tRUypY4HsUK8AUogBu9AHT9tDwU6MmIBryZlY9FClBwWhDFRIdm
	W/W85zZuMCHvknebSwyItssidYst6PBqoQKG2u8DMB7jHH/S3+mhjZd48os4jigD
	6Xlt6/b6EyGFC3rzTpcc7JdhA5hP4Ofel6d3TpRNATuQ7j09ufqrHXeQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mn17wkJCmL30; Fri, 28 Oct 2022 14:33:36 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 00CAA41203;
	Fri, 28 Oct 2022 14:33:35 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 28 Oct 2022 14:33:35 +0300
Received: from yadro.com (10.199.23.254) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Fri, 28 Oct
 2022 14:33:34 +0300
Date: Fri, 28 Oct 2022 14:33:35 +0300
From: Konstantin Shelekhin <k.shelekhin@yadro.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Aleksandr Miloserdov <a.miloserdov@yadro.com>, Christoph Hellwig
	<hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitriy Bogdanov
	<d.bogdanov@yadro.com>
Subject: Re: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Message-ID: <Y1u+D80ohMF8bbPJ@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
 <20221026083135.77125-3-a.miloserdov@yadro.com>
 <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me>
X-Originating-IP: [10.199.23.254]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_043346_884722_C35E1962 
X-CRM114-Status: GOOD (  16.82  )
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

On Wed, Oct 26, 2022 at 01:49:17PM +0300, Sagi Grimberg wrote:
> On 10/26/22 11:31, Aleksandr Miloserdov wrote:
> > Allow user to set OUI for the controller vendor.
> > 
> > Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
> > Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
> > Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c |  9 +++---
> >   drivers/nvme/target/configfs.c  | 49 +++++++++++++++++++++++++++++++++
> >   drivers/nvme/target/core.c      |  2 ++
> >   drivers/nvme/target/nvmet.h     |  1 +
> >   4 files changed, 56 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index c8a061ce3ee5..0b415335bb5f 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -372,6 +372,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >       memcpy_and_pad(id->fr, sizeof(id->fr),
> >                      UTS_RELEASE, strlen(UTS_RELEASE), ' ');
> > 
> > +     id->ieee[0] = (subsys->ieee_oui) & 0xff;
> > +     id->ieee[1] = (subsys->ieee_oui >> 8) & 0xff;
> > +     id->ieee[2] = (subsys->ieee_oui >> 16) & 0xff;
> > +
> 
> put_unaligned_24 ?

While there: we have a little internal bikeshedding on how to actually
name the ConfigFS parameter :D

Weirdly in this part of the spec it's called IEEE instead of OUI,
however in other parts (like EUI64 generation) it's referenced as OUI.
To the end user it makes more sense to call it simply OUI. So basically
we have:

  attr_ieee
  attr_oui
  attr_ieee_oui

Purely a style nitpicking, but what's your stance?

