Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F65C98304
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=; b=0Z1HeVptEkgED+m7SSSS44C9qH
	UzvkJgSuVP+kRDe2YIVVN+8X7V5jvmJOnQFj17S8640CdKotj9GXgkdxB83hyOM3dqpBVExAbVXv9
	4ajwnL+S6q3oQvfL7BbDdYcTj+OCWtGf7hObeWt4ckCe1QByKVWAMfFCqtEnvDM66VSUwTEMJac7b
	7YDrayLNwU8pXO6a/zJoMcKeaLiJaDgEwFi7/pehU30FecG02QBCFtyIg2/BUiJMdWIITApDtcqFW
	a3zjE2NO/G9rn9GAyseQ1dNgbdoBie03nyS6NTjyabRLjKxwiVjzqctaijIzsO7QqJzcnvClE/Xgl
	CGpBlikQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9bAr-0000000A0s2-1snw;
	Thu, 24 Sep 2026 04:35:09 +0000
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9bAo-0000000A0rF-396m
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 04:35:07 +0000
Received: by mail-oi2-x10.google.com with SMTP id 5614622812f47-4b37a368895so1007294b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 21:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790224505; cv=none;
        d=google.com; s=arc-20260327;
        b=rjiTLuDggC9Yh3/nuTaEoMe6fwKxoD5tAVn4OhdDz5uehlznJTxuvwR8hP7UUFVSRi
         WWQTIkvTuq/7vrQAbf0TH+7HHCB7vVGfo4gNrS8p9m8xKEjygyZV95I/PxLvfVHUoTCb
         zBYAeJ5eJUo2kOYmfsvPMA/iViO2Vsuou6TUAbYUPUfpHdluoDEc6gfEolv91vXp2gWF
         J9oK7CqBLXFf8jwwv7CIrJPsftu+vzZ13lVsBsDxjhihLfrzVXHJzUsM11msMzD7Hxe2
         P9kxuzSKfQRQwqopZaAN0UjI+3o0mQj03zewkswlxhUgEGp0lfSYupjVePsYH3gN60hq
         cU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        fh=ktDKhnTXRSTOLr3rHDLYjinIaISmffn8iP5KFgFdF7Q=;
        b=E1Zsu6uiiHQB++fvRrq1yrJTGi9x22gpsqMzS/+jSGjUDvgHAl/XiXe1yohVOjWxRA
         PKwtruCiebDOd2oj6MigPSK2f4XTs06zyMVNkN2v0jyGZX7SXVGn/L8UTXEwhRCpGUSl
         BvSO0cLQbvZRpZZLH+8x4rSEX4O0zGSWLYZVLEfI+4XLIg5T40MVbz3o4hE2yRHoSYCS
         BQEyQjGkAIOlmwiOX5KeOWA/dranOKNwEtbyNoZctSdnpeLqEYD3tCHV/eCsuHuM7gpA
         +JdnOKylMICgNXFLL9jWQlSSAHnX9i3w9Gl1m+rlB/FfwiUuiZKGBzs9nxuDhcC11PDy
         kGHw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224505; x=1790829305; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        b=pOv4qmhGS/PYbRjfcqbA8UjCqchQZs7U2Z9IVyda1e7WUfLTQ2hD/DtMVnCS0RRo7f
         35OaacXP2HHSwafgkwuWXGW8AxPCzOJTtU4fZFq2FHCxu8pKYoKM9c9cL4ojaJCslQuM
         CgY79pCOQjE4wCDcUqO0DX54em7H0k7f2oWMFxSuggKel9k+WK3CZzKeNzDv30R+5HMd
         Z/isjkJ31k5Jo3bXcG4Ksv9JSYg3Rf6Y14MfUGhsu6X5bo5GXk1vedkwlhdLl/kYRA95
         vWC4K+4i7Q8WY+XLGQDGg7LepnvA6EETljTAokJN5WL50vp14r85L3ZqEVpAPnExJ+0R
         l7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224505; x=1790829305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        b=YDIvN/UwikMQSqdmJ61Jfg+SlqukxiliMpTwNzqN4ZZZNe2H2IAwOVISktJg7lEK+C
         +iG4GHtVp7V/H09ziZutvodKT1Te9GoFW2GHCY6AvuJlNI9n2ZFnli/Xd/xIhiIwMJ6S
         3ye9+Ut9jJafFJtyDwipVqsVTN4xsAqJMkEjPqfbFWdoKW2x2eidXl7ViRyak5pVvxOs
         MLWZ3gMi9w5SFe+8pWpkUSbBPccYhAGvSqytbAoAeEcon0alB2f+H8CeGs4sEATw6Xdx
         Tzdu2CTPhp/qGD6JNI6dAj3U9h2r3C11A67Q1KXusCLU9VuKMgKV+/yU7rEv8HngTEYB
         snvA==
