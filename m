Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD93C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC32206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhOE8ynL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3sI77iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC32206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=61EIGujWk4UETnhnZth5mJMJhOWo7GIXaK7lxex6B84=; b=jhOE8ynLPwuzrEtJHZmtcBk81
	o2FdTAEClOwyF71ACl697EtCHRdwpmv2bcgJLrnBaZMrcaIjRvFYm5Ri3ki7EHMAENyHB38koGFBN
	+2AaE2dlDY3stoihnHwDw5uDBEYdBBubwLeT6bHqcU5FKcOnjmlFqsZhBCYts6vLZjv7tHqs1x5ut
	szPq/shpNC5yn+1jUZCzWvrHPjmOkziDnwDiycJtIbdk0n81i8TzjKddyFftz//zClV6prBbxJ4pr
	J/6thZ5MBLziQ9xfNd9sTq3YEdHWzT2m0Thbpj8MTYA2K2d1HJpuZQCAYVlNaCfFhCExc8XrxL2qS
	xpGrP///w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomUG-00028j-PK; Fri, 26 Jun 2020 11:25:43 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolEp-00014E-Cv
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=sVK39yIZDi/Cl/Zi0n90YQlQJFnuvptzqLJDUTt48j8=; b=f3sI77iPObtbOqPPmjwJNiCnt+
 tkfcQTn8JoCCIVTXVa6sJRo8VvvjV6fZpwCPTItor6/P5RfrcrTMEexJqy0kt5Lkm+6Qb/m/jl7Fb
 LUWctZpNDTeDTyOxT8hisDBhc/wu1p5BkiGaBnx4n/rEBfeJ5n4ayFnehViFhEAaXgvfOp1/2cDVB
 tBuUSP/csULFOFsitdm7CTGNax3VRGdfI8pjYMqcjbA8pjxmkjcjUIV4o9/38AUqD8cZVHSnTxGCc
 Y8lPkjXCX3h8eMnaFBhClW0/Ca02TxnNVHXQ1w3QlTCu2Qb2RX9avVl1ekU61NFm+lyijVOX0Gf+G
 TXR8K+XA==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokwI-0006M0-Vb
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:46:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C01D68C7B; Fri, 26 Jun 2020 11:07:10 +0200 (CEST)
Date: Fri, 26 Jun 2020 11:07:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626090709.GA26616@lst.de>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_104631_796953_378B6387 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: axboe@kernel.dk, Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 25, 2020 at 04:12:21PM +0200, Matias Bj=F8rling wrote:
> I am not sure this makes sense to expose through the kernel zone api. One =

> of the goals of the kernel zone API is to be a layer that provides an =

> unified zone model across SMR HDDs and ZNS SSDs. The offline zone =

> operation, as defined in the ZNS specification, does not have an equivale=
nt =

> in SMR HDDs (ZAC/ZBC).
>
> This is different from the Zone Capacity change, where the zone capacity =

> simply was zone size for SMR HDDs. Making it easy to support. That is not =

> the same for ZAC/ZBC, that does not offer the offline operation to =

> transition zones in read only state to offline state.

Bullshit.  It is eactly the same case of careful additions to the model,
which totally make sense.

The only major issue with the patch is that we need a flag to indicate
if a given device supports offlining zones before wiring it up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
