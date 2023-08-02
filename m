Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F39C04E69
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cV18Cisizme2k4YqWIWHrJEyGuocEaqPxg924l7XK8Y=; b=zsWWtUrvtzYTaIlDaPF7AT0Q9n
	Zp0GZFrNcy3hbjZYdOaMpmxtDPe+SdhgyDyO3az0rHMOpeqKXBstmPwBB3Nrt6msuQLrF8H+T+yQW
	ZSdR13w4a/q6T5fuWig9X6qos7JnLCNZKfTcjkN5f6JUwV9Y5xqd1wwZi1b59TyruT5LtuvvGFEFY
	R65xrPi3KunHgoHcJnfZdfLeMYJkUAp2ufRdfneIlfnAWmUko6AhKghZuL56q80AREQIlZV+kVJ5I
	onliRS2K/lIrHe2TGUSGqxW5Tigymv+1jzb5yt+LTEdPpoB5iNV3n5LO4cC1F0MLvajHmWnSVni+E
	DwT7GqGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAE5-004or7-2L;
	Wed, 02 Aug 2023 11:41:13 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAE3-004oqN-0o
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 11:41:12 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68336d06620so6499125b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Aug 2023 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690976469; x=1691581269;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV18Cisizme2k4YqWIWHrJEyGuocEaqPxg924l7XK8Y=;
        b=IlAptlq+VK98mpA2few2pmW5mYTUzP5uYXmdXaN/l0b1Pr25CRxbZ0IZrpzSaJdLF1
         LKHy4H0jBlHaaQcmjnw4aWlzvaIwACMlP2WBeG/l5UQNzhjIRfTylB+Pq6rK5vaukdr2
         hiiSJjYw5JEu+RD0SZ56T1tT3FOdybiUuD7BFDyyMsFiWFoZrVcY8nrCNBeSQOzL8NO2
         dJ7HzFdMyiYncy74xY8g6S1B/mHPnpS2HfVGQ56v/SUHKBfV03+qJgQQX1u/jceTmP6J
         KZrEbPROquPw4qnN11yg4pbrK73lUZ1plyqTosBJpn3MiSOS7K3x6MZxtMJOYFOXO15V
         wkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976469; x=1691581269;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cV18Cisizme2k4YqWIWHrJEyGuocEaqPxg924l7XK8Y=;
        b=f+9znTDzXVGFRPHjCKxdHKcOxE/POa1/mnl6Zo7AUQJRzYNYUDXlx65Ll19zM3R5at
         m3jfPxy8ZqROcyW+38biZxLjYkeOK48EMHmKyk4OyNUrAZ5YmIcx2t+0srGbfT1PmUWO
         OMJ6Si9LINjKugekPo1BtrbcMZNGBX6NV9x3UBp/D5ma9Ck4Ieodfj/CrWWh0bWkuNSj
         281swCyKegzGGqKw3s1rKQgTQ8INVzvBTj6PLBkFO+YRsVvqgM0fn+H+wEBDIJ6W4Gj8
         N/QWsoR0UxAyFz/7Fk0miISATwX4PE+O86AxWCKRjCR0FpZuQAkPiJfAFSuJ9XogXWCZ
         /YTg==
X-Gm-Message-State: ABy/qLaWflxNzbnBZi6UN/OzAb40+GM1SRAlAL8I/vSXhqrvs2ewrfwx
	WlflDxNSPvva8HV0OXla2Og=
X-Google-Smtp-Source: APBJJlF6j5ZE3Y1mkxc9NxRnr/WudTbHe7GtCNVIUFzHuZuAyRVujwhnUraqbCBuy4C/MSirnmQb4g==
X-Received: by 2002:a05:6a20:a121:b0:13e:1945:8873 with SMTP id q33-20020a056a20a12100b0013e19458873mr9327883pzk.37.1690976468831;
        Wed, 02 Aug 2023 04:41:08 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b006765cb3255asm10912100pfa.68.2023.08.02.04.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:41:08 -0700 (PDT)
Message-ID: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
Date: Wed, 2 Aug 2023 18:41:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 shenlinghai@163.com, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, dwmw2@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after "nvme
 subsystem-reset"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_044111_292359_60C78312 
X-CRM114-Status: GOOD (  10.88  )
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

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Issue description:
> root:~# lsb_release -a
> No LSB modules are available.
> Distributor ID:	Ubuntu
> Description:	Ubuntu 22.04 LTS
> Release:	22.04
> Codename:	jammy
> 
> root:~# uname -a
> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> root:~#nvme subsystem-reset /dev/nvme0
> 
> root:~#nvme list      //This command will hang about 60 seconds. 
> 
> Issue analysis:
> Maybe it hangs in function nvme_wait_reset. When we revert the following commit, this issue will disappear.
> if (!nvme_wait_reset(ctrl))
> https://github.com/torvalds/linux/commit/1e866afd4bcdd01a70a5eddb4371158d3035ce03?diff=split

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.cgi?id=217745
#regzbot title: listing nvme devices hangs after subsystem reset

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217745

-- 
An old man doll... just what I always wanted! - Clara

