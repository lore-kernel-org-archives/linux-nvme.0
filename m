Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13985CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 21:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7CKFsGVCHwOUEvbNokOpZJVitLmlkJlYmyI5G2cqFY4=; b=YiiA+3xP/cZqNIGN682U3wJkZN
	ncU1J5mybmToHRws3yMo+nnF1KEAufKqdWz/CrH2VA+xRP0hqEzN03WNC2RyMuIKFcmlwSi7AaAEd
	LdkaECpxLdlpFdGWJq6kW962SIwst3DNNUSZOfUuyILj1kia8LJICe8GhSnla3iUED+GaPesL2K07
	EWFDM214CbeVuub7O5kP+UA/V5Aj234cUtui6NJkZhfPI5yJu2ltgKmH9HU3+wE4DTSgb6jZfQVlg
	AsQpMpKxyZRwB8vtLy7IeV6wbB9EG3X4/gog0GON7KCBYfWFrSwDndnOA+JsLC29ophAQpXXium9y
	0nadAvgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrUr-00DHsz-2C;
	Tue, 17 Oct 2023 21:21:01 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrUn-00DHsX-1t
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 21:21:00 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35291dbf7efso8379535ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697577656; x=1698182456; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CKFsGVCHwOUEvbNokOpZJVitLmlkJlYmyI5G2cqFY4=;
        b=nlCs3wIc+kId7dIlfE2NgGUqseA76hh9FrdXJDQM2TiJrpXp35h8c8YqKbNLlrRrSV
         Sk+msdZmGjSIiicgd1MZtrImYpNR+b2T9R1tUkvn19lytAxA042AVC228DUQ0H7kuBMv
         l7KX9EHTBx8vOnKi4lp6d4YE3nYmyNkhv02kcdhj1YZybpKFfKnrClow1mB0mw6k4bQo
         7qX4ecFUdMCOqxEYGG2bHffqrkvee6xsXp1gaSV3dqWkV1UhA1oY2SYWVB2K4BsuP+/o
         EclshsU0CGVBTXgCS8cFIC0HcgTZpyTaEIj1+5ei+92qVcbPfrWLXSQeAZ9J5RxVPNIc
         HvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577656; x=1698182456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CKFsGVCHwOUEvbNokOpZJVitLmlkJlYmyI5G2cqFY4=;
        b=vo2qmy3rS9GcrDf/BzE8Qk7K4rod01okf2WDLdLa4ZBiUcsQVmUaM2ch89ohTn1HTR
         vuPT7RDACdrqTjRKKah0MkUt9AJXeaUvYyUk8T9J1mU4O4zWyYSGRb8JKsgZfgvwqL5x
         EClGw/wiV3JCLqkZCMKUBhnLTpD5bTW7DpFCkW5I6h/BAoXkC0VD4yoKam54TZ0cHqFQ
         ie6w1l9510qa0QFNy3bc31CJv6j5JvV4QIjMsaq8cbyXsteaOgGF90Kbn3FVEbCCUcO+
         ThBDaCQLmakQlUqaEijFek3GEjcBy1Bd3WiClVAygVmnJyyS9LtorJNh/Yy6htdnT7DQ
         voXQ==
X-Gm-Message-State: AOJu0Yyx/8lFVGOQQBS7ZJeEIdCOIo1rsfKJ+NpsVoot96ca6TVXWWAl
	njPp5iihhYPEUYEiz6F2yLZj4w==
X-Google-Smtp-Source: AGHT+IHKIcqYsfbQfJe4jN7woanzZLmONejbjPw83G9/biVZ2NnKWa5oum4PN+nesb4iNEgT7K8eHg==
X-Received: by 2002:a5e:9404:0:b0:792:8011:22f with SMTP id q4-20020a5e9404000000b007928011022fmr3617426ioj.0.1697577655746;
        Tue, 17 Oct 2023 14:20:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a029503000000b00418a5e0e93esm743606jah.162.2023.10.17.14.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:20:55 -0700 (PDT)
Message-ID: <06b77d0e-06fd-496f-8d7c-4c3eb0b5b94c@kernel.dk>
Date: Tue, 17 Oct 2023 15:20:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.6
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZS73WKIh0TnckwK6@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZS73WKIh0TnckwK6@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_142057_840511_9A31099C 
X-CRM114-Status: GOOD (  10.13  )
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

On 10/17/23 3:06 PM, Keith Busch wrote:
> The following changes since commit 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:
> 
>   nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.6-2023-10-17
> 
> for you to fetch changes up to 1ca5b644f79b0d357c6df148c634940db685f471:
> 
>   nvme-pci: add BOGUS_NID for Intel 0a54 device (2023-10-17 13:50:28 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.6
> 
>  - nvme-rdma queue fix (Maurizio)
>  - nvmet-auth double free fix (Maurizio)
>  - nvme-tcp use-after-free fix (Sagi)
>  - nvme-auth data direction fix (Martin)
>  - nvme passthrough priviledge restriction reinstated (Kanchan)
>  - nvme passthrough metadata sanitization (Keith)
>  - nvme bogus identifiers for multi-controller ssd (Keith)

Pulled, thanks.

-- 
Jens Axboe



