Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A47FD3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gvunzOD153CTbwKYwn2c7/rU7pSguFyzL0oEONlkeI=; b=NVIU8TMmK6wWNXzisoxiW/rpTM
	H6i034vA2iQc1MtWlcOYCm5P4yCV+10W0W9siGuRyeOj8OcAoRwfKQoyD3HtcbabJ1EMtF43Pqgmt
	GOms2Nr/k4vqkmq1SwOprmoP+Vf+ZIlrXF3PYhHyL7cz4FfSJviyyavkixAir3J/UsG/zZY62udnI
	qYuu9qH6VQO891TrGXHdSUVVQKnbnpkEDA8K7I7DxLwsUPIAHzjTGtzOJdGnTmgd5S/Nf/iLYmCNy
	dQaahUtGM8gaUgA7lRR53ChpkfaEJvtvifqowSPaa9JF+i2gvsxn3AT0SMv8eXD976y8MIqXpiUjH
	qZuOjOHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2eXM-00000005Yze-0S1Q;
	Sun, 20 Oct 2024 22:36:36 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2eXJ-00000005Yz9-1DCb
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 22:36:34 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso29386885e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 15:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729463791; x=1730068591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gvunzOD153CTbwKYwn2c7/rU7pSguFyzL0oEONlkeI=;
        b=wv2pisMMSBe3+S11vATHkx2vCoEP92qxWUXcSO4R5oIW7gCao8VFKhxMOs9fzS7cKv
         fWb8beSICO6lInCSHhjNyqECnTVAEWiblLl4EI66TA0xifqWerd42aNFImKjS+5wrXHz
         SN0PVzmT/ooeqtnrQBcvvXlzKXkmZEZTOYQNOy2qGC7tWLjpUorEqfTeU33CvV22M0PH
         5UJRSxBWZ5mn7LZmkjxrjyKTRO2dnvSRZYQ/LjgC9tassH1ZTyjAPTglW2ituv0VreDY
         3QglcON2WJYbzNlu2rt7c99M/CaQbdeAhDPWkOcM9Soi3OYdFlzgVQpHH84v2Otyb1M9
         DASA==
X-Forwarded-Encrypted: i=1; AJvYcCW9WgtYqAEgwlRpVLhzdzK4Qk8OuZNkhhZ2lTAj5uHPTld+9XZzW2i9yiEiteQfoQuZO27R5/1ENHid@lists.infradead.org
X-Gm-Message-State: AOJu0YwXMxI9dmnmWGFUKORbArGAdfuxubRc9xoDbaSBu2i3+qk3vBd8
	o/XIjVrdYyIXTIlaCNgeux3x/42kNzS6fIjiI6KGIcWRnRhWzgy/iKhGkw==
X-Google-Smtp-Source: AGHT+IHheMV3Sdg7BIEzxN22nLJOGCXXAVtkyk5VALxK+nrqLHQ/THwlDudeaF9cDI4GfbMj8XcCtA==
X-Received: by 2002:a05:600c:1e04:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-4316162297emr67583875e9.7.1729463791118;
        Sun, 20 Oct 2024 15:36:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160682759sm100858975e9.1.2024.10.20.15.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 15:36:30 -0700 (PDT)
Message-ID: <74828866-cc4e-4598-8e7d-779f771955ae@grimberg.me>
Date: Mon, 21 Oct 2024 01:36:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sysfs tls_configured_key naming?
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d3466e4f-23dc-4a07-a2c3-98bcbf6c7960@flourine.local>
 <f56b5973-81c0-4e1d-8552-ee87066029bf@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f56b5973-81c0-4e1d-8552-ee87066029bf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_153633_354871_6B956777 
X-CRM114-Status: GOOD (  16.32  )
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




On 17/10/2024 15:13, Hannes Reinecke wrote:
> On 10/17/24 12:54, Daniel Wagner wrote:
>> f5eb7397471b ("nvme-sysfs: add 'tls_configured_key' sysfs attribute")
>> claims that the --tls_key is expecting a 'Configured PSK'. That is not
>> correct. It expects a 'Derived TLS PSK'. That means user space has to do
>> the whole key transformation as described in Figure 21: {TLS PSK, TLS
>> Identity, Hash} Tuple Derivation in TCP Transport Specification,
>> Revision 1.1.
>>
> Not necessarily. The spec indicates two methods:
>
> > Each NVMe/TCP entity shall support:
> > * transforming the configured PSK into a retained PSK before it is
> >   stored by the NVMe/TCP entity for repeated use with another
> >   NVMe/TCP entity; and
> > * using the configured PSK as a retained PSK.
>
>>  From a quick look at the concatenation patches and based on the spec,
>> tls_configured_key will never hold the 'Configured PSK'. I think we
>> should use a better name for this sysfs attribute. I suppose it should
>> be named 'tls_generated_psk'?
>>
> No. The 'generated' PSK (in the current wording of the TLS concatenation
> patches) is the PSK generated internally during TLS concatenation.
> And, curiously, the only one which will _never_ be presented in the
> 'tls_configured_key' attribute.

FWIW, I don't like the tls_configured_key notation either. But I don't have
a better name.

