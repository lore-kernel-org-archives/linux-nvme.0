Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D983C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B670E20658
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaTV2nBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B670E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+NwKbPh+Q9wzjltBos3sZxMizBNCPQgoSEsQr8qhBog=; b=GaTV2nBME3tvq5u49u22jE082
	NYNfPB/4eRil34AlSMOyt91KFtApxsr8XJa1WjJH/3otCDChoj2hWBrFMbxs5+SzwcsfrFXFtZc4I
	TgdnoaMtmYMaLEaG1Z18rNrd7B2COne7pjX0+cXcatYcB9r5W9RdhUDHFyFXR5A6+LqKwgf/kL9ij
	DmyRUsamNAovG8SojDL9pitZmUncHV70UKqlCZIbUL/ratZ2DYDvOeNshQH+rd7kkytukNb0vi2L3
	R1StNDHoVc2NnWWGr7yC4wdqY9ECWXi3TmU3vv8tG8jReO6BDGBhkd8dN/QgKToTrtdirYpLFo3is
	HGZoDtSEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFjjH-00074g-Gh; Tue, 08 Sep 2020 19:56:35 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFjjF-000745-Kf
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 19:56:34 +0000
Received: by mail-wr1-f68.google.com with SMTP id c18so457215wrm.9
 for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2020 12:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=peaCB1PbIQAG7RtVIc50xlGlVayvkt4RW8aK5zdtYx0=;
 b=FfBCvmsWp8hfd63HdwzEf4sRzGQZEMCx24oY/qsH2pU/gKnBDlv7Dz8YbOR3o5h+Iu
 zBXynXvGYGifx5sXRLuft18JxEy56Hac3DVt460tWgn8CjG4i9qpwGkcv2WAGb6xIFeb
 7iOdXIbNpzE07MJS4VrGrH3InyjuoFngAJT498qllY3xqPzcHtxOFEDxXGP8pkCn+uJm
 BRS4E/Z0f3s4bGdR7KTX5KBdrTAT5V7CqzYIdPWG76HUWNqoHzJogFNA896jLjvh/+SY
 h5j4ok50h5ACUoUCVHc+iJswAQxlp6AidbplM8G9bFAltqPIh3gSm0AchKC9en+KO9ur
 cLiA==
X-Gm-Message-State: AOAM530IWAqwSZ98oYGow2v0X3CdFyyFkwh4YporbBucy/HeGMn3CyBU
 paybMKNSghimh8cKkbbbIUiYrg2uF+M=
X-Google-Smtp-Source: ABdhPJwV5oVlODDO8prV0TJIV08Oy6AFlyx+AftCaBTGFHtayHLwenKvG3m1Wng17islvdpPO1biNA==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr289036wrv.134.1599594992407;
 Tue, 08 Sep 2020 12:56:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d04f:59f0:a712:2917?
 ([2601:647:4802:9070:d04f:59f0:a712:2917])
 by smtp.gmail.com with ESMTPSA id 11sm576217wmi.14.2020.09.08.12.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 12:56:31 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
 <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
 <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
 <c24eeef2-e235-f095-0a34-8b62fe917e5a@grimberg.me>
 <20200908090518.GA18666@lst.de>
 <d8567289-1c33-9e82-570c-c77ba52e7a5d@grimberg.me>
 <20200908164818.GA17210@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27c098f7-4ef6-5650-d6bb-fc2f61285626@grimberg.me>
Date: Tue, 8 Sep 2020 12:56:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908164818.GA17210@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_155633_685176_E2FDC302 
X-CRM114-Status: GOOD (  13.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Let's do the minimum change variant for now then.
>>
>> The patch in its current form is that minimum. I suggest we take that
>> and work our way from there.
> 
> Can you resend it?  I'm about to do a patch sweep.

Sent.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
