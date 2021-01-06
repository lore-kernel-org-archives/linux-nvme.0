Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8BC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 01:54:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D682246B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 01:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D682246B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I4+voaAJiyPvFaRlMr23Xmb3elOWSRyw4Xi0PIm3X3s=; b=UhVUa+nnuJg8EmBrH0AyKd0jO
	NYUMp50iEL68I3TC29wkcp0eUEekgAnZjNiB2UUCAgGpSlPf+DnQ+PsCGSl6WzOqM3j7Biq1zfFcd
	rk8vrB3CJb0TM3D93Vd5VBHb0oxEVB61HOw+PIVthJ7Pac+iZr1NI//7bGM0uq8gkFmMbR+VSBVVC
	7BpN1m8PlXSGVHTfdkbtoiA21w/t0at83Vnnz2ZMdtTOrWylnYS81kabR0mFJxYNosdXsQQWK+C48
	Ea8EnIg5HzhqFu/bANxcxm8HQJHe6/U3WltjNJ6bUxGfPAnMRoU1d9cdq9+dvojbXYVKUWDLK3rWz
	C2Lw2yBEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwy1O-0003uQ-Oq; Wed, 06 Jan 2021 01:53:58 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwy1L-0003tp-EX
 for Linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 01:53:56 +0000
Received: by mail-pj1-f46.google.com with SMTP id b5so768848pjk.2
 for <Linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 17:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MdGF6GrjV/DW8tEihSyPr/+v9IBdsaPwI55ny4cao9M=;
 b=LzBYeg45QaBDlVXlmn31laOhiEQvEkKmLLWBW/5JpJaAMDYeRhyNxbl3xkUtHgTVOV
 +qbFXr0ZVLUMWLQBY6pc8Ckn15Ph+TLJi97QADGMhwyO2Gg6N/tHwxRA5NUuFEm6HzhZ
 YNEOxnWfmG0LjSRFD3k9YVbgg13cGjdvdOjTUymUucbm9Xea5E/24pXR6nb8yQSkfv2u
 BAPhDzruiWKafuBchhVX1BATYt6XcQCc/lSOZIVfYDwGihL96rgvD/pWsqQ1JcNpYC6C
 nMr41jq5u8vJ5NDr0Ywocma7GHEW1F2x2U5k2/sU/Rw27I9sc9yq1nntlfPX8ytUiqiy
 FILw==
X-Gm-Message-State: AOAM5301NLev6YV5HoNlnielKOEaMmosvNKGiLFfhvj+GlZuD38k0wqN
 tIcWCpUlYGfyepeEy+aPXt4U87mCHiM=
X-Google-Smtp-Source: ABdhPJwXc7OU7Bms5vvuVi3A4i5TvfJ4/TG6abT5ajPInkqIW8f9ZNrgSZp6uqvDsCEvCMwRBK5ayA==
X-Received: by 2002:a17:902:eac1:b029:da:88ce:f38f with SMTP id
 p1-20020a170902eac1b02900da88cef38fmr2023537pld.42.1609898033746; 
 Tue, 05 Jan 2021 17:53:53 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8cad:710d:d1f1:8ff1?
 ([2601:647:4802:9070:8cad:710d:d1f1:8ff1])
 by smtp.gmail.com with ESMTPSA id g85sm564120pfb.4.2021.01.05.17.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 17:53:52 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
Date: Tue, 5 Jan 2021 17:53:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_205355_534326_B287E02B 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Hao,

> Okay, will do that in a few days. Something else just popped up and I 
> have a limited time window to use some machines.
> 
> BTW, what is the performance implication of disabling merge? My usage 
> pattern is mostly sequential read and write, and write bandwidth is 
> pretty high.

Did you get a chance to look into this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
