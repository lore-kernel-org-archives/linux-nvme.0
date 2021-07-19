Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8014AC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:04:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC05610F7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC05610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4o6ojTeUYJZ8MJvOkVg7JnFYFqAW4mICX/xVsiD4Fg=; b=vSzDGQDG3q9ZPR
	Qsj5FKtCFCnTR/wYETTK5gr9enbKtnfkvDOn57oye/lJktV36GlUNiYuWOdBnW+F11YONeLiLMHpt
	AYn9KLil9TrAbL0yLqyiGAwPgmtAndQnpIPn/2IhJtOZhar3GD3Ue7OGT/3VbCuitWmS8b2PZ6JWF
	ee+5rDeIINtWtN8FD/NDX8tH5+TdVwK8rRYyYjdtF2bu3fQ5IXFIJLgnct9PLLNZqw7OelcC+JVBE
	Na4AOcoXyQ64xC6LjXJEGHTi5BQQvkNGoPlMfkcluDkIDYmGqDbXkZJORc7CgkFdMc5KQ3Ghc8UcJ
	U3ZNtn0IIQ85CRqHNQsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Q8P-009BVz-5y; Mon, 19 Jul 2021 10:04:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Q8L-009BUw-K8
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 10:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626689058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIArJd668+DITQakrkSuaSzmxBEQaYwP9nAIeL820XM=;
 b=Nd7CPhsCH9Cm7OTOydhas6dELWzX8f2f3G9DPWvtXHNHT+A4Sucv/0SXvdlzKb4mTIOo3V
 tnjNqADNTo5I4xxHFUjateQtvKazs7VJfLaAyGK/nCJ5Kg2AXdYbiQSdJnsZkHaKd+VIAf
 n/GxSYFx6A7IV3J0Jg82W5qA5U0qYWA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-HgFBQFeTOrCq98P1z-w9EA-1; Mon, 19 Jul 2021 06:02:40 -0400
X-MC-Unique: HgFBQFeTOrCq98P1z-w9EA-1
Received: by mail-ej1-f70.google.com with SMTP id
 i13-20020a1709061ccdb02905478dfedcafso1165414ejh.21
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 03:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=LIArJd668+DITQakrkSuaSzmxBEQaYwP9nAIeL820XM=;
 b=s0oqptcwKkLUm+J7i2DaJyYQzDgsbsNI7AUT9TghZGt7YBnKbdxTfL1XajvsBSkRw/
 Cv+4UjvMLvPB2pdI1BlRg1shUjwLn/f+c3u9PQ/9S7iy8buDxhqc2iM+uRecznJBNEmf
 FfHvCSx/QQQhxIj4WEndBNvAOIYWJvdxlKOGITuohFyorV9bkqi5xSYTLUWM3BRvvOkl
 9ASSU598CuzFN8y7fY1n9tWC1p2f3MogjaDuyUKGl6jm0ry/oIcCveEcIqeqkKZU+2No
 uPn2JRHL4Xo1n8jex/mfJ1ZYotLzpW15MLefi/2FZD/DWfB2GRn1/HCLc7fUpe05hSPt
 uxFA==
X-Gm-Message-State: AOAM5327/z3eiNEk8Nv9oAxa/7nqNf9tLggEmhW12FwxfLZF5/CLIYzF
 nJH6oHBRnYON+P0aDIUK3K+5pYSeSm2dNK286ErBwZ0yrRkPn2lJ0VsxauNdobFqTwDOx4vAXNP
 dWLgpyQKVrULq9vk3DvqDqwQ+pR4=
X-Received: by 2002:a05:6402:22c6:: with SMTP id
 dm6mr33660105edb.228.1626688959518; 
 Mon, 19 Jul 2021 03:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf7AlHivCiHIxTEU+yzlNocceBxfAEdg+F908CY6q9MgpA1ztNfyNzGn8lRI1RGkddChsXfw==
X-Received: by 2002:a05:6402:22c6:: with SMTP id
 dm6mr33660085edb.228.1626688959306; 
 Mon, 19 Jul 2021 03:02:39 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([93.56.160.10])
 by smtp.gmail.com with ESMTPSA id d3sm7602270edp.11.2021.07.19.03.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 03:02:38 -0700 (PDT)
Message-ID: <fce7efe2a5f1047e9f4ab93eedf5ace1946d308c.camel@redhat.com>
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
From: Simo Sorce <simo@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>, 
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Date: Mon, 19 Jul 2021 06:02:38 -0400
In-Reply-To: <20210716110428.9727-1-hare@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
Organization: Red Hat
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=simo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_030421_818277_FDD53AA9 
X-CRM114-Status: GOOD (  20.19  )
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

On Fri, 2021-07-16 at 13:04 +0200, Hannes Reinecke wrote:
> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit especially
> for NVMe-TCP here's an attempt to implement it.
> 
> Tricky bit here is that the specification orients itself on TLS 1.3,
> but supports only the FFDHE groups. Which of course the kernel doesn't
> support. I've been able to come up with a patch for this, but as this
> is my first attempt to fix anything in the crypto area I would invite
> people more familiar with these matters to have a look.
> 
> Also note that this is just for in-band authentication. Secure concatenation
> (ie starting TLS with the negotiated parameters) is not implemented; one would
> need to update the kernel TLS implementation for this, which at this time is
> beyond scope.
> 
> As usual, comments and reviews are welcome.

Hi Hannes,
could you please reference the specific standards that describe the
NVMe authentication protocols?

Thanks,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
