Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF5AC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5llpMVxmM62RdSoWzXTrV3xrLt8zZBi93xYenMpXorQ=; b=PepgFQIl1qj/bkyxhfEFfGb9G7
	1rnSvPHmz4YTeX3HBM3O+7oRPlNaFXLT+sf96rzp40PdRSazeHUZTsAncd9GQsFa9rJhfXYsEyOch
	v4dgFInU3zLhdplzWxUiqvd36GGDa5xGtfi4QNbHD3T2CRhnPXqfEjqj3Qc06vmRDiUUhwA/LCb2+
	6rjIK+uYP+2qdCb8QdD9wnv6q6+Fg36e0IaOMKFTgsoJ1ugNLaVAd6vRzyxqKmcCbXfLNI8OdPjeY
	1rTutdvaS1ueveZAZaAZhcgt3Ip/v1/JdzFXZIv/fpHH+825n6jzpgXVBT/n20DrwX6Cwtw2HKiH/
	qMFWjhfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOFy-00000001elv-4B4a;
	Thu, 18 Apr 2024 09:40:39 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOFw-00000001ekV-1792
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:40:37 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343d32aba7eso129921f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433234; x=1714038034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5llpMVxmM62RdSoWzXTrV3xrLt8zZBi93xYenMpXorQ=;
        b=Z3miqs0QEVEpz+VmhMvHVkDMiZTNkpREiHezqQCXhcOaz0jCMmXiP/6jtpl3H97Sea
         IaiHshnqvj/zzu3AiCwOEMl00N4Cbn/W9Bg9Wod5JRAtIkWJc4f01Q17njPp/Ec1FXpx
         nb+JdhldBLp/V+cVHHN/7cfSe5d71qqGxClsf5MtEWzH8jxrnhpRxCjtkSfTiOP70434
         SpYSLvkC7YmjIAWUQmYzh66d4YSSALwyE+RhOtXPLwfHcgzrRSiJeTzFp73t2pcwhF3K
         wMBcC/1bZPpzXfT7BBJ6fKV9DWjoW50tfwVyZxClkzqJiKuG8Y17cEto7xf3N2+ODPGM
         NwSA==
X-Gm-Message-State: AOJu0YxvfFB1BsnHemK4cJtGX8YCLL2LAVTNJuW4pKLAEV36hcIQHnuv
	vXnu54DS/KvFpLeRG1ME2kKaV18TFOY1K1FjKKc6D5QhgpnPV4l8
X-Google-Smtp-Source: AGHT+IGSqUYFbSGDXtQK/T2DesnT8E+l/6A5w8bR0mNdPx7XbKYpU4thJO/DZ+r/+okT2pxvFyuDCw==
X-Received: by 2002:a05:600c:474b:b0:416:ac21:9666 with SMTP id w11-20020a05600c474b00b00416ac219666mr1496537wmo.4.1713433233848;
        Thu, 18 Apr 2024 02:40:33 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0041897c6171dsm5806870wmq.16.2024.04.18.02.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:40:33 -0700 (PDT)
Message-ID: <85380369-b7d1-4cc3-859d-d56c4491c39c@grimberg.me>
Date: Thu, 18 Apr 2024 12:40:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 00/11] support test case repeat by different
 conditions
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagern@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_024036_351392_B20DD617 
X-CRM114-Status: GOOD (  29.18  )
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