X-Forwarded-Encrypted: i=1; AKwUvBwAZq67oYgtAtl17I2ZlUgcnlOd0KKNkxEt34DsyqWf53kKIzuGBVOmZSCj7n1bsU0gDFx5JzpHYho/@lists.infradead.org
X-Gm-Message-State: AFuF++mqwxIuMQg2dB6tLG1JhBNk+rYiNH/gvd4mrHMiCO7x1Y7WTvGG
	3hz+YgH3o5FnfA099RfQq6gdFfL/fijVzh2WsZSJ+PPNahcIc55owixyTLUKxIFS9UvO3ud0Bba
	MK5WY/Y4cndGQPZylgOr5zKEtDtwUN0E=
X-Gm-Gg: AYBFou03ccUpAoLU1HJt4WhADPubBVK3+rAvaKV6nYUWSMO7OX3ykfZlmRlDKkGhAYq
	Gc2gnYkrhB7776oxLhPn7xUfJbaUsQTQAo9S9L+FfmyiTlb7XTzxy2mnvTyz6HX9mSG9BjB1W9/
	kZyg9nW3hXTBa2r10Jhj/hfc+1Du7Qos1bPHDF4p0xRm6cl9OSwUEjd2VCH4UQ3BKsjFXJaYJR2
	s8vTZ7wHxnWCE77lca0mpuJAhD4OTlSVoz8N6trUFKV/n13r+WmH9KqNwjpF2+AvXNR9/nNsZFg
	Q7vVQWU4DYef6U6T9WUitxUJ6Dh0qiulC6ro+HhbNwmDqRDizD5X7jTB8ylUShE+pxYQqhrBEyK
	y0D4J+qqeAJc=
X-Received: by 2002:a05:6808:1992:b0:4b2:98a3:a567 with SMTP id
 5614622812f47-4d72be39068mr1776744b6e.4.1790224504958; Wed, 23 Sep 2026
 21:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260923152653.40953-1-yupeng0921@gmail.com> <arP0TmdK3FnNfbwH@localhost.localdomain>
In-Reply-To: <arP0TmdK3FnNfbwH@localhost.localdomain>
From: peng yu <yupeng0921@gmail.com>
Date: Wed, 23 Sep 2026 21:34:48 -0700
X-Gm-Features: AclHuK942CAMjDTV2Zi3exg6L6EKi3Q-gOuQhHvB5LNabYOBYKDQn8SWx2V9lpQ
Message-ID: <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_213506_800294_89CEEF65 
X-CRM114-Status: GOOD (  20.69  )
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

On Wed, Sep 23, 2026 at 8:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Sep 23, 2026 at 08:26:53AM -0700, Peng Yu <yupeng0921@gmail.com> =
wrote:
> > Scenario:
> > * Create multiple nvmet subsystems/namespaces.
> > * The namespaces are backed by different LVM logical volumes.
> > * Some of the logical volumes share the same physical volumes.
>
> Why are LVMs mentioned? (The test scenario doesn't seem to use those.
> And the example is backed by RAM, so where would be any IO to control at
> all? Note: I'm only giving this part of my attention span.)

The LVMs are close to my real use case, so I mentioned them to explain why
I need this feature.
When I write the testing code, I try to demonstrate the usage in a
simpler way, so
I use RAM devices.
Sorry for the inconsistency.


> > * The subsystems are exported to different users.
> > * We should provide each user a specific iops/bps quota, thus a noisy
> >   neighbor won't impact the performance of other logical volumes.
>
> Why cannot you place users into respective cgroups and configure
> appropriate per-device limits?

I export the devices to nvme target. Per my understanding, the IOs are
controlled by kernel threads. The users are remote users, so I can't find
a way to put them in a local cgroup.

> Thanks for providing more context about the scenario so that I can
> understand what's the goal and obstacle.
>
> Michal

