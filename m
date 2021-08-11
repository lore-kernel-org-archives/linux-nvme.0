Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C30C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D75E60EBC
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D75E60EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+IwdZExAzach24rhs0BDUnbzOjTJ6ckQDinBtz+xUW8=; b=tzWSP5dSqGwRRx/Lwb/Z3UiHjO
	j9K796xJoSf7WVpGx8ef/kcV05sf555jL5tvbjDMHKyRGsS/8ECOgO5emvb7G9e+eKO5BwWs3QBid
	LdQtRfi1TsJtlo+QgOXcILHFZDfn76eDKgZs5a6Am7lluKqCzM30cwG4dmpq6dwCN52vxOG3S4gGL
	wiv219Pgp6f6hrPXisKR5f4XmSwX7LeLEKUoZyTUOiU5foXaE2fCJgN7SQLnSbVaKw81MYJ+wyhB8
	aKdA02jVUcrVGaTi6uJdalRpRBm0JFgvV2EF7ge1Bpz8tQ2zYSOlqD4fUiatPc2gDSL90XlnvOluU
	EHDnpt4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDcgA-0058BS-7A; Wed, 11 Aug 2021 01:05:10 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDcg7-0058At-Gb
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:05:08 +0000
Received: by mail-pj1-f51.google.com with SMTP id w14so785362pjh.5
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CgNWZSgrNzJPLq2mMqUN5nw8xAzOXxjDw3rTcWX5ovg=;
 b=GGLi88r7cMRg6bp+ADS5g4AY2U+mOKWBuwLnuFk/hRHX5NIMas3+McuMJ5C5d+OgbT
 hyUihQoyZ0Fq7mpBdP3r3XpMW/8hAkjlyU7Nf6xVJdInw6JP1j54lObKYx0WpRolQxiy
 5KDKpy2EhIGjvcNQIDYAIbJ8caw3yxyFVqr0hMMCqUi1SdvfH9dHi2s5ZaSsMKu2yuzj
 twKQlblwyq55ncDyfP5/sG4kSiygZZYaZzS6nwAByZ0mQfpmew5CK4/d2DmuY0ZNKijl
 PtXRpPZ+o1ROO9MRKqevuODiZebTpgl1hnqtrT1hNoILchPVpl1i+jxV6Sltzfzw1z1o
 Vu9w==
X-Gm-Message-State: AOAM531mydWB9PNL0Nm9pCeg03tk4sijwnnoCSVj5wLtpMS7bd4cPviI
 /CPtaXgs0QtVTBSnNMNE4xQ=
X-Google-Smtp-Source: ABdhPJwDNVIOmkI4OSVdRpyOi7HjUPALBUuuEH4209cpN7PfkEPWc6DyiUkhGWsyPV4T3o/+erUEHA==
X-Received: by 2002:aa7:8a13:0:b029:3be:c2a:7a45 with SMTP id
 m19-20020aa78a130000b02903be0c2a7a45mr31944891pfa.8.1628643906594; 
 Tue, 10 Aug 2021 18:05:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id x19sm4406732pfo.40.2021.08.10.18.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:05:05 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <20210804080847.bajae2twtnmccvq7@beryllium.lan>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
Date: Tue, 10 Aug 2021 18:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804080847.bajae2twtnmccvq7@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_180507_620345_284B8C3B 
X-CRM114-Status: GOOD (  15.50  )
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


> On Wed, Aug 04, 2021 at 09:23:49AM +0200, Hannes Reinecke wrote:
>> There still is now an imbalance, as we're always calling
>> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
>> call 'nvme_start_freeze()' if we have more than one queue.
>>
>> This might lead to an imbalance on the mq_freeze_depth counter.
>> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
>> the if() condition to avoid the imbalance?
> 
> What about something like nmve_is_frozen() which would avoid the tracking
> of the queue state open coded as it is right?

Why is there a conditional freeze?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
