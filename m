Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6719C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 07:45:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5260560F6F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 07:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5260560F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QbHvmM2Ryv9sdGhC88g3VenqGIJvon3sAVNa4VM/HVw=; b=xvC66iunf4z5TgyvLQ+AH+1kl4
	4epfCXRKDhUFDlQ4IUZlfR5b1INBRdj40zG6gXVOjDev86Of3TJWQp+S2Ahsp+NqgfQ15rjda8SXB
	2BuAryRYc/j+HPZWYyyePT7baPaXZK7lWVW52IXlIhmp3c87eKtkLWc6lAeBmGjUwZgZkmnASayVm
	zA1X4JkrTSxRNlnpWV5ysGnfbxb0U43+1IG/ee4XjSDP7KSov0unZk404E71+ic1JVwx9c1SEjqDj
	PO6LB/vlCUYPeyQ63bVZQhqyXWlhW3+6vNRlQ5YoiOpuqqvbjo1kUbo0farsdLcz6MC/YKZs5P0fA
	OZjvEdmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPgdq-000Y0D-VS; Mon, 13 Sep 2021 07:44:39 +0000
Received: from mxout.security-mail.net ([85.31.212.46]
 helo=fx303.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPgdb-000XyI-QV
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 07:44:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx303.security-mail.net (Postfix) with ESMTP id E73831C3248
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 09:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1631519056;
 bh=ndKz2VboEpXZ4I3OUBjRjJ8B6A4KaIT/GQHDFRxgXpo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=LNvPu2dA7s6MepuLF7G7wOUuxoOfn//eCBH4uo9Ii1PqOSC80CaovsBkSsw+Y8gy+
 FD63A49/2pr5/oh0PZp9CgDgvAaFkE1B0KgtAGjvgrvkqYsTWTXCbv21upRlMehi+K
 W2DcBQhHem/eWL/7ER77SZ4mi8iEr7KFyKX3IEV0=
Received: from fx303 (localhost [127.0.0.1]) by fx303.security-mail.net
 (Postfix) with ESMTP id 8AE8D1C3241; Mon, 13 Sep 2021 09:44:15 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 0BD991C322A; Mon, 13 Sep
 2021 09:44:15 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id E95E227E02E8; Mon, 13 Sep 2021
 09:44:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D1A3527E02EB; Mon, 13 Sep 2021 09:44:14 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 xYFFTW1goifB; Mon, 13 Sep 2021 09:44:14 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id C1B3E27E02E8; Mon, 13 Sep 2021
 09:44:14 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <12a4c.613f014f.a543.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D1A3527E02EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1631519054;
 bh=sBbc7NExqedTCd+YINtse58u/Qj5toEqrOlcWyDqrxQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=rNnFI4EPAgEmHkKP1fFW7zeqriH8vw+0DKkyVMMK54bJWBXCUBgCWIM80WZCTDckL
 dtri1l9lhZGUzw8XbfGt6IWmaXuqdIzgo6DMyJtWbcxOi7aB3RzdBphpeTZpyLk9vV
 Pdq86s3gidZzdlG0Kd1Cjm9ejN24fGPhzJdAdErdKqdfDSMnlhswf55th2YYtR46NQ
 nwCE0S4sjxxfk96bwN3098Dp+kiOoCJTO3VrZciHkVs5DSMLDFrBDjHGCFD2olqdQ4
 EcdpNlomIEYcWyJ096QmZSv5tXec6skSkAi+G9YcR2p7G+V2u4FpVvMHW7/IaLxdci
 Dr5kD9x+NH9Hg==
Date: Mon, 13 Sep 2021 09:44:14 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme
 <linux-nvme@lists.infradead.org>
Message-ID: <1387247003.6552417.1631519054752.JavaMail.zimbra@kalray.eu>
In-Reply-To: <7e313963-b377-74ef-2fb2-650e15cde2e6@grimberg.me>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
 <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
 <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
 <7e313963-b377-74ef-2fb2-650e15cde2e6@grimberg.me>
Subject: Re: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Topic: Command timeouts with NVMe TCP kernel driver
Thread-Index: fphYJJOSOcWKI1NHAeT9EQnHz8lMKg==
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_004424_762572_D9B4B78D 
X-CRM114-Status: UNSURE (   6.35  )
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

> From: "Sagi Grimberg" <sagi@grimberg.me>
> To: "Samuel Jones" <sjones@kalrayinc.com>
> Cc: "Keith Busch" <kbusch@kernel.org>, "linux-nvme" <linux-nvme@lists.infradead.org>
> Sent: Thursday, 9 September, 2021 10:54:32
> Subject: Re: Command timeouts with NVMe TCP kernel driver

>>> Keith, can you send a proper patch with a Fixes: tag and a descriptive
>>> title so this can go to stable.
>>>
>>> And let's wait for Sam to do some more extensive testing. Ideally we can
>>> also hear from the WD folks that this doesn't cause any regressions.
>> 
>> OK, I'll do some more testing over the weekend and let you know next week.
> 
> Thanks.

Hey,

No further issues on my side with this patch.

Sam





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
