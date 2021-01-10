Return-Path: <SRS0=Xmhu=GN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8472C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 01:33:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335C423715
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 01:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335C423715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S6OrZhcX/5VAjoaXj1sWItTW+x5Fc5kS5dHu1/7wXgg=; b=iXDAkOgtFvo086eGp9x1YHOlL
	1HG98oi+CvnA/PE7ZTaBNJ/9UUob1II33orzCXAl0QYKNPvz9i4JSfN6wjyZWI4dbfPBTS6zsaEDp
	XRRxYvMsn6aCKRUz/pFzwbR/p09j6dLSQjFZNQIyeyJfffWth9LfOR+LRfjknjd/MNKOoL9YHGnNC
	VwavkBq0LhBIAxbYKmeHEhHaqrImI/fUepWMetkRqkt1+CXWpDKxGu/zQw5b3Ep4kT5LV4dW0sl4b
	LwpxNkLKFRpmiJJT8O+GVtVe97tE2g5cx5+LwFewp5vIGVdk1DyTqU3ewaB5zw/AHBoP/sNlZaJ8y
	W3XS69vUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyPbj-0005fF-Qo; Sun, 10 Jan 2021 01:33:27 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyPbf-0005e9-Qp
 for linux-nvme@lists.infradead.org; Sun, 10 Jan 2021 01:33:24 +0000
Received: by mail-pl1-x634.google.com with SMTP id s15so7641097plr.9
 for <linux-nvme@lists.infradead.org>; Sat, 09 Jan 2021 17:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wWO8jhhNyLOacdDRAuU4Yd5s+q23iUqhz3X3JZq4KIk=;
 b=pzLv/69ns72Ip4ZEQRLsCgSe5Ml6g9E1utpL/DfDg0UKIWPm4XR3wpfBLq0KdYrNDs
 Vgx6BxPFG4IVDbKDCRUh9S5yLfTzSzo1PZ1yn2AY77B0BR80ifD82lq093f0JAjLDquU
 p8qAdCiPoe/pBy5Nu7ckLAtClaD+tnNHm+SvrunU9ynhWAUTXF9K82y1R3WL2uHuE5cQ
 1hH4B5nIBNfqqksCr+N9E3B1n91j0cQRqPOGNaCJyGYmhQFDf4FFfS+i5Uk5kEdj/caS
 fgUFEDcCU1Fr8SvOznaERsVXKc3a3I8F0oAthr1jb15Ila7owMdl3xn6pcHVQnbKmt+4
 tIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wWO8jhhNyLOacdDRAuU4Yd5s+q23iUqhz3X3JZq4KIk=;
 b=Ts8anBPnufQv2VdgANkiLBj+FITp9KZd03jpTnh/7v222gsKU8dPevB+UvlDrEB0s+
 xtenRHq1oGr0ahc4RggoGeDQW2GWSqYpGe7pLN1NYpD1M8BqCPS0KEWouhcB8XzNwfC1
 ecWd4+Rx/VyD8vggWyUhyGeiCfGvsg6aHEAjnNURnrbIPYUx9ujWyoHRgBEAwCfZtytd
 AXXyA2ZwyxhVtlIiN+1zmAFDsLqyo5xnGsrCjvQPj/JbAP117E1Y58t77AWOUU1cCj++
 2SwGWyOj35lRy+417GfVa7hzJ9bIPgOtmJtsG8/8LxU+2uysVuv3SRzQBgv6QYxakA+Q
 OyYA==
X-Gm-Message-State: AOAM533BOximToMB5GLSDiVJJVyqkI7EroRrSJ2xUg3jnLYygYXZXswt
 LYH0sbD+A0NCqjnWRl0EjEw=
X-Google-Smtp-Source: ABdhPJxcKNjCoKMNS8JVLrKhUKqQwGYaH7U+Q2G4rmmTuqfafJZ2elEXqzNk1tlOF8nvotfm/VLRkA==
X-Received: by 2002:a17:902:aa45:b029:de:2fb:995 with SMTP id
 c5-20020a170902aa45b02900de02fb0995mr8463438plr.81.1610242399648; 
 Sat, 09 Jan 2021 17:33:19 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id s7sm9175076pju.37.2021.01.09.17.33.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 09 Jan 2021 17:33:19 -0800 (PST)
Date: Sun, 10 Jan 2021 10:33:16 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Message-ID: <20210110013316.GA4369@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
 <BYAPR04MB4965078A7B0C75B03D342EFD86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965078A7B0C75B03D342EFD86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210109_203323_903548_4AD39AE1 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-09 20:34:11, Chaitanya Kulkarni wrote:
> On 1/8/21 06:54, Minwoo Im wrote:
> > This feature can be applied not only I/O queue commands, but also admin
> > queue commands.  Admin command during the initialization may fail due to
> > some un-ready state of a controller, so it would be better to have this
> > feature for admin commands also.
> What is some un-ready state ?

State that controller is unable to process successfully command as
"Command Interrupt" status code represents.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
