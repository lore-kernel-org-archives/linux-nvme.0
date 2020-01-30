Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22272C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:37:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D907A2051A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iisLQvVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D907A2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uTQo/Gur7hHHlTU/w8I4n4YTsQYordGBNsOU2LDH2ps=; b=iisLQvVRlmmG/V
	07qN0x7kbAuQBqdJ4/LLk1pGz1gH4hJd6Fl6lxSQlN2DwmhlZ5ytPE2ORtcrNr7loMueo16hCJSBB
	2wnlj3Gddhq4av3Y+tAzRiEkNfkcus0GHX1cPIf0McxbjWPfEaKU9r0djt1QjDfdg9rlpoUi2ET8S
	b0dbs7iR/+Zm0L7SrVGwy6fv0TaEBJUiETuZjPnXx781tPHM8UZFhWkPRBdT32wCv55Pb2m7sZ789
	ZK7iysBAqSNl08OobIOjLpMcXpmr+He0WHtPhmx9zpIZU/33qoCD1/N7ssULYrUnATLrNetO0YXlU
	cnMOfpT/cz5+eexfT/jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixBsb-0004X7-Nj; Thu, 30 Jan 2020 15:37:17 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixBsW-0004Sp-Eq
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 15:37:15 +0000
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M6ltQ-1ivWOL0ISE-008KaN for <linux-nvme@lists.infradead.org>; Thu, 30 Jan
 2020 16:37:07 +0100
Received: by mail-qt1-f177.google.com with SMTP id d18so2758766qtj.10
 for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2020 07:37:05 -0800 (PST)
X-Gm-Message-State: APjAAAWEfqZkZL3FtYi1jH5uBsvZtYQH12c1R1qixpGfmWV+2KSOI7Q1
 9GwwBQdssf4mGWhEg9igh4JMgNqtSzEvJxDIujU=
X-Google-Smtp-Source: APXvYqxCkWZBhg4bg1vNcfrCI3V9o1JnukFHyxuV/csq9TxhQ8iZPBGMHyGyEWygs8mH72cQSiA48iKSHJWBp2VH4C4=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr5422862qtr.7.1580398624859;
 Thu, 30 Jan 2020 07:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20200107214215.935781-1-arnd@arndb.de>
 <20200130150451.GA25427@infradead.org>
In-Reply-To: <20200130150451.GA25427@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Jan 2020 16:36:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
Message-ID: <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
To: Christoph Hellwig <hch@infradead.org>
X-Provags-ID: V03:K1:gYjS11yEcmg02zllz7Lr6LShL7eF/oDGnA+1C+iggYYgPXm4013
 nrLFTG4IdkMX3Pwib06F1SvthN6ai8Tvq7pkShCGMmTwOCqgmNF8r4mt0vT1bgEbdRTrYdw
 GyceRKgYpFexv8x3Y/mOvleGqD8PQCl24hVZBIIdzUTKIl3Jka4DmHlD1+usB/Ta1Hhqd6x
 d9XJoVYoN3plaN77Uxk8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KQAnJ/62FxU=:FFCpIoHcbvy6hpb9M4JL/v
 h7m6YlcsiMz+I7/MKMAOx6DPUE+Pb3VrMETvduywJzlw3iNFaQKERaj2Vw+Q1U7y+51YA+lBS
 5O9mdiCWxzrrRILm9RxAMAKlay1qEPXf8pksKcS3zlUEBA6gyQ+Wh8xjI3c5V/OBytihJMUw9
 wUQ7haWnX00Hk0sInpMwBMTl7I6iNXChCsh2eWMxuYmnXTnU/3mFjUsHA8SloYBlyf5dK48Sa
 gggw9jQ5GY6igIa4qEFOnyS+QNFdL13fCeYqHJlhvj5QmdEuTowuS8aFi9HTyYba31cknVJr0
 yYxy4qxZl0SmYXfgNbe8CKPBDkyddvDkaHENRiEi7jBH1/2motVK8NSbZUv5AEB/2fmmXbSb0
 DnBrirPTZ0UQ0Ot8th1MVpTT54yFe+AMqBDTxZgOHplMmb2nDAonzXlBGiYtadJz1Rt5dwFmJ
 L/SaMO6NHJ0ut1bMQHQug2rA16efdL8lhts5tImPwhZh9SLYR5IYG3KvaOG58JiWwM9XAJKT3
 7YwVjvwB1/PnlKVWet+DO8zRtnSeGqBInHEMHWh7gq22wilj9xyGZlPnCbHQKsZBh4VGOojvp
 hKgU6H37Dy/JX4px2RYNRCShLrBJaQwfNCDtUTgIFQ71uP5Ye3BiCpeorysIpze5y2r6lQeWQ
 9wRtJ/Io4KcQjEzIYa1U9eliabTLofGFl8TtNW74eQWDa6PaqHgOTx/t4q7zsxHhUH7bvfrQ/
 v9HcrdFqmhDA+IBvpxoLnqR/e5S+BnC0zGo2yzu746mI7aeyiCyrItOzCbgTTfSGJoM3EtqW/
 q6f+Cq652QZHj0ZOrst36BLMUVsT0Z0gsshq76eKw/CZq9/ocg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_073712_821162_0AE941F6 
X-CRM114-Status: GOOD (  18.00  )
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
Cc: Oleksandr Natalenko <oleksandr@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Marta Rybczynska <mrybczyn@kalray.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 30, 2020 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 07, 2020 at 10:42:08PM +0100, Arnd Bergmann wrote:
> > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/nvme/host/core.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 667f18f465be..6f0991e8c5cc 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -825,14 +825,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> >       int ret;
> >
> >       req = nvme_alloc_request(q, cmd, flags, qid);
> > -     if (IS_ERR(req))
> > -             return PTR_ERR(req);
> > +     ret = PTR_ERR_OR_ZERO(req);
> > +     if (ret < 0)
> > +             return ret;
>
> This one is just gross.  I think we'll need to find some other fix
> that doesn't obsfucate the code as much.

Initializing the nvme_result in nvme_features() would do it, as would
setting it in the error path in __nvme_submit_sync_cmd() -- either
way the compiler cannot be confused about whether it is initialized
later on.

       Arnd

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
