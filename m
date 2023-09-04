Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA6C71153
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Sep 2023 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vGFV9RdXIBN+D6ZdfrgNJVd3fOxwTgeaUelyWOQ2VLY=; b=rDPmpVAIpLBFShAJmXwhFjDjns
	i7mn5lUgtdRgWZIXt4toEhZrpPWsnEgAY65yYKNhiwTKulHby77kJ7MD30QjEPGI75iGmo36BhQoe
	vFXkqi7Mje7dBdwspJsr+TQlTHbxg9QxZ0Znd2pb8G3mjNYfEDTMEBP1KQ47qkv3/PgQG/ZjsSYQG
	Q+OV++YX8NYHJ8xHlWr/v3arIqmYg7eL1XBnoKL8tItyTTRbHRBlVie7f2y7uiCOZpFp0GqO1r3JS
	tU8lUf3G1IsWvV7rfHJpvYMF8RV74//xPlq91SOieJb2CPBsL0IhwDeJRfuXLXb4gy9Yr7DCibtzz
	rb0rF0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qd7SU-003y9U-04;
	Mon, 04 Sep 2023 11:09:30 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qd7R6-003y91-0n
	for linux-nvme@lists.infradead.org;
	Mon, 04 Sep 2023 11:08:06 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a520dba33so1088783b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Sep 2023 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693825681; x=1694430481; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGFV9RdXIBN+D6ZdfrgNJVd3fOxwTgeaUelyWOQ2VLY=;
        b=dD91j+rtG9iwKjEsaLdg16AnqDvJEz9uNbTD8/qWqHRgh+Zu0sBKHvXqL2PFD1GeiA
         QAwvhaee+LHkXbew7ECMnjkR9vP+8K6zjiMd5mm3tmAAIS8Rwj8CAiI5RdcJOHjBO8rI
         Eq5I4SYm076fSI8iFBSA8b3UCy0VTrkM6tOMekuYcOcCZZ1fmJbnL71kx0AQItFOjZgx
         l9qTvWTEyriLzwKn3mvBkSMs1/5tnzdMGdMiDFvda1PAaf6Pmr0BXj+1haUU57dPDslX
         COsufL6/GJGyQFw9tcg6RDgYNhcbHdKbQeokbV1Mpum7bsO/Vx7rchyvcjM+Doljzk6R
         vu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693825681; x=1694430481;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGFV9RdXIBN+D6ZdfrgNJVd3fOxwTgeaUelyWOQ2VLY=;
        b=KZx0bXvPPL/WyXvYLkA6q9hNsyJefOWUl168LP9tSRm6ZJTlgFz0dfyCmLHFXV10h0
         rUoLuw7LM7wVtT9njf6lIR+eXDrdGYGOzzCSC/L0ir3K3usMeaQIosOPigDaoGivbjtM
         rTp3mW36BZVGoWIQVstXDBNwBK3lrxx8dpmq/KSrYyBGBEEhh6jcru6jKYGe+xEUWRbH
         D7UCrq3dtPad3QkHyjkbT2FZ89/loCYsgCHapvtkw1K9xTgfdKXteh8r9JuG511bU53r
         g4ROj7NH20XWJhIZOC+QPunT7dg2PqPM9hBUspDD4x/8rstxN6PwPFEwZSHevJf75OhN
         FLeA==
X-Gm-Message-State: AOJu0Yyauzcy6XO9eKS7rsDl/VcXRp4JFe90o+H8cRHdYAMctJd+BEgC
	lmaFGxbDILw8JAT/0TsGkfk=
X-Google-Smtp-Source: AGHT+IGSm6XZ2nlG25arT69VYYhZ7sC3wwO1vhYk8pWlyzLHNDl72ZVoXTbaPcZuHWIZviCz6S9daQ==
X-Received: by 2002:a05:6a00:1585:b0:68c:3ef6:2170 with SMTP id u5-20020a056a00158500b0068c3ef62170mr12481566pfk.34.1693825680516;
        Mon, 04 Sep 2023 04:08:00 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id p22-20020a62ab16000000b006870721fcc5sm7396453pff.175.2023.09.04.04.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 04:07:59 -0700 (PDT)
Message-ID: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Date: Mon, 4 Sep 2023 18:07:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Claudio Sampaio <patola@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Stable <stable@vger.kernel.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_040804_687531_C8EF4F00 
X-CRM114-Status: GOOD (  23.81  )
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

> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the time. It wasn't recognized, with these messages in dmesg:
> 
> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> 
> My other NVMe appears correctly in the nvme list though.
> 
> 
> So I tried using other kernels I had installed at the time: 6.3.7, 6.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
> I installed the 6.1.50 lts kernel from arch repositories (I can compile my own too if this would be an issue) and then the device was correctly recognized:
> 
> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple suspend
> [    4.654632] nvme nvme0: pci function 0000:06:00.0
> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues
> 
> And then it appears alongside the other nvme:
> [15:58] [6836] [patola@risadinha patola]% sudo nvme list
> Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
> --------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
> /dev/nvme1n1          /dev/ng1n1            2K36292CEKD9         XPG GAMMIX S11 Pro                       0x1          1.39  TB /   2.05  TB    512   B +  0 B   42B4S9NA
> /dev/nvme0n1          /dev/ng0n1            NF9755R000057P2202   Lexar SSD NM790 4TB                      0x1          4.10  TB /   4.10  TB    512   B +  0 B   12237   
> 
> And I was able to read and write from it, pvcreate and so on, so it's working. But I can't use a higher kernel version so apparently this is a regression.
> 
> There are other people with the same NVMe model (although different capacities) reporting the same issue on this reddit thread: https://www.reddit.com/r/archlinux/comments/15xbxeo/nvme_device_not_ready_aborting_initialisation/
> 
> I am not sure but I think this issue might've been introducted after this patch: https://bugzilla.kernel.org/show_bug.cgi?id=215742

See Bugzilla for the full thread and proposed quirk fix.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.1.50..v6.3.13 https://bugzilla.kernel.org/show_bug.cgi?id=217863
#regzbot link: https://www.reddit.com/r/archlinux/comments/15xbxeo/nvme_device_not_ready_aborting_initialisation/

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217863

-- 
An old man doll... just what I always wanted! - Clara

