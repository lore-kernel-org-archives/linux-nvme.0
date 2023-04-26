Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14723C77B61
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GAiumTveurVwi4CGORvJHmgiJDUf5sD0BC/MQrwNdV0=; b=Y6uTaLd7oE60mFynIs09E6bi2c
	m/J304IKf9+CPHTyM7VjbEzuF3BTDZv1DfO7kU/UFIFyELMMZOJeEJv9WRr2S+xIhEWbB9BM8iaDJ
	llrLJzZ0hieAWz92kyD67pzN5TEdhp8j3TGZEpJWkkqqkyoxljGIkwGuO22hhoR8q6nXqOh1PUZkz
	NO2ScNfVtTPl3ssZLpYHJB06m5oAigyoxEn3pykpXTp3p8St3XDj2lYnvK7rgb2LMsWwL65679dIB
	2BGH4aaGbhh50WPjgP7TyvwCDamzjdEoihhiGcTuMnNcSzj1Yq5DF2kjv+DP/enufrK22PQ5q9hDS
	gn5m/0+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prT02-002UCH-1y;
	Wed, 26 Apr 2023 00:27:10 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prSzz-002UBp-1e
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 00:27:09 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94ed7e49541so985394566b.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682468822; x=1685060822;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAiumTveurVwi4CGORvJHmgiJDUf5sD0BC/MQrwNdV0=;
        b=fT917fdYgdzw/YOHotqywDB5r4Xjnp0E3T68ORP6W2mjQhStTKmvfZ8N0kcl4bAZN8
         cjxgS3XOqo5DuQqRaEA6HWvbQmiPj47XdT5y9ajjgCOcRYGcIZ56rrFx1GCaj67vlrBX
         T1CFMLIQkDCs+lU/7qXJYpEnIETojaFkc+rnQa27tQooUJzTYwxHR0ard2Mk6T1u20hR
         fi5XoYZ5q0c+yphIl9dTnOZSQ0rs+kn7Met4Amdsta9c9LTwCJP1HQBpdbbg0tGnWhP5
         o2rP6rrG3g8tDcVTI0ZlL5K6obBBHiQc4ZyTyjHWBFDJTh9tYRU2MSIM23j1vrv7gkPg
         GTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682468822; x=1685060822;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAiumTveurVwi4CGORvJHmgiJDUf5sD0BC/MQrwNdV0=;
        b=MPS8DnPepa1eSYhbD0vT/zYKHid0mIw5sR6jGKC7rbFnfPCvp1z5M1A6GMXRCFd5FY
         vgMiwwhzCTQILK2ydIbH/MPR5pih0TtYXZN0tlE/FcxF/ZJzYHKecFP/r3mcwyd9omQf
         RLSf06zTE8wsK+6MzE/IgLA/SVAmvsZU+KbBHwuDnxZJOYq5JqI+s4cTuv6i+GZqxv4T
         7DBz5FdHI5Xa5WBxzXSte9EdqnkyALBjtG05S7U+f4i5l5WvItRY262r75ANHzpvI23/
         JuqFw+i+9s45XlHJ6YSpaRqkfbYO52x+jouWcRNwJxOg9yXjAyfG0srRDsoHSqt7UrGI
         aG/Q==
X-Gm-Message-State: AAQBX9frhNTgMybvBHmZsxazPdkVb1sAsnSC7dLoTGFa5dySV5MCvrCR
	WcI3AdUAGgHsL5060zHeZrh6G6K58WMX7lshS9ZVpLGJ
X-Google-Smtp-Source: AKy350b9UIzKQgWAsQo0v9V/7DlT4ZfMrdjGMOeWMBux4+siA16xT9EqjD0+fbmvzLALqXMNfw88IaqSJTy6APzVEz0=
X-Received: by 2002:a17:907:d507:b0:94f:3b07:a708 with SMTP id
 wb7-20020a170907d50700b0094f3b07a708mr12233400ejc.29.1682468821798; Tue, 25
 Apr 2023 17:27:01 -0700 (PDT)
MIME-Version: 1.0
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Tue, 25 Apr 2023 17:26:50 -0700
Message-ID: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
Subject: Seeking for help with NVMe arbitration questions
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_172707_574806_B0355965 
X-CRM114-Status: GOOD (  17.84  )
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

Hi experts,

I'm trying to evaluate how NVMe arbitration would impact the overall
IO performance but have been suffering from finding the correct
materials. Thus, I'm reaching out for your expertise help. Could you
please comment on my following questions? I'm a newbie to this area,
so some of the questions might be beyond this mail-list's scope. But
any help is much appreciated!

1. To be more specific, I'm trying to enable WRR for accelerating a
specific set of IOs. So first, I'm figuring out in which layer the
arbitration works. From my understanding, today the NVMe block layer
adopts a multi-queue design to leverage the high density of CPU cores.
But I'm confused about if the WRR works in software queues or the
hardware queues. I suppose it's among hardware queues. Otherwise, it
brings synchronization problems to the software queues, which seems to
be against the design intention of parallelizing IO submissions. Am I
getting it right?

2. I've also learnt that the submission queues can be further
classified as default/read/poll. I did some experiments by issuing
different IOs to different queues (intense large writes->default
queues, sparse small writes->poll queues), aiming to prioritize small
writes over large writes. However the performance didn't vary no
matter how I distributed the queues. Is it because the node has far
more submission queues (64 cores and up to 128 queues) than the IO
jobs (8 jobs for large writes, and 1 job for small writes), so that
having separate queues for small IOs won't help? In other words, does
it mean the queue type has nothing to do with prioritization (or
arbitration)?

3. I came across this mail thread: https://lwn.net/Articles/810726/,
where Weiping was trying to add WRR support in the kernel. But it
seems the patch was eventually dropped. Does it mean today the
linux-nvme kernel doesn't have WRR support?

4. If the answer to question 3 is no, then what does that mean to the
application layer? Does it become a pure device layer stuff?

Many thanks in advance!

Best,
Yicheng

