Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877A3C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWWMII8laEI2vFsQaEykQ28y9VWn43QYhEX+pUSJ+KA=; b=BElXLjjfTQSduY5/2TYDgbIbGq
	2ItjA9eJD/W7HYRNoVFFAEB951zbzePme/XjK9PfUBC1VNEewvYjgbqrW5jF7Sz7hws20fO0CGHjn
	+r0i1GaIUB/K6+mRXSY/Mx1e2FxMhEmYAjbR42GBxYy/HS2sDqdDMNaLgfppF7kL1wiDQU6bf2Mfh
	1sL3Z5zvEhqycswGJk1caOxro/9BV8GDgG0yUgxpH2DWjBtXiRFc9N4qsmYEErPRDb2h4eEEdenV4
	1edyhZ0cd2Xb6BrIuR3X/2UBOjSJ2hzX1OaVEhNLNeIoXYPM2QNOEl/Lztc8Q5eoxStE16nhNDiOR
	tEFb0Y6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPmmS-006hGH-Dn; Thu, 03 Mar 2022 14:50:12 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPmmO-006hFP-T6
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 14:50:10 +0000
Received: by mail-pg1-x535.google.com with SMTP id t187so444124pgb.1
 for <linux-nvme@lists.infradead.org>; Thu, 03 Mar 2022 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fWWMII8laEI2vFsQaEykQ28y9VWn43QYhEX+pUSJ+KA=;
 b=DnYMBZZ66vHnSDXm/ZcIQmpiLp0Pn2muj4V2o5+lz+c5Sh+Shep2DLwj1gZWgP8crp
 F6GREnQ+AubnK32AhapWG0l5BgdUj3DLPf9BBnLPZq4JuUEq+1nvc1oUHL1TIYvQASu6
 3xemY1tQLqvih/HLWvH5fpK8NdDBaZoV8Z0/1k7mDz8kT9koxN0a75vn88TCzfy7eOWA
 wZAG2YpF9sRKnfFDyRRFpp4WMB7ud89bY6PIK8y0GyhSQzACZIHL9SfnhVph9UkCcZng
 NCGOfyPYB6zYBzVYokfPA1ZH0dRZ+NuRre3y3n7Z1CBu6aW9HsN+mDHIaN4p29Srg86Z
 XFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fWWMII8laEI2vFsQaEykQ28y9VWn43QYhEX+pUSJ+KA=;
 b=QqO243KjAQPB5U47GYsN74hZZ7kvB1TGOdOR3r/aXSzfU+z82Ag5p7TjbNcwDtTHhg
 GMF37al4Gos2tZHVRLMHWNopX13xwiPif970Zc+Z0Qwf55mpavP/1K1+mVrnuV4fTrA+
 wR70nkH5wBmZFm0DtIXnT3KH0NlQdmpylAHkyck/3WAQUQqOuGsEAe3r4AaQZ5uNz8sk
 FIdByOoGBr2BkyBOQHcZPPDWHaKwOu5BMsY8NXp6jin3jMXEUd/o3AHaP5LrLuBzTAhA
 FV2Mb7EXLDXmrZXq+U/IFL9kObFYEdmbvp9yT5gkL3TaXYniwEmvnNEajQkVDLThkBTh
 l5pA==
X-Gm-Message-State: AOAM531gdFPbueK6zne0Nv7S4cw+yhTkn7P5LZgsWegdcVSqBur7BvBH
 J2HRM7g7iT5unxCai1/Xn7u64w==
X-Google-Smtp-Source: ABdhPJx+llELsr7zrHUh4UBBMHEut1DDv2B49Vzlw+Qc93VIpJZ7hET9UOJ+RNrQXT+WCiWztoWFSA==
X-Received: by 2002:a63:1245:0:b0:375:57f0:8798 with SMTP id
 5-20020a631245000000b0037557f08798mr31156186pgs.490.1646319007089; 
 Thu, 03 Mar 2022 06:50:07 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a056a00188b00b004e1c075c6fbsm2760852pfh.52.2022.03.03.06.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 06:50:06 -0800 (PST)
Message-ID: <c7be737d-9cf1-83b7-94f8-f4f0e3786eac@kernel.dk>
Date: Thu, 3 Mar 2022 07:50:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme: remove support or stream based temperature hint
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20220303105049.315987-1-hch@lst.de>
 <20220303144208.GA2367645@dhcp-10-100-145-180.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220303144208.GA2367645@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_065008_986906_DC76CF37 
X-CRM114-Status: GOOD (  15.85  )
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

On 3/3/22 7:42 AM, Keith Busch wrote:
> On Thu, Mar 03, 2022 at 01:50:49PM +0300, Christoph Hellwig wrote:
>> This support was added for RocksDB, but RocksDB ended up not using it.
>> At the same time drives on the open marked (vs those build for OEMs
>> for non-Linux support) that actually support streams are extremly
>> rare.  Don't bloat the nvme driver for it.
> 
> Fine with me. It looks like the early interest in streams never really
> materialized, so it's unlikely we'll hear any complaints. 
> 
> You can remove nr_streams from 'struct nvme_ctrl' while you're at it.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> And without nvme, there doesn't appear to be a real user for the
> write_hint anymore. All you can really do with it now is prevent
> merging, which doesn't seem useful.

Yes, I would suggest that we just prune the write hint and just leave
the fcntl() ops as stubs as a followup patch.

-- 
Jens Axboe


