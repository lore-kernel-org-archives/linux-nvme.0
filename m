Return-Path: <SRS0=BlPy=FX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30600C4361B
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 01:35:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B94A23BCA
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Dec 2020 01:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B94A23BCA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gz/PYgKen8jMhwj7rrsCKVvXfZTM47Gh4nDSPfoyzbg=; b=sEw6XyR5JFxOsAiWQaGMkEBWH
	zBCMVEByeknupgB9NJ2yw4wRkO0T/OFhBLyJAAbwBrS/mipqVGISQbj2/9gvzYk/8IPXo7iHHvorS
	vXvklDRfttj563pirZe7f30yKSg7HPkdbB7NAafhApK9Q4Cwj+4jwXAUWs+nenjphDMrHDd2yT7+4
	CZ5NfE44kGBrAzBWOcIZgQOyye6OUprbou/eBekfNQ3DzBukrn+9trSu+LZ6+m5SkuVgLWQPqqE9R
	cT4YRxDIN23kIm7gp/N5EkRADd7lJUar6ExshxV6bB0SgoLmAkmk7fbPTOfgNnPJuFX3lhO+degwH
	4voaDmldg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kqR9J-0007KD-Sr; Sat, 19 Dec 2020 01:35:09 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqR9F-0007Je-MC
 for linux-nvme@lists.infradead.org; Sat, 19 Dec 2020 01:35:07 +0000
Received: by mail-pj1-f42.google.com with SMTP id j13so2321996pjz.3
 for <linux-nvme@lists.infradead.org>; Fri, 18 Dec 2020 17:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRs09RGdeLAts7RB1LTV2NOtVJYjoFPihuzldv3bdSQ=;
 b=LYgEv29cufdCQSmAazPWQ2L08yY9avol7TZBm+BmCZAiA9jkS696mi5YEIpicn1wdH
 7mzmLEYbsB1auGg4ElJ4csmZmXwwbU2eWn1uFELSrHVgOhu4lGZWI2ZQmWDfFBhNwrdy
 HE7g0slKAgQKkObN0pBhRTWIoqi2Va7pra4AZGNqY9/txoUrp8VBASmaXMI/4MPYbe7V
 js+bXT3VXk14n4urg/7FvnRrTko17a024skeY+2D057cj/Qc2qQoJw1OO0sHBt/E3XH5
 Pg3pvqzGA0wPzd+mBU4Zpj8liSmPd1IwW0FV81DGS5DCwYwXRQ6m9fdcQFk5jpLsc1xW
 BP5g==
X-Gm-Message-State: AOAM531m5g6jrYGwshY+STiVrHd7+XXNzlLTCEDKC2J1vkJhba4otFHA
 09L8nEBOjt21BZJH97VB0ok=
X-Google-Smtp-Source: ABdhPJyq7DRj2hHd+BRy3sKiJAtEpPAHafj+A3UrMoD2RVXsgkAZFKEn6dCPG0fJnvELgJwA/VCMTQ==
X-Received: by 2002:a17:902:d90d:b029:da:5114:7275 with SMTP id
 c13-20020a170902d90db02900da51147275mr7046614plz.64.1608341703999; 
 Fri, 18 Dec 2020 17:35:03 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:ad66:235c:5bd3:e462?
 ([2601:647:4802:9070:ad66:235c:5bd3:e462])
 by smtp.gmail.com with ESMTPSA id x15sm10051037pfa.80.2020.12.18.17.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Dec 2020 17:35:03 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
 <X9mgW4AxRpQsetN1@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <52bc9a04-777d-7a29-d784-468a69aa1478@grimberg.me>
Date: Fri, 18 Dec 2020 17:35:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9mgW4AxRpQsetN1@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201218_203505_798161_6590E988 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Potnuri, does this patch solves what you are seeing?
> 
> Hi Sagi,
> Below patch works fine. I have it running all night with out any issues.
> Thanks.

Thanks Potnuri, can you try the patch without the nvme_tcp_io_work
portion? I think the issue can be resolved with just adding
nvme_tcp_send_all..

Thinking more about what Mark mentioned and it is correct
that io_work needs to reschedule itself if it wasn't able
to acquire the send_mutex hence I am not sure it is needed.

Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
