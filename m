Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02854C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Dec 2022 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zESImfXfHInRMam/uoQWM8wlJUZtanC1aSI+6niPwso=; b=GPEUo4lXk2ncl7
	DO+0TEY3ZK1VVU42mp1zKkY4Hdq2G5HdL7aGN2N7p82zFxLCZzTC0dRhqzI7UTli2OkDwaXYt8RWi
	S9jfkZQIEMPqL9wCn8jVuzRDgHmauv1qzU1TEEqE7ayXlmKKbhs7h815sVDFA8KCC5H+B2IVTMefz
	e+ArGvc9rtTs60+ZfcObVtOxpCJx12YHCLC5P+R2CW4xFEEpEv1KmFz++XSFo9/jJD9WZUXHGsB/u
	xHZaKfkLNZ+xh8+3kG7pmkmuInsJX8qO07xTaG++6mzD7Ab8mzWw1FpuTtvkHdJ7svYRB3YjXpL5V
	39ATatHuRQimrOEMpVHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6dDu-00CS9Z-9T; Sat, 17 Dec 2022 19:51:54 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6ZpE-00AjMD-HI
	for linux-nvme@lists.infradead.org; Sat, 17 Dec 2022 16:14:21 +0000
Received: by mail-pg1-x52d.google.com with SMTP id v3so3641660pgh.4
        for <linux-nvme@lists.infradead.org>; Sat, 17 Dec 2022 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zESImfXfHInRMam/uoQWM8wlJUZtanC1aSI+6niPwso=;
        b=q1IVTTBa3QUFkdgmXo0l2PzwqmkhkBoSc3yL+6IgJRKvhVAz/WaHusDXUsdMWJ48AQ
         asavWXdO2/eiJcjGgunrtrBDBzaScQYbhSBYw+gWa83ZsA/FBKp913jU95yvL+WcKp10
         3scvNNQ7p3k1ENjoeielQFBZvaGGqNnRksKwKmd4FCC2OYeZZ/QTrnQGNRki/VKzYRsR
         HPPcyY5LnX10MBCvEdelh2emyz4vDNv5PArBEpeanegv1onoO0q1DaGRRlV2NbMWZHDj
         Savc9N/eZHTaWSG2OUomReBznbFPAAg4lBLCu1qCooV3nfcHEVoPJaA9VrPokUvucoVn
         QR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:reply-to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zESImfXfHInRMam/uoQWM8wlJUZtanC1aSI+6niPwso=;
        b=l3sUdq7ZD6sSe0R8G2nhiawF+74AaUXvngJxwGqlw2ZAd4gWnoWGI6sESGxVmLrznV
         bST83W9yzK461g70uEqfGVzrVAIMo3Xh9t/i70/O0xytCVGZX0xkwqcYhOFfS6rGAKLx
         E67rahw493PsoaXeJGNRIjZOseMg5q6cwxbCI/fid1F6eBD6TUBfoQu00E/RI2t2wNnu
         zWqBVuunAjeUBW+/kXuyp2tZE7RD8KJw73Giis5ekIFkbjqFPSEyTxnjMYrsb7LKCKZ2
         hbL6r73rg/mzzw1XMMRWV1ZMZucJz6gKXlJW4BjdHZ1Pwzdo1p9OTq+srtKZl+VJwje/
         J/oQ==
X-Gm-Message-State: AFqh2krqgguC4fLXVqpcAh11kVW9JFrU2OU4fDKbsyi2KdVQNxJ0JGFr
	xRlVdukSFOaVcVqGe/QQxUtg2pflDgg=
X-Google-Smtp-Source: AMrXdXsdtD6mZ60W/B7IZkClqJm0aHFG6MC071kr+ex/fQnTtXPy4ldl2OUO0c2OKUdmQWmPbfD7Ww==
X-Received: by 2002:a05:6a00:6:b0:578:2b1b:e900 with SMTP id h6-20020a056a00000600b005782b1be900mr2878922pfk.18.1671293650797;
        Sat, 17 Dec 2022 08:14:10 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id i22-20020aa796f6000000b0057630286100sm3092717pfq.164.2022.12.17.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 08:14:10 -0800 (PST)
Message-ID: <6e25bda4-f0cc-0717-aac8-a8595886f2b8@gmail.com>
Date: Sun, 18 Dec 2022 01:14:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: jfhart085@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, hch@lst.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_081413_616477_4D108823 
X-CRM114-Status: GOOD (  14.58  )
X-Mailman-Approved-At: Sat, 17 Dec 2022 11:51:46 -0800
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I also tried loading a smaller partition on the Samsung card at /dev/nvme0n1p3.  The copy stopped with a "no space left on device" error, which should not have been possible as the source device is a 32MB partition, and the destination partition on the nvme ssd is a 64MB partition.  The two files to be transferred were very small and could not have accounted for this as they totaled less than 5MB. I found file system damage on the nvme destination partition in this case as well. It also occurred repeatedly. I am still investigating this last case.
> 
> In no instance did I note any otherwise unusual log messages or errors from the nvme driver.
> 
> I do not yet know if there has been any damage to any other filesystems, but I will check.

A correction is in order above:
That smaller partition was at /dev/nvme0n1p2, not /dev/nvme0n1p3.  The 
former is a 64MB partition, the latter is much larger.

I have checked for damage in all the filesystems on all the non-NVME 
block devices on the system, and have found none since installing the 
Samsung ssd device.

I am presently unable to safely use an NVME ssd drive as the behavior 
appears to be unstable.  I can still do testing with the Samsung drive 
if needed, but the Kingston has been removed, and will be returned on 
Monday local time (Japan Standard, as I'm in Kobe)

J. Hart

