Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4406CA5FB7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jan 2026 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZTH3ZTdAE82r7lemIxd3d7ZZpxLSrkE7KxsaG+oA5s=; b=WXZfTwKkH4FfbnznL8mlWDmoyv
	n3cCNQtxZkjLo++VFkv5wn9ac32pSMBPqYE8gbOuqjMpzGj9KSS5gNND3kcXLBUY3s5xx7n1JlGBv
	ANNG4soUB7vYhT0/DIi8lIMV8140CeJ+8x38CibvvVYBfEIDDoYxu41/JzLg9PKvm/dAb/h4KUHdG
	eayxdrSydVsK1+Tcw1p4Os+9x2IzosdiQCiz+vWM64bOKxa7u1xw4MyklzSONiF+7xJ0HdK7uhiKC
	NqUjfO+z8sP9QQMQFSc7ISyhN7sjBOKUQbS1F22JYC4Qnn3kWOOLjnwbnePhzhQ+g37pSAZYbHAWo
	m1E/smdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTG-00000004ElU-1s8B;
	Tue, 20 Jan 2026 17:24:50 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTD-00000004El9-0QYs
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jan 2026 17:24:48 +0000
Received: by mail-qk1-x741.google.com with SMTP id af79cd13be357-8c0f13e4424so617321485a.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jan 2026 09:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768929885; x=1769534685; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZTH3ZTdAE82r7lemIxd3d7ZZpxLSrkE7KxsaG+oA5s=;
        b=HEzARsEK6yCnbTrd4TRpF59aG1qYAm1HcuJFxq0O66y+c7d6mV3bbURJw0fr1G2qA8
         v5NaD+GRcI8rNsZwn/wvqBq2PqT9x59diM6lT3Meq5mn2aC9UDve2E/V/kWDkUfWSn+8
         In3CUeDQFpZ05NO8W90f2wN2gaU//s8iaVXLshW/3N26zA+nFcH99mwDfwY2pFrOzr4Y
         0h8wpgsnjjU5ouor+5NjIPx9RFkerltQbrALp8bbqrFpagBL7vFxQ8fJjhy+23A4MFBO
         VU3wC8SMJEtACDxnJEwqetc8H1NQP0tgRODPMPB1Wf0/kfxaTnNpx6PSmpTitJ4c1l1M
         OOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929885; x=1769534685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZTH3ZTdAE82r7lemIxd3d7ZZpxLSrkE7KxsaG+oA5s=;
        b=IGVQMUqPErEFpl5TyKsKSqSuO76ENrf+ea7Tqb5wcOPXCG7PfcIsBNSz5ChafSOapY
         8INl5E3u0HLVJaUNC4WrfBG9yNEbxhQmhqz31epLdMjn7vNgngm7xC+FII9UEo2PT1t6
         4bvAoQwx6KKpsuAJWehf2De+jmTgOGIbedf9dl5w/ICdIDGGMBBuTsQio0KahjmMaLKq
         y6fqwY0/Jlyzy4r10DRKN+z2KYe6s9/UQ0MVvLnHzqqGVfN80NfqJJ+Zt1t4ErN8N6BX
         65e4YIgRbAlkJ64blNPAWdxUuqrPCNktYHytAtPc6SfIgmrds32PcbXjkEAGehu5/Sqa
         sgBA==
X-Forwarded-Encrypted: i=1; AJvYcCWp9wLGdq7hkf1RgfRPRoJJcWk4x+lLFiICp8QqRHFNPI1oXddX4U6aOLb1D45mgzwBcxFETo5+Ln+P@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2VXnqHnroZq3IP0yGBVzu8MjuuH2o+ZVzW10QuIrXrhjK3X8D
	1dD2CVauGo0OcmIQ12SNw4Z3q7X8j/7PJQPbqPO30ljrWYW8bOjo2hklNQxVlcUQ2iU=
X-Gm-Gg: AY/fxX53p5JJQIwBAaTAEB5n8vhwmVIlPyleF0rxg9FBX/F+gtunpQMDSHRP4b5UVVU
	gcdIoOBb0GxsiBGRTlTwZy+x+OZzopAB8ZluBPmqITMbXyaNRwD4/Yzum1ZUdier6TBNRXG1YJ3
	8s7fDZB2kp0GpGs6Vv2bdnvCxpQ885IbmzBQaU0eYqYgxvjngB8fxuTHnzibJkJLmgawVKiidA4
	ASaSUlbFdtq/2Tua5DqrEHGMAFNsF0Kp+HVLRvlH8bGgqrwIfVs1xeR+IhZkGc6qosU8jB6+KTX
	q4PsuL9v8SrFd9C/SuvipZJ3lkCp7zqfYdXqUxP0UR8YZqJHDBeVyCMk/oaJaWGzbihlwXZCwZ8
	odM3cd/uUn3fO8Rhtd2berNgSftpZVsrHjbePXw7LbOOfFnyppWuUz9tMAtRkU/a450Xw3Qtms5
	8oTtURpfy0HOB9fZ0kv0Dq9yIzoflEJUNHPQ1B5S9a+JLSK/IydXj7Sd0eP/qOJWj02aeS
X-Received: by 2002:a05:620a:4054:b0:8b1:110a:e14 with SMTP id af79cd13be357-8c6a67648cdmr1965912185a.55.1768929885180;
        Tue, 20 Jan 2026 09:24:45 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm1070802285a.25.2026.01.20.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 09:24:44 -0800 (PST)
Message-ID: <1b983be6-ae2f-468e-b306-3889d0b78553@kernel.dk>
Date: Tue, 20 Jan 2026 10:24:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
 <aW-2Q9Zv_UNX127Z@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aW-2Q9Zv_UNX127Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_092447_416997_DE6A1795 
X-CRM114-Status: GOOD (  14.49  )
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

On 1/20/26 10:07 AM, Keith Busch wrote:
> On Fri, Jan 16, 2026 at 03:46:36PM +0800, Ming Lei wrote:
>> Hello,
>>
>> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
>>
>> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
>> context, and improves IOPS by ~10%.
> 
> Looks good to me. It feels a little unfortunate to have to add this
> parameter to the callback just for this one use case, but maybe there'll
> be new uses for it in the future.

Yeah I agree, but the win is large enough that it's warranted. When
I originally did the task_work fix it was on my list to investigate
further, but the bug was such that it was better to get it squashed
first. And then nothing more came of it...

> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks!

-- 
Jens Axboe


