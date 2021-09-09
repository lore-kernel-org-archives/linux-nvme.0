Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C64C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:10:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B0961139
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54B0961139
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=A8DhQCwDH9T+l9Bt/pevx+s1Zc2UcbNe/1bRsU9JQkg=; b=uPvxkkOkMnjwSVJMm6J4LaLDup
	QDY8Y6rPk+wNIAewN64DBtgHYmHyxUQhL3TI7JohS8eMXv5hY6dVqtVe9MkWrwAS84pxaBPiTbgUm
	YgF5ZtF7ZTJODW3IQrF1Kddrt82+5ng7KjM4CbMkVnREE58gZ93YSnjCYNXKXZY9b1bGxUnQMlyNH
	LJkkQkZjQar6NCM9549kqUDJyxiET9JkDGGSFYNtvcttt3asndQ8o481FhJlZjXfKexXuCcHizFMt
	0Vn0IKvioxO7xjQxo9ak8YX2YYI2wlVTpiS7mIrXRHgAJLjxIbXIQCZ2N9u6VSSch84Ja348W97hI
	ntRTQvUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOF7v-008XWh-6j; Thu, 09 Sep 2021 08:09:43 +0000
Received: from smtpout140.security-mail.net ([85.31.212.145]
 helo=fx405.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOF7r-008XVz-PL
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 08:09:42 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx405.security-mail.net (Postfix) with ESMTP id 297CE3237D0
 for <linux-nvme@lists.infradead.org>; Thu,  9 Sep 2021 10:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1631174976;
 bh=tJdtzYRS2SFGcKO4uwFZjx+rzvJHCE044jF9Om8Mb88=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=B9xzii7hoTtRD3gOGTP4wyHjbOcLrAMLuaC1QgGCcyM0isiA7S5Nq0xGk3XRdveiN
 5xpMwP7R/BDGRXdPkNMQE7hpXvRl5eD5A1wWCLwnb7PJ+5yzRYVZHBu3buKkGEEr0t
 iCEauMaPj6J0UZqnvnkHsvkKSzM7UiLzRhl/67gA=
Received: from fx405 (localhost [127.0.0.1]) by fx405.security-mail.net
 (Postfix) with ESMTP id CDC753237A9; Thu,  9 Sep 2021 10:09:35 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id EBE0F323777; Thu,  9 Sep
 2021 10:09:34 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D2AF727E02EB; Thu,  9 Sep 2021
 10:09:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BC99127E02E5; Thu,  9 Sep 2021 10:09:34 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 PMsPxeRqShr1; Thu,  9 Sep 2021 10:09:34 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id A839927E02DA; Thu,  9 Sep 2021
 10:09:34 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <915.6139c13e.ea05d.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BC99127E02E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1631174974;
 bh=45Mm5skaPU+f4WBgnUerUILgHJkt4yhN5rA2RSx3D6Y=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=oUWq+Aq55UflxAXRmo1POA8C07GAgc0w6Uen2W0yqU+noTMJyTAUdbDIHT6rki0m2
 o8HlnPO8XJe7ZJJgNsDkipzLQ0ud2BhFLGvVVeMKkkYHQf2KLoBl0oqH140h2PP8he
 UuEtRIlZSaANkNezeOPyyRIID1HCG+FVr+7IgrQKYPJziPjy9lwVjTV39Z0WOgQHw5
 0tb3RirKHtBAWmGgJWA5Qi0GQs7jy00YTEUpLIn0lRAOTcD2NBucb2PvZ1RI5Uc1Uj
 KboL2gXsaYoP0T9W3zitlHdKKqx8N5xcnOMk9LWwIMbCiapQLgcAtoIo9l1ae+8URC
 dW1laXP6VDMZg==
Date: Thu, 9 Sep 2021 10:09:34 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme
 <linux-nvme@lists.infradead.org>
Message-ID: <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
In-Reply-To: <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
 <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
Subject: Re: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Topic: Command timeouts with NVMe TCP kernel driver
Thread-Index: rrnteH2YMBWA953yI4tNA85/WQRCYg==
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_010940_614459_F156226C 
X-CRM114-Status: UNSURE (   8.06  )
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

>>>> Sam, can you run some more extensive I/O testing with this (different
>>>> patterns of r/w and block sizes)? Also Keith, can you ask the WD folks
>>>> to also take it for a spin?
>>>
>>> Sure, I'll request this patch for their next test cycle.
>> 
>> Great.
> 
> Keith, can you send a proper patch with a Fixes: tag and a descriptive
> title so this can go to stable.
> 
> And let's wait for Sam to do some more extensive testing. Ideally we can
> also hear from the WD folks that this doesn't cause any regressions.

OK, I'll do some more testing over the weekend and let you know next week.






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
