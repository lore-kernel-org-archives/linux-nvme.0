Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E0C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 06:31:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF69861447
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 06:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF69861447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aSQo8lYgJBEDr9P17Td1/YuQLV2CVAp/ncBDvKEic9Y=; b=LtG3YjG8mSo3wR3WxFbUgI9mj
	Y9TZD59QQ+FQKD8MQR3WcM6WOvLfhQXvCBd5hQ40QPK8FgR9TeIUxYes5g68+rppYl1LSFvJVdVMl
	TKPY/gobsLE7ndSgM7338nlb0FcEjbaFwqod7B5zd6DKJHunh/i4TxfIQh7E/aY+qeNk2uC39uGLT
	jesanI7Kpp8MHSu1rr6PqL0Ic7E9Dzn8PosEU2qsuBK+QOZSLmXDFAJmigQtNG2RSr5Dzf7MTFqOQ
	XtyKf32y8/eI+f0H4q8XLzpb7rra2+/72vxslxR5J+l53wvLBu234MFRtSRaZ5GxAn0ouc5j69C/S
	ipuuFzmmg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lc0Cd-0055GA-P4; Thu, 29 Apr 2021 06:31:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc0CX-0055Fx-Rq
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 06:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TuV0OH3UmGFFUoYWMU2bzeNhNGrvf8bB6Hl9WHg7gqs=; b=0OeeEV0t9iu9UCVSBAeclBc/ko
 hn8y9EDU2vBfjfdaWOs/UZdT0knYvCuVg8W6l8+UNMyPnJ6Xzb76aNzfa0lRrO2fUTE/kEpMKyBmB
 fbIekXeXvAg8MBMA+cnTuDwFk/GjJXhHCe9Z5RNjyqp0lOZFFIpuL/8nsG21VQb5LfDxqUa4A1yFW
 dZS1jm1uR7fXsmgxTlDxeC29D864Vb2k9kAnyvXIzuU2SlwN4mfYTy2ETOBGugBUWYay4b54g/e9g
 kYbztWuiDhVvfg6/UtlYRrGKwJzsf2PsDgY2lXOiMEkEvlGSYilfqw3JOFjXA2PGyDZ+8Ir4nTYlc
 MCNrIX7g==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc0CU-000PVX-U3
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 06:31:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5A3B467357; Thu, 29 Apr 2021 08:30:56 +0200 (CEST)
Date: Thu, 29 Apr 2021 08:30:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>,
 Martin Belanger <Martin_Belanger@dell.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Message-ID: <20210429063056.GA2482@lst.de>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_233103_157982_401276E7 
X-CRM114-Status: GOOD (  15.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 28, 2021 at 04:18:25PM -0400, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Generate uevent on NVMe Async Event Notifications for NS_CHANGED and ANA. Today
> the uevent handler is not capturing on NVME_AER_NOTICE_NS_CHANGED
> (Namespace Changed) and NVME_AER_NOTICE_ANA (Asymmetric Namespace Access).

So the problem with these events is that they are only really useful
to then issue the Get Log Page command for the corresponding log page.
But reading the log page will clear the contents of the log page.  That
is if userspace races to do this first it will completely mess up the
funtionality in the kernel.

This is a bit of an unfortunately design issue in the NVMe protocol.

Maybe you can explain you use case in a little more detail so that we
can figure out what we can do instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
