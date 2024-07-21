Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB05C3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oGpNNE0fQmohe/3NFm3zr9of5WUFxL5w83Hve+2m2xg=; b=tbTkmBP3mQtsMU62DatCELiVYt
	TBPjk9S7nP9eitTqojyw0pVRCJPmq4N+q0klwjlDZTScfWEK6dyrIKzaqoaOlIRNY44aoBy6GJGU8
	30sFS+LevpRsra7PtGkYswt8IvEgxiJxqXbmFVvYrCmTnqfsLXY/SLcGklC7THJ/5h6NUY0CG6hJE
	hrl/qilhXuXHd0fAexv05UHLqsYenTz+lkTIAZptNR/xTQB4eiGKdglATJjzANEjXVKR/RnxhnAzi
	3LC+HxjIyMl2Y5fdRNUMWCLmUe51Ih/EkRwDFCRx0mv4ZvpREjFLjml6KDOgjXbtfhajpzMYYp/K4
	KzDgWpxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUnv-00000006jbA-3ync;
	Sun, 21 Jul 2024 11:32:39 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUnt-00000006jan-1nan
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:32:38 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4265f823147so1360465e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721561556; x=1722166356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGpNNE0fQmohe/3NFm3zr9of5WUFxL5w83Hve+2m2xg=;
        b=jw1Z5f7gmbs0Cgbrv3m3v0YAV9uxa3b7GMrzAwTZjUXlMcpI6lwnxEKguzvsDh09EN
         ChR/z7B2hR/hmxb1/iMENvxrYUEv80BadiKPj8CW7xGaYx3LGuMt+54/ShUbNIERh1mD
         gr6odZWdFwkCdDDKEMOID25QutLWORE84Unllc7om5shYSk9AKW+IBRNO4+tSMQbuz/l
         b76TPzb/XbauDmFAodaaXaEu5JrhTTiGqatF6yomr1rpFh/WKqQ2HAuXZ6GOJ8BovajM
         51CDTPPa7I9+NUrPgjkQA27/22h0EoOlV4ekMT2eI9D4TWVyz7k8EohGOF9BkAqUTmsM
         HxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvCAM1AZyhTta+/oVDCawmd7ZpYdhwsYU2BD0Cz7IDNcFtx2DvDQfjA8KCZO9XGw90DHR/JCJuR7oQJN5D4MeHK4elFMAievsJHSWkAEg=
X-Gm-Message-State: AOJu0Yx2egeEopOmQc7KkhC5YM6TkS2F72EDveTPE5+hYlHnowwMX7gG
	2odwd1dXK6C+Ejn+WikfK8UTR4/LqPFoocFrRrsc38LekEPaSHng
X-Google-Smtp-Source: AGHT+IHaTk72EUIm+u0iHYvtG0pxEVELCEwPVno9+H7d1oRfsfJTYOdZVt0sbfcaX+VALltxVfXnww==
X-Received: by 2002:a05:600c:3ba3:b0:426:6a0d:1ae5 with SMTP id 5b1f17b1804b1-427da9b5b07mr21001565e9.0.1721561555508;
        Sun, 21 Jul 2024 04:32:35 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868baa5sm5740282f8f.40.2024.07.21.04.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:32:35 -0700 (PDT)
Message-ID: <ebd59258-c49e-4da7-a5cf-78c4cc694438@grimberg.me>
Date: Sun, 21 Jul 2024 14:32:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: Implement 'admin_only' authentication
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240717110338.27332-1-hare@kernel.org>
 <20240717110338.27332-3-hare@kernel.org>
 <1b59c7c9-5d20-4d96-b844-88014cdaa14e@grimberg.me>
 <ee49dc85-d2de-4f28-a022-6afbfabfc458@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ee49dc85-d2de-4f28-a022-6afbfabfc458@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_043237_500960_CD12DF47 
X-CRM114-Status: GOOD (  10.99  )
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




On 18/07/2024 10:38, Hannes Reinecke wrote:
> On 7/18/24 00:40, Sagi Grimberg wrote:
>>
>>
>> On 17/07/2024 14:03, Hannes Reinecke wrote:
>>> It might be sufficient to run authentication on the admin queue only,
>>> as this speeds up reconnection quite significantly.
>>
>> By how much?
>>
> Haven't really measured; the prime motivation for this patch was to
> have a testbed for the patch to the initiator.
> But I should be able to get some numbers.

Cool, I agree that we want to have this.

