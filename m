Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF46C4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6872076E
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g+s8rPwk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ywPGPlbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6872076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IvtTNqn2TJsEKSO/sYMtpDOTHD+Qg8OX/cuQiWVe3B4=; b=g+s8rPwkjrjxQLoLgdcrJAicr
	JkrZtOT9yqvudH083WN6HxsmlAXECzFf4amuBRu+XViFrh4B4UrrYIoDio3FX93oNlThrrKcGry0P
	dK0XQ5b+1JIPAAQ7hy2cdigvSmRn5hH4Ba6wvLgApzZQ0ZugIhZTQ8gc5GXhaCBskA/BLoxSjbmqf
	74+JwJCYEzL8vH4Zp7o79ZOPjfANa/H3MtcMWVw2h95tdSbTItdKKE+DumT1SqRoEbbo65vBbkaxw
	HEb5u3o0BXUdh0Bqmk7l62napChSfxIXkd8k+PlD/pxRyKzTW2bwlg3C7ZrBT5worKwp0dIREiHJA
	opoU3eVfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcV0D-0005v6-Vn; Tue, 10 Nov 2020 14:52:09 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcV0A-0005tC-8M
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 14:52:07 +0000
Received: by mail-pl1-x633.google.com with SMTP id x15so5773279pll.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nx5eqeg7MJ0UkBhGNYYgQ24vfp/tLZx9Fz8eX2aHPnY=;
 b=ywPGPlbJdBOQzWn6iQh0Idu6yvaCg5rAQTUlc8yYGeIxRLEpKkTNnJ4aFDE5OgheCH
 KI5GueOkTiH8l5Hv9kiebgvgR7ogK42aO4yT3hRDNStP9GQcZ5NfKJXtWGBlvnw7aUx4
 RtbxwIMDGQx6TG6HaL1VGozVFENftJ14Ra2vWpG9Rjaew4/mGk8NK323CQNXwWSgq96C
 JHJwLPDsY5gpgl0MZey/hj74GqNIf/mVAwMj9k6eWfbLcOmFySUNWuh7WeoLxnC8B0An
 fwM0emsLs4RPM3SqkEokVAyfWifv/zcCvSXYPi/Suelt/TGoMaz4F3qptMnC6DjSNI4a
 wFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nx5eqeg7MJ0UkBhGNYYgQ24vfp/tLZx9Fz8eX2aHPnY=;
 b=JsFmsejKKxM/FbIzki2z39CC3DRc8tPsFrHUaqf3c0d+gfaDHa3qrJrplUvMMpfOpp
 Z5aHwcGffkIKcAekJGdBkXT5SfKDCgnwqJRw9PUth4njOHqq7EknQgDDXUXNbVfZN3im
 fnQH7ZV+QmsviNXbJ3FkqMU2ZpJs5lKV1mV00Pfr0lKF4BdUdwF/C+ZLkS0YFAvcsFov
 Ywj4xpELWds9BB0GHTnIADRbykqb2klVmcK0Ht8q1C4fvTHJKdEgto8JE9SK3StGwXXP
 iRB7imFsw7AjwpfF8VwI4ZHVcmO7fQMGE/J+hzPFNQUtff5HbMZ8Bwfp5unrhpOg1tpA
 feIA==
X-Gm-Message-State: AOAM533yImtzladjv5CNiUAuVfwijiFNCbena3jm6bIrT5xOVAEgL70q
 LPdCJo3x0AqoG+v59keEzehNDdBDYlZubQ==
X-Google-Smtp-Source: ABdhPJz8owAJX/3JnVR3TXfApRDf00SEj/s77BfhN2Re2xq5WfDDk+IDxMy2OQ6OJTA68rCpMVsrHw==
X-Received: by 2002:a17:902:7088:b029:d6:8072:9ce1 with SMTP id
 z8-20020a1709027088b02900d680729ce1mr17503444plk.11.1605019922138; 
 Tue, 10 Nov 2020 06:52:02 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id cm20sm3812618pjb.18.2020.11.10.06.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2020 06:52:01 -0800 (PST)
Subject: Re: [GIT PULL] nvme fix for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201110103620.GA3200092@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1cf10be5-301e-ab08-a83a-6d55a58ddc6e@kernel.dk>
Date: Tue, 10 Nov 2020 07:51:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110103620.GA3200092@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_095206_321271_284D1F5D 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/10/20 3:36 AM, Christoph Hellwig wrote:
> The following changes since commit e1777d099728a76a8f8090f89649aac961e7e530:
> 
>   null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-10

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
