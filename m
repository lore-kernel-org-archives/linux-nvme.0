Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7556C5AD49
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2HMsxKFr+iI0d6Tud/iM7k4FKDD8Q3Y7uGH7YipaKVY=; b=I75FPPY0S/HRUf2QK2av0Ckuk4
	PBnGtGADMgh1a9FkUOzzagYeU9FyGWOUiYEiM8UpRFl5VpnEjAB9ypcjglgtwWmSsOeIQENR1O624
	wUK0KffjLmZFdwt2S4/Ci4GqHUj7hgMXpqOzBEkcibOpKUxeglkJTVjomL3H6f7XeR4Q9Sbv9dAtM
	+k5b6zA6xCQrJQjw/i+c3Uc9ONYgIOFVTwH3/ikuzFolX53//n/rruq9wAuwPyTtkhwpiHKa6kH4v
	w9rgK8aoXzM9y8EGMb6dMsObhTYwwYx0SLfHxKchRg2vFC0j9wq40uZnko8/tMOTVeNxojquLsWnX
	u1TiygXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNYbE-00000000Thi-0s7i;
	Fri, 06 Jun 2025 15:03:16 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNYbB-00000000ThM-3O6N
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 15:03:15 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-86d00726631so48784939f.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jun 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749222192; x=1749826992; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HMsxKFr+iI0d6Tud/iM7k4FKDD8Q3Y7uGH7YipaKVY=;
        b=G59eT+veU3ksDuSSG7ZriRqOz3k8jsbw2E5VFAo4IqMrRrMmMZw4qLG6hLYQJRHviX
         T3DN6NohNPUzKT0VUgKTlAamJUt0d9X9aM7v9TSRJ25cV5irUSBHSSTM5bH/qxFCTEhB
         YduRB6ZTnP2TG2cd4lkj8SGhpLNtiTLdHh4XsfeLw/KDJTbbVRawjA29y8OPe/SE1tad
         zDtqggKenIa1rh9GMdq/jaaWPJvGbFRFhZ+5yzBsX85g7PWLHT/Y5HCnreWrmqKSaJ8L
         oazIJCkN3tTlSbL5PCoId/n4df8iBVmZtwUjtle+Apa5Ip4COcIXhg3157Gsx4mYnQhE
         5zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222192; x=1749826992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HMsxKFr+iI0d6Tud/iM7k4FKDD8Q3Y7uGH7YipaKVY=;
        b=OsmgFGyVBbwGRC5NMOcPFzUD1dzhK1HR9MQeh2U263nBxWnlyUQ0/o4J4WoLq3wjg2
         ZtCqaS9xq2nBbs7z6dAi6pWWPdVQhqwuq6jwh5xX+F72i2X2BiM4yKqdo6qgClPLN9qp
         k2qLgrPeL5OKtYCUSRurcWOlyo/HbZa6EK033zzmknjcFVclGnIZcigy+Nbpxpn7sLxC
         RaA1Ep+0pf7MVbFdzWRQn0P5laqv5QR31T9JZvRl2bD8XuXNLdG1Pq1qkI1E5yIyexW8
         B4tnDFVNjR/GgU9tqzSMPQexlVYeFiGlbqXyTEjaxSCyf0o2y/9nTcGDwSBia1SwYMn8
         dM3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2s0evZRzbIF9yFteJ/glR02b3QeiM6nP8S4qj927oq+W07QPuDOjgNWR0BS86RdzlBvMmyvGdUAIa@lists.infradead.org
X-Gm-Message-State: AOJu0YxFbFDxhLl8k0qvptPogd8xpAMOZi9Y17xWvQlVyP8lLzMuBpqm
	nL+5AlZsOpKLIxDgtrE45uVRVZFtSAw2gII+OS+65ZKpzjDR420Xq/ETYu+4FWiPVlA=
X-Gm-Gg: ASbGncs0Etd1FFTJewCmCUYHUy8q/6JdSu8KCamTkWy18oZ/j9/pQiVpPivjXHWfl90
	BPIeqwJLCu/rBZxLoMSrTscSXoEMTbwq03nh3o+CG/1g7b1N4+WrFnsjlc1F3fztVndtczXrGhk
	bVIy/R2Chba1VZUJ3OKFbf4DxxdoaVvrtIa9G//Y7SzcCtL0yTcqpDoBEaLyvZelTtMMSCx5Khi
	wyy5I7TxsrSi8B4ghzWJ+YQQHgwJjF7s2I/EjeFsDvUKvxw1ClCXitOfvG2Oyt7+zTjn0ihVC/J
	2XDgMd03v6zc577FPMjLU8VpWzv0tl9asy299tzkjWr9t8I=
X-Google-Smtp-Source: AGHT+IG+WbX8uzWkNgXKj6zpzdEmc3KwbYfTHiHsNcFQomIiNJCU7RpTxEKhImMpphBDhSqMdjEhLw==
X-Received: by 2002:a05:6602:6a8a:b0:85b:538e:1faf with SMTP id ca18e2360f4ac-8733666758fmr457995839f.7.1749222192533;
        Fri, 06 Jun 2025 08:03:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df41fa3esm493580173.30.2025.06.06.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:03:12 -0700 (PDT)
Message-ID: <14194a5f-e320-45e0-8f6c-019ce3bd4dbe@kernel.dk>
Date: Fri, 6 Jun 2025 09:03:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.15 kernel
To: Daniel Wagner <dwagner@suse.de>, Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Tomas Bzatek <tbzatek@redhat.com>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
 <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
 <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
 <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_080313_853300_6B6D48E5 
X-CRM114-Status: UNSURE (   8.32  )
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

On 6/6/25 8:58 AM, Daniel Wagner wrote:
> FWIW, the contributor for the io_uring feature, stated that it improved
> the performance for some workloads. Though, I think the whole
> integration is sub-optimal, as a new io_uring is created/configured for
> each get_log_page call. So only for a large transfers there is going to
> help.

That's crazy... What commit is that?

-- 
Jens Axboe

