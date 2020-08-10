Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EB120716
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3oYcUao";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE8wkfv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EB120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MrS4YSkxWcvQSvW4mMHvtlDADSebeCnVjW0U25IyZy0=; b=u3oYcUaoqq2714OB4Vxg2yNMr
	5L7wiuOEUgzi2b1oWuvurFJl5Gh0zcpn/VlTUl4THTrLKkBwpByvAhQsP0mBagwqjr6z8OfIY6CfK
	oj+L8Jygb/LifMzcfw6oCNB38l56hrZjdHxGl0gNKntJBLFaIG8PYYqlwP9wzeQhqGKDav2tiisQN
	cN50HwgKg4JE+RV404Yf4/lI9dJu+LaLqDIUy2Gedx+1XTN3aw6atI+2wMIwC5VuGs016kejbywvi
	zmZIVn9QXlkUw9xwBUU2DMHY9Gkt3qvyyVcWbdvnmSlJFfz2BbnXfDBfFsCxmIWBLFrUMzvmfPE5i
	/XlQh/zlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GwU-0000vk-QH; Mon, 10 Aug 2020 23:10:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GwS-0000vE-PG
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:10:57 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B18D620716;
 Mon, 10 Aug 2020 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597101056;
 bh=FMKYRv5NY7c/GWx8ZtB3YQKCYsq8V04EJZu2d3iikXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mE8wkfv97drxc6J7nWx5whjkOoyB+9EGL+MqqaEHob/ZzlF29G0Wk3wf+lFuXz4JR
 Rf5UQeMRFugVxB0gkGWSZGpCI3zz3dEur0Pjm7QqZT/T5CYUW+Misdp63UHr5Ld8YJ
 ekhKK0HewkNnsxM1ZB0WllEHFrKPFD6q4zPl7bZc=
Date: Mon, 10 Aug 2020 16:10:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Message-ID: <20200810231053.GC269401@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_191057_243608_957BBB54 
X-CRM114-Status: GOOD (  12.64  )
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

On Mon, Aug 10, 2020 at 11:04:36PM +0000, Chaitanya Kulkarni wrote:
> On 8/10/20 14:11, Keith Busch wrote:
> > Are these flags even used? I'm not finding these getting copied to the
> > 'struct request' in this command's setup, nor am I finding anything in
> > the blk_execute_rq() path that checks the bio's bi_opf.
> > 
> 
> Good point, maybe they are needed for backward compatibility ?
> Can we be consistent with the backends and different flags ?

I don't really follow what compatibility this could be about, but if
they're not used for REQ_OP_DRV_IN/OUT commands, as it appears to me to
be the case, you should just remove them rather than add more.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
