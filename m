Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:51:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FA02053B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0skzkRC0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hXDaAKBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fnUyQel7G3hl7hb//Bvmqc5Pglywa4lCVBQQe+QMh+Q=; b=0skzkRC0pmVf2R0yZgOsCQr0O
	kfxcKe1XtNkjF7U8FNRCThto/IBay+DOUBYsBxdRvA+yzg/6b0u+8klMEP2OAj10+vL3m7bHueQnA
	9VpjezgZYVHTwr6CawFAHODUZ/GhmO55NrAGH3R69W/8pG7VeoJz+Rf9+rCtwgTElgUXXic0bkr8e
	b9RRoXKch8bs/ke75vcuGCwLJ/kceE1uZaU33Rpv+1jLCRg6Oyv43MAJ474TB/tc7vgkpFLvLuFks
	GuYVN+a3TMInOxz/3WpNiK1nErHToT/ZRzvQRTvwhJZmSxFasqhwJhV4H8KvxIMgCZqZskQCFVtKU
	7bT7uUfgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Sok-0006e3-5z; Tue, 28 Jul 2020 16:51:06 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Soi-0006dY-1K
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 16:51:05 +0000
Received: by mail-wr1-x443.google.com with SMTP id f7so18992519wrw.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KzCgOK1emBTGa1QBz+hCMVhgMS5dNUHqQWgoK5YUYic=;
 b=hXDaAKBYzTQxF8F/b7O+Q+7RFCtDA2pRAlQiiv0eQrcII80KojBIiwHkQ6Cfh77PBt
 BfmgVxY+eTZImObHJTP2ORLrPj4bu4i+8BhDO0pXrEaXySoIhpEy60N2L0fGiEDRoFht
 GcFMW5P46vkpp2ooChsNvY2U04d7I7L7ftgaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KzCgOK1emBTGa1QBz+hCMVhgMS5dNUHqQWgoK5YUYic=;
 b=S/0hh815lSalyW/d+jzjBhUX4Uc/vodxFzIlRWugQBDcnuGQcRtqEpL2RKwhAq5CN6
 GQrqh1z/PkL0CSi5l1LB9i7k+oIiqnLQB8eLn0Eo1MINFx2AXB+47G8mf1V4/OH2SXXe
 ToeSrHO6RbmXiwmZK0wmVELSlsEDrkgBg40jbtGXh6E/BpfnE2Mm44EjB/la2VoViLqT
 HMqKWJvAvvS4/9eVDN094BbuNpP1wCuv4YRVKi28UEwrxaULkVm+7WX9itDmK/dxlJy9
 z08j0RitfdwUDKH5tXPIAHHiz+jvRybGqk8s6esF5qXUQ3TAyXw+rLRI6pprv4fZIdKe
 7kVg==
X-Gm-Message-State: AOAM530DBIcLL1DtSv/jUUOIwe3Jg8vJC2rXdKrT+EuQ039npGyDzUX0
 sHh3uyz7GZy4j4uYM5pc/dHpmA==
X-Google-Smtp-Source: ABdhPJytZAw+01nB2dlfxYRSZ66OgfrVUuX19Pp6B4nSrLijI4s+8TMWpPQjh5vkF9IIX2bTjfg0fA==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr26070297wrv.331.1595955062804; 
 Tue, 28 Jul 2020 09:51:02 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id v12sm18559993wrs.2.2020.07.28.09.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:51:02 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <20200728105058.GA29609@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <84dd87f6-19d6-8213-d8b8-c0a2cb0068d3@broadcom.com>
Date: Tue, 28 Jul 2020 09:50:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728105058.GA29609@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_125104_113885_D0957A7F 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 7/28/2020 3:50 AM, Christoph Hellwig wrote:
> Applied to nvme-5.9, thanks.

No - I disagree with this patch. I'll reply in the other thread. Where 
is the delay I see with other patches before being applied ?

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
