Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XMcoeRBvd8uLgcAAc3czlI1+zvP91Hjty6FTnTtIrU=; b=WaFSxFhRb2BH9E19lbJgD4rl5O
	M/0+hu5pEw7e76Pv52CRHIqT9+vFrZQDcLdyZ1PpzLSPYoKdbKxFboDgXiLgXnYkjbxrbr1GyuqAP
	If/znj59XmANTYaxaEfhssjl5duyI0EnMJCNtAJ1Xub8MZlE+dmXo28o4l4wzI/QpYsFKePH/FFcf
	2WN1H9qCT0Ii3zkJwM4b80nBqZgkK8clj8wdXpJjZX3BhRFDHQQaStAOMC4GyNE9ZggCD8UE1KJWl
	sEfV7B9HWVsuai/RIvfwET8n6h0y4GInkrWPRjeJb7HoLy15ep4Ppq+61lbQW4c1bBFbnZMHUVw8d
	5YfytK0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqbVs-008Ghi-2E; Mon, 16 May 2022 14:15:56 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqbVm-008Gdc-CR
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 14:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652710550; x=1684246550;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZIVl0tMHMU=;
 b=FAnEfpvAlJitHhf12zIhxmHG6Taad1ECon+XyIlNmGaerQAhd3aCvpfW
 NCnSNtTfNvigOxZd77L657uyBcasdy3XdSd8Ke3Z8idO6Fuwb77XlP9UL
 1kz4lj1DW9o/aIpOiGFVq/iUvJuA4SnIGNd5wX/UZotp+qgEl/gFiOhsO
 NnKCMDE7vBTDsahflu0oLrrwU8MkRojdYrsOLRxMcwcqjLAnvufOh90Uo
 M/o21Ku9jN5bNC7km9L4n39W7BoxO9lMzniIRD2EZyNLgRPN8I0l+GBfG
 JVqJ1tGLkeWqIVkWc5N6fXkH54JK+3yj5kVF3Pt6ubsF60Djxcvp/5rOn A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; d="scan'208";a="312421627"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:15:46 +0800
IronPort-SDR: JR2CU1ud4M/E4ELyfVWG5FlTQnKOOaPq8YZqUwmi9kTxeKQ+2Jp6rd/R2etjSBrvGt5tpu5zLO
 ehSjZhc7vQKIlUcZYg6tEgd1Rp1yG4KePtOv6olE/KDDIY9ClFOWkEycmCSej09N8XdZVBFe9h
 la9Xr8F06yHnAOGo9BJTElWkhI6ZP38i1PEgSOkURarM/RAKA7VB/U5kw8YuSYbfO/8z3uZI70
 83tDJxtbqWBh70xIbVSWJJwApJAAXGKtC16Tp+oUNs1RHj2N9at+GlmB7r8FW16S7PvKijbnDq
 +g3iLFc6jmFsRQx7LOXd1gky
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 06:41:25 -0700
IronPort-SDR: UQNj9aI9Chns3PentARh9bL0AST29b2tZpOudDvP/DSLnyZU9EDXePEI7+4yx8OOygUujhnvfN
 Ib5l146kmVLLqZMT7d153LgbfY55HMGmyc4iIKybtL1EDcO1cXRUYgIjWYVqs4afBWcXjt0Wc9
 fLlsA38hk1WW5MVn6xO/t/0g1AmfO/EN7v8cUJVVx1yUZVJG5d8W49hLOhEKy0bV+LEUpJbyyF
 yp9L2YnSFbveqPP1MD3pOLIV2xRHDfTR/kvfRJEVfEcQc2la8ie65YHQPPecJ/f/+UubqB9eme
 YBE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 07:15:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21W32jrGz1SVny
 for <linux-nvme@lists.infradead.org>; Mon, 16 May 2022 07:15:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652710542; x=1655302543; bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZI
 Vl0tMHMU=; b=i4y52IglqHa1njsCmAT+LslWANsFjmGWNuC+BQusYwJboYbqlpx
 1K5trb7R/DS0LQM7zIGMW36j5tKV1MkXjwyqWyIuVDc9mYbpFnl/PFabswil526a
 8PiySSAYXnoSsIriKA/fIQIfIzGNus805nNa9Qt91pNUX3WFWNouE47CHlBB9rel
 maqyn8618u1OIr5FZQpjtBkmCq16SVwivVnZFernknGS9rgAJn+4/1wc9xKfDMsc
 KdcjDRBgvTZk1H8sIVIYRnv8T+1SqXKjglgem7sY9T2qTTW/b7gkVCrv7G4sfF23
 zShZbGhGxHLSBwjGLH9SpFHHDxkqgHQgncw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id ddMCDUOtpGQ7 for <linux-nvme@lists.infradead.org>;
 Mon, 16 May 2022 07:15:42 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Vw31VPz1Rvlc;
 Mon, 16 May 2022 07:15:36 -0700 (PDT)
Message-ID: <31e03f27-6610-c4e4-58b9-6b9db000a753@opensource.wdc.com>
Date: Mon, 16 May 2022 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, snitzer@kernel.org,
 dsterba@suse.com, jaegeuk@kernel.org, hch@lst.de
Cc: jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
 Chris Mason <clm@fb.com>, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
 Alasdair Kergon <agk@redhat.com>, jonathan.derrick@linux.dev,
 Keith Busch <kbusch@kernel.org>, Johannes Thumshirn <jth@kernel.org>,
 linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <CGME20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444@eucas1p1.samsung.com>
 <20220516133921.126925-1-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_071550_460844_919676DF 
X-CRM114-Status: GOOD (  17.78  )
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

On 2022/05/16 15:39, Pankaj Raghav wrote:
[...]
> - Patchset description:
> This patchset aims at adding support to non power of 2 zoned devices in
> the block layer, nvme layer, null blk and adds support to btrfs and
> zonefs.
> 
> This round of patches **will not** support DM layer for non
> power of 2 zoned devices. More about this in the future work section.
> 
> Patches 1-2 deals with removing the po2 constraint from the
> block layer.
> 
> Patches 3-4 deals with removing the constraint from nvme zns.
> 
> Patches 5-9 adds support to btrfs for non po2 zoned devices.
> 
> Patch 10 removes the po2 constraint in ZoneFS
> 
> Patch 11-12 removes the po2 contraint in null blk
> 
> Patches 13 adds conditions to not allow non power of 2 devices in
> DM.


Not sure what is going on but I only got the first 4 patches and I do not see
the remaining patches on the lists anywhere.


-- 
Damien Le Moal
Western Digital Research

