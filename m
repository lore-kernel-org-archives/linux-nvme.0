Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AEBD59D95
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sw+TZ05CWoRbYITLC8mhdWi9l6cIfEltGaAi5Y6Dxrg=; b=zkorNvk7pHeFJop3+d/Hzq6vvb
	GHo9CQVpH5BzVdpAYGZSOoUGko6+LAoz0QYs0t/2qkP4sdWtpVZY6vo3yBv5RA48xHpLRRkWKN01g
	BBgqLJwGwkwk1kuZmsnzp8JQvyfAaflYjAhw6nhe4lM6WKA6ZWWeB8EQDdwJ9/y3UfZPiQ5StEcpB
	LkV5n0S88yPbAMqckSunKmOJ3PqrlCKStYHEsmHiJBdXTqByriTlKAQ6EDgd/lIecnD0kP6hFp263
	zfZH2M40+O+5iuWyqz+Q4wEggmvXUxkk+OAUdfUWZIC221czY8uKdOlLAf9h0b5nugdD6A15N/KNg
	S0k42Hkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUAUb-000000016H9-2kVQ;
	Fri, 12 Dec 2025 21:16:01 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUAUV-000000016Ga-19y9
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 21:16:01 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2268961b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765574154; x=1766178954; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw+TZ05CWoRbYITLC8mhdWi9l6cIfEltGaAi5Y6Dxrg=;
        b=kz83v9vv19vNPwr23tig1ZlD4Ke4Bk+zlrIsUf7cdA+MBnoK0w+ypnVMb6iJRf5Vrf
         rYKkhsQ1Ndg6owc65XP4qcVpMm4saDFMXvmSom5s962itbwCiCa9E/SzN74hSK96Jm1S
         G2fsUv+jViRu6JtpKGB06Jnv/OM4YSnJ+avMyxk3fp/NDIbi8aNoOTeDmERooxTrtlpz
         roCtgbY8XxSm6jrK3JhEyehbjVhwIhG0b2oJQmiU1V7QbLuwtJ1ud3hFn+I9ZDbDjgaV
         x6OV3CMGpusmlNLSgOr07BBBg6HQ3F+168Tk147KS6q5KXOlMTIo3XPSIkR29zCFZFt+
         3hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765574154; x=1766178954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw+TZ05CWoRbYITLC8mhdWi9l6cIfEltGaAi5Y6Dxrg=;
        b=EnvNaXwtaFlzov36XV/w6koNeUEJ2Gu8CRy8ytb7Zs0Txd3aA0AI/AxIrU7CtyMsmi
         DVvPV6k8zzUWDsPi+j6Sq/Ee7eT28Uy309kEkjPZqFquJzI7tojwJZK8r8VxQF2w4j5v
         rlnNscaA5dYuNHJnsU1b+3L27G15YD0aG8TXpxQPMsWs7Qysq8gbF9oScc6Y90gcNdpy
         3f3H13z+FChrUWfOrJoo7kpQE7jelrxkPn4hERtL4thq3EB3ntRp6rTEDh7a+HOi/7FF
         qhYcXFyCPAa2ul0GLT4pQvRxd++k0EBdmsA9Bbo9JjdnT9cCv6r2UkIa0YoEUGTfFxFD
         IYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMfM7Q9wiV/Hjq0ZXopW1Snbys2V3CWyT5qu1mYHqJfM98LPrAGR1f9b5VugRWOIDyj3q0H7THJjhb@lists.infradead.org
X-Gm-Message-State: AOJu0YxNF+AIIN5BIH5Bd3fHlqpsSTDKZ0wpcn9N7WT5JXJJgH/dSwfg
	nJgoOGxJJngSHDxXDlZ2Aha45NEFgr7O/Kb2UbGi6Z8bRWwE/XxmOgUH4cJfZCeXWME=
