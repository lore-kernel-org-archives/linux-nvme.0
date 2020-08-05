Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 15:29:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D422333F
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FdG+77ue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrOFPPKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D422333F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fh04Ke5X+VaEtq7qM3kNaN5IhmQdD754wAN+TXOuitM=; b=FdG+77ueQozd/Oxn/qnEfCzw5
	1/aj9tlEiik4cXSWYiAC14sPR9gA1GhdB8N0IR6rBcivFI2PsXLBAon8Xh6TIawSSoW2UKWIdCGX4
	jgxwxiVL5N0ee2owJxFyViVfe4uPViT2saGZ3glfMvz/I23wP1IXb7UVeoZGLFgxmrdvdHr0qjz4B
	KDuR+wXwcO7qIwqL3j7+yndHvQMVBVG9JcFU0VbvohJBADgioEYdr8qEf1P9iFAgB76SPgjI7kDvI
	xRYUSHXi0Ak/z1ntfW7el0dXRPOEchfdm0Muv3f8BOVxRCifK06J5wy1jgoNV+mJn/sprFASDc1+s
	0IQE5ZM4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3LLu-0005s8-2e; Wed, 05 Aug 2020 15:29:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3LLp-0005rm-Oq
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 15:29:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D8472333F;
 Wed,  5 Aug 2020 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596641347;
 bh=v/iw7HLgHxwYY5Yh624RA13nvCiamSNuF3DRtjijYo0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TrOFPPKpwIn9yYf37A7p8tHbJFUPh/iu9lPOzvDTGVCnIHglpFhhR8rhPwp7AEpph
 bSNJf+n4IMvZm1gKB8XSXkrKdocBkA5k21mz1KsGE/W/c2Gq9nZRyYqZQrJz1/mcFU
 TVWeVuaed0jjeOZ3SkFE4vc/p3g04xt0ce14rS6o=
Date: Wed, 5 Aug 2020 08:29:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Message-ID: <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_112909_989261_7FD24E26 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: linux-nvme@lists.infradead.org, John.Meneghini@netapp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 05, 2020 at 02:40:48PM +0800, Chao Leng wrote:
> John, Wat do you think about if delete translate NVME_SC_CMD_INTERRUPTED
> to BLK_STS_TARGET? Thank you.

Perhaps BLK_STS_TARGET should only failfast for REQ_FAILFAST_DEV rather
than REQ_FAILFAST_PATH.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
