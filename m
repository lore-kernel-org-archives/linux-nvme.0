Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A317C63697
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:54:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F43821741
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hz4ivZOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F43821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oRvw3pqceb6pC2XvW5Gb74mG9rcLxVLlO+QTBTgNUbo=; b=Hz4ivZOPS9vXKwuZgMInjYthU
	/0ZVi7F+cplp0KIhtP0uXr5JAAHIP0bL8qwT77FjK9GV9TcT0aVutr7Txf0OzrP7CxPxwy04Us6F4
	+gHDr2lm++mpYl0Ti0u8m+v63Fvmuhenr6y9bXKSNmz3BYnwd5EjgGF1lyjGzb8wKjHe0mXvReFO6
	qfhKuv4VsJ/jT5Bn0YW71v9VCdCiBRYOM/aXMWdLA0WIqYt4R8jO0vwjaSrrm4NSoZ8S67SywX9f1
	Sphis9/a/17uryiECMXqfmvHUPiUM5CeVb92JWUxEKxU2Knjq1FVRQQEw9rYYHlcfr9T8Wbpx+H+j
	9qKPUaPfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki8MR-0001Vb-V6; Thu, 26 Nov 2020 03:54:26 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki8MO-0001Ur-1f
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 03:54:22 +0000
Received: by mail-pg1-f169.google.com with SMTP id l17so587496pgk.1
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 19:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ljeqi4iuVJAeyFS6+4rMz1sERhKaFo1LuqTr/QOmZEA=;
 b=bEcI3cpNiC+YNdkMl5tO9o3eQAfKLtpt480gLKi9W9fKTvbcAg+fopx6LVmh0RTOgG
 W50493tESc62tRvlRsSLpkohHQaTw2ZU6eTEb5MWjJpyWYfOxVegfyN95A5NgGgxZMgo
 D1V0ow6p2Cf3vKsFkDGgmo07fz+wccZeWBp/VoPzK8TNCEn+RIzMGW2MfQav41jP5BOl
 2cYVG2SDItntbkJacGAVEef+2raNnvCsLwmpbVfg6SnsVtcabgbgcA/LZqSrt2mRYLEm
 OV1dj6I3M2nuNuM19n2+E8Itrl2xLmAmFlNrZcXIBQeUdVx6T+PqNW+43kA1dopDNrbH
 UZiQ==
X-Gm-Message-State: AOAM530vGLVwGv+O+Dp97RWj/+Oo0YQXEne1k0w3myMVmYV74hYIafMX
 OArin2fv/SBfZg2KDb1x1KlGnM9GzNA=
X-Google-Smtp-Source: ABdhPJxsTRwIdRAmKUbH8b6cTyngSGjo6dFo/s5E7G4QMLRevScdt6KalCIbpl8mYK3Xau8h7oY8tA==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id
 i15mr1255407pjl.93.1606362858857; 
 Wed, 25 Nov 2020 19:54:18 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id a123sm3229515pfd.218.2020.11.25.19.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 19:54:17 -0800 (PST)
Subject: Re: [PATCH V2 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests
 if we set multipath=N
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-3-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <91045630-3a91-15ca-511b-d50db339b82d@acm.org>
Date: Wed, 25 Nov 2020 19:54:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-3-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_225421_817261_DA62A653 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/24/20 11:32 PM, Yi Zhang wrote:
> To enable it, just do bellow step before we run it:
> $ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
