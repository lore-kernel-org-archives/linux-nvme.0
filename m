Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBACC2D0A7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:47:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3282064B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORD89Gx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3282064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KW23iPD71rYA02KbFsNGLTeRnmnIe75x0u3/x1efz3k=; b=ORD89Gx5DZWmZA8wfDFnu7J3I
	Xn+/wJO+VeA6MbZ7P5Msx95RjZo7HsmKIBo8b4d4T4JSP9xpEHHOmdslLNRnz4Ddoj1He47C11urU
	7nTf4lOf2iBrCrH0hMotI34Eg4mQkpJAkEeOe7ibb4Jjbl8PYLxMrOSZSzoGVy92MYspWtVS9d+wk
	akRdpRChgRdYa1S0276TG7yN8FL/8VQzZomlScGHOHMK9pGcN2TtxA6zByRSkfldf8UjUsfO3GepW
	EitnG6bsUlw2ZbpcyVhVGuJOUhv3ZYPPj/aKCwViALC9lMJ04DiXhO3QnA1c/K+4on/Vbb6ru2mpc
	l4XVBSRxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFhia-0008Br-Dh; Tue, 08 Sep 2020 17:47:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFhiW-00089r-K4
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 17:47:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0BCEF68AFE; Tue,  8 Sep 2020 19:47:39 +0200 (CEST)
Date: Tue, 8 Sep 2020 19:47:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v3 0/3] nvme: cancel async events before freeing event
 struct
Message-ID: <20200908174738.GB20285@lst.de>
References: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_134741_194091_424C917D 
X-CRM114-Status: UNSURE (   7.79  )
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
Cc: james.smart@broadcom.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied the series to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
