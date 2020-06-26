Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EF2C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 16:08:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23462075D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q18nXF/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23462075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1XpI5Qz7roaUuD1IeAboJiU3fSssAcVCRBmWkdl7x0Q=; b=q18nXF/lA7DWxst+2sR0daipb
	njcrdkETRcf+1Z6CU2wP995dsjSHWfwXWNOHmTN2WeosSFN20IhcyKvhWF5j56EREH4WscreZpPDy
	ZMHh9lu4BbPZcKKrD2iaUBofT+ZjmRN+/ad0e98SH5Qwb4/93bRGBzZ7fe2BK6YgIuIy63KdgHfkV
	rcm+Vbbx1Zwi2gwbXcesZlCF0R1cxP4y/sY4i30s+FRukZuQK2L1OjYC0OESTIgWudAhOKToHJrPc
	gRURL+VBS5HBIRs9/ouXNeOKmzHDTcdl8dE69Zxexp0IAB4ra0TdM4hmuO/p5PwTqf5falG4H7Lah
	G9w7mDuOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joquL-0008N4-Lx; Fri, 26 Jun 2020 16:08:53 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joquJ-0008Mj-QO
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 16:08:52 +0000
Received: by mail-pl1-f174.google.com with SMTP id 35so4452588ple.0
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 09:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUvxHQil2exbtqF2IcGZm4I2H3c9wnbnjLRUgZy0aUc=;
 b=owaxWGHE0bMKj1RgLADLZudVKjL59nr8kuicsi6vggxn1OrjMrt1LjXasOkTrdkIl2
 AGPVsRlaPu/tsY6l5mV6arEigOmWrX8a2aTHh2pGg3AxrwvD376ZtKrY2CbMSYw+5Knm
 yWeSzGTuZzaZkYELdw2lmSNguAv+a71B6qzmIhWVomgjEN/HTWjFFT2XHk769hxR7YgN
 HAyzoFPN1RGf/AxiZDgEMur3ILdYiUIJDZIZWYbOZft/7d7W/HeNMEGx/TrJpdQTZYuS
 l0+DTqZO7iVmsx5qbtNW2RRr8JLPlHpmrEf86PKAL6RoVw6oMfQhKyogrSJuKwIMFUGB
 8KEg==
X-Gm-Message-State: AOAM531PHisWCOQOfS9EIqz5OLf2Iszx9GvM3q0FIFSoCniF9s+idFAx
 PYSXKNLzsELYIxtykK8RMLI=
X-Google-Smtp-Source: ABdhPJw+Ogsn5l6ZXlK3Q5SS8m4Ntseo7nqDCA59FWezqrnz7fQSLj5sXH+rJ2zaVmokTAkQJqncug==
X-Received: by 2002:a17:902:b692:: with SMTP id
 c18mr2484489pls.274.1593187729439; 
 Fri, 26 Jun 2020 09:08:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id g19sm26248323pfo.209.2020.06.26.09.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 09:08:48 -0700 (PDT)
Subject: Re: [PATCH v3 for-5.8-rc 3/5] nvme: don't protect ns mutation with
 ns->head->lock
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200624085312.35967-1-sagi@grimberg.me>
 <20200624085312.35967-4-sagi@grimberg.me>
 <b9e5a68d-a363-ec84-cad4-3e0dba95c09b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ef7986d8-9e4a-d2ac-0239-7f7c8cd76fb4@grimberg.me>
Date: Fri, 26 Jun 2020 09:08:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b9e5a68d-a363-ec84-cad4-3e0dba95c09b@suse.de>
Content-Language: en-US
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> But what provides synchronizsation of the updated namespace values?
> And if it doesn't require synchronisation it would need some explanation 
> why not.

all this done under workqueue serialization.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
