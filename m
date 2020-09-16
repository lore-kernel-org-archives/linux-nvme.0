Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D8DC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:07:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E4D2223E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y7Mi4wBl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="RJbVDAlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E4D2223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GYZpHnhkDk1YVIstsuXUoRoixPTJlZqHACASYL6Aftw=; b=y7Mi4wBloqArd+t53IIFlntFO
	1tcpH2etPL5LH61WnFEEIs3Cg+L5ipf5j7vXMeEsk+kCYjHZnhPQ2hjcZtXLpJP4o9Qnq5sOmxK7D
	fQ7SwC77nJG3u3YoieteFbAaZROtCgy8L59a529pl/Ou0xw/vw/Mbg63e/spiLP2Ar0Qzpvt0dytk
	vAQL8piCy2QuXrZ4kt8RitQmGI87n2Sr6lGU3yDveHgpau7FqY1NH9rpyY+UaFQ7bIcCsnWTTUtVs
	Me3GgmmeOZLOeXEOSMRE7sHeqOv1TOHkq58hdIaaGXsC67YFgh9rBSOuACk2SxyplBC0Oo4O4yiBp
	+4gHKZ/1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZxq-0000Iw-BC; Wed, 16 Sep 2020 16:07:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIZxc-00007J-LF
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 16:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jCIKoQMgI8zbCmofiyz+I0OmINz4BVD/CtG9mKhrrso=; b=RJbVDAlp0cAwRoUHkzGXdbP4co
 o40MUmJOI98n7NMIDwAZT05yo79eVlTf0HwL7X4li+rKs+AxClcEs55Ib3us6Jtz+ArAaYhCV/KP1
 HdOEskvooeG7ogY7NQXKChM3UFiE65UKo8KDuillEZfZ5wsz9R5ZaQuPpHyEMvFrm91UeNdgrcJWh
 +xjWLwnt0JHMxsQlda/tT/QwAzKVYfF1bApbT4hENZVfpQ+orL2zKKKA1ps08q//MU5qoNU33SMm/
 NBjmzWP22sLtGezxRnkH/8i9Czh5v/H2ZPN22kHfAw5L4b200TvdBsVuePgvCqUvoCY8SAOpsdLx3
 NZFGA8NA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kIZxa-0003p1-WF; Wed, 16 Sep 2020 10:07:07 -0600
To: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
 <20200916035326.9229-3-chaitanya.kulkarni@wdc.com>
 <20200916065243.GA9283@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aace5146-a155-eb18-061d-6f17c9a31e4f@deltatee.com>
Date: Wed, 16 Sep 2020 10:07:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916065243.GA9283@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, chaitanya.kulkarni@wdc.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 2/2] nvme: decouple nvme_get_ctrl() from file open
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_120708_762609_D2791052 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-16 12:52 a.m., Christoph Hellwig wrote:
> This needs to be split into a fix and a cleanup.
> 
> Attached is how I'd do it.
> 

Christoph's patches for this look good to me. Whomever runs with them
can add:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
