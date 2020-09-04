Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D27C433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:54:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246F120709
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf7AUc41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246F120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Kf7AUc41u8nFI9/aNK6zS9pV6
	V21Yc6OJokxmGYYE5rbNIDRgZCf3XvjE/iPpBAEEYIr6BqPJVE8NwGnkG5OVSQLJ40TWx3kzgFJly
	vo7dde0KwDcYxk3Xb7tGj7XIvZKMJQtCNa9QqYfKW8sedSyppcna2zgLcXvtPZgp33nT2tU+81m19
	BQfZLeScwlHftU9BWvsRzg4A4hPnKtD9sVXijMDUHCwT9lgfsNj+0Rf0VQ3/lXxiN/EJCv96M9rJa
	tR8pXlHAeU/nBwEchJ1hecObz/E2ZJY+Bpm+QxU8wrvOoTSRKJEpB7U5XAOhqTeaPIQgJYqo7Fy5M
	s+zrJEh0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzzL-0000SW-KD; Fri, 04 Sep 2020 00:53:59 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzzI-0000Rq-CP
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:53:57 +0000
Received: by mail-wr1-f65.google.com with SMTP id a17so5023210wrn.6
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 17:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ZN7L+idVZ/VOFsJ/F5XJgtzqI+qXvOhdRDA5hDmOHkztDGhZjyTRIZe60HY7BPzZN6
 rnIVMH4fOie5ZH6XXrpk5cbv2xl8R4nYM+XNy98+BicDw2vTjOB4GhC8x1aqn2NgPq7q
 ZawVFGn7isOxySyHg0OYS/WTn1G3vb7k0H+MB6p9ZcujOM0nx7O8qB+xy/fDBkfI+DL8
 8JYsNLl0D8fZOJUB2rNHZgltn846YjKKbLqNfY+1N8yC53nOGewyS8RHaLdRyYPdxMBI
 lCUWcPoYwIu4bvi+s3eVqv8BtvyqZV+4F8q314B7gNobN1WTTFhaLAMeJMDewyXlBC35
 Poxw==
X-Gm-Message-State: AOAM533nPnSf6I/v/P8nBgWju7tjqrKIesGnRZ56F5DRU2lYR4naDCy/
 RJcc4kPf7Ck08dKpuaUE+VnfXKCic4hiXA==
X-Google-Smtp-Source: ABdhPJymEqeayN8NiKoBCxl6A3PqJbeU8u48aPlHGOr5gsokZ02hINKj2Y1zqYSLFLviNSETCtjQFQ==
X-Received: by 2002:adf:df05:: with SMTP id y5mr5346657wrl.39.1599180834978;
 Thu, 03 Sep 2020 17:53:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:79a5:e112:bd7c:4b29?
 ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id t203sm7662508wmg.43.2020.09.03.17.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 17:53:54 -0700 (PDT)
Subject: Re: [PATCH 1/5] nvmet-tcp: have queue io_work context run on sock
 incoming cpu
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB28697B878F8E60343BB9EE91E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b43482f-f380-f074-c238-ecdc001b889f@grimberg.me>
Date: Thu, 3 Sep 2020 17:53:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB28697B878F8E60343BB9EE91E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_205356_432455_6080F1CE 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
