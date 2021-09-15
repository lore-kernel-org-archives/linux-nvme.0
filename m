Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5135C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6C16113E
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C6C16113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrknAgpjoHWftMcWjKXGyv9f7vxwFlzQUA7XD/hUoZM=; b=i5WJmpOXpm6y4n7gt8drPUvUdF
	AlYfXwwAwqp4sWanuU1AjdsLS2IeJq4iwzqd3oMk6YO8I2LOBaCl6LUoQhqP+TrTWX9RRGUv45tlL
	+zFDzz9SVTMaFhhr/cElh6GFmleybNPmt55IidKPTy+3fMvduT+LGXNhRbRU0HER/jIiL7hJkTbHa
	FNdb1b0EA6gm1e38QpdxQE+432eH9wOpKWTirr6Y7XvtUptsgPn6DdKx8nGpAqBXLuw+6aQgPd1qU
	hpy4c+ftiQTkOKWPzPypAQ40XzUX3UZKvpr9FQ0S81AFTWSuUMGk+gSytNJhiiGm5cvcdN/JnZcAE
	PampxQQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQRDy-008hAy-NO; Wed, 15 Sep 2021 09:29:02 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQRDw-008hAP-6k
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 09:29:01 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 b21-20020a1c8015000000b003049690d882so4231937wmd.5
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m5n6cdJO0DCuN1kyPVm+vcAn4vFtUOmQSD8KZnNWlDw=;
 b=Bi9vVkYg5U9JfeAm4daBlGY6xHZQ6GVUjSKXdlliRVgvHWgM2tatE9SNXRVlvDWhXp
 bvHGaGmUDQVcTd2/y08yyGU8S+JMzfpG9uxEeA77RjfIPBZXnMKki8INvVyY9HxHfRG4
 ofHi5kdkLXUlOwwxcAnvDfafQ2sdCoECMECbhuVM2+FwU8qLViMM2h5xhrcgCudO2mlT
 73pknmRGTv2RFfl4yM6kE5b1rrSekYgN99TwydBDasVLBent3MNrSiWWuoG5OhdDgEA8
 WdCrKAx9T7MaEkNF6FJ+dEmJeq/5eNC36SDCXmzE2r6FRrjfYRTeXLDjoBSRJBIoHpRm
 KntA==
X-Gm-Message-State: AOAM532Lr8KuaYbChsd7wmvDleCYWkulnVKm9pkj9M0OotTYMeHmklpJ
 tfRuZtcSrMse9vzQ3+8A4+UpkjnruF4=
X-Google-Smtp-Source: ABdhPJxKJhW+pX/LP741ZFSzVE8HSSQWMeUxJZn8ZjWToEzvyANupJ1HmAbXocAJ2q44qrAbZYIuJQ==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr3409411wma.105.1631698137534; 
 Wed, 15 Sep 2021 02:28:57 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id j14sm13038186wrp.21.2021.09.15.02.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 02:28:57 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210914220128.GA3778445@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4294fcf6-c561-9597-0c13-6843bf123746@grimberg.me>
Date: Wed, 15 Sep 2021 12:28:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914220128.GA3778445@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_022900_306392_032A41C9 
X-CRM114-Status: GOOD (  15.46  )
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


> On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
>> - Keith, can you ask the WD team to test this as well?
> 
> I'll send this their way, though I understand they've a bit of a backlog
> to work through so it may be a while before I receive test results.

OK, but can I get a review? This is an issue reported by Dell and the
patch addresses that for them.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
