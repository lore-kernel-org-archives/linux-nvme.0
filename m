Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837CC433E2
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 12:03:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100C720757
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 12:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mfhZTYAI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWXOq0jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100C720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mWjzak2z80A6ryFnpEnYv9GiItNF8FHZoZvk0sFJeFo=; b=mfhZTYAIQ/vVLtnkcIVtDRzl4
	UOZfP0W7x5qe/14AUl059kJ3A7mQcgdvzhr6+XGmAGZwFOdsW1nqAp2UWOwjUdo2PIVkDfzI/tydw
	E1AbwVj7hVj7goZaJhC+fvxCbmrvIRqyE+mKcfCdoeB86wxyAdpx5NtD7wdAixa9Z5szycPeZnbkZ
	cWO8jpsttvVTBNtD7e4dtdrqw8bl1ZKa2jEIMZxFcNwm+Ul1x1JFOaUYA6bUvag5KsppirZ4d4Ruj
	5Yt5Tfkf4eyWFS4is50+cZEklWy87vwD2W4gt3nGAjGR5PzWTsnw/iZJ5QDyNwuayzLGPsXt3A4lh
	Bh7fh4ZsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEWuf-0008Qo-8F; Sat, 05 Sep 2020 12:03:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEWuY-0008QO-1N
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 12:03:14 +0000
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E342520757;
 Sat,  5 Sep 2020 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599307392;
 bh=CL+8vNktyF9sqP+DrWIv2YGkaXiyazpKbZtcIXOTfSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BWXOq0jUKp1yZ8Q/njk18/Tiixpxxrq6XTP8f7Ek0vMY+RW2LpXKUoD+qjtE5iDOg
 NPS/fcfzJBXfpJWuOWmSWX7sMWPUmGOm95FZJmj2EzYTWltZcF2mRlsp6GLvHeV3mx
 r05E4mXuaQ/j6t+KcEaib1+dYEAADV0rej/fx9IA=
Date: Sat, 5 Sep 2020 08:03:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.8 11/42] nvme: skip noiob for zoned devices
Message-ID: <20200905120310.GI8670@sasha-vm>
References: <20200831152934.1023912-1-sashal@kernel.org>
 <20200831152934.1023912-11-sashal@kernel.org>
 <20200831153818.GA83475@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831153818.GA83475@C02WT3WMHTD6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_080314_140135_48966E6A 
X-CRM114-Status: GOOD (  12.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 09:38:18AM -0600, Keith Busch wrote:
>On Mon, Aug 31, 2020 at 11:29:03AM -0400, Sasha Levin wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> [ Upstream commit c41ad98bebb8f4f0335b3c50dbb7583a6149dce4 ]
>>
>> Zoned block devices reuse the chunk_sectors queue limit to define zone
>> boundaries. If a such a device happens to also report an optimal
>> boundary, do not use that to define the chunk_sectors as that may
>> intermittently interfere with io splitting and zone size queries.
>>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>You can safely drop this from stable: nvme zoned devices were only introduced
>to linux in 5.9.

Dropped, thanks!

-- 
Thanks,
Sasha

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
