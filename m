Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:16:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23B220719
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I/DshtFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23B220719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=03DtPGcPjE1rg14DbolIru/rUnJNNNyeNK/TrLOI7Hk=; b=I/DshtFld+h483Cpl9w3zvb6Z
	gFYwNmTAsYqO/gIXp0lHIMCvqNTGQ2/5EUZUJ3w4C0BTtorvUSnvSb58sf2uHFvYZ+HT80N1AVQOo
	n2AfhTLl0Tq3xaZEM8j17SXkLoR+DIyJt8U5wEnmX/Bulxa47JxngUyE4YpgUPPSSu0T9Bl2SFjEJ
	7CCiuW50DkbO2w9jDpwZxVTdYizY/n7UeR9IIIYzp/PWqRnNgi8KJXIBuura1yZQEp/BE8AuIsH0M
	u8ZVB6+Xsfy/CjfheKdH4M80IVW4NafH43OBnCGnYL4QG9FxZQP+hQgvldjP8sWz82cYxt2UaP2zj
	CCUarRq7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb2Xp-0003Qc-7p; Fri, 06 Nov 2020 14:16:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb2Xn-0003QI-DS
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 14:16:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D24DD68B02; Fri,  6 Nov 2020 15:16:45 +0100 (CET)
Date: Fri, 6 Nov 2020 15:16:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V7 4/4] nvme: use consistent macro name for timeout
Message-ID: <20201106141645.GC23884@lst.de>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
 <20201105232832.21216-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105232832.21216-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_091647_585693_560E3671 
X-CRM114-Status: UNSURE (   8.70  )
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

On Thu, Nov 05, 2020 at 03:28:32PM -0800, Chaitanya Kulkarni wrote:
> +				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0,
> +				      false);

I think we can just pass 0 instead of NVME_ADMIN_TIMEOUT here now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
