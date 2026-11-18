Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102C606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K8/gv7vp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NEyw64RX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IIeG/OYAPKXy4APgwIqvJ/o0UacdCmwD2riFFZBJNFQ=; b=K8/gv7vpE9gmF8
	xbJ+4WqejXVR1KFDMCR4jF9yhQNg1zpCSFfaMtWXYH/4oB4UP4f6bx5uYFWIaJvFegnZnpHUIiPDi
	pHOMvTCIF9kT3rCz95OmDRR3JkqH2tmr26mlBeAFFqnuPRC08M7NQv2EcUOrg9O2zEoh0/mBma+jn
	Mo+GFN2Qa0/m5Uv1/eDNjf41U0xaTZlJVxxQPBegR6Lahlx0bu1XIpqdHWCxWacUf7dotcK+JQdP5
	Lt5uZFyqmTEld3lzjFLRFypFWeQ6k7702+neKN2xwQz0fnQlG7aKcWvHa9jE2CZRmcyz6lnnIUF6G
	5K10xDLddy/wuFfodq8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTV1V-00000007VV8-3GAk;
	Wed, 18 Nov 2026 02:03:45 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTV1T-00000007VUn-1mId
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 02:03:45 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso804527eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 18:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794967422; x=1795572222; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIeG/OYAPKXy4APgwIqvJ/o0UacdCmwD2riFFZBJNFQ=;
        b=NEyw64RXxvXc1xYiXEKi4uut9jfiCp+bqRQ8kAxIlZWAgCNjKKBJATvu+fj9wsnwNr
         octDB6OJETa+lZjIdmyhZ+KjMxoRSgx51HU7ckJwi6ofUpRrjhVu9dsjDm+/cVkVeDKj
         /1YYbsE5tsLdZkizj96X0f9Gzv31gR7QbU04qomVYPFBSljxrCy71iLDOBtGdlz6f+fp
         Doq4LNaUN7WBCQ1EE8q6p47pqn34sNRdOZoJytTKQADMxiW6r/7N6Y2mUPOoWhtq3N7U
         /PZnFrKlm5nahIko861B2I74AVE/S+nsdqgDDPwFkHcjckqGyJyWUzBl/2ZLYUf1Qbec
         J0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967422; x=1795572222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIeG/OYAPKXy4APgwIqvJ/o0UacdCmwD2riFFZBJNFQ=;
        b=pl/N2IkCSPCRPcx08hV95SBZ3jYugJ8u6cqNwU3X9tEX5CWBDiYVIkmOsnXK2qKT+e
         kpie0zCo8qHhhKXVJGR5mJMN+BT4S6zsMFjCEd9ne93MP4WnF8Fo2xOm5EZ3ttPRzBl8
         iJ9i5Tk7NyQAG+VtzH1S+BKEWms26D8nNF+iUjTsowbRIYaIq2/KZ4JCz2jIzY8OqwIv
         IzIziyI+e5X+sBYDJqUMektiAh0ut/kfLS0b1yB1c1VMFrbRzG4LRTDoq/5imkdZnpTx
         CSXLuEE7CgNIp6Rc6FR8WAn0aGFt5gIvwNqm1j2xcM9pXWGqIOWMkpzPeyvr3Il+lALa
         WciA==
X-Gm-Message-State: APuU4Z/C/7Glq7Q5RtSeVWH4GElK0nKyE0cwf6Eo5KGdHmERb+0nSlEQ
	llUvWoPKHAIBmdH8mj0QkVXPYCKqy8P3EqyHMRH9FGOF2zujYBYYKNMvm5ZMo+4cEIMVROPMhbN
	FRqdtlWY=
X-Gm-Gg: AZFdTZel3G3Via28uX+2aib1NJTc7Jicu6zVjuK2O5QczQKy/VxkarOxRPHOKBM6HH+
	T6I1IHSWe+RRmanzR9iNJfXh+/JL4Grd5Z+fNP2Q5iw2vSTQKUG/5FTXQoFT0r+EZzv2afFRdH4
	qp2Kq75R8l8o6uGBlu9o6TvehDQpDjJ7I6fNkWCfbdfx3MHNUJ9NpYnntpi8RSO2O4fYGVgLuFF
	zuNeMFjGykc71FBd+N4zvT+1GvfM3ual+eQJs3vdtGYq73/Ld+mN3IT/jsyjyOlzxlg1Ub5VUu8
	eZaHob5hTI/i1MrnTFPY88NghQtOm7CW59b72r70VlqE7qksh46OtOhbtjcwXKUDqAraGC4TUAX
	pMTcSlp9YSoZgyKXxtZoC+DJB9uPf/TVLkLpKZknMhqUjjK60XldS7Y5oUsg9Vu2k82yDUFnbMu
	MR6EdzfcGuDgwGnBgrchZyjtt8Frw+Djw//xRSyuj37KG/wUnI7AKRGJphwN3+JTmsgHZt7r89y
	lxQ74oenvRwd+CssKB8GphH9bV05hda5dLZ3adcfB3+IbRYzgBa1F22tzrw2YCnXE4OufrdbWH9
	gENhZ1EvQz7d1LImzftPnKYoC5HrSrnD1rpWveRMGGOrew+mVjOT6oOnjJ34AizQhBRw6xl8k8O
	eOH06EG95P805Rok6FMdpFb5mIf2ZvqTY3bgpnH5ORhzyBp1p
X-Received: by 2002:a05:7301:9e08:b0:379:7bb6:9c4b with SMTP id 5a478bee46e88-38281bfc037mr1041837eec.39.1794967421817;
        Tue, 17 Nov 2026 18:03:41 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304ff2sm2070031eec.6.2026.11.17.18.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 18:03:41 -0800 (PST)
Message-ID: <c3e59cb9-f3db-4915-90c4-679dd130c14e@kernel.dk>
Date: Tue, 17 Nov 2026 19:03:39 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.4
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <avz6E9jYgGkRVmx5@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <avz6E9jYgGkRVmx5@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_180343_577306_CAFDCBC9 
X-CRM114-Status: GOOD (  12.81  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 6:06 PM, Keith Busch wrote:
> The following changes since commit 28f7d31c2aeb350df9a0116093fade0a840fb4ce:
> 
>   Merge tag 'nvme-7.4-2026-11-05' of git://git.infradead.org/nvme into block-7.4 (2026-11-05 13:47:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.4-2026-11-17
> 
> for you to fetch changes up to 68099cf27253a8c89d703a282d3d811446d9453b:
> 
>   nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret (2026-11-16 07:42:49 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.4
> 
> - Fix TLS handling of non-data records on a live queue and wait for an
>   in-flight handshake callback
> - DH-HMAC-CHAP fixes: use the parsed key offset on host and target,
>   synchronize secret removal, clean up DH group state on failure, and
>   securely free secrets
> - Fix short reads/writes and range check overflows in the target file
>   backend
> - Fix transport error handling in loop, tcp, fc and fcloop, and validate
>   R2T offsets, inline data and queue IDs
> - Remove namespaces in parallel
> - Fix gendisk leak and subsystem lock deadlock on namespace and
>   controller setup failures
> - Stop asynchronous event work before ANA teardown
> - Fix suspend when disabling the HMB fails
> - Reject invalid timeout and reconnect_delay values
> - Various target fixes for log pages, zns identify, write protect, PR
>   allocations and ANA group IDs
> - Merge duplicate PCI ID quirk entries
> - Various dead code cleanups

Pulled, thanks.

-- 
Jens Axboe


