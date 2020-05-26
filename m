Return-Path: <SRS0=Hg5O=7I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C96C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 19:45:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88BB2086A
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pjPvPT1m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBef1ux4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88BB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z7UyAJMJ+/ggdfZcxf4rnaZ8fg0WFtFuIF4Ly4DD1PI=; b=pjPvPT1mFmx2jL
	gT4ssw9jHonsdksoi5Z76PD27TnY5g8g16mzy75rtxuzN2GNBp7DvUOy0aTJxg6dJisqqAXktdMSJ
	3tI+04bSpi/cpyQhPyBLS9iC6OlfwhfXP98W0yKL0pgX+gvWKsRO/9BEqR08neq5iwFM/0cHboRiW
	vzMr1igEj36pf+Vjyo3kWtKAqOUh0iJ9kiCV4UKq8/cVJI9jzQEA6pjaWYN+mUvIckIqDXmPBEnHz
	wfzF1l5d6WikE2k46QJnr2NBl8/w/9xaXseNLj1gswfFP1BnHONkv4jgooLlg4w2/CGHuMM6bEHed
	qDM/3oZSPpQk3qopIuAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdfVU-0006KI-Nq; Tue, 26 May 2020 19:45:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdfVR-0006Ju-UU
 for linux-nvme@lists.infradead.org; Tue, 26 May 2020 19:44:59 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 030B52086A;
 Tue, 26 May 2020 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590522296;
 bh=yoFEZymRM/om2uVZpH37wTMiTh5QaVDYJIRCNKs8Az8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SBef1ux4oZU7dWJRDgYPfK/taa6vb6WaxT6vnaru/2NLrUKh9P9J5D3Z0AMO08Rni
 Cuusb+cqb36z+e0MMdk3sPYLvO7PcKysew5fDeNaTT/IOEESc7gz8oaly3uXIuEWPg
 CesLHh31gW+pSE0gXA3/l00gyjw30yWdoYEBmVAA=
Date: Tue, 26 May 2020 12:44:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Zhouhua Liu <liuzhouhua@huawei.com>
Subject: Re: [PATCH V2] nvme-cli: Add huawei vendor id as filter in command
 "nvme huawei list"
Message-ID: <20200526194454.GA3429867@dhcp-10-100-145-180.wdl.wdc.com>
References: <3a4b9e11-c653-2d81-98e4-09be9b0ab584@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a4b9e11-c653-2d81-98e4-09be9b0ab584@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200526_124458_001611_84CAE86F 
X-CRM114-Status: UNSURE (   7.81  )
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
Cc: Kangwenhong <kangwenhong@huawei.com>, wangzan <wangzan@huawei.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya.Kulkarni@wdc.com,
 "Wangchong \(Michael\)" <Michael.wangchong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 22, 2020 at 11:40:40AM +0800, Zhouhua Liu wrote:
> This patch V2 is to add huawei vendor id as filter in command "nvme huawei list".
> And comparing with the last patch, I have remove the symbol \ to comply with coding style.
> 
> Signed-off-by: Zhouhua Liu <liuzhouhua@huawei.com>

I've hand applied this with a more appropriate commit message (no need
to mention version changes there), and fixed tabs/spaces. Thanks!

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
