Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE80C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DIOPGT4IXzb53TeFxygnnT9SVnGb3OT6S3Vyq34H2OM=; b=B0ttwZMutEWDAWjgn+5VXdjEEn
	QYNIgeInCCheYL4Y7o+ksXPx4dmXmrNSQi7Mh3vvnqDDGRj9XReOZZl9GSOOj1A3P79Jj9KMZoH0d
	5v7iAbKdOAVKuYLLDs/yWnyeLzTcLhfqA67OrtEz5e3rmeoiOXpUqxYpwLArOK4LXygaQDwPhLxnZ
	vpsoZESVlW+/+zTwqitRGi80BwbbD/6pDxz3nCG2Ri7wdpvcm1I+3NQFLn2y5GDga4BbvBmgg9wXk
	SP8yFMrNhBsvGL9PFuX0lTSYjc8zQL2KEzu5e2Hc7c6DJ//aeCgyO7U4BATmhATP0MBRjCiXsg3GO
	1PotZjzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpat-0000000GEg2-1Oef;
	Tue, 25 Feb 2025 07:43:07 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpZe-0000000GEUy-0154
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 07:41:51 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so5471132f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 23:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740469308; x=1741074108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIOPGT4IXzb53TeFxygnnT9SVnGb3OT6S3Vyq34H2OM=;
        b=VO1N4LkKhLtzjCy5cKe47jjYki+C8A1a6l+N5HJ/4cZL+AVAio9vFfllFmmfGPfNRd
         5BIWT2yOSZYVruwFirJzhKkaLRByfZCPDPzvtZHQmRhEWZbI5siphvTq+pPMcpHxrbVF
         iUIkKDUBVL5wyFindRC/U6KuXGqWpgI+cPjiKM8UjUSh/kOvN9P4SJRZ+BZQ3iJ3F/Rj
         185Ziq+dx/m9Eaz73fgVX1rTrmkpMGFdE/0edi5Wd6IIyS3wIcv/jPaF9dCbsI7ILv3H
         pEqoOYhpA+MVV/He1dlRADkLp5BGgATK0hhUcI4V4izhdn+Hi1hRqYxSrH/y7QXdeOv7
         SyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqdR9Y3u54sbDMj+Bsk8UduqKzR/4zyNOUvnD5CXf2JFCn5w0kKQRBCQYCfYws9QBkEGcnYIcZG6gw@lists.infradead.org
X-Gm-Message-State: AOJu0YyRwEuQXlF+RpL323flWCTL3f5GsDigkpS7+d33AMCD9La2eRsa
	nqZ4KQXHXC1j4c+rJM5hYPsOHXoa6tam2wjxyjo0H3eDZZk1YWtt
X-Gm-Gg: ASbGnctuaeCawywo65dJT4ZcbZuy22tJAP4gbCx3V9D6D6b3zD+PXao31CnyVqhYf6m
	0UrQolU7repJL0yCyXkizOKv/Bl/WHB9gv/DTWWrztINPmn7VrKYpiM3jpxCeUewILD8eb/PNCI
	WZb1O3S1JxqSYbejuyazEPFeZUXxo3CuJ3XNwnXOnPMW4JYlwje4+9KC+StmPuwX7cR9++Ki9aI
	nKNIiP0MD4mOauD59fPBtYXBbvAelJQfNk5RexS3eUKnTT2tr85VO5+Wl58m3YWoBNPoZM/ab4R
	5ik3YKwJp91TSalnxbFHD4osqULbZ6oAe//7u+1uyI0cEi3QxMLUyfj02m6WX0AoCcCh
X-Google-Smtp-Source: AGHT+IGZRT/WSUaWI12Xl7ecaWonLG7WmLQWcgAjEIFvCrQ79q+IFZ79WmSEIxbO7eQxIZSXHp9S3g==
X-Received: by 2002:a5d:59a3:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-390cc631b55mr1473019f8f.36.1740469307804;
        Mon, 24 Feb 2025 23:41:47 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm1359975f8f.73.2025.02.24.23.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 23:41:47 -0800 (PST)
Message-ID: <b4988427-c195-4c4b-ad13-524c790c1c1d@grimberg.me>
Date: Tue, 25 Feb 2025 09:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
To: Hannes Reinecke <hare@suse.de>,
 Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 hare@kernel.org
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
 <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
 <0e3af565-f8e6-4647-89c3-6757f6bae3a6@suse.de>
 <D80TVRHC1LFG.RHYVKMPXX3DF@bsdbackstore.eu>
 <c0b813ab-c39a-4cf6-bbb4-abdd3bdf8d1a@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c0b813ab-c39a-4cf6-bbb4-abdd3bdf8d1a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_234150_056376_C53D04B6 
X-CRM114-Status: GOOD (  16.03  )
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



On 24/02/2025 19:03, Hannes Reinecke wrote:
> On 2/24/25 17:48, Maurizio Lombardi wrote:
>> On Mon Feb 24, 2025 at 5:04 PM CET, Hannes Reinecke wrote:
>>> I really wouldn't be doing that, as we need to terminate the queue upon
>>> fatal error and don't really want to delay that (eg by waiting for the
>>> transfer to finish) and
>>
>> I did some tests and it seems to work with MSG_DONTWAIT as well.
>>
>> I am just wondering if calling kernel_sock_shutdown() could
>> in some cases race with MSG_DONTWAIT, preventing the packet from
>> being effectively sent.
>> Not a big problem anyway because, as you said, it's a kind
>> of best-effort thing.
>>
> 'xactly.
> If in doubt we should prefer latency over correctness; and especially
> when running over a more complicated network setup (or doing TLS) it's 
> anyone's guess if the entire stack is still operational by the time
> we're trying to send the c2hterm.
> Part of the reason why it wasn't implement initially I guess :-)

Agree, this is a best effort thing. No need to jump through hoops to get 
it...

