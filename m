Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D6C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 17:16:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A21625334
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EeH2bjwf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrno2bTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21625334
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rlyx/B0S1RsGmTeAm3em7ZR63tfDF870xsaU20aXBVk=; b=EeH2bjwf8NdKere/6gVSN9svb
	9JR3iUknz6watrayMfyfgx//hae9I0xkyWYNLPEftmLMIg2Q+wcBY59eUYQ3ehOMU2Vljn0ghN1pg
	nb+gzO42YVv2CNAKg6ScKplIgcamjeToQcvQeGdio8LV8Je/FfRrYb8lMMZlSuxq6nVUwVSEkEtKI
	zl3xp5ImkIFEUSWgWtiLnfTt1YwNKkrQTc6ms6VTHvFHtiXsutZt/ypETP/axGU365L395oG7ymIh
	QRqxR/cZWTGcI08B61Xf+UE8J9cPC/M/PMYVMVnscTmJfsRi4UCTNwt+8XGNhc8Op4rq0c/ixCaRB
	UQYakjBtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSNuM-0002IW-Nl; Tue, 13 Oct 2020 17:16:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSNuJ-0002Hu-Ur
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 17:16:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 201E225334;
 Tue, 13 Oct 2020 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602609373;
 bh=P88v3uczwmNVagw81qRi3rAiSPy869r419KvBCA3QZk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mrno2bTWkgwsgxWy4DV4bYCRvfmUzGQ8vi9D5OzvcHSUPHEsUOT+eMpvUtHS+xI/z
 mFJsI0v0Mj8o8XD2iMXMER7s1lZpiCITsCQPOrKep1kmZnA7OI3O6d3Cf8V71Ot/7l
 /rhyZdTpER689Zedi00931GZLDx+y+7/9xegNkjg=
Date: Tue, 13 Oct 2020 10:16:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
Message-ID: <20201013171610.GB1033288@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
 <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_131616_064954_FB363DCF 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 linux-api@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

I'm going to try one more time in the hope you've just been too busy to
notice these patches. The series has been unchanged for a month now, and
has reviews from all the right people. Can this be considered for
inclusion?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
