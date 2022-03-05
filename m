Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2242FC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Mar 2022 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojwLotZqL1XX/lurv8bY4W0jgyvpAjo30XtbPM1k+zo=; b=NHUeH7NJba105pXTT4zrHmnk7I
	f1HhfJv9S/aekoTMIybKVK7szTgGY16txTDQnxAuaRDYwkPTMyGzsyfsbEMJg/pUGKfaNpjQ7rru1
	hV0qFVYOdzwNTvsWTK4ZsmfkRpRDfU/WRz6hBLWIlUBGAH8MAR0rpiuYe/eu9OkVVZsdmVRbyAXR6
	fQOUgJ2nu55A18IVtdA88+w7lFlmAsdwwgsU5cinwbgYTqssJDjgTSc9P8ydk7CxUkamAUmp42yuH
	9MuWRyXc6Mdup51eStZvu6dJDMJbA9Om+JBF7fY7kHXg1D3TyGl1DfVynDQainihV4bnpCvbleVkk
	dVjy1DEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQOXY-00CskH-6V; Sat, 05 Mar 2022 07:09:20 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQOXU-00CsjL-TT
 for linux-nvme@lists.infradead.org; Sat, 05 Mar 2022 07:09:19 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 9C7E2B00CC4
 for <linux-nvme@lists.infradead.org>; Sat,  5 Mar 2022 15:09:13 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID 1575308660
 for <linux-nvme@lists.infradead.org>;
 Sat, 05 Mar 2022 15:09:13 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id 8CBE4B00CC2
 for <linux-nvme@lists.infradead.org>; Sat,  5 Mar 2022 15:09:11 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646464153; bh=eNSZNCIQvJX3BIsPSVxmvt3kCFvgkMDpfMtpQFtvFKk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MSuUsI3uWf0AtRseaOViOhhCSlQvi0Aopj+QQKGFcdh+zcl+30hSDQ5/3f1+ONiuq
 dP3dNZBPMnvx8GsERgLrjZIS+fPuqyQwog/2soieSChu7O3BOxXP3HLlfs7D7D45Mk
 XbCRl8Emnbw27rJRP3C80h3xXJeIrn2lrkuSliX0=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id 9C01AD41598
 for <linux-nvme@lists.infradead.org>; Sat,  5 Mar 2022 15:09:11 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-Xyti8L8kPN for <linux-nvme@lists.infradead.org>;
 Sat,  5 Mar 2022 15:09:08 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam1.tom.com (Postfix) with ESMTPA id 0F053D41550;
 Sat,  5 Mar 2022 15:09:06 +0800 (CST)
Date: Sat, 5 Mar 2022 15:09:15 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220305150915.00006b44@tom.com>
In-Reply-To: <20220304162032.GA12250@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
 <20220304092754.2721-3-sunmingbao@tom.com>
 <20220304162032.GA12250@lst.de>
Organization: DELL
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_230917_582649_53E6F708 
X-CRM114-Status: GOOD (  14.30  )
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

On Fri, 4 Mar 2022 17:20:32 +0100
Christoph Hellwig <hch@lst.de> wrote:

> I'll let the NVMe/TCP maintainer comment on the actual functionality,
> but:
> 
> > +			p = match_strdup(args);
> > +			if (!p) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> > +
> > +			key = tcp_ca_get_key_by_name(NULL, p,
> > &ecn_ca);
> > +			if (key == TCP_CA_UNSPEC) {
> > +				pr_err("congestion control %s not
> > found.\n",
> > +				       p);
> > +				ret = -EINVAL;
> > +				kfree(p);
> > +				goto out;
> > +			}  
> 
> We can't just call networking code from nvme-fabrics.ko

Well, actually I did have thought whether the calling of network API
here is proper. Since I did find that there is no call to APIs of
PCI/RDMA/TCP in fabrics.c.

But I hope the following could make a defense for it:

Anyway, we need to validate the tcp_congestion passed in from
user-space, right?
And it's reasonable to validate it via network API, right?

The role of nvmf_parse_options is similar to that of
drivers/nvme/target/configfs.c from the target side.
And both of them can not avoid handling specific options of the
sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).

Given the fact that the configfs.c already contains some RDMA-specific
code and has the calls to PCI-specific APIs pci_p2pdma_enable_store and
pci_p2pdma_enable_show, so I added the calling of network APIs in
configfs.c for the validation of tcp_congestion specified by the user.

So I feel this is also acceptable for nvme-fabrics.ko.

