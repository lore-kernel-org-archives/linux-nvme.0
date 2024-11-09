Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F2D5E369
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 12:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsuXcRen0aJbgkvED4OFHV27I/eoszV1Epwxmc1q2I0=; b=fyn8KD5Lr5gydIpqcnk2aFN3RZ
	1A94MdC9dDl69GA6cd71ZY8kyGlAjJyFXg6TRwQbKjXBqNdA7Tfu4+IZczpZleWXAuwspXUGBBtgL
	zWFh9cdedpub2c+HtAefj1mWN+z8P+6FzKTcOO9ryfO0hjsUjxu7xVqoldqzwsrW7udfzsqy5FXOz
	/lgvWWJmRvOiKtmzw7JgRI9ESedORaS7toyUN1bkXQ53GubfvW7kU/3onscCpT1vPte3hVPHRsmx8
	rqjg1SvSzM2WUlegyKdQx2mEYl7cFOOT3vRajaea5jcNotdU0McDIerP0mtA7z6DDvqSZdwWRLBiI
	5ee7vxMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9kU3-0000000DI37-0gaq;
	Sat, 09 Nov 2024 12:22:31 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9kU0-0000000DI2U-3CYP
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 12:22:29 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso31873805ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 09 Nov 2024 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731154947; x=1731759747; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsuXcRen0aJbgkvED4OFHV27I/eoszV1Epwxmc1q2I0=;
        b=Dxk5z0BGwUZc93BX2d+8HEScL8xSpt/CrdEkkOzx7c0mumDN800WwRes8vC84GB6Wx
         a5ZN5z5scIDUU5fgrxG4ijXcfLCRP128ShWzQpqDxtpXgJxppX0/RI1EK7jACouZviyF
         6NIrGgVNnBlcIK+GNGYn+ADv11dN2McJv2HiL42kTSB7NE/omMNuBeEDOjkq000+QN7l
         H5V61Ie2ZZGwZ1F7Rw+5bWgAWPGfPzyqV0od+aM6mTFsWtm9HeOBdPqW9wuVkFWWZK34
         ZsDHfz7vmVgMiaw3uA5rxslsHfGObylkujoQZh52JtwpRwNYbLjTibmIR3HCxgJOf3CA
         Iodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731154947; x=1731759747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsuXcRen0aJbgkvED4OFHV27I/eoszV1Epwxmc1q2I0=;
        b=Lr2AlJJJ5KRKsPX8R7QcGAwZX6LSN+4ihqMQHKm2BXPKbzk8rrzFyLYDW32Dk2Gvvj
         8uPKNeemP1BkDp2hqv5+ajpUIBZyfxvhreZ8SSNGsKmBoDHG7+sFUgX6fN+r/Ix2DJZY
         kMRqvv4VbGWbI0hPlbrYnWjIQMqxBwpaD8I0kcXAFyPENnvbAwbll51Ca68ThEFbpQSO
         BFj+U6YrQenicDgUEYke+NlJI0M0qQneiizUn4wmUYLzVf2y2zFEfIoVdrFFVV9x5uHU
         f/7Uc4kBh3S/I9KEDxYhrqojsaxiUAKHj4Ch+kPBjE5jWmuhwctRO95NONSpH8tdbzqn
         UBxQ==
X-Gm-Message-State: AOJu0YzOzRK4u9tbgvAwXn8b6ld/Fxf0k5HS5k9sq/FNdzsBolQzCykU
	iQe6KM7Sg/cD0tGSIZGqeat0V/7/0JDWVG+EwJC8FBh7z9zAA+Dc
X-Google-Smtp-Source: AGHT+IG2DRrrVA/9QY84gHrVSIPkkN6oXtpIPFqmSuUNQ1sK5lbfntwqb+3kbK/0C5AgONkjrFangw==
X-Received: by 2002:a17:902:e5d0:b0:20c:d578:d72d with SMTP id d9443c01a7336-21183cce89dmr79188665ad.7.1731154947544;
        Sat, 09 Nov 2024 04:22:27 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:c1ce:644d:cdf6:d1b7? ([240b:10:2720:5500:c1ce:644d:cdf6:d1b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddd637sm45647415ad.69.2024.11.09.04.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 04:22:27 -0800 (PST)
Message-ID: <d4b0077f-7d96-4021-81c2-02be1243469a@gmail.com>
Date: Sat, 9 Nov 2024 21:22:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add temperature threshold hysteresis feature field
 definition
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241105145628.11833-1-ikegami.t@gmail.com>
 <Zy0zu0lXqFghcq8R@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <Zy0zu0lXqFghcq8R@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_042228_834172_D0EED25E 
X-CRM114-Status: UNSURE (   6.09  )
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

On 2024/11/08 6:40, Keith Busch wrote:
> Let's not define new constants that are not used by the driver.

Understood so just added the driver feature to use the define by the v2 
patch.



