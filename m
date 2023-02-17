Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E2AC636D6
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KEMNOuO8+jl8HrgRQYisWklYternUWLl59Yj+DzOu5Y=; b=jcO/wG6u7Wvlc20iSQS950j7WX
	n4Rk8NmWQOK8P0Ia3goZorzT9uloDrZZV55lyD/ynyhJls5kUTtlLLYKHu46awayNdpIhcUMMv1xc
	qDHsUzh4G9EbFT8p6YfjpO1d/Sg7UG+bzN81KmCaNrrlIwRjQQL/+UP1pT8216WJNmQai8um/zLxz
	1YCX+dLIn17gt10vBjgByqOwixL961EUD/91Y0ADxBost/+JLlirpT4cyIZqHMA5gtktpnw4YnAg8
	Y+0GKyYnOUNu8WWDDWWFfcfvu6FSPoGughLujKX6iSs7JQc0K61vXe7IC7Oj8bQw/9X/2BkHqRvcv
	QDn2leUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8Cz-00Fj7h-4h; Fri, 17 Feb 2023 21:23:57 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT8Cw-00Fj7D-Eu
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 21:23:56 +0000
Received: by mail-il1-x136.google.com with SMTP id t2so866059ilm.6
        for <linux-nvme@lists.infradead.org>; Fri, 17 Feb 2023 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676669032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEMNOuO8+jl8HrgRQYisWklYternUWLl59Yj+DzOu5Y=;
        b=Twm0LBWYpmVFprJhsa+ePCdzTFalANv8TPbn+PtACdxjR5/chuimox7tNJ9gzZPWdm
         Ivnw5TEUlJt2G1IfHauzFT9WJbzgyioPoSSiYpcU3ku4TLBOZ3Dz111VynWhu0CYiKJS
         Gi4aBn1EUyqAwSr1wbxAday4ZSod9vHW6qhWgGJqCXSMDvtLElwbLk0/LarfUbzjetq8
         wBZWP64hrkQ2QLzGD0UHLyfNHk5XHAU237Li2YZhS3x68R8r7JKs91furK9iHagz3H33
         jk83OPSNemuowSXMZDNhAbELVYtTr2pvIEMxJqUZOCvzmXc19x1Ef1URprtdlhoYhiuC
         8btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676669032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEMNOuO8+jl8HrgRQYisWklYternUWLl59Yj+DzOu5Y=;
        b=VfGv8ccPP7upytVt27uNtFQ+ri2PjNL9HZvD0CgUn2sf36hyqWfp/VhMakKnsSjp3c
         6m+8rPW0C19voWSRm6KNLzJazNRYOqI13ORleF5wRtqkeWWM6WRdds9Tzr0bmvZo37vM
         SeAB8I8kMhavbFROt2aRc0HrxQ7TFSOYD1BQBLkc07EAJKgUqCFCuHH9pqPKb+RJj8aj
         MWtAd3feqy/3PRXaG59fwcqRaVUVJ75X4eVEtCeO+8v+Lkkj4CaHp/O3z08AwNugRRbd
         iCB8DbjpCaoZ3whqs3iYw+63m5g3hf3ARHay9TO+MV8BJSQ37TgXf/66jaxLmskPxEIl
         orIQ==
X-Gm-Message-State: AO0yUKUULhFwmbdev4BvVBTbd1jwUVHf47m7xkemgOTAIlxFpOJzX5n0
	VzQ8vze7DXl1g7fNmjDXLsLpkA==
X-Google-Smtp-Source: AK7set8oK+xWLmt8H/nJcfJrDmqcrK/zK5exSB3Nm35mqoz3QWa1kIcohnyQrqrkiF4nEFngviGyxw==
X-Received: by 2002:a92:1910:0:b0:315:8bf9:53d8 with SMTP id 16-20020a921910000000b003158bf953d8mr3528045ilz.2.1676669032256;
        Fri, 17 Feb 2023 13:23:52 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u13-20020a92da8d000000b003154f7c11f7sm1627591iln.39.2023.02.17.13.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:23:51 -0800 (PST)
Message-ID: <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
Date: Fri, 17 Feb 2023 14:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, michallinuxstuff@gmail.com
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp>
Content-Language: en-US
In-Reply-To: <Y+5JdR02tlzD/TFS@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_132354_574655_D8F70838 
X-CRM114-Status: GOOD (  15.04  )
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

On Thu, Feb 16, 2023 at 8:19 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :
> >
> > >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > >
> > > For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> > >
> > >
> > > # grep . /sys/class/nvme/nvme0/cmb*
> > > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > > /sys/class/nvme/nvme0/cmbloc:98
> > > /sys/class/nvme/nvme0/cmbsz:524829
>
> The breakage is that the attributes are decided before we've setup the cmb
> regions. I'll send a fix shortly.

Michael, have you tested this? It's queued up for inclusion, but I don't
see any evidence that this was tested.

-- 
Jens Axboe


