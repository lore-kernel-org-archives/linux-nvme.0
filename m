Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEF1C433E9
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:35:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F3764DE8
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F3764DE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B+HtLheUmSZ0oNciEtOwr8UEaYYSPn8hiEKTqIGug9g=; b=DzkxeZ0Hnav0lWUqxFAlIlA3y
	UzrDMFHHgKPIo4rOUIWahJALerEvJ7JX3TR8d4FljYczDhjbyD0hRFwu5Uf3xiTakInS2Qzf+Dnkq
	mTABTEiy1A03IYemmGMRzw1lcsHVwVFIGSfPgUv/kq9oGwlfghqsV2xVshONHDl+xEbX1EVHFvHUW
	wDen78kNoZ/39oct2G4KQ6jQax+t11nJvDpQreqO/n09oeeWGH0O1qrUs17KYKTbAM+W+CkWgPlDz
	Zb3Y7wLWcEtvwpM0/+vH7w++kJCp/JUN91o0STm3AQPQUizwEceQQ525MVIqsEY+doP/+8qxKMT/7
	FAPx3PYCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBlWz-0003OR-NV; Mon, 15 Feb 2021 21:35:45 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBlWw-0003Nk-Vz
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 21:35:43 +0000
Received: by mail-wm1-f53.google.com with SMTP id v62so1087868wmg.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 13:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zQDupd0GOAeOmBffLjyeAXyII+P4mJrjhyStasRw05Y=;
 b=bQIjcOnznHim46YGCK+vyiC9k7D4SeMdPmMeF+ZmvHJctyHUrlyNaJHQ7186YES7zp
 NXenBJsZ14m0/F1tMSBs/vTEWNq0NHdSKrFXqoHsBFZBOHf3aNBtcSBerd5kpg8FZquJ
 0E8iGPuduIbLV0DP4963egO62ndnIABACI8d+8B/ZhhfQlSI59vvwT2YQVwc6xZoC96g
 6A2YDCvsVSQnii0HwXrd/ybbEm0+6Rx9lk7nOdt0+eFcnxGjew+oPAsF+SNIjSvRyo+g
 pXyAs/ho6qQHnkFMNN68kkz3RaJyXfMWEueQu91h7LnAqD15gOx3koHCJPyaT8ao44zP
 e1jA==
X-Gm-Message-State: AOAM532EUEOcVDRZ8kW9W8+aNZ+fgkJykpqWajW08S1zKRZjfdAoHIoN
 G6EPKOqYHUDTOI5dkmw4KVlmdeNFZi4=
X-Google-Smtp-Source: ABdhPJw3hCpm06MzB01GPG8uvZssZrx3TyxzemxcqeoZULY03znnmXIDT9nCE7qxsKRuMr0SXd+/pA==
X-Received: by 2002:a05:600c:4fcf:: with SMTP id
 o15mr699760wmq.96.1613424941323; 
 Mon, 15 Feb 2021 13:35:41 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321?
 ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
 by smtp.gmail.com with ESMTPSA id u142sm730242wmu.3.2021.02.15.13.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 13:35:41 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
 <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
 <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8937148e-f667-9a05-3828-58114dca6da3@grimberg.me>
 <SJ0PR19MB4544A653D3A84A19A28D3984F28E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <1a430561-498c-70dd-f14b-8fab10673f65@grimberg.me>
 <SJ0PR19MB4544CAB0A539F84E54EC5208F2889@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7f5ff08a-36f0-3b67-9753-20eedd4b6f4d@grimberg.me>
Date: Mon, 15 Feb 2021 13:35:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544CAB0A539F84E54EC5208F2889@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_163543_093934_05DE2A14 
X-CRM114-Status: GOOD (  17.26  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Hi Sagi,

Hey,

> Just to give you an update...
> 
> We're still investigating the root cause of the crash.
> 
> We found a bug in our Discovery Controller related to SGL format (format 
> 0x5A vs. 0x01). When the host sends a "Set Feature" to configure AER/AEN 
> with a SGL format of 0x5A,

This is coming from:
--
static void nvme_tcp_set_sg_null(struct nvme_command *c)
{
         struct nvme_sgl_desc *sg = &c->common.dptr.sgl;

         sg->addr = 0;
         sg->length = 0;
         sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
                         NVME_SGL_FMT_TRANSPORT_A;
}
--

  the DC responds with an R2T, which is
> obviously a bug. This does not happen when the SGL format is 0x01. We 
> believe that this R2T, because it is unexpected by the nvme-tcp module, 
> causes the module to crash.

I'm assuming because the R2T has data length of 0? because set_features
does not pass any data (feature offset/value is in the sqe)...

> One of our engineers that is more familiar with kernel modules is 
> currently trying to understand how the R2T would cause nvme-tcp to crash.
> 
> I will let you know if/when I get more info.

Cool, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
