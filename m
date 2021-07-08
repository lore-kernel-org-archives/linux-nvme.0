Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213EC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 19:45:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B653161625
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 19:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653161625
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nkvelZh1g9dEQSi6I9iF+Tf3j6xc1YhCwqQ+Me3LnQ0=; b=SLH/o/FAEaf7Wo
	zs4BN9XoSu3oS/RmqfVMVQmQNncxBE9Gupgm/KlCPRFPrXP33cdLMP1IvwdJZLeV5KHTPzx1GdfF1
	0PQAnBs8kqpP8pXbtcuzqrFhpStctgcpupmAifb8RVRi3Rui4N58fwS2spCELw2Mdn3vf/N7XVV6N
	7WdQotZjsdwStjuhuYqcN8OUubHoBpe/EsstFCvkLdemQPA0oEba9Iq6B95XxC9oEhJe7dA+Gl5DO
	IAXnLsb5nBmAoYH/w0T8IzzZoQuK8yoV2ac+EU+pe7M4lCb2QuEGsPmo5ddKfb5rMCnrxqNDVW7gz
	gPc53QPyKpePMWYqP4WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1ZxC-000CRY-3K; Thu, 08 Jul 2021 19:44:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1Zx9-000CQx-MB
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 19:44:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFF561624;
 Thu,  8 Jul 2021 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625773494;
 bh=t13vCO0/SpWGdCqeb8vf8K/gufVzDINp8gotXwx1WPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gVpblUEUWY51YE7c+BUFPZO4YhfZELxCm8HXkD2RcnNIIsQFIvB1S1iKiGrdtv8hE
 L2zPqr8q4aZVc7mKYrMD9zr6Ck/Ajz/K1xHluOgd2RmVxiafZawFsRYpx3VIoiFeth
 +N1JfTnggySXXkaSrgkC7AUW465LdGeEerPxLvpGph6q2j/yW7osgPLJ5UecdvbM14
 FonNILYXW72EbgHt7gFrJxsrNtSCxSygS9WqfNIBDIkNepDMOf2xspzQJNtU3Bqvtu
 cMZtVVbvipxQ6G3gJks9o2/UezhsroDJHnboXFeiDM1TpF82uQEnAnEjUYiX8s8Tx/
 mqcqJUmN7ibsw==
Date: Thu, 8 Jul 2021 12:44:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCHv2 0/2] rr: nvme-pci: fix races and UAF
Message-ID: <20210708194452.GA289335@dhcp-10-100-145-180.wdc.com>
References: <20210707211432.29536-1-cachen@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707211432.29536-1-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_124455_784482_6BC1C99C 
X-CRM114-Status: UNSURE (   5.06  )
X-CRM114-Notice: Please train this message.
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

I have reviewed the series and it look good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
