Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA6DCDB466
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6XFB5kge168cBB+v9VOhHeuwTfvbX5dEL0d3duanck=; b=kSzuE1FkVPyepmMuEr5DiIowAr
	SqN2fHw25Sg1aF7kysHBl69o6e1W5rOyMcNaHxqLUBvtyt5XUOXVHN22ctjJW8BAg3SFlWji97oW3
	CJFasbToY7ZNVTIcBwMhxAzyCrHPA3OfSBZrVv5EjjJl54wtbRZuXRCHiSlxKDgnzg+q+dJt7uPqR
	ssg0XCwaVOFxTFXxxdxdT7rTQkX9WNSAwgBH+jlOYutaolg2PgsS8HzbFZCrhhF/S7ORgMskB4R20
	vohkseVxY63qMVRzs51lYbEJWnm8CCSwQIvrhajX96Pu6DoPy0AbMvUJBZ0yP9QJDvpeN0Hnt50Yc
	08NqtpSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboOK-00000005Tf2-36ze;
	Mon, 22 Jun 2026 23:49:24 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboOG-00000005Tei-3Gnw
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 23:49:22 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-7ff6d33ceeaso49961387b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jun 2026 16:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172159; cv=none;
        d=google.com; s=arc-20240605;
        b=flPSjVmvlFhSSVsTkHiUDnh3/DLwQvIrr8PdPQHS4arQ1WuodQc4ZYThRFmscoF2Jp
         VaDPfF4BhI4kcQtB8pNr2GbniG8D8u61nwnhW3Hr5Jo2KBypZ+SfcclunZGSn2WagcPB
         7oSsREYu6p0790fvukpC/p/JYKSUepyJnRUvPvDRa9khH0pQGcEDaTZBbGxMi7QOnXTx
         wC+bYTAklNJtX1VI91IdfkSiQr962JVaeQdiSLld5EF8FhSwZaN4nRtIpZZQjfPdZKQ/
         tnjKYTg6JQZplAUA6r4Z/ZaUn6w0U7wecLYgVUOMgvTGpgBSIzduxh+nmMkjdRr1xA+z
         A8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p6XFB5kge168cBB+v9VOhHeuwTfvbX5dEL0d3duanck=;
        fh=e0HpYPtF5dnVvr0bdUxb1DJt5rA4ECdHOD/AkDgxpkM=;
        b=Wii4Yjn819zGrzM4OIjx0NBwhmJV9s6hP66WKDwZmqkUJIm639/uT95xZ02ZHL9S3g
         WNC9tgPUQvvo3dab0ZWl6n8kS9FtMV6ur4TZsHRFUja37quhu9c7bVUitqO6lLKbgUrN
         89CZgSIWmakaYZlPIAvZHbx7iN9CP5LdZtlMnVE9UBqJqk5M8q0KpM5CJnCI4BD+Mf05
         jJMfuaPocj/2uwlJcnOdWR+hAJa13p5JmKnfsr3YdNV920Q1YQrBQyyYK7ZW28K8Iogk
         EDAss1yuvVLzw31ejPVmZmX+VR/u5qK2puZsFleZrXzax8Snyb89Acf5IUBw37FL3yS4
         XKyg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172159; x=1782776959; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6XFB5kge168cBB+v9VOhHeuwTfvbX5dEL0d3duanck=;
        b=qQvZLWYh5Li2LcdNmRnst4b8xUTDQ12/RVX4y0OoO2S6p8PzT5E09Yvwya/66frrDh
         ZpAHmOlNtKsbscQpF+J/xPEmN3gpQT1OLaU5wzdt0XrpBBys4RZTACuNsbmWrMZdS4+W
         Uw87hi2UA+ZJhptdpts9KhgHJAKJVT1BA2x+rOW0gD5b/fcBmnc0FfbrzGN9QzeHMAmB
         zNLCkrgh7EaZY8nFcWzpHP0I+VEeCUOuaPMiCYU1bNPJSmtvIm9hQViutWLE7XoRz+KJ
         4tNYdvKS3sOFfpv1u7hdGMkCVMK/jR8KNrg3naLgb5+bBApvvJHFAESY7LtGyGdLBWAr
         r1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172159; x=1782776959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6XFB5kge168cBB+v9VOhHeuwTfvbX5dEL0d3duanck=;
        b=fswkIId5u2vFofOY94Zhkbc/+II6Hbh8bYfq2e4HZeN0vrJV45FzE+a5YU33D3JQ+y
         au3yz5Kmh8oGRNDqnuIeM/pi4ZKMBKRXKYj3jHR5pTk0ueHn6WW4v2Di8uJljYjAiCeB
         vx/WUPFyhliswnWDXenFR7nq6RzbrBXH+hfp4Eqgw29eZfDsRd1n2jyRGkcnlCuU8wcH
         txwQlUt8/uJiDCyR8WmFs+euLWns8+3G1NXxtBJFnXBKk4oEhJIEnwj8WYtQSUeH4vJl
         vSqm0Lll5DWtqLuyJt7nyHcFgACjqyk5Dh5jmdWm01mJr9oT6kMTLwqaf3rKLIOvxYuN
         HRLg==