X-Gm-Gg: AY/fxX4lX1DC9BrhUATq271pdR/HzOnLpjCMVmz7JlVeyPkSMxCDXCBfJRlCHMCt71W
	J4FO3hliCsChwToVzaHuvlwhXuwIqn5J1BfEJ7rZpmzfZ5ScLm4wMKP20l2cdT2MZ8vjpfiBqt0
	9oxjearL5i94aMZNHTI51fBvnxYy6RG4MUTtKrWMG51ZzpbMZHmnmbXO3K0Tqie2gi/t7395zXy
	RZWC8du8Wktq5+eAx9YkTGYcDzFC2mly3CkOET4terV1O2Rk1jF/ckn3+LXZWxafBZ4qOwMt0rJ
	6sj5ZIy3hc2tvMrP01sQDBPHtLVS+zBwyghRYphBahlM7HtW74ikt3X3QRQgOQ5UTQweXA4XDzr
	/d9I8wFr32rvW9KIUUxWM5Bhz6JGbr2ENmhF/XPVcZFSXjNp/udAJI3z1rGPAvqLQiwtagX9R7c
	PV5Ll2HtK2VDN1PUonULGUKkjwwhgXknPIWcv8VZpcp/YKYIBFXA==
X-Google-Smtp-Source: AGHT+IGwiyKSTF8MJBx0lXWuVgm1TM/eNH9XqZGuySnYZvIIOI0ejMjcIEB+VGMKoicTtQjWeh+YTw==
X-Received: by 2002:a05:6a00:1bcd:b0:7e8:450c:61a9 with SMTP id d2e1a72fcca58-7f669c8b0d5mr3201250b3a.64.1765574154233;
        Fri, 12 Dec 2025 13:15:54 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2379972sm6126110b3a.9.2025.12.12.13.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 13:15:53 -0800 (PST)
Message-ID: <c194cceb-d60e-489a-b6d6-fca3dba870ec@kernel.dk>
Date: Fri, 12 Dec 2025 14:15:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: fix NULL pointer dereferences in
 nvmet_tcp_build_pdu_iovec
To: Shivam <kumar.shivam43666@gmail.com>, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, kch@nvidia.com, hch@lst.de, kbusch@kernel.org,
 gregkh@linuxfoundation.org, Shivam <skumar47@syr.edu>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
 <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_131556_020392_A7FA7C0B 
X-CRM114-Status: GOOD (  10.85  )
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

On 12/12/25 2:08 PM, Shivam wrote:
> From: Shivam <skumar47@syr.edu>
> 
> The CVE-2023-6356 patch added ttag bounds checking and data_offset

Please just replace that with an actual sha, and add it as a Fixes
tag too. No need to resend for that, I'm assuming whoever applies
this can sort that out. Some random CVE number doesn't mean anything
to me, a sha is something that is easily identifiable.

Rest of commit message looks good.

> validation in nvmet_tcp_handle_h2c_data_pdu(), but it did not validate
> whether the command's data structures (cmd->req.sg and cmd->iov) have
> been properly initialized before processing H2C_DATA PDUs.
> 
> The nvmet_tcp_build_pdu_iovec() function dereferences these pointers
> without NULL checks. This can be triggered by sending an H2C_DATA PDU
> immediately after the ICREQ/ICRESP handshake, before sending a CONNECT
> command or NVMe write command.
> 
> Attack vectors that trigger NULL pointer dereferences:
> 1. H2C_DATA PDU sent before CONNECT → both pointers NULL
> 2. H2C_DATA PDU for READ command → cmd->req.sg allocated, cmd->iov NULL
> 3. H2C_DATA PDU for uninitialized command slot → both pointers NULL
> 
> The fix validates both cmd->req.sg and cmd->iov before calling
> nvmet_tcp_build_pdu_iovec(). Both checks are required because:
> - Uninitialized commands: both NULL
> - READ commands: cmd->req.sg allocated, cmd->iov NULL
> - WRITE commands: both allocated
> 
> Reported-by: Shivam Kumar <skumar47@syr.edu>
> Signed-off-by: Shivam Kumar <skumar47@syr.edu>

No need for the Reported-by tag, you already have your SOB there.

-- 
Jens Axboe


