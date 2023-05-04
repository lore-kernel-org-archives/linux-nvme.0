Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89292C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmsEyvQWQLhz8Wo2w2vPqihJ7gBJNKHrPhp6n9tMN2E=; b=Vul0O0vYbuTIyUgYffbsiuay8m
	X8zqEepLinsHLKUGmYbfV++dT4SXNKtnRV6OUrqKP2R4Mx1Tj0f1Y5OflX1jco/Gj1uiiPSMZenfh
	GAzLHXb4Svg2job7/iexBGF0BLAqB/22T2gzNZ8fvJLbRABURk8xkZ3ZsQLR+ErU/8R7RGdaKNxrh
	wOqnDpE8pg4g3uL/Icuh0d5jmDmso7pS7ZjWeqK51jZtVd6QEEdesSC+u1lIzPf7vbPXxQNrl2kqC
	BfRHL7Gi5+EI33l5wKawPVzWjW9Z2KPjjaiEt6IT79exgLm4zXG3qHmKqQP5ok3dxYNcxbZAtU1M+
	ufRjJBNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pud7S-008Sys-0l;
	Thu, 04 May 2023 17:51:54 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pud7P-008Sxj-1t
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 17:51:53 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-769a4e76f30so5150339f.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683222707; x=1685814707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmsEyvQWQLhz8Wo2w2vPqihJ7gBJNKHrPhp6n9tMN2E=;
        b=twe8mnAMI1n1ZENXvEQiP/IWTAqjuK9bihn8ytCraFymd2ek0d/gXO7PK92qlGXZJy
         K7Q0TjoPjJHO6ynWmw8JqDe1SDr7pwdV5FZgK4E9Vx6r0ad8uWNRoPU4WrHpBDvxP1ev
         cDhVRBXHZDfxtDyrtiIHlNXfxa2baPuYjTWcQ/ENtccBcuzW0Oq+jSwWU/iyQLqrzwaR
         2ZsZVKzFnAPiGkOpmvbCjnEOR8RtEAmSoQDGMSrDQgfB+c6kUXF9+Ce3s/Vw1ovmj9Lt
         CGcKP+fnizUQN1OZFqyz3MwwGGCe72Pwm8tm57h8HK20EMkUefQBHiXyZLIqEabhpBnZ
         qaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222707; x=1685814707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmsEyvQWQLhz8Wo2w2vPqihJ7gBJNKHrPhp6n9tMN2E=;
        b=IJHR151vbhrKIiNUlVgVwrrG4GRaFuiSLnIQKKwRpQUIlSuGzfL+On7B0ENrIzm9Pu
         +0fiagv3bGBvfvXiJGOSCN6t8Xq7OUllZLk8tKVk8J1HD8+QfXRbzjlKfa0138ECuOWm
         URAPM04fK7pk/NeXsVlqxzrX8IoEAAlcJqC9JZm/Im+NfFPSVU9+l4jxhMvwTS0pNWb6
         F0mUvJYgqgkdwxGa1SUjQysSeCiJfKaUfNzJ3AkYHOa+6Bet4MlbtHWgs1At0kNU9eKl
         2CTAH5Oi0+cvZJbn5K0PNkFuxJ1RctKuLfjA0ZIABq0GIA4Km5XhADDtFdOYI6DHuJaH
         m40g==
X-Gm-Message-State: AC+VfDw0H0roG+3X1pJWyuYnisUsfU5+hQxXiV0Kb7H0NdKCKV2rv03M
	ptN92j+ycIoVmSeHPpG7UwgwKg==
X-Google-Smtp-Source: ACHHUZ7A56eBv7M/lXClJyQTCjp11K7TI6GQUUHhOUm5qb0Uiv+T2alaqH2egBBXju3lGMhMD2yWBw==
X-Received: by 2002:a6b:4115:0:b0:769:8d14:7d15 with SMTP id n21-20020a6b4115000000b007698d147d15mr4982579ioa.0.1683222707633;
        Thu, 04 May 2023 10:51:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x20-20020a6bda14000000b007635e44126bsm9822062iob.53.2023.05.04.10.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:51:47 -0700 (PDT)
Message-ID: <0a50fae3-1cf4-475e-48ae-25f41967842f@kernel.dk>
Date: Thu, 4 May 2023 11:51:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/3] io_uring: Pass the whole sqe to commands
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, hch@lst.de,
 ming.lei@redhat.com
Cc: leit@fb.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
References: <20230504121856.904491-1-leitao@debian.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230504121856.904491-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_105151_627262_48806A0E 
X-CRM114-Status: GOOD (  13.64  )
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

On 5/4/23 6:18 AM, Breno Leitao wrote:
> These three patches prepare for the sock support in the io_uring cmd, as
> described in the following RFC:
> 
> Link: https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/
> 
> Since the support linked above depends on other refactors, such as the sock
> ioctl() sock refactor, I would like to start integrating patches that have
> consensus and can bring value right now.  This will also reduce the
> patchset size later.
> 
> Regarding to these three patches, they are simple changes that turn
> io_uring cmd subsystem more flexible (by passing the whole SQE to the
> command), and cleaning up an unnecessary compile check.
> 
> These patches were tested by creating a file system and mounting an NVME disk
> using ubdsrv/ublkb0.

Thanks Breno, applied!

-- 
Jens Axboe



