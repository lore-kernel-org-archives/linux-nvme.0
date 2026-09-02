Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E297C61DFD
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrhr596mnK2dbjRLnW2TpPyTsU+lz2ODEABE+FOq7JI=; b=2OdCK28IHHez3xZVDUK/rcPCGu
	/DYib7/mNF+KamrgQE1Da7RjWmAsloqZY7kh1PrqnWOcx3p5qLqdj9bD9xRf9VchrmelYZhiod60r
	VbOiXzsFrwkZv+FAEs3DtDf2tPA7uRrxTygmWCDDC0aOV1OP6v2asHBKY2UCNgB/5/fQW4daAzSYv
	V+amFYjCJepJ9HU8EIN+KDGeT2k5RRdywRQkxZhV3ALLvcUhwG99VPI54gQEC6N63qR2eJbptJoa/
	vunwMsLxVAn8L/OVcN+O3jDFN+YHQIMSGGHAAsT5BDEC5kcNZAqsLeK6V+KB2YTzvLH7ImQsFk7iA
	2k43T6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1eOl-0000000DrF6-21JH;
	Wed, 02 Sep 2026 06:24:39 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1eOi-0000000DrE4-3zKX
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 06:24:38 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so647349b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2026 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788330275; x=1788935075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrhr596mnK2dbjRLnW2TpPyTsU+lz2ODEABE+FOq7JI=;
        b=AIQU2b58RXdN9W5QIgMB3YycRNOtBUREdW+33eoBABTO1pNvja6D08byyI2TyYtqt5
         Wj5xXByrCA51/ujy5CnvIDEXNPhLvPb5bV7v2yHcBWjFViqMQHpTxwt2Mb88/FuoNZzC
         0cxPMygB4BbaCw11DzrD5bLnkK8opd+c0l3IOAl95jcZ3TgXnn6JAPSFi0QvTNHbOwLR
         xGEx2sMf0JQ0yeaZv/EfweivwORHLp0hkgEHubYZQMjT0kdZtkAeyDk4j5QLVTx9rtoO
         0bcTjMnxH0zfyN263GXpodcnCfT4EC5p/AcZFYbR2ny2xtCOYQh3gwFums/9wvTGctih
         a6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788330275; x=1788935075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrhr596mnK2dbjRLnW2TpPyTsU+lz2ODEABE+FOq7JI=;
        b=rSkAoo8VgKOkSJO58iV3qnLxobFyzsDZtIYNesToDhT7uPGEw646pflvRjBdUFGggD
         t7TKqdjnnM9hDFWVX40/z8M2xUCOWrzGS/meKgAJJPL9Yy9MjXW3X51FFJDrrdqZptM7
         iQURKhu7321x0/zdieWMfP4f3aIgWrfJQHZJuvcvsmVNK/2SPNSUp5r04kAjksyjrFUV
         NAORbQ4aaE9Uyj2JG7UvePxHxAwaqFihxME9ILgOiRhVZJ+ThkiSEg1Cq4c29NBq6vXr
         q6HRyQOWwnkC/AqxpLPXb0Pp1MrvXFSCs/mgF/CmxEQz6ygkC2yO3cXrwU/VP6pT/wzw
         hiLg==
X-Forwarded-Encrypted: i=1; AHgh+RoG7QwjPnxggJ6+gnVGG1cKFINp3nMfE0aVSH4c35pIBliLmoQQ8K2xUNPdMbtal/ZUhSpLXKouG07x@lists.infradead.org
X-Gm-Message-State: AFuF++lQE4/hymHfdG1IzVD8B2FDQgADY18oE+moxM+a6tl6hDGjexGX
	UW2gdwVZ7EnZIcuXH53GgQIReVJDCELLonEv8kXWeD7tCQqHmXYawuiT9JSCE7tRwfg=
