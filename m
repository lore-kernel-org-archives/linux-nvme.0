Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB65C54E65
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYwhYnGWVwEVKGqlxO7W8vyyzWzB7meGREypDuCzFrM=; b=W+r9uMRVKz9/2Prx9DQRmRKL1K
	yGE2W0AqffsLHAP7FxfiBsebRAS8m0WqhakWCuZDg0sT4pIyIMPpMndNjKgSJc6nyYE2kKneFEC2f
	ssfzIUNF+wuNU+NfLxPnRqOXlCaqL3Cz4l0RGgiGieK2FKwDjxA+JMMwEzHMNcREn+kZHeqh7H2AQ
	nCOe5WV6xAh6qp42aBupuhhbRDys49D+Qe+0nYHIdHEAqoF9MymbBs4zNMZrgXcgyg+NWWSyfxgUm
	CGgkKCABizFqVoqzuTpr8Tcn9x/8KeHBenMksTKXo367NwsiNFIVT+DtXfjz/xtkQNZ7yTQJDGSiZ
	SOsecGOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHfql-0000000FKsb-3YVi;
	Wed, 21 May 2025 09:34:59 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHfkH-0000000FJSA-0UwD
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 09:28:18 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-acbb85ce788so1286262466b.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747819695; x=1748424495; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwhYnGWVwEVKGqlxO7W8vyyzWzB7meGREypDuCzFrM=;
        b=KwlFtE6ThA1oV0A9b/zRCXPXVyNdiMQZzENjF0o7DV/4BSFeYQmv5QpdXYnzd5JbG3
         eQPsxwvJAQ76sbSKgoPapQ91IO4RKps5ONwTO/4B+g+H1bVkOILa/X+CJpH21YrRhuwz
         w2xb8KzgP/z2R28UoAlcs2EPTTeeU3nyHtSGaXalO8UUYMzg9o4B+IVIACYCa0ufLfm0
         oMN1JqmPD+qtE1IqXhclBaUwNMmGNOMmz5xUxE0pBrXk19GY7/SQpcjIH7tKWdH+C+OV
         vyx6dd7aP/NHI4qubvKGISM/q90HDomse1guhE4dw+OUqOIXCGdjaNOqOPt2wn1UWZGJ
         zNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819695; x=1748424495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYwhYnGWVwEVKGqlxO7W8vyyzWzB7meGREypDuCzFrM=;
        b=vh8DjPl+cb99pZONt5ADHysC1K67Uvq+0skAzOy3CDx234HqJ3AZ2RMlg7SFkvDDcS
         OfdsMZBvOBRko4Cyzh+NclqUZfh7IpuEzSqZak/oxeJqJ+06qA6NkwuVw+aAyH3zn3+Z
         tKuMZUxKxaU/h5JD6hODI0t9DmJ6COZfLdyaoZ9oOUsqXSymex5rw7RgO0xqWnhhuBjK
         XJ+GCt1Xg+T1lA4uWO4qQZbq02ugreuK851ln/YwAhE9JJ3AGhzzNOcJzJ6+6wYrwdf3
         7myGIQ1yE9r4IksKS+C+Inslb8kaTCOi/aGj6yngntgZ1cwwp8Xp7dVH59JqXZPCQi1w
         LeSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9gsouThtZaxK0dNPevEUr5THt5uSBkLtpW9iYe6+dY58gxyJMyGnLuLOiW8Bd2c16piNLkGSs71Tz@lists.infradead.org
X-Gm-Message-State: AOJu0YwsDFDcpOWygetsjBEQ0xh8oWxlBc+FtoK6Ag5lDqFOFgRcV6Zg
	SpGf4nlFESS+uBpGSF9xc0tc6lcKbmV5oYZe0Xirzf/WK+u/FPD5vH+N
X-Gm-Gg: ASbGncsS7g2C3EugjUAyGHdDa2xRvrBHO4i38zKVfdRb8qM9VD7J9EYKOu/iCZxjV+x
	n9UiwyBevAlC3yhgkc3R6JlGWGDB145dnXAc8GrSLSp1gm4UMM+TKVSxaRdPtjzxbHBKGn32p9V
	0I/v41l3xZLzipUll2rANX16dQdkH1laPvYnuifmCEVwblYq2WdmYrVF19r6PnIveI1DkMZYwD8
	w7oVcIXHZrgkE7pT9GVUYvVBUy8oGcLLJ3ngbMw3NEfSRtbBTY/FTx94XwpMyv1iLvRDQqIu7gW
	cDtCONWYgZ9DgDA44+Bn/gls3CIyeUeo1q3HshoXihE1DyiqH5fR7HKpPgvchQ==
X-Google-Smtp-Source: AGHT+IFb3xwDlyAGqIC/BE1Dpn5v5zIcQ/GFq2tnG6lNCppqLh7Wyk+i1UqVD8rz4FuxYvxGL2M26Q==
X-Received: by 2002:a17:907:9814:b0:acb:b1be:4873 with SMTP id a640c23a62f3a-ad52d45ac94mr1658785566b.2.1747819695037;
        Wed, 21 May 2025 02:28:15 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::3de? ([2620:10d:c092:600::a96b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60231eece31sm1041471a12.51.2025.05.21.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 02:28:14 -0700 (PDT)
Message-ID: <e57dba8f-b90a-4052-8dfe-e850c9cd9ea6@gmail.com>
Date: Wed, 21 May 2025 10:29:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
To: Keith Busch <kbusch@kernel.org>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
 <CADUfDZpkUnWqtiMBOd1p=Ws2HuQDZhLr6xNYGmfXswwJ9BXpmA@mail.gmail.com>
 <aCyj1Yk6UT1x0Ysj@kbusch-mbp>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aCyj1Yk6UT1x0Ysj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_022817_174152_1D9B1A51 
X-CRM114-Status: GOOD (  16.64  )
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

On 5/20/25 16:46, Keith Busch wrote:
> On Tue, May 20, 2025 at 08:42:36AM -0700, Caleb Sander Mateos wrote:
>> On Tue, May 20, 2025 at 8:28 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> nvme_map_user_request() takes flags as the last argument, but
>>> nvme_uring_cmd_io() shoves a bool "vec" into it. It behaves as
>>> expected because bool is converted to 0/1 and NVME_IOCTL_VEC is
>>> defined as 1, but it's better to pass flags explicitly.
>>>
>>> Fixes: 7b7fdb8e2dbc1 ("nvme: replace the "bool vec" arguments with flags in the ioctl path")
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Keith had an earlier patch to fix this, but looks like the series
>> never got merged:
>> https://lore.kernel.org/linux-nvme/20250224182128.2042061-4-kbusch@meta.com/
>> This approach also looks fine to me, but not sure if it will
>> complicate some of the changes Keith wanted to make.

Aha, so it was caught before, that's good.


> Thanks, but no need to wait on me for this. I will revisit these
> cleanups someday once I can arrange for fewer distractions, which may
> not be any time soon.
> 
> Patch looks good to me too.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
In which case it'd make sense to take this patch, but no objection
in either case.

-- 
Pavel Begunkov


