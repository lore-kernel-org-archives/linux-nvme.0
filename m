Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F1EEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UT4sjaDwcFqKs9Obf7DcB5pD7crKyvQ8FvzUnXWxBBw=; b=ExgKbDjEpej6bitjOvkkQ4lfym
	8IkBg9H8LKxy2obphrkUO/TUY1p+bJCISVNQ9K40dx51o/+4Pk4FLBlaUztKHegy/xNCdoC4ySifW
	HqnUfhWRf2EhwJ90iWwjixq9WGxkzT8DO6LiBbABaOzIqnZe1qfPhmEHXq/m3n40yj4gGCrTKKkPN
	ZgL05dpuAupOaea5JRxUQkmZzaNkAFMCo8WsYJ8KUQm3znKQgRJdyC+QC0BgpeeTUGf1hAWea+LTH
	pCueOka5GQdbMkYmAjYuyvvvMLbx9F9u1HRmlGR+XaPQX4dzUUmLniVhHvfhuhwDBSWF5gYvTUUbe
	qtputSWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaNW-0068Rh-0E;
	Thu, 17 Aug 2023 10:37:22 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaNS-0068OX-0e
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 10:37:20 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c4e426714so170625666b.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 03:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268636; x=1692873436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UT4sjaDwcFqKs9Obf7DcB5pD7crKyvQ8FvzUnXWxBBw=;
        b=bstX8Ze3UecXn1FR+05Ep7DT/hbJW6gm7SW5iFf96vgX8nxAsET7UK8Xi/fUYmu4ul
         JbIZLMpa60JdnSChro25hy6aWYBX1szAzoWPbZdi2djKE6whvyFi/xMGLVvnTX+njUjX
         HqKIMnQQSBphvwXzyzqXXankllcIVrtvGIGZzDoZbk9JC8SwtXfR+Jwx6YK424FOS8gV
         nVhRdrw87y5ylEfEH2DWKR4r51/m+Fv3xDHrmr8jZYhDNi1n7yum1kMbSBYr04mCUEyN
         7vRb2JphATDAaYg+2xyG6Xbme4CpTn8cApE7dbzzZnjy6vZLl4z/XGOjTe4OweZmpbDY
         G7bg==
X-Gm-Message-State: AOJu0YwTtLsmtKdHJPXdkEp+U7I7k32S9Evh5MIPPQihwC/g3QowbP9y
	sXF8wJw3PQJ5KcrrFGmeVmQ=
X-Google-Smtp-Source: AGHT+IExmbugO3B3BJT51InwAUVJNpOJ0kd72hUoHfrVOqOOASvUX/N101A0kixmust+7ojPHWvLUQ==
X-Received: by 2002:a17:906:2098:b0:99c:db0f:e115 with SMTP id 24-20020a170906209800b0099cdb0fe115mr2852385ejq.3.1692268634181;
        Thu, 17 Aug 2023 03:37:14 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id gr12-20020a170906e2cc00b0099c53c4407dsm9969733ejb.78.2023.08.17.03.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:37:13 -0700 (PDT)
Message-ID: <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
Date: Thu, 17 Aug 2023 13:37:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_033718_238923_8A761C0D 
X-CRM114-Status: GOOD (  15.52  )
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


> [ .. ]
>>> So I figured that the current approach would be preferable if
>>> we accept how to expose that for a given kernel/driver, we can
>>> accept dns names, or we cannot.
>>>
>>> What do others think? Christoph? Keith? Chaitanya?
>>
>> Anyone has feedback here?
>>
>> Seems that we want this, but the question is how to expose
>> a new format of traddr (now can be a dns name) to userspace?
> 
> Or have a new token 'traddr_dns' (instaed of 'traddr'), which would
> hold the dnsname instead of the ip address.
> And reject inputs where both are set.
> Hmm?

I listed that as an option, you should read it.
There are some disadvantages in doing that, it needs to co-exist
with the mandatory (today) traddr, which is now will be mandatory
only for fc. And also now the user will need to decide a conflicting
existing functionality in nvme-cli that today accept dns names as
a format to traddr, but now will need a different argument for
passing it to the kernel.

Anyway, its possible, but more complicated IMO.

Plus, I also think that it can be useful for the kernel to signal
capabilities and support for things that are not only valid tokens.

