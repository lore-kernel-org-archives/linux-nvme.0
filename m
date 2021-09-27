Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B1C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DE06103B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59DE06103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XAABogTewbeA+H7VftfucJz+Mp3h8SOMP2d3qpr5SAQ=; b=psF0jN1z11567fTk/UDdtC2yYZ
	LeyZwD9FfNSi8+ZaTQLNY+U2S93cfN1Nfbztzg5sa84BUCiNosaJmQWQDT7nBiSC2TyZSITzGVljy
	hQnr1PjNIbgdWCfxp96wODZwRU8+/ueRvUQYLx00kbJkVa5bzkuJDnoUwBchIgVorCcuBQ8IscepV
	B39tfOu+ju25q6sb/lh2ltjhOBDzGWn8l2/3MMkSvtPJxu7AeMhiCCqpGtHqNGzQzF3z1j9D3teO/
	2rkE5A3BmmfKTeAjRR1DsboFf8+shhqmaFxNtu5l7VD8A0LIq2WddbM6SSgddUFsoo3PYf0b6+YMN
	3h9V5YYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUzOz-004k61-OG; Mon, 27 Sep 2021 22:47:13 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUzBw-004gRE-6X
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 22:33:45 +0000
Received: by mail-il1-x129.google.com with SMTP id b6so21135156ilv.0
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LOsuwHDiPC+PPoCEQN/qtQeyMVFZbR3g1AzPIbWGz1s=;
 b=YTqmdXk5vu2O6Z09DphFzhzdWxPQ8jmaJFHrIsMI+6Jhr8dovpFIgf0hfWsFZmWJGq
 EVBCGkS1YFFNZ8M01WgONYjDBxGTGP/DCZWSKVCmRzFam2Hh4IgqxVmjePf268PGtV81
 f5vMDXMmwBYUfauwYcel2Rv7+Z/vgk39qzYsRkTAosBsqgB4GwDsvm6cOxLKEb7WhBzu
 TSGL2cQt0huoDrGurVnZof3FIGpxyaHR8+jLKBQHjcW0vLlSgpEdy3xv/8pfNM0RjCzL
 S68pit92xtiJTYJshqe0ROVs/67npCPOQRoa5DA5iXWksCwd+SjdXeI2A9yZ8hXhKis6
 coXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LOsuwHDiPC+PPoCEQN/qtQeyMVFZbR3g1AzPIbWGz1s=;
 b=NbpTKE9HnNMXMUYC4D8wLQXJnmh5bxyk04NKqdb3Y0icD1ihfxaCtDp3NNEap2+lfp
 q+heg3tQl1k56Ca05VGa5mrLfJooycrWNeeKV6Md8ZiNSudCK2bDDYRN0ngrYaW9hjq8
 jUvZTIUy/7wCy52AqfgX4pWi5Q+eV1pkHq8NCkFLO+q1VZhr1FXFnhZ3ywglT+OpeFct
 E0XT5a0SKkZCpFQ9GeUF/ZRF+iuyKMm/f1HvQS1PoK2RONvEHAIxXYq2PX9I7NXmLD7A
 WPI7a9HiNlT1qP4wPuzuwuFUx6mOKD3Sx5sk0GRDEyQ05W/THpEnoRaqeVoxDC2J5GhC
 Ws+A==
X-Gm-Message-State: AOAM530KkbL513AWwnVmcC8qFDpd4Zii9vi6MC6iDBIDBiZ4IouoqtwE
 +wjVqAg4+EJ4jRSCvdmv1Vk3Uw==
X-Google-Smtp-Source: ABdhPJwueWxtKqjP8KyNWWEV43ZHbAJgLgbtzL1ErWyEowm3/77Murhw193eceS6jFlQ9sjaEQjTVg==
X-Received: by 2002:a92:da85:: with SMTP id u5mr1851944iln.213.1632782018707; 
 Mon, 27 Sep 2021 15:33:38 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id y2sm6427866iot.45.2021.09.27.15.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 15:33:38 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] block: second batch of add_disk() error handling
 conversions
To: Luis Chamberlain <mcgrof@kernel.org>, colyli@suse.de,
 kent.overstreet@gmail.com, kbusch@kernel.org, sagi@grimberg.me,
 vishal.l.verma@intel.com, dan.j.williams@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org
Cc: xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220039.1064193-1-mcgrof@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c17004ed-884f-5a97-c333-602e3f9903e7@kernel.dk>
Date: Mon, 27 Sep 2021 16:33:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220039.1064193-1-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_153344_279575_DCC6BD4C 
X-CRM114-Status: GOOD (  11.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/21 4:00 PM, Luis Chamberlain wrote:
> This is the second series of driver conversions for add_disk()
> error handling. You can find this set and the rest of the 7th set of
> driver conversions on my 20210927-for-axboe-add-disk-error-handling
> branch [0].

Applied 1, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
