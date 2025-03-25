Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F7C36010
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=; b=QyFfdaZhhvsrrPPrNFVey07ajO
	w1lpy8pnRVjC4CnGjHiFnEJvncZTvDKxjpPsY9rwihWvfZhGpQuJGMYrftuo1nS5A3LG51sfTuh3t
	EJyQqCX2J6mnmTPckWKFFU8AsyIHhVrV5DOGIUZ18rKkW7tzgD+myRu3GjgTdhHmxE711IRyrZlU0
	DBzrtbDk+Nlqnkc6ZIUcsSHx0m8kiHdL4Egz8nAH06XmaxBc8ntjn51m0aTgHOAUE0l7SjwDLDrgd
	O+cdzuXJR06OMosRAk/hIUqFAu9P6Wgk6G09ogHcJ1WMDCZbEs4VlPlSJ8W69mK28jKy83pfXhf+k
	VO5HZwlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3wG-00000005xs7-1HTA;
	Tue, 25 Mar 2025 13:03:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3mA-00000005w8o-3b1n
	for linux-nvme@bombadil.infradead.org;
	Tue, 25 Mar 2025 12:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=; b=oMJ0wLAg+9opnuaZYbrvduDzv9
	p2izheCnixwCJsC5d4+b1MDO7NhoYwYQj2bNByJFL8KMII8LqH5qI6lFXslu4zccnxuVKPmjisDeE
	W76r7o8hSAIfxMHrcRZFM3+0TTokMfP9o9HZCc3JNXeTOxjZ21YCIk1zLcUP3YvzpT78LRwE1pZ7C
	Ap3ykLlQ0/OzCF4bxjKAzE3l9e3xZiA9UKcfHyDd2g92BD+7c2Qxk3igBQPslfPmYcXNvf/Wb1wFj
	uUBd6NsfD7FeqHcYfYBMuuhW4hjAqgHM5A+5kMMWlnqt8IRjHtBGEbNIKnrh8MjxIoMIFvo/9AbcO
	JfmyzCdg==;
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tx3m7-00000005R1w-2g0S
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 12:53:01 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7c54c52d8easo711498285a.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Mar 2025 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907176; x=1743511976; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=doj3tuzCPYOJTjoHmMYMylt123zRSx5SfcXpZUpEqW41QOW4dn+QwfYv/+5ajqbZ2A
         RLnxV9AlCBC93Yw1cLI1a42CDU9vLu2D3lQUXIcynYkfJZpkNY6cx8aV9iGlSXahFDHE
         GMI5UfDuLbHkxGrhB6399IAVsakjTq95UoPljmhRHWNo38d58PTFImYaUqZSGE2DNltH
         0zjfDe6hcjQ2J+p0eFcGFDEqc0iom1VPof3QLbcZ/Zg7mO2xUylqElbJIe9gDpBIKHcI
         tND9bAXRdhKRATz1RMbZ70MJjJ99lNuCAdrzvdohgEMcmyCB78kWccTZP7sNiD/0t3K3
         nCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907176; x=1743511976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=o2jozuo6QX+slfcKWyjKn1K+RcAqEIMUBLNv5e76FIynZeULggRqVqjjDoPKB2oO27
         uH0LAzR9PkXrNy3g5arvA3oB0YanMlxwfrx4scApsV3GMbYpLHCUmOCL4O/O4OWVRFem
         1qONopb37hV6a3nz9k8SWaglZXAXF4gYtMSGg//byVrhiNYhiP0LrHRYEc92+kHi+L9a
         +XJhWT7Wjfs1rb5Lia3rF3t8SZai0n3z6fV7O4Z6n05/D1wSdCsKWII7gYEgxpwAR8qO
         iLbTolNDaD2e1LSVFC6jzWKeFFJ35ipDBj4Zp1tgpcuVrHWRmZd+r7lz6IIsrpO2I/6a
         aFKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNDz4o73Wf5DYNgvRTBmkhzt4EwEPncKI13bw5U3d4dbHFutYZay9DjTPLJTCxNIPgQf252U9etfJe@lists.infradead.org
X-Gm-Message-State: AOJu0YxorEYfMXv7LvchcnUenn2BW6HtZ2xeu+rRdNP50Fdr+GP5HBak
	cR6+ASMYXpgW3tDvERxXtSjtj3//XG4KjRqzPJ4v3pAe+F+ieJvciwi+2HRQFqU=
X-Gm-Gg: ASbGnctSTnaiM94F+7nJsj+5YubSqAYcFc+R9faVXHltsoCrLu/Nyo5pgR1S3KRQsKi
	Wc7Vc/pONEfVwp+fsUt8aMB2/7hd/eNjPMNaJJl/Y0Dq//4sUSidbTsESWT82iQWLeZy+ZEA6p5
	2d2m6S+EayTX2yd5zMYNxZqwVrrcl0H+eCKQmOgEjTlUmpEgAIxiRUQNuKMj+aUDbe7n4GbEjC0
	1KPsRf5voIvXsthSio0CkQ+2zoKvs7gIVIukp3I0oMLj3vT9SXTz2aEKyYpH7xeD1t/WMMrrute
	K9HMUzc3zW04X8PV3WCNIPY0ZLnVmXCjADveMB/AIA==
X-Google-Smtp-Source: AGHT+IGuzAh1m+3Da8HMyPjo4cS8BnNgDmCwUc/FwsVtlsCsRku7PH5rlGDzAZSOlfFgYFdymsUcNQ==
X-Received: by 2002:a05:620a:4554:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c5b05296cfmr3274590385a.15.1742907176053;
        Tue, 25 Mar 2025 05:52:56 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm144992485a.90.2025.03.25.05.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:52:55 -0700 (PDT)
Message-ID: <846fb871-c171-4f31-9097-5396aa9376e7@kernel.dk>
Date: Tue, 25 Mar 2025 06:52:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-4-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_125259_886625_48C50BF0 
X-CRM114-Status: UNSURE (   6.27  )
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

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

