Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D27C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cQkJUfpFwZxhG/i0oLHUj1K0uq
	YVCJFVjwuOxMnkl7KC0tCIebOOx3SQcQdrh+9kyLnkA2Ot0hikgIyuHRLyj85j84MXiaWLG4e+uTN
	FvOuictkSTDvEGUhZd/cl6b4e3hQw5RifVvKgBgQcA64kAZlDA/MKKoHVXhwaSNgQ5Ej6burJWpgq
	Bm9WRDvYjWCRGa1lKe3uAo9/uh7opV5j1VeOQ3dFF90yUavMSA3aRpCv4BSJbWDpUpmrIUuGbLX2+
	6o28VC4N+bFcvT65V9To3v+pzIPGyetCjicpJslS4wXjdqZlSJT9ou71wOTZMQ2a5PpjYK0bi8QqP
	QSl6bj8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rzm-00000003grn-2BFk;
	Mon, 14 Apr 2025 22:09:38 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RzU-00000003gk8-3zlr
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:09:22 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29fd22163so779773766b.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668559; x=1745273359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Be4iK2KjnHEVj+umDa3UdcJ69IQX8gaALazZLxwvSzhcR4j0dIL/kaj8UU6l2p0nuA
         m/E3JyVA0VBrqaGCsRk3VzkJkislOabWcz458sgppfm5MjXLSW9aeLVysp9LjRQMjuQd
         pYXrE4Eg/fHXTHa906Zsrsdso9gfWW9xayVJBlWa+LlxXw6b5O0vPc9GK3iMsOPSPUgG
         DqDnp9qbbpjffhMJb8BC+Z1b049UmE7qt/fw4AuQe1FQMdnFlUJyOrw/mcNt6uaATydV
         Q5USH6QFs8XsVu2X9orwgVRxi0uaHvDfr2z0ryi9/+ZG0IysF9nEzqaVMkL5gh9hZ1kq
         0Ywg==
X-Forwarded-Encrypted: i=1; AJvYcCVCF3jAvt+uY/9BHDkaQUrqSyih4ggu4n6SZlIKBTDO2YcfeDFLpp1HaDsVTpvC4OGavQJRapa8AKmG@lists.infradead.org
X-Gm-Message-State: AOJu0YxCWbMG5kZ9+uLxtpnGFAnQxb4Ub2fV5e8K7gbTZ54NKPEJtyfe
	DL0+bTv12mT3Q1d8bHZFYkpHdbgSJrP4HkksGXQEok9+BgiFIy2/DvYoIYIf
X-Gm-Gg: ASbGncvhZoWYbD6/BTj0qEgjwMIZRucenHq2jZvpgD3CxZZ+9s1uzqywO6jd2QvhRo3
	C+N6XsHRwIib/c2jYPHqDRLCZKS2+bh3xN77mVNwb2vmK4WsTd4sTkc5Ln2hxIWyaJipBcxmTIn
	t90H0e/qseRpNjCLjfzxhvZaQFPfLR87cUnBmdNMLhDHIK6mzjpqtRPBvYJ2jskwbStpDO4dT9u
	gE65WHRKudR96jAbAA2qi6E4LVB1aRFOfdRscSN2tTXf6oGhCkrKmb7N3N7tBa42Z8A5Ych29l2
	HbKjFw9lqSV9NcpcYwxJbvJKoWPEN1P74gqo8q1yT7T+QwbgOBrlmjJFr+NsIGCS3SGpzVvw
X-Google-Smtp-Source: AGHT+IGa8K+Y23T6nWqY03beoSA2OIEe7xMUXteJExek/QlY8eBcN4ZcgXzVOSFUzPCOxzBecneFVw==
X-Received: by 2002:a17:907:7e8f:b0:ac7:cfcb:c3e3 with SMTP id a640c23a62f3a-acad36a0883mr1378520066b.45.1744668559165;
        Mon, 14 Apr 2025 15:09:19 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c00c53sm976066266b.75.2025.04.14.15.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:09:18 -0700 (PDT)
Message-ID: <94478dce-05e3-4cc8-8ef2-467e00109575@grimberg.me>
Date: Tue, 15 Apr 2025 01:09:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Srikanth Aithal <sraithal@amd.com>
References: <20250414120509.49638-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250414120509.49638-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_150920_981472_E7B3B279 
X-CRM114-Status: UNSURE (   5.39  )
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

