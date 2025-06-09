Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C126C61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BvQqX5iQdSePNBNBJ00et482dqomFiNGamV1dpJOl0=; b=3+HqMmR27gjh8IFSwg+mbAC0kp
	XlrqFl84aLYigWj9aPbjQ57RFIYCKNPZvOAZcTEEWagisTpvVAPIIq2cdXDXGspm4w64Hb/jNmrZd
	RnMsgducQL8+I60P2DWXx9SOAEONy/KJJkulLR2f/qxnIh6GTGEbV4cc6jKGPWjd7XRJVZg94MSC2
	7FDVZDrjy/R8VdvDd7Lam2iZi/lewR+qvgQjR+P5SHPtYemcYePqhZVTA+u4y9KkhXvfjUJZRyeDS
	bwk76kZXcLl2T9GaLuUPzNJ/T2X/Z4ajDBlazl3TryO8CEA0cuhdEX6Ojik+d3KFLxisc31DnjU7W
	U2m1AZdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOdPV-00000004NBr-2Sju;
	Mon, 09 Jun 2025 14:23:37 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOdOY-00000004N58-2giA
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 14:22:40 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-864a22fcdf2so157086639f.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Jun 2025 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749478957; x=1750083757; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BvQqX5iQdSePNBNBJ00et482dqomFiNGamV1dpJOl0=;
        b=q3bTuBx6wcoBGfkNGUC7uLr0WYR7ArQWbJ10yqmYS1iv1f+b4INZ4l+ErNjKMyQvTV
         60BWInJ5YACSA9yONbxTD6UWgfYDiaATykOTl0yFpqVMke2WhwkGC6pkMA0djLOySSU/
         M2HCMLrzVp6GvcheMAeLjKjYO+tJVZxXo9HkeY1yZ27jsoacA2iwMMvsmAuonQsm3bF4
         m1ivoYe+XnS6gjCgi0caTqQFFhlwtViJdJ264udQWh+1O/OGS6jukGCwTjqSyYeGtN6Q
         jHMA2mfcXXze+aRR9xZ8e/t2Gb6VLKwYIsv5KjUrHX2dJfGV4/f2zXGcxhXbPlDBLfir
         au9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749478957; x=1750083757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvQqX5iQdSePNBNBJ00et482dqomFiNGamV1dpJOl0=;
        b=Y4HaoR35byEKfkphbsuCRCx+Ai3gluFwuCaoDYxNGLmrP/rSH8Qtl+dxU6ag3JXVhU
         zaeer+r7UzXbQGvTysWVYNhhSOlV4ckKHLhQMesz77o7YvC59w3RRssKarGKtF/YaRJh
         0EHzXgYkf0j9r3I2SsZ8eLcpbxFk6mdvP9K5fAH1AyEcwvw48Omkt74RB+TYRrF5KmNx
         70EkosS3nh0UJAtEc8FviOKcPCtrwGYvc+HqKKQheGZ6X8qPf0w9zz0xxeBXA/DS8nUT
         BRIDudvtwhkQv7jM5Mg85ET5rCoiSRXYKhxe5t3lUeQymv7pfMs6455jipLGc62qPNQN
         sZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG6nTp05tsfTz7DMYfcgoYJOndN5PcqO4cKmEM8ZZ++Xyr/0GWoBcSRwQD71tuMyvp9ZiiFaK4i4YC@lists.infradead.org
X-Gm-Message-State: AOJu0YxAxpAjnPZ+JQQtWAyLhpf7M5uybPz3w/0vprrPAE+16V3SSrNL
	yYf08tD50RgKT8YUdcSqeM/p9bLFyZrzLHULepFbBoFf3lsEf1IvT3BSfVnQjjg+fVcUnRICqYl
	QTsX7
X-Gm-Gg: ASbGnctq63F9kbzKSTTtvtXX/V2HjKrQDXvfuRrczGTzKu9g9X7g0dexMLrAVQOutvs
	uD9R7r78b6H+Myf/Yb5fR4qQLkfnyPTc2NJrswiINy+gU4mNmuO9Nmnio/An58QV+jEmqzotbru
	H6xEyPLapQF9CsMjPBY6tyajALtvos+2z2V/clcKQoCdYM+WK/y18gkJm2YH3nAwNzXTY7lZ6bv
	tfxyDs4pwN/A6bimmsLeNp7D/7eyu3VVmxsRTuSIRgVVKJsOuWzI6j/HLuscJ4uBGcF7RXv3NRp
	wgaV82HKtofNERJNxWLaLqQaBBXnnjAJkrwDh22+Tje7Fc/S
X-Google-Smtp-Source: AGHT+IEU5X53TW7+qSifqoYWNiT2vzKJIH3v9vp8H2K5WCCseyEHuFGHSkfM+Ttqwza+nJvItopmwA==
X-Received: by 2002:a5e:8307:0:b0:86c:f0b1:8dd7 with SMTP id ca18e2360f4ac-873caa2049cmr9684239f.0.1749478957410;
        Mon, 09 Jun 2025 07:22:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df587ebfsm1836794173.73.2025.06.09.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 07:22:36 -0700 (PDT)
Message-ID: <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>
Date: Mon, 9 Jun 2025 08:22:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Yu Kuai <yukuai1@huaweicloud.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEal7hIpLpQSMn8+@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_072238_919179_7F01F760 
X-CRM114-Status: GOOD (  11.97  )
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

On 6/9/25 3:14 AM, Breno Leitao wrote:
> On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
>> Hello
>>
>> The following WARNING was triggered by blktests nvme/fc nvme/012,
>> please help check and let me know if you need any info/test, thanks.
>>
>> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
>> 'block-6.16' into for-next
> 
> I am seeing a similar issue on Linus' recent tree as e271ed52b344
> ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> CCing Jens.
> 
> This is my stack, in case it is useful.

What does your storage setup look like? Likely not a new issue, only
change is that we now report/warn if these counters ever hit < 0. Adding
Yu to the CC as he recently worked in this area, and added the patch
that triggers the warning now.


-- 
Jens Axboe

