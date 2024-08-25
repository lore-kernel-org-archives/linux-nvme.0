Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F4BC5320E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2lRvDJmlRezSfqqeoIHD6IIZqC
	JtdLUbfEqtGlNWS5H89VQ04sb6YrO7/IoAGDc9rDfKzP6tJVtLPrhLcPGhCVcEgFP6Kyj8oBu9nst
	LYT2QMnKglk251dblResMLJUuui+EJDFW5ZcFjQOkvf6r1Gcs/g+bUYttQYRtVCpX5/OZkJ3o3SPk
	FyhTlwJZclfbC5O2BFp668q9hj6IyM4WkmVMyovMeK2i2kQe95Iwb+9S1iSMa0MyUAoTFBcijNmoi
	fzSgef3zUuhHeA5TenounSvqnUhYhKHrSsWYW7ltKLKGHG3Y37X8PM0mrhvFUdI9T2b23anE1KpQf
	KwgsSbnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si86z-00000003uDW-2w9Z;
	Sun, 25 Aug 2024 07:56:33 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si86v-00000003uCs-35ug
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 07:56:31 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so26590505e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 00:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572587; x=1725177387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZtNEOCbPotA9lrjMG85TzlQDgcYjlnAo1GOvM+VQ1c9uZ9dU/YIW2dzWcghuvehDA9
         reIkh/VDXvlRdoccbV6//kCoTUBYE9bEDm0KdNapuT9B4i0jGnqWBTL1pFuQXDAZiOfj
         tJH3AcOZVJM1PUtcVknvtSguJgbSK1k2kPE5rs6A+8hcW6Akjmxmm74pennenhx9MhE2
         rLPsr1Cpeq68fNlCwWPcvqBiM5tMeJdcbHCGkuCbRJG0qS31C6rzCxW8givPMqBn6W4h
         +3kTrJ0lPjbBcSzkTNPqQrh73yl8hhfE4trKz/N7ufsovR3PE4bbvokn/10D1HGFIoRc
         kzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5EfS/Y0jDUUeGG4TNv17TTGIvFQAv8uVntLFuNqY5qJ55MTCHdriUCs8zeBDy8XY1lClAOktijsyg@lists.infradead.org
X-Gm-Message-State: AOJu0YyWXWiVCi+ax0EjXmD1y5DP528yscjpOjYJmToNUgTAw4KweOpK
	/GCrPoDcDd1Q28SeZnoktBlCpkVrveZHjdi+hM+8xXbd4mNByodo
X-Google-Smtp-Source: AGHT+IG0f6m2Txdcli7jeDGYiXwvELfz4bhY1jjk+4bKm+jmig3A5htbFfiO1OFzRdiL/JYSlzuSww==
X-Received: by 2002:a05:600c:4453:b0:42b:8965:1638 with SMTP id 5b1f17b1804b1-42b896516a5mr37440565e9.1.1724572586682;
        Sun, 25 Aug 2024 00:56:26 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ab6e90db5sm176340785e9.0.2024.08.25.00.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:56:26 -0700 (PDT)
Message-ID: <f6a21ba6-5e76-462f-8360-1cb160ac6467@grimberg.me>
Date: Sun, 25 Aug 2024 10:56:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] driver core: don't always lock parent in shutdown
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-2-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-2-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_005629_813049_1983B746 
X-CRM114-Status: UNSURE (   5.58  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

