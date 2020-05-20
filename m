Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:40:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A94207D3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4O8jQL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A94207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BeALwvOTu962L9deqZEjWJ3iKuM15E8/1fl61IPxfGg=; b=Q4O8jQL2BOx8gaCrQVgjXZ9D6
	xRNpH7GhbTcDhG2pR2kGItHkqYPA36NUc2eQfBKr3S2A1Mf7FRecnx87P5kfJeWsc3WkFtmKT/bqz
	naInBBV2BvERrfjp2eUvSE3QVEG7iKHn/q3HQHhfYXPavGdOsD9ixJMsNGf660QwIFiIm9G11Kwuz
	raRGhSQH8YqZL717s3ahcTCJN22hbhm04/6CkCt8vqJUgfLM7Hhn5EYJrJ5oeFxjEsXG/ijZtRB6/
	sr2vSB7mADkkf/501Kryemz0NWhmclRjjNn/kzljfrjTtesHudretZbHtuXN1ttEDz/v7iefS/tIQ
	6pDfjbd/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUa6-00080k-TF; Wed, 20 May 2020 19:40:46 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUa3-0007vT-Im
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 19:40:45 +0000
Received: by mail-wr1-f65.google.com with SMTP id k13so4392872wrx.3
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 12:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qBEMYwPhpMIboG1EONuKehNqsMNpNCo0XzKxhawnecw=;
 b=LPXnJMAmXxLqvuvP3zVuasiUvgD83F3nBFbloJ87RAcu8V8xN+l22u7kwbr3ml2t0m
 Z5NwybsgTExND26Wvb5SF+LGcNndn+cW07QRoQVsSYow2WMMw3MCHu6NYRyt2L0kEwRf
 QC8S5xcL7ATB1AnTdZsrA61lbotmY0CzX2zt4n7/kDbGdQc0XrLIjUKFUvF5WGGixUwN
 +orsYIRub8+Mi/Fiiq/EjXSpEy7UDzGCXYjLZRjiHjROmDMum505BKMykslIzt8So9X2
 Qn8pmi9gHX+9Z1Vw2KUEr70lzn6oNRLoJjo9tdWZT968oUMB6OJO+xgS1fjfhKed69z1
 q3aQ==
X-Gm-Message-State: AOAM532GG6iSJU5pjm2enzIvl1p/Goymb7UI+J5Zgdqou9YtYS2FEJ7J
 YHJDyrqfnX1Kh1ImXmUDPFU=
X-Google-Smtp-Source: ABdhPJyg4pJ6e4wfh5+Qmed/K54I+kfZA7IBw57zUqwdnD42W8A+euqbA2AM+0L4NDnKhfp8qpPNOg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr5443604wrm.108.1590003641947; 
 Wed, 20 May 2020 12:40:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d?
 ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
 by smtp.gmail.com with ESMTPSA id h74sm3939738wrh.76.2020.05.20.12.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 12:40:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: Christoph Hellwig <hch@infradead.org>
References: <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
 <20200520172741.GB22182@infradead.org>
 <df8d9a64-d7ff-b249-e5f9-c3b0cf092c4c@grimberg.me>
 <20200520174632.GA11265@infradead.org>
 <38af0291-4d09-d8c4-59fe-2d642ddaaaa2@grimberg.me>
 <20200520181526.GA11892@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b78f9d23-a1ba-ecf2-be2e-df343bc32f03@grimberg.me>
Date: Wed, 20 May 2020 12:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520181526.GA11892@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_124043_642690_12416848 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: chaitanya.kulkarni@wdc.com, David Milburn <dmilburn@redhat.com>,
 dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Just the fix related part. Then have a small cleanup incrementally.
>> move the nvmet_async_events_free to nvmet_ctrl_free and make it
>> just free the aens.
> 
> Ok.  Do you want to send a proper patch?

Sure, I can do that.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