X-Forwarded-Encrypted: i=1; AHgh+RpN+ONOTjkmeqpGfkXPmF4DQn/26ECZaBWaqautD22cGPBrQqDdKml/sMKg6ckh+QAMDiO8Ql0kspxS@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5dtiNkHU97F6C2sTSGFiPp1UKXF4fkb8BAwRhOLYd7Rg0be5q
	Q8blRPYQJOTiCE+1pJdV1kfDix4BjxrZUwSkYjYVQLbIfhw94tKLI4EddjDb1hPRMW5XgMrLxxf
	aLvtAv7Y+Cog+JzGZb4+jX086Cd8Ot1Q=
X-Gm-Gg: AfdE7clX6+U0aOVFYwfEe0bbqBZuUVsux6P568kuLBbuJs0xYE0Z2uyBlVK2hc+HNnC
	uM5O5rWDm6PEUp64v91FXduXa2iB/oFU4xWWlEYi+8a2wNmjywjOvgoumDJ/V8eyT7dlrz1li9C
	D10RlGdi+NxKgEvJAfcLn7pv5OrnONz2brijUQkWelj7OyqN6JdC+IlEXXhBnUhDaLi5+W3YyT8
	lmNpoawBBVtvxmIjVy0G5PiF66vyZOLRY6WbeYPK56NBAvbWkyM/2FAmuyhiKvceIvijdFduCc=
X-Received: by 2002:a05:690c:dd4:b0:7ff:13d8:bc65 with SMTP id
 00721157ae682-801336f584fmr183905067b3.39.1782172159504; Mon, 22 Jun 2026
 16:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260622232131.3718076-1-zzzccc427@gmail.com> <ajnIPsEIdnCZ8WBm@kbusch-mbp>
In-Reply-To: <ajnIPsEIdnCZ8WBm@kbusch-mbp>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 23 Jun 2026 07:49:07 +0800
X-Gm-Features: AVVi8CdW1akV66HDIb3eMihgR9O1gyrU95CUXQk9e1IEsV0Yo002EKPlqT76uNw
Message-ID: <CAFRLqsUe1frE_HMi0yYUeYvm4Ppwx6g7=o=7zhD4fs4gKdah2Q@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-rdma: pin device wrapper in remove_one
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Steve Wise <larrystevenwise@gmail.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_164920_820248_0FB1FDE1 
X-CRM114-Status: UNSURE (   9.28  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> I don't see the point of altering this loop to use a tmp variable.
> Please just submit the minimal patch diff that fixes the issue without
> introducing unnecessary changes.

Sorry, will do.

Best regards,
Cen Zhang

