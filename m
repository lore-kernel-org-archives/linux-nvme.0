Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7AAC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:55:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0565B206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFC8IPxy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YJmx2keG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0565B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPnBv5Bl8tZRD0A6YlgCgTUyR69dryjSHh7JY7O3zGU=; b=lFC8IPxynybaKOEIRTNvr+s+I
	VvGUKinS1MYCCNLsemTJbu2XB1yz6i2oHUjfaeosolhLFzXe5kXpwQK3odaLnhRT0y7qexJ+Q9vNG
	n5+XUYbs8nEZJb+A9XOlJysQqdfQsI9x2VQI7GqIbe7/3+V/5G5VelYiycli3vsDcjwC8XXVTVW9k
	2kh7/7TaGWfZPW2Z9zwxgu+2ZX+Plj2lBlvG3MWtwqgTdeXtWQLYK+OJeBIoPUtmL1A+UPYwZuCGE
	o3tVrM6r7tfm3keAanktw1cfM7QknwK7fF6GHdlj1np9iyov5giHe8Gg6mbUq6Kr8NQduGU0LVG7N
	7l6nxjCkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Flg-0006XA-VG; Mon, 10 Aug 2020 21:55:45 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Fle-0006Wb-Qg
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 21:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLMQ5W54R+zR7mnnLdnYezB22vo4WDqz1MCUO3bEKtQ=; b=YJmx2keGIYnasYWqoV3KeGA7B1
 uW/x1blpRs0hBlDHKY8R38JA/FRzW55U4LAb+x52FZcI5FuoG4w3g480QNxNs1hepXOAm8WVl/rZ5
 sMwR235wlmKwRz6SSZ/MrC6P5qBGuKECczL776YOVp56im/CJD0wWiSzPlS2jtJzL+/ja2RiQHpbF
 HQKPSkmNVdfcZvBTXQJhnc/Ymw0MDnn1a/usnaiF8mx7JYrVwAcMYB6Wj24P/0w0WeLYl5kx4Uc6X
 pBD1/XKBkB7V47eniOxZ6OxIypN73BJ2Vnjk7OJKWVgdyEoQ4DOncYcSvFAoxF2dUbx9pZSRZHhIf
 SQb8ot+Q==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5Flb-0000BR-An; Mon, 10 Aug 2020 15:55:40 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <31ec987e-edf7-0f02-4edf-de33c9c6d533@deltatee.com>
Date: Mon, 10 Aug 2020 15:55:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_175542_928400_EE166F57 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> In function nvmet_passthru_override_id_ns() while iterating
> over namespace lba format loop variable is declared as int that is
> inconsistent with the id->nlbaf type which is u8.
> 
> Make loop variable of the same type as id->nlbaf.

Why is this an improvement? Seems to me a loop variable should use the
fastest type (ie an int).

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
