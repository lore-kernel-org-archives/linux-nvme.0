Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EC1C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuxkbyAxuoH1akbvnEbu0efYi8wWnWpcQwcT8zxbzJM=; b=tXOvMK9PE5Slhme3jsK2Z7WKwl
	cIpHyscqCUhh6y1cfAGczSfFPxzMhAezcBYAhG7HVrG1AuV0sNZ5XiVU2ufLiudM9hVuXGPycEyxC
	C0aam07jSXAN89aqJY2P4Hoq4YYDO6iqnjX8pmnSPn0UMgo7gDIKVWSvDU6W3evF9YEkQDWbwHOyY
	ZaWJ+B7G8j+3E+YamtHpMalGcxUDnhwvJUBiFEpm+S/SIzI0eqiWP6FCyr/vI9lO3s6kG+AsVnOpX
	h2zUS/XduY8BYL4QX1ZT9Gmq5IpIgNh0nCNZL/bK+mQzmEz4vAVMCqJepMt5SyDeNpqc5yuKzOFXB
	kvm0oumw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ15O-00EpUd-0w;
	Wed, 17 Jan 2024 08:15:46 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ15K-00EpSy-1s
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:15:44 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so11164003e87.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 00:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705479340; x=1706084140; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuxkbyAxuoH1akbvnEbu0efYi8wWnWpcQwcT8zxbzJM=;
        b=Hh1XzcPUvTOfokhUUKzAmJch14L14egAe/S7uFTmOH9FwwTOzfbaCGCSUS46moUJrI
         Nthzzwa8H9fkCX4mI6nkunJBWGTwJnbSw0ddfPWS6sty0VQiEMzMIGc7KO/O3bsruUn7
         IdjbJ8DYDLiPFeqV6fkh+jsJWRiXNA1U+T9/vLqN+d+0aE97/B/DEIfuNxv5ccOexzhp
         bheT6Ruz/yBD6yMeOyukbLzJzF+u8fKfpEVql7VC5lNKiM2GiQJRBisEUPpyfWu0Vwii
         u86xeSbSM4Kn3jG4kjIHt0isQK8tlGeiRt8st+xr7hbC8Ls4vHNAPiihFr2aAZClQzLT
         8RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479340; x=1706084140;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuxkbyAxuoH1akbvnEbu0efYi8wWnWpcQwcT8zxbzJM=;
        b=m/G0Zga0X8WbHQupp0VlUI/sw5dViGXzMF9HttqkwGy8wff3RQVUDWkMLyoglzvqBo
         ZLUlxKV85ymPjrrDbAPYYZ+jhTnBobPXx6mGbg4zOVniysLaCt4NWqaeuNi6ncj1pBkR
         icQHKz8xVqKBy7X86PMEQa8jgBydSXTlajQ1vOj9VTEL73Whsa0vFrDpl8hH1cvOdF6s
         CcgM3inlugfHnoMoXE8kLwR7O/vjmbdZDlQHBqlAG9LsP7KKl6t73GIWg20rWRqjLPZv
         8z462VKEHk17KMddnOqI9Ox9D2I57zwz8/ZLtwfoPnl5GnvQuEhnmF1rT7ZDtRhX9iW1
         41AA==
X-Gm-Message-State: AOJu0Yw8YGqAcTlQ5TnYRVBIUlcGyhEN/Dh0STeNRZEgK+7jI4Y3dMhy
	9ke++Sl9A+8t7TeDHjbvIjqju9rFgcYhsQ==
X-Google-Smtp-Source: AGHT+IGPq9/Eq1UhC3pZj/TdkTfM+eftF0NMAfvDo4C1Okh8MAKtvC03cBl/8FarHZi42Or4ri4hjA==
X-Received: by 2002:a05:6512:ad5:b0:50e:7476:e027 with SMTP id n21-20020a0565120ad500b0050e7476e027mr2249734lfu.275.1705479340169;
        Wed, 17 Jan 2024 00:15:40 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:edb0:1c42:2f2b:211a])
        by smtp.gmail.com with ESMTPSA id t24-20020ac243b8000000b0050f09733c1esm168634lfl.267.2024.01.17.00.15.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 00:15:39 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
Date: Wed, 17 Jan 2024 11:15:34 +0300
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Message-Id: <FCE5827D-756D-44FA-9553-F74FA9A977BF@dubeyko.com>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_001542_618836_A4D5C4E6 
X-CRM114-Status: GOOD (  10.51  )
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



> On Jan 16, 2024, at 9:20 PM, Bart Van Assche <bvanassche@acm.org> wrote:
> 
> The advantages of zoned storage are well known [1]:
> * Higher sequential read and random read performance.
> * Lower write amplification.
> * Lower tail latency.
> * Higher usable capacity because of less overprovisioning.
> 
> 

<skipped>

> 
> In other words, this proposal is about supporting both the Write and
> Zone Append commands as first class operations and to let filesystem
> implementers decide which command(s) to use.
> 

I am interested to attend the discussion.

Thanks,
Slava.


