Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D090C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 09:47:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2576103E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 09:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2576103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=89+g+Zu8Rd91b4GxoHHRV94Ch4je3nwryWH02kiMGos=; b=PvHTC2Q3yCdi+LmYNxV5IXD4q
	SvOPp/sZCn++495RSC2CNEuf7tBNoSYJMNsD30rMxpMun73Y0U6KZOA2gDUbgAJVTrr8yVH/i6Kqh
	Y2bRbIPwghvOpI7JugkpW4eVTX9rANtzj/gsav8/+jRDEmDAS7FZfXKOgvUIin5AN5XX1A82qDEuz
	v+d4EdX2PS0nnpvrRvEKF+a2DQSqH5JQYhQt+EoR35cCGvHNSKGk9Xh1lGGV0VuljADRi7L+YfEK2
	Cf3IKOXIO1pSIvrQatKr0HrwKyRsiqQVO0LuhtQEY7//pXa+RQ7KspUMiHUAnK7gU0YnHcQXTB4OX
	AFsBmkHjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leabG-003rdk-Du; Thu, 06 May 2021 09:47:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leab8-003rcH-Fe
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 09:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=3LAYgx+8ZfxOmheXSt4NnpINueokxBYkkZeZX1Jy0lY=; b=Ml10O0M+xRdfzIFdV62BoOFd3L
 7lcR1t51tzS3dOtgYjv++CFeHe4DuQYjZAS/3O3oK83N9AUEfQkN6OOy4lOVQ2IrMRUcZpwAJkY56
 jcCsovvaviN7uUbCVL+n6M50YQLiY8c33UdKYkUubcpqdQjl78lAbNzcyTMdF21xJvLdFsxa7Bprt
 LDNzw9lQPUOEELesfT7NYto2eFns+lQsLfSZzYpMVmRnLiOovnJe2aDlS46WITwbZzC5wbksWBWUu
 EIW2NxtG7qnfaHPw0HgpQLlibMW8XnVBS1ipTBou09l4RONPuow/hltO6nT/4emD0waao8djZ6PR7
 lo8fw7SA==;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leab5-005vL0-Qx
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 09:47:09 +0000
Received: by mail-wr1-f48.google.com with SMTP id n2so4936335wrm.0
 for <linux-nvme@lists.infradead.org>; Thu, 06 May 2021 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3LAYgx+8ZfxOmheXSt4NnpINueokxBYkkZeZX1Jy0lY=;
 b=Ydcn/PMsE3E8Mvldma6sS59nftIjQieNGtdX5Luw7+9zUAFG1vjJ9+3zmMxyIbIPWC
 CHoyLO2I6OuVqfUrAJIIIQZ41CVwWqUdHXSUbLOck7FiGCW7vquVmCg6jBT8kN/6nfMS
 2Oa13Dqlc56Wmcikw1dfO41F+SSOAXQknIdrfERAL+QzFbfxJLE6ebkzxRD/XgpiNw3P
 gr7dmwb1qmZ2P+W4VvpNVVWmRzVvQm+Qabp5AVpjiBkl+/BFrGtnGgrQiU9W3A2pOL0Y
 NvTGkWevtaTMf5TOPQrBQohAXTg+xfpeQD4MPr7U/x1DH1ySXxpLUfNiIQRhF/TWjeYw
 MMeg==
X-Gm-Message-State: AOAM532XoA5TRNQdaPKTu+3+3pmvmwPnqx2fvHJy6gu/3qUjJaxzXPBl
 b1CtTBtaWlV5f/nCyPaUzpRG7y8nhUY=
X-Google-Smtp-Source: ABdhPJy9kiII8cwqrUJ4zgPmd9bWR/UxZZz+Mad4r1cEF5fGAN3cQ1L2dqAycs4ViP31K2ABcEd2pw==
X-Received: by 2002:a05:6000:1566:: with SMTP id
 6mr4003948wrz.157.1620294425822; 
 Thu, 06 May 2021 02:47:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e504:8c1:c1db:d524?
 ([2601:647:4802:9070:e504:8c1:c1db:d524])
 by smtp.gmail.com with ESMTPSA id x8sm3284674wrs.25.2021.05.06.02.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 May 2021 02:47:05 -0700 (PDT)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
Date: Thu, 6 May 2021 02:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_024707_900061_FFE1FF0F 
X-CRM114-Status: GOOD (  13.14  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I really do not think we should change the mpath behaviors years after
>> first adding it.
>>
> 
> But only because no-one ever tested MD on nvme-multipath.
> It has been broken since day 1.

That is my assumption as well, and its a problem that by default
a pci device unplugs or a fabrics controller is lost and removed
the stacked mdraid on top stops functioning.

I still think we can fix that by changing the semantics of implicit
queue_if_no_path and restore it as an explicit opt-in.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