X-Gm-Gg: AR+sD11QeYiAmATske1CBjF099+YJs24HDgMfd5gpyJ5vsewV8xFRi2YdrW0vijXP2w
	bLJLcmnGe6nDacXjYRlgtCzaFewTAqvLwQfV+ecq764TjUYRPjDC5rpEN53vpzBMpk1V5uSb39Z
	x/C8zeV9ny3MnTVqxRKWdG2rc+CMn2Zd/xd2h9IKDr8gSLgwu3Fyfn6nUL5n7rj4xA3TycOXAmz
	7IYfNeBxYg4PayhqwGpdeEReuuWthRp6vEmS3MNV9pTBby7z0uwHOH5il9jzN5Or5LAo2R6WE+Y
	WtCviWUREZfloLsX4Hh3fCzk2f5pUVJOLkXy6cM+FttIcdbM4OXATnfKstC4vfwyIaflaDpab11
	F0rxhj/naUq+CMID+VMPACV7K0ekmGGYRLB+Tt7dYdLEKMtjal5Hcz/kbGVJW/hDNjUV2ppZmP4
	MfxscPW20lOGJ9cW579lyRcKVTIWzaggzMcIpjnHp+tw8zk5FVvFNCWnix78xdAmsBxnL+EPH7E
	3Z2t1jNIthhj2TYyf7O2E1RWteW0NuPMYP/EbhTLP6h70s61mZn0A==
X-Received: by 2002:a05:6a20:2cf:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3d9acb3e963mr4580612637.5.1788330275276;
        Tue, 01 Sep 2026 23:24:35 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:3036:5ac8:3cef:cf51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f7d77sm3390670eec.12.2026.09.01.23.24.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 23:24:34 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Tue,  1 Sep 2026 23:24:28 -0700
Message-ID: <20260902062431.61412-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me>
References: <20260820083634.71689-1-saravanand@crusoe.ai> <20260823174348.40236-1-saravanand@crusoe.ai> <1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_232437_000869_30200404 
X-CRM114-Status: GOOD (  18.98  )
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

On Mon, 31 Aug 2026 01:30:08 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> I just think that the adoption approach has downsides in many other
> workloads. I wouldn't categorize your use-case as the common use-case.
> Not to say that it shouldn't be solved.

Adoption in v2 is opt in per controller through the io_cpu_adopt
connect option, so every workload that does not enable it
keeps today's behavior unchanged. The downsides would only be borne by
deployments that choose it. I concur with the broader point. Adoption
makes the driver itself decide where socket work belongs, through a
fixed rule that cannot fit every deployment, while a writable io_cpu
is very flexible and leaves the decision to the control plane.

> I agree with you that queue io_cpu selection at connection time is too
> limiting. Perhaps we can have each nvme-tcp queue expose a sysfs entry
> to set the io_cpu?
>
> Something like:
> echo $CPU > /sys/class/nvme/nvme0/tcp_queues/$QUEUE/io_cpu
>
> I am just trying to think of a way that will allow some control plane
> to set it exactly as it wants, without the guessing part...

The per queue sysfs io_cpu works for us, and in one respect it works
better than a connect option because a sysfs attribute can be set after
the fact on any existing connection. The control plane already knows each
VM's cpuset and can read the queue to cpu grouping from mq/*/cpu_list,
so it can nail the socket work placement.

Two questions before I spin the next version around this.

1. On reconnect the queues come back with the connect time io_cpu, so
the control plane has to notice and reapply its placement. Is relying
on the existing nvme udev events for controller state the intended
signal, or would you want a dedicated notification ?

2. What should the write path enforce ? I would validate the cpu is
online, rebalance the nvme_tcp_cpu_queues accounting, and let the new
value take effect from the next queued io_work. I intend to restrict the
value to the queue's map group.

If this direction sounds right I will drop the adoption heuristic and
send the next version v3 exposing each queue's io_cpu as a writeable
sysfs attribute.

Thanks,
Saravanan D.

