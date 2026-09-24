Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA40BC98318
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 21:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sR/3LZABr9dEE/A3u+cDtehoGgAdOlE37mBarHxqdb4=; b=OlxSIUr6mrcQUwkkWT+4c2yB6R
	6MOiaat3D5iZgRmzMzocu1m0j268BPEC3NBn48AQNvRmRAXot7BeP0U6/3GVZnMKW8BNp/TLthg+8
	33LS6tZpFukdpkmvo93vt56AWELJcls5sipBKOg7T40Y+5Fsd2yCQiYveJEMMKQFaM7JNgzXu6qoX
	hMHWoLxSbfkD7t3mg+xOCgZ/GmSfe8svgH2F0TrfBuj+YodGMcJ8taO7af8zfJdBAY1E5La7vkng/
	trgaE4ffp6FlX4H/mJgPHRp3cNcbxejud82ZF3ZDvmVgLZSX8saDpcuDwkeOPHma94AKFbMos1kCE
	3OQ+42QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9rFd-0000000CEoQ-3tUz;
	Thu, 24 Sep 2026 21:45:09 +0000
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9rFa-0000000CEnn-2Xk9
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 21:45:07 +0000
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-340fbf9c1c6so122411eec.3
        for <linux-nvme@lists.infradead.org>; Thu, 24 Sep 2026 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790286306; x=1790891106; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sR/3LZABr9dEE/A3u+cDtehoGgAdOlE37mBarHxqdb4=;
        b=XxELvxjy2VxrIiHO8q3quXAYAmW3za/q62jrEkdGp1neBrlHe1MivmtMYWjgjoeVkU
         RfqlDRk2+s8g8nWJPvBJ0y4LC7BOSG3UL7us12bEsu7tbdYdn/0BC7R4CbO2bEmtYHKw
         AUrp8y4VHqq7BLuC7h6uEB4jk6RzS0Lc+iSfn2x35I8djCFlliMeApfCDlDBWGWHwv3g
         vT+JGR4VVzuhXS46vWR9cGascdb+qxiSWFbGSf36GC6WZpKC/xd4YzymMz7A0jbe866Q
         cpj34VD1NJyVhSGo2pTw389qpZtcTg8PwKize8FSUVgHbhENDSIpu8vJhIk3qL+y8j06
         NYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286306; x=1790891106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sR/3LZABr9dEE/A3u+cDtehoGgAdOlE37mBarHxqdb4=;
        b=F9CVOWXl4EohJs/+LyGuzyLPlf+vrSOm278etUX6NamoDIM6MQeHMr5t5Oo0IoFvwE
         YW/w+uoKqzudqyAGYFv+JXNOpgmbAXNL+nNCedUwGue2MW2ptM543Kz+/z4sw7c3HSDA
         c3387QuyGj9P7PKGpvg9kJhIHeZNEAN+r+BTynTk1eBW5WcloyR5s/kS4WymhTkwg9bd
         +XSJ7yaAB4zNoBZAeF7ElBzXGW/9LAvsmgYpDE8AQR82SJfpKpcHtBmJFQ+X6SOG9M6M
         QuKffWu4pjVv/KbzZz6hJ72fBknw3GwfHOAt6U0CyYaC4ED8rPKJY5EOiN8xhRj7eH0S
         qNkw==
X-Forwarded-Encrypted: i=1; AKwUvBz9SZPRB+DyURrwgtDERJgwm2EwSWJ/fkZEHz/sEXVb1Bl3JKoVaXxbf5vJ8iNfqRGjArncdFzk7HIv@lists.infradead.org
X-Gm-Message-State: AFuF++kBlCADdm//ovSa+89ilkMsDrq+Gr50v4xYm70bhC0uQ5HuCcXE
	itNEJ0WkEUen+9pNmqVcRLamnXgYWr8/Hlb/JM6nPvTFz23z2IxQX9dSd1H1CfoQ2C8=
X-Gm-Gg: AYBFou1TFTQvmou3QwcCxvej3f3oBcB7vsKb8nDGvLEk78Slgwdx69iZOAUqwbIocqd
	1wXDYAtzVdv+eR5RH2Yr1GI6alvtJdqwbJRyChoFVOFUr4nZhM/rSTt8cEnLDOTGJyhvxRHJJDS
	kkHHv7SFKRgkOsCelE2NkQFHDxiNeTmGa0n3tlBY5/D8jQMxjfPV7xNph3luDbTdT2uXy4Ny7gw
	ReSpQDDe2y6wr/62n7JmTc//TSkXtmTlO7q6YFmB+oP8/9m1NfzLxUcAdki5dZIiHWuCt99mV/M
	1jof4SGrKEkDDskmR2JJOgHHiWtgcS4x2wVTyWgHNwZ6IZXA0QwgCmVZoOsIcFsQvRo/OAxtZzH
	BvK0rGryzRkEIdkrGyrBNuA8mvWDXQIEb4j9+1lsNC/zIONNoRCGEkWpSbqFPOYm5MAGLRO9dsD
	HTLOX4lcJl7llT/Y2Cs5f6Y7bFwDCuNY0vHKaU/sAwhoBfIXRjQpscVp4w0QuIvtYd7u/0jW1r5
	RgMDtP6nF1Q4u5+asr/kfd49xqFsFaJHA==
X-Received: by 2002:a05:7301:4307:b0:328:3542:b73e with SMTP id 5a478bee46e88-341978b5979mr27940eec.15.1790286305564;
        Thu, 24 Sep 2026 14:45:05 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3416e4c2f50sm863013eec.27.2026.09.24.14.45.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 14:45:05 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org
Cc: hare@suse.de,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	sjpark@crusoe.ai,
	saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Thu, 24 Sep 2026 14:45:03 -0700
Message-ID: <20260924214503.82963-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arVFPIKeT-HoYF2K@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai> <arRJLL4ki-sVQnHf@kbusch-mbp> <20260923225753.49224-1-kiyer@crusoe.ai> <arR3zlpx3Xm2mRt-@kbusch-mbp> <arVFPIKeT-HoYF2K@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_144506_656063_DA46DBB2 
X-CRM114-Status: UNSURE (   8.24  )
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

On 9/24/26 8:43 AM, Keith Busch wrote:
> Okay, I see. Pehaps instead of having one controller export all the
> namespaces, why not configure your target to have multiple subsystems
> the client makes independent connections to for each namespace?

That would contain the failure to one volume, but two constraints
rule it out for us. With nvme/tcp a subsystem per volume gives every
volume its own controllers, so TCP connections, keep alives, and
reconnect work all grow with the number of attached volumes instead
of staying fixed per portal, on the host and on the array. And the
subsystem layout is the array vendor's design. As a fleet operator we
attach to what the array exports and have no say in how it is
configured.

Thanks,
Krishna

