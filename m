Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF1C47081
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:20:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE0A61406
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE0A61406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=c06fECwDLXSiy0S3ZQn/jBrBNo
	4qeMxjd0/intQRzLFwcN4eI/ytU8KyfMjfwDpL2rUdJTaJA74rm2vFgczl/ohpGfJL/I3eOyqM6sJ
	+nwIMkgikLO+b3+6cfvi8xkrAXaFoXZunx+A/jTBCrTcfc4IVt+g1aRX1YXZx1XvMiCgysYrI/sdT
	Sw9BSAsgLCzLFMfM4g2vVRS3cZQBwxwcw/7YesVHhLeVfSPhQ7Ap9hlb9saYqhKSlEMjkFUCnJ/5n
	KXHhWdEWLepM0giwU/v6Q9C+qu8i9EvosLbjkddb0MaF07FN8WkqTxtebkq72u+jSIKnLP+Kbepue
	uLOR8rRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBck-0010nB-70; Fri, 21 May 2021 20:19:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBcg-0010mO-B4
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qC4oLHRYBwBUxRD+furLbX7Lrs
 ifwcRGymgJ0JXUt4DD0PVh5GzbBdMos+ftK4wdy3pv01hVXPB1sLKRcC8ILCQW0quYesZCZW/6KTJ
 LVjL+fPrJgMHK0y/8AuruVMQM1hyrqPxl/3AYtcqvQ3r3awLhdkVr1ft2rBN5tCjMqejSytz6z2Pc
 2mIkTGUDrO9Q4vgWQOsqTp+M9PfO9TEwcjdIONZd8LGfH1F5NxZEM6blpMYZJNKdvoUc3WDO17znT
 0Ksw7aHYX2G6SWckEJ9qV4Cifai/wEMnRKXLKSruQpj2qLMDXRdgaaKEfxaWtpIRs3n5G11lMU7E9
 +YjQWK3Q==;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBce-00HPCg-1T
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:19:53 +0000
Received: by mail-wr1-f48.google.com with SMTP id c14so20416101wrx.3
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 13:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=nOuyizx4kCtxxhDBLuOM+/Km0hZsJtpVkxuvzCj8V2U5MFbagBS5vssl706lUQ2NIZ
 nhwrUIsgiNHNbdgC3bHx2owajdh9X5FBBj8KWL4Gu2rAlXhbOYmn756zMnq54L/4O87e
 ndLKR+2eqSz7AmJgQZI7tLFo0XsseMiFbwC5yfjaeNajVkklNPmMhBhUAOhmePVKTfuz
 h8NaxaObP8BI2mLAtZP+AVljrkwNum9QuloSQvxXfKIPFWWGlZT4jEEhCWONGK5hZ0zv
 Acs4jiglfiuHNjabrd8zRo0K5C4/FaoW93nEhO6py/H+Jgv5U0RAxuf1XzvpRjndvn/Z
 Z9jA==
X-Gm-Message-State: AOAM532SuWVCa05mhotkeoiZSwG//D61F8l8xNM4Grosdc3QNvjoxENt
 F/JibqsLaLdJkfW8AHHRUp/9p/AJu3w=
X-Google-Smtp-Source: ABdhPJzEbtKHOyOOqrcv3Kyp+o+cWLD3v1xfq2d8O96potPHAJ6qfxe0+U1/4Pz1wldYFqVNnvJYpw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr11357646wrr.37.1621628390351; 
 Fri, 21 May 2021 13:19:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id l16sm565633wmj.47.2021.05.21.13.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 13:19:49 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix potential memory leaks in nvme_cdev_add
To: Guoqing Jiang <jgq516@gmail.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, javier.gonz@samsung.com, minwoo.im.dev@gmail.com
Cc: linux-nvme@lists.infradead.org
References: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8285f9cc-34b8-4c18-f837-8a005e08d619@grimberg.me>
Date: Fri, 21 May 2021 13:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521073239.722341-1-jiangguoqing@kylinos.cn>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_131952_088018_5D4CB486 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
