Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C1C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:26:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBED8206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8YPnnb3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq1r5Dcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBED8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nTMfjW3x8Ckc5YBldcFeXGhMMejmamDRFzOVyBMvyp8=; b=C8YPnnb3cdxH4N8KAV/HHees9
	TtCpPDOFfXW4CRLzZvvC1junU59q7elBTaLzLcEO3A1G9M5aAR75SP8N46IXKCDAgNxk97MOALyUs
	aVkhkq242EDzaYze4frpEBXHPTgxJG2eJyVMg/H+S2MIP0lJeJg6IawTYvNY1qj0erqNQ2u7cUTvd
	Qa+ZGmS/nx3NMdTu0jkCqzhTTTguzmAInLZwIm/NbOUsPqOssIldlzQTO4Knpj7YnfwoZX04+Gted
	7V9u0iKI33cG/IdJkbZTxRwfqA2b7sBWIL2RLquslO8VS2hCmOfJm3MLGkRWFx7+NfjW8/E3MIKxv
	Q3eTsIjhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5HBt-0003zz-Hx; Mon, 10 Aug 2020 23:26:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5HBq-0003z5-KG
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:26:51 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2759206C3;
 Mon, 10 Aug 2020 23:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597102010;
 bh=g1sPaET6SyRaThMiZehx/YCuXmlekAVwxW0bE2UIWpw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Aq1r5Dcv0pVwL15sRZ2cE6mEO7DuMnsWFr4hRvGhRV2TOjOsLdVqlqLFenLTVA9k3
 E7VfbeqeiWTQCYB2WQ3DnLyiA+TrxGbTMrXC2nmMS10qe9RO8fC0GEobJhD8Kyrvxf
 xuW6EZkC2QzFGbaFMqahL6ZmC+MA32UHCJ3ibgMw=
Date: Mon, 10 Aug 2020 16:26:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Message-ID: <20200810232647.GA866477@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810231053.GC269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965F8FA39BFE340075BC37186440@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965F8FA39BFE340075BC37186440@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_192650_753324_8F9AC613 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 11:23:03PM +0000, Chaitanya Kulkarni wrote:
> On 8/10/20 16:10, Keith Busch wrote:
> >> Good point, maybe they are needed for backward compatibility ?
> >> Can we be consistent with the backends and different flags ?
> > I don't really follow what compatibility this could be about, but if
> > they're not used for REQ_OP_DRV_IN/OUT commands, as it appears to me to
> > be the case, you should just remove them rather than add more.
> > 
> 
> Then we have to remove in bdev backend also ?

No. That target doesn't use REQ_OP_DRV_IN/OUT request ops through
blk_execute_rq(). That target uses REQ_OP_READ/WRITE bio ops through
submit_bio(). Big difference.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
