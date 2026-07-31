Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0407FC54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axVwyepzuz5vs7KCy+kgdXSLK2Fq5ai7WRMb+rYqcNE=; b=2aLjgya28OUWtSIcqK9lo+Co1P
	hXhycEly4ipO7Jy9PAUs1gnIv9093loHrNk2/ddcb6ku1mZRKEwdC3sNHulkfqTSJnhS5Xhvvim06
	P8FZhyYwePZop2grJ0ticLUGHwdbi8tOLZ7CluTFqpmFquL6/zzv467vmzFtPDYsHiN0pJS7+HGxZ
	+oumQgU2mtOalxlxEPgBdxDc90GxiG5TUlbxUl2GYwRFwxsZC5I6Y27fqndPv81g+WznSRAzFajEG
	FM7FaQYkIgwP9XkyO0ZEuT7eUGipzTNy2DP2XGXVmaV5rBG/p3ZzocWtNXhO3yQXnLjfjUY6IFvzg
	8oNmlbvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqIJ-0000000DAGv-2aTg;
	Fri, 31 Jul 2026 16:41:11 +0000
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqIH-0000000DAGC-17Ow
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 16:41:10 +0000
Received: by mail-pz2-x01.google.com with SMTP id 41be03b00d2f7-ca8758e7e94so45929a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785516068; x=1786120868; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=axVwyepzuz5vs7KCy+kgdXSLK2Fq5ai7WRMb+rYqcNE=;
        b=T5CLhV/9nzqDSD8Yu879o3GaWfY2aXeJmMxgjDEm5M6RPRPcH6PINfXuxj283Zz7CM
         D7mljbpujXTL4wypxSFjbezdeJQiUOpz5vskRu9RmBQgIb4lcRJuHeRDSQPoMF3fEmlM
         Mh7lUiW6qE/8nHzIPscfeCsLVHjQ4thuk9kYYqOOTo7yVq0cB+wEcjDaYpLVB06uksy2
         lzftrGEBhJJZSSQEdnxma5oE7e8j2UGu3HoYEVMJdTOU49QEimOArYGDzNLQ1dkz7WKt
         jROpM7LC7Q1vPtPMDLscHL68rDYh9hPw3laMOd/dI7cM7LgQb8f7sDrTKlQ7oZ9Mr8y4
         ScmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516068; x=1786120868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axVwyepzuz5vs7KCy+kgdXSLK2Fq5ai7WRMb+rYqcNE=;
        b=ps7OpwPA391G6gTa5Rb1vyUUvmQgcdzt2pFIXs0QHI3kNcZpiGAhoLHikYFY3to2CF
         h9Rwq6q/I7551j5VEBLX8k5+HB6M8Cv6m6v0g1CmQ4ruRwbAuK5J/K/NZOiGzHPcz+5l
         4mxoj2i2qa4dORuFZpsM++b+ZOskMaaezsjs7hc1fhgoLNt8crGXRVqxq6RRF0krrGdZ
         TpnSGRrbZuUceBHwicVZ/Mf4tIfTRWpf5032/VR1UZs2TnWKJ49mIKerhoz08hR1V7Fc
         rlAVlbGo5UQhKKszOngQQ9TeMYvuyUoUX69xj2x5hzh7w59k6RKPMaZBcb24j60bGyU9
         4Xhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1MNFnMzckYn5hQmrhRine8dlWFRLOsOTA/Lghv+Q9PkxpakN3Gp1/F6y4HZpTNIQEA4aKRiShSaMF@lists.infradead.org
X-Gm-Message-State: AOJu0Ywy6kE0YGattEcUWStjFwEd4GoXr+pEkw9B5ZLqmMtUQHO1qsIb
	b5/hs59Ex9ZKXeIol3eOz2pEVUBLt7mcxzH3a600EyqX1gNeVE0kHQVR
X-Gm-Gg: AR+sD10Q1mIRcNhTDpcJDB/h5ROwevPaVwxA0IPth09OdHXWOMkKBOQzOKk2tV4X6ZP
	iwgGIa2jdRKJyisD7rxpSw41QO3rPHks0ZRux4PidpHRhTER6ARCZ8oLCC+SVbcB0eljgmQ3L2V
	AuHCNiJPO1IKUk0jLdhyUsVqLoi/dpYlc/1RxRK7uhhxtFwGO6xkrA1k3tF/YpGvmtCWOiewvFz
	Hx18ggrqIQdyDkyCVpI2aApfz8ScZ3Gu1ys6VkBRKZ4J1PlBW6pDBZDCDf5kXOpikZSb6oI2cjU
	k82yddEw+owYElhjVwkbnQ/L4WcjwIisf5Pujfl4zbhlCKZGQs39v9vOdc7wLwA9V6kk/u2EduQ
	3ALHJktS2aLvxZgNF5QJWixZpaOV4wljyaRPcg+JihqClH7VBvitmYiROQCooL7+gQi1AbRZaUR
	AttCv9qbxNwyDgyCJqCxNvXK4hAf8VKgqENx46FFfHxL7j6pRA4v1V6onCZ4riMN+r
X-Received: by 2002:a05:6a00:a254:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-84ee4844d1dmr300123b3a.12.1785516067920;
        Fri, 31 Jul 2026 09:41:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm687490b3a.24.2026.07.31.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:41:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:39:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me, 
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/4] nvme-tcp: NIC topology aware I/O queue
 scaling and queue info export
Message-ID: <amzPgFs4whuvrnUW@devvm7509.cco0.facebook.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_094109_328811_2E517094 
X-CRM114-Status: GOOD (  16.01  )
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

On 07/31, Nilay Shroff wrote:
> Hi,
> 
> This is a resend of the previous series to include the networking maintainers
> and mailing list. There are no code or commit message changes since the
> previous posting.
> 
> This series has been updated based on the feedback received during LSFMM.
> The changelog is updated accordingly.
> 
> The NVMe/TCP host driver currently provisions I/O queues primarily based
> on CPU availability rather than the capabilities and topology of the
> underlying network interface.
> 
> On modern systems with many CPUs but fewer NIC hardware queues, this can
> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
> resulting in increased lock contention, cacheline bouncing, and degraded
> throughput.
> 
> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
> with NIC queue resources, and to expose queue/flow information to enable
> more effective system-level tuning.
> 
> Key ideas
> ---------
> 
> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>    Instead of relying solely on CPU count, limit the number of I/O workers
>    to:
>        min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
> 
> 2. Improve CPU locality
>    Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
>    to reduce cross-CPU traffic and improve cache locality.
> 
> 3. Expose queue and flow information via debugfs
>    Export per-I/O queue information including:
>        - queue id (qid)
>        - CPU affinity
>        - TCP flow (src/dst IP and ports)

[..]

>    This enables userspace tools to configure:
>        - IRQ affinity
>        - RPS/XPS
>        - ntuple steering
>        - or any other scaling as deemed feasible

Can you expand on this a bit? What specifically helped the most for your
tuned case?

