Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD4C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:16:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0942071A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIKdtK0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0942071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aOvOCPpkgiZW2Z2byrKFDBc2JDBG6HK8touADqsuy8Q=; b=MIKdtK0pMbjXnKs2rZ4GkBXU8
	bolOCYZcRAXqq5bacJbn+hqMbel1p87kugJSjvRcFNMJNyWTDP+5LyViGZShbmN/m7rW2Y3CenT2I
	wiWH19oKFDUUWE3Rkdg1FkyL+jBWQQvsT9GWx8XMS9KGXPkUdhxBQ9n8weM05oQLNBVaL4BROF4KN
	JquZUMh0Goki4HSrQBejconCW05YAYbhLux12fyQvyyDD83C3Z7GlfEJPJTbjtTV6va+E/DL/eBte
	Wb6zy00jOh7VngFwVRHPsWbZmT+Db60V5gcOa8Q0epGT4PIbewMuruOAVHHS2exjm8mA3bXXLI4fC
	MRlqDtCvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb2XA-0003My-8X; Fri, 06 Nov 2020 14:16:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb2X8-0003MX-2a
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 14:16:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9019F68B02; Fri,  6 Nov 2020 15:16:03 +0100 (CET)
Date: Fri, 6 Nov 2020 15:16:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V7 1/4] nvme: centralize setting req timeout
Message-ID: <20201106141603.GB23884@lst.de>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
 <20201105232832.21216-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105232832.21216-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_091606_248836_57CFDEA6 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 05, 2020 at 03:28:29PM -0800, Chaitanya Kulkarni wrote:
> -	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
> +	req->timeout = timeout ? timeout : req->timeout;

Nit:  I think

	if (timeout)
		req->timeout = timeout;

reads much better.  Same for the other spots.  If we don't find other issues
I can just fix this up, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
