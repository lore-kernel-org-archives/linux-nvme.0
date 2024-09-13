Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E3EFC616C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQlndyxNz0y8p4ktDTL7mO25tUCvrQgrqDCIL+ty3SI=; b=HTbtwpGhS8VlGJjNazFgClzPUD
	KpOhbDCW5SQ5sab+yc86cqU1CTVzpkf0pHf++eENgNEmLEp4LKR/KuuHaFqjH/SdO36KP5IMhaAZe
	qv0T19M/NHNeP/uiw3ZVCuOMpo014CNnZp2iTEQnpGwt9rgfIZ5UBcO53yFNWa6Fb+h9NfHHFmFgG
	wfgZc2Byo28EDVJLHcfhG5rk2L4UANX93+UCKxULA7XWIwktmNxJfXJJ2pf4HtuIUQn9bOKOkOg4d
	o0yyhUtALLXkASzhJFrrsSA6Ubd9jYRkKKIdY/i9M4UylreXzrGdZXIavQe+1XwYzP3/CIbGC3OfU
	f8AFZIIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spBB7-0000000GpgC-21Fd;
	Fri, 13 Sep 2024 18:37:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spBAF-0000000GpZ7-23YI
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:37:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726252621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQlndyxNz0y8p4ktDTL7mO25tUCvrQgrqDCIL+ty3SI=;
	b=iBytsmr7yqpGd/xBsJFhD+zCt8i2s38YC6wuh6wLZQTLWd7YBl/75kHRXmkU+rjnHa7c3h
	O3hAK7GbPq3doQJGdYUdVyCzUkgakIar7dovgX7VpZxZEmVXhw4RkYj1qPgnVidNoYmaUw
	XKCNCAsdVr6tpQBPy6X1LMgKDawycTA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-egxBN4JaNr2NYwEAEupFvg-1; Fri, 13 Sep 2024 14:37:00 -0400
X-MC-Unique: egxBN4JaNr2NYwEAEupFvg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f756c272ffso16549681fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252619; x=1726857419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQlndyxNz0y8p4ktDTL7mO25tUCvrQgrqDCIL+ty3SI=;
        b=HMswXBPPKVBIFJzA0p0s2DztQG3njIMVqj5Ubc1xYgw/waws6WqLP/VpH/Znf7vxfF
         oQe7p63Vi7AT+fu3RsFmWB4OrOLyYc4SHEm4W3u8W0YCCembZhkkDG3w5W2Viztip2sN
         6au841TUr9nRbo6Id3cSFB3wPuCGUm1U0g/lqmzndCIuxNg1Clwp8F9ObMk/RLLDJUZI
         Qul7HOafTvQV14y3f2Jnvvlsn8if9WDqgXVXk/O/MitNdsM1c2bpnBGE2cRQfJ5JZhF+
         QDgN7SMQPxYS4mrfTMdKBxVYYIjx1ZwvRvjGcj4GDeAvCpUnLnn1TnDVQex3NtvoIibu
         CXlw==
X-Forwarded-Encrypted: i=1; AJvYcCVpaWRx5TBVV81LVGlrblain6VOdWFFEt31pNZtl7CM2R8h5s5Qa9FZk06xZgu2KXA9lTeqsTQUxgUH@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+6k294Mtm+DFq3lQV95QXD+tMUmT3/BbwhcasaF3fVtBC34cM
	b5/zgrW1aNYZK0r+8R1lu4Ljd0qmVGzMqFp7Bp/DDZhCLrGeXEBk56vpiTw5ACPd2PCIp7YmnaQ
	o4c2yKvOUkJw4LD2tL56f8W7EmJ725LcWd/fU6wbiYmmM+1+S898va7rt7kAtAMeJJS/iq5szT5
	ANGikiCev/tyA2o/OHhwZc/OMXhHl+hDmMcVGLFpg=
X-Received: by 2002:a2e:8813:0:b0:2f3:f690:17f3 with SMTP id 38308e7fff4ca-2f787f39bd5mr36982831fa.31.1726252618515;
        Fri, 13 Sep 2024 11:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWOXk6BISYleH+3FWtU0zJ9i5h07oRhVxBWwk0/i1El0Ro4NeQShu2og3yppqgjxyDBqxli+6neIh9KqGgisE=
X-Received: by 2002:a2e:8813:0:b0:2f3:f690:17f3 with SMTP id
 38308e7fff4ca-2f787f39bd5mr36982491fa.31.1726252617304; Fri, 13 Sep 2024
 11:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240913134430.5416-1-djeffery@redhat.com> <20240913134430.5416-5-djeffery@redhat.com>
 <ZuRXc8uj7J2CBDE-@kbusch-mbp>
In-Reply-To: <ZuRXc8uj7J2CBDE-@kbusch-mbp>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 13 Sep 2024 14:36:45 -0400
Message-ID: <CA+-xHTG8_T8hXzF5uC4wFCHxZSrg18t0dzwNeh+RdDEjORh_1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] nvme: use per device timeout waits over depending on
 global default value
To: Keith Busch <kbusch@kernel.org>
Cc: ens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_113703_841642_F1DF8DA9 
X-CRM114-Status: GOOD (  15.22  )
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

On Fri, Sep 13, 2024 at 11:17=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Sep 13, 2024 at 09:44:30AM -0400, David Jeffery wrote:
> > Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> > nvme_wait_freeze_timeout, use the largest timeout value from all the
> > namespaces for the nvme controller. This will match the wait to the
> > configuration of the devices instead of assuming a single value can
> > fulfill the needs of all devices on the system.
>
> The module parameter is obviously too coarse, but does IO timeout really
> need to be per-namespace? I'd think setting the preferred timeout at the
> controller level is sufficient.
>

The expansion of nvme to be a remote storage interface means different
namespaces provided by the same controller can have very different
characteristics. Take someone making an nvme-tcp target where one
namespace is backed by local, high speed SSDs while another namespace
is storage backed by a slower or more finicky data solution like nfs
or various clustered storage products. I would expect such cases to be
rare, but they are still cases where independent timeout values may be
needed to better handle different namespaces through the same
controller.


