Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B618C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 21:44:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACFC60720
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 21:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACFC60720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txqnx6/EvpBvp3GlFmfj+I7i3iGYJoq9fzVKS0xZleQ=; b=j/I/iaBvqguXuSxGUxPjoFe/Si
	IPWwiZyOvzkyGy3qHrOdaA6HvFCvigqtTBNFWeU7bEvqWWtWZ+Q5m6n3lcTzQCH2yXHkPwav/umoy
	Kvmj+hfqRi6RfTUpwB70MqghdsOYwTmBXCYCaijm63Qw5bFIBaZOrBPEqGvNwBfrIO/L5dQYzZhvt
	iZ1FL3ehMEgunuIu3rME2tWBRJ75ICl6/0lozVwXGaN6UQ9ujh2lEf5NgxXTcESapjFFHxmnww5uG
	2T/i5zAZ9R8F3qeoxWOhZbPTHXkKvts2xCm6Y2uuHTwLJSAVZIIbQvVwAMr5XHcEes/37FYQskuz4
	fC0+28Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltGrE-003HKZ-CM; Tue, 15 Jun 2021 21:44:28 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltDOA-001whD-Lj
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 18:02:16 +0000
Received: by mail-pf1-f171.google.com with SMTP id q25so34185pfh.7
 for <linux-nvme@lists.infradead.org>; Tue, 15 Jun 2021 11:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Aiejuj278oPItajB4uIg31KUlkHKB5BdFDlTpAZQYw=;
 b=YX4kIJQHMpW1Dy/LUBsHIPKbjJERofVu2KpP3JJPo791kR2Jgk94WSdZboAL9dTYj0
 3N2QRVRwdKPaj6IM3jQ9v9lPZyjDWNNVQzKh10fFDy3q22HRAfelvEI1CvbX3WBxp7vQ
 dH1kPVUMPCHBBOj/c/k39tHF8Vv8l84ON8tI0h9ZZBhmcSlVo0zhuQI3b84QhPE6/WRz
 Knz0Te+1yInqQRVIJyGbTaFcuJsL2aV0T6oefePK3OAiVnr91kHu/nitUv6xD4pGJ1zH
 t8RtWayRf+dCDf0oSS3Dm6DO8G9NuyjC3Z85WpR67yGQ3OezT/OkWlqmZ9GEvV/fS0lL
 G4Kg==
X-Gm-Message-State: AOAM532xQB8xVy83ETsGJqGKw+M+t0zKNS5T38OV2SRufzoAskY9DTN2
 /9C3jGG1N61RR6srFQTB81fgMA9jOtw=
X-Google-Smtp-Source: ABdhPJzIUkSVIQkG8ArfHrXUWaz5w/mVvWjgZOKkjB78ueD+nksYkjlE5ElhOaiQRQy9XMmKKWjwlw==
X-Received: by 2002:a63:1453:: with SMTP id 19mr740394pgu.270.1623780132417;
 Tue, 15 Jun 2021 11:02:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:48b9:2651:95c3:4510?
 ([2601:647:4802:9070:48b9:2651:95c3:4510])
 by smtp.gmail.com with ESMTPSA id q21sm16514775pfn.81.2021.06.15.11.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 11:02:11 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: Add a multex lock to start_queue failure case
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <20210610084112.30400-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c79420e6-8110-4367-8361-cf1244f60318@grimberg.me>
Date: Tue, 15 Jun 2021 11:02:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610084112.30400-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_110214_790491_360658F6 
X-CRM114-Status: GOOD (  11.06  )
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


> From: Amit Engel <amit.engel@dell.com>
> 
> this is in order to serialize nvme_tcp_stop_queue

Thinking about this, I don't think this is needed, can you describe
what is the scenario that requires this protection?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