On 16/04/2024 13:31, Shin'ichiro Kawasaki wrote:
> In the recent discussion for nvme test group [1], two pain points were mentioned
> regarding the test case runs.
>
> 1) Several test cases in nvme test group do exactly the same test except the
>     NVME transport backend set up condition difference (device vs. file). This
>     results in duplicate test script codes. It is desired to unify the test cases
>     and run them repeatedly with the different conditions.
>
> 2) NVME transport types can be specified with nvme_trtype parameter so that the
>     same tests can be run for various transport types. However, some test cases
>     do not depend on the transport types. They are repeated in multiple runs for
>     the various transport types under the exact same conditions. It is desired to
>     repeat the test cases only when such repetition is required.
>
> [1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72/
>
> One idea to address these pain points is to add the test repeat feature to the
> nvme test group. However, Daniel questioned if the feature could be implemented
> in the blktests framework. Actually, a similar feature has already been
> implemented to repeat some test cases for non-zoned block devices and zoned
> block devices. However, this feature is implemented only for the zoned and non-
> zoned device conditions. It can not fulfill the desires for nvme test group.
>
> This series proposes to generalize the feature in the blktests framework to
> repeat the test cases with different conditions. Introduce a new function
> set_conditions() that each test case can define and instruct the framework to
> repeat the test case. The first four patches introduce the feature and apply it
> to the repetition for non-zoned and zoned block devices. The following seven
> patches apply the feature to nvme test group so that the test cases can be
> repeated for NVME transport types and backend types in the ideal way. Two of the
> seven patches are reused from the work by Daniel. The all patches are listed in
> the order that does not lose the test coverage with the default set up.

Nice idea!

> This series introduces new config parameters NVMET_TRTYPES and
> NVMET_BLKDEV_TYPES, which can take multiple values with space separators. When
> they are defined in the config file as follows,
>
>    NVMET_TRTYPES="loop rdma tcp"
>    NVMET_BLKDEV_TYPES="device file"
>
> the test cases which depend on these parameters are repeated 3 x 2 = 6 times.
> For example, nvme/006 is repeated as follows.
>
> nvme/006 (nvmet bd=device tr=loop) (create an NVMeOF target) [passed]
>      runtime  0.148s  ...  0.165s
> nvme/006 (nvmet bd=device tr=rdma) (create an NVMeOF target) [passed]
>      runtime  0.273s  ...  0.235s
> nvme/006 (nvmet bd=device tr=tcp) (create an NVMeOF target)  [passed]
>      runtime  0.162s  ...  0.164s
> nvme/006 (nvmet bd=file tr=loop) (create an NVMeOF target)   [passed]
>      runtime  0.138s  ...  0.134s
> nvme/006 (nvmet bd=file tr=rdma) (create an NVMeOF target)   [passed]
>      runtime  0.216s  ...  0.201s
> nvme/006 (nvmet bd=file tr=tcp) (create an NVMeOF target)    [passed]
>      runtime  0.154s  ...  0.146s
>
>
> Changes from v1:
> * Renamed NVMET_TR_TYPES to NVMET_TRTYPES
> * 1st patch: reflected comments on the list and added Reviewed-by tag
> * 5th patch: changed NVMET_TRTYPES from array to variable
> * 7th patch: changed NVMET_BLKDEV_TYPES from array to variable
> * Reflected other comments on the list
>
>
> Daniel Wagner (3):
>    nvme/rc: add blkdev type environment variable
>    nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
>      tests
>    nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
>
> Shin'ichiro Kawasaki (8):
>    check: factor out _run_test()
>    check: support test case repeat by different conditions
>    check: use set_conditions() for the CAN_BE_ZONED test cases
>    meta/{016,017}: add test cases to check repeated test case runs
>    nvme/rc: introduce NVMET_TRTYPES
>    nvme/rc: introduce NVMET_BLKDEV_TYPES
>    nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
>    nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
>
>   Documentation/running-tests.md |  16 +++-
>   Makefile                       |   3 +-
>   check                          | 129 ++++++++++++++++++++++-----------
>   common/shellcheck              |   2 +-
>   common/zoned                   |  22 ++++++
>   new                            |  21 ++++++
>   tests/meta/016                 |  29 ++++++++
>   tests/meta/016.out             |   2 +
>   tests/meta/017                 |  29 ++++++++
>   tests/meta/017.out             |   2 +
>   tests/nvme/002                 |   4 +
>   tests/nvme/003                 |   4 +
>   tests/nvme/004                 |   4 +
>   tests/nvme/005                 |   4 +
>   tests/nvme/006                 |   9 ++-
>   tests/nvme/007                 |  28 -------
>   tests/nvme/007.out             |   2 -
>   tests/nvme/008                 |   8 +-
>   tests/nvme/009                 |  36 ---------
>   tests/nvme/009.out             |   3 -
>   tests/nvme/010                 |   8 +-
>   tests/nvme/011                 |  39 ----------
>   tests/nvme/011.out             |   3 -
>   tests/nvme/012                 |   8 +-
>   tests/nvme/013                 |  43 -----------
>   tests/nvme/013.out             |   3 -
>   tests/nvme/014                 |   8 +-
>   tests/nvme/015                 |  48 ------------
>   tests/nvme/015.out             |   4 -
>   tests/nvme/016                 |   4 +
>   tests/nvme/017                 |   4 +
>   tests/nvme/018                 |   4 +
>   tests/nvme/019                 |   8 +-
>   tests/nvme/020                 |  40 ----------
>   tests/nvme/020.out             |   4 -
>   tests/nvme/021                 |  10 ++-
>   tests/nvme/022                 |  10 ++-
>   tests/nvme/023                 |   8 +-
>   tests/nvme/024                 |  40 ----------
>   tests/nvme/024.out             |   2 -
>   tests/nvme/025                 |  10 ++-
>   tests/nvme/026                 |  10 ++-
>   tests/nvme/027                 |  10 ++-
>   tests/nvme/028                 |  10 ++-
>   tests/nvme/029                 |   4 +
>   tests/nvme/030                 |   4 +
>   tests/nvme/031                 |   4 +
>   tests/nvme/033                 |   4 +
>   tests/nvme/034                 |   4 +
>   tests/nvme/035                 |   4 +
>   tests/nvme/036                 |   4 +
>   tests/nvme/037                 |   4 +
>   tests/nvme/038                 |   4 +
>   tests/nvme/040                 |   4 +
>   tests/nvme/041                 |   3 +
>   tests/nvme/042                 |   3 +
>   tests/nvme/043                 |   3 +
>   tests/nvme/044                 |   3 +
>   tests/nvme/045                 |   3 +
>   tests/nvme/047                 |   4 +
>   tests/nvme/048                 |   4 +
>   tests/nvme/rc                  |  58 ++++++++++++++-
>   62 files changed, 437 insertions(+), 379 deletions(-)
>   create mode 100644 common/zoned
>   create mode 100755 tests/meta/016
>   create mode 100644 tests/meta/016.out
>   create mode 100755 tests/meta/017
>   create mode 100644 tests/meta/017.out
>   delete mode 100755 tests/nvme/007
>   delete mode 100644 tests/nvme/007.out
>   delete mode 100755 tests/nvme/009
>   delete mode 100644 tests/nvme/009.out
>   delete mode 100755 tests/nvme/011
>   delete mode 100644 tests/nvme/011.out
>   delete mode 100755 tests/nvme/013
>   delete mode 100644 tests/nvme/013.out
>   delete mode 100755 tests/nvme/015
>   delete mode 100644 tests/nvme/015.out
>   delete mode 100755 tests/nvme/020
>   delete mode 100644 tests/nvme/020.out
>   delete mode 100755 tests/nvme/024
>   delete mode 100644 tests/nvme/024.out
>


