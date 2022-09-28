Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E49C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJHc+go3jDaELDQpLsPChCRGGKZ/uH8jU3lHZ71kLf4=; b=x8DhsXRqMqFdOdYD8olPzpeout
	5MpzcVRyA32WMcV7l0NNdDwSZ/Gs7/m18Y+NYASvzBED+W3gLlD4KIWksxEngqK8xPNtrAiKEoEYg
	YuQ2YMAFID0WiMnpqRhOWpOm/vb7m1hYIRtHWt/rQXV+PWVrm7a2PuOG6xZvAm1nYJ2NbxKVPBZr8
	roMpqKxpW6xJD/sXAO6NgSsUWaOY3vrT1WrOanDurYtlPM23O/tRjwzvqrMnJ2LF4kKXvxWWKnhFt
	sBADY+Kgcx1LkDWvDCDGO3Hlm3WUpfLtIN6tF4/T2NvBPglT3JQZsiU7CYChC3gYZkQT1ErXNQzJe
	FPJUrq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odP8L-00DzIT-6b; Wed, 28 Sep 2022 04:57:21 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odP8F-00DzHX-Mk
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 04:57:17 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id 126so1692146vsi.10
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=SJHc+go3jDaELDQpLsPChCRGGKZ/uH8jU3lHZ71kLf4=;
        b=R9a83vWqNhPjgbg6DwuYmPUVoOKzbW2YBrrj2Phz7CVUKsRnJ4/8CaC+EDVHOucAot
         EwHYsYTfvzCkXu7SMVnMTdIieQWWfQ4ufjtQO6ExIRa/izQ4AIhFB3auYfpIXTIXjxvi
         Vw8jWFNz6uF5DTGyHmf8LpMx7WODbFEcqBWkL/0BtKYVb75H8M0e38QANwHtqRwZTxgQ
         tQXCmsnwwQmE6pDNdGxXWuzUxHAT5EDDRd234m1EkRB4Qt/322cTwOfJ9sly1hS6Cmsr
         EDTS/bTGkZmqrhdA4bOl8iAQlqiZESIrX3vqj2wijRPfZF21HXQWYCUTq7qPjrBQCVgX
         C3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SJHc+go3jDaELDQpLsPChCRGGKZ/uH8jU3lHZ71kLf4=;
        b=5zI+X4tmY7Drfy4wH7XjnE0Xh0pBw02zmEvIaIlOR+JUJkzkBeAZuRL93cNPz0I4EX
         jbeJRR7LGGI8N3sTo+fAf+oGmvKRIlMlekAULUi8yrY8YcoNmeZR2KeY6KGeE4/sigFI
         v5FD9bWu8ah6pVjdrrXJw4RdNSgwC1JCIazyvnYGUAUoE5nluTWU+04bu01mxzWz80r1
         EPhSczregA4zSWRqKybsM47R9MXur0kzXWrnokmko3d/4vtMcHNoVdd+r0cH7HiUwjo2
         xK1guXbM4simC/iCr7F7KeDIF4/N9KgQQagnsiDiWWJgEgNSkD7um5KIFArmYeNuMPRr
         fcJw==
X-Gm-Message-State: ACrzQf3zcr05W+HhQNH2fhUI4IokseW5rI9QOHNJaEXtUUWYW2B6fyOc
	Dk5zwjsFiLNrXC9OqsS+UWxBk9m33tjWlOlYDE8gETBaVROdvQ==
X-Google-Smtp-Source: AMsMyM5NM1+3j4XP3jWRSLo1t45J7I048+xMb//3QUY/4QgmuYy3jIzY/MzUgS6zMusMn47qri7v2MqH574wW7DuoNY=
X-Received: by 2002:a67:c005:0:b0:39a:ffd9:30b1 with SMTP id
 v5-20020a67c005000000b0039affd930b1mr13427489vsi.65.1664341033755; Tue, 27
 Sep 2022 21:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220906045922.30631-1-sean.hong@quanta.corp-partner.google.com>
From: Sean Hong <sean.hong@quanta.corp-partner.google.com>
Date: Wed, 28 Sep 2022 12:57:02 +0800
Message-ID: <CAP19T+79o4oOLC52MHS=FQT5fO6xn-1dCgro4sP5DKMu_AfPJQ@mail.gmail.com>
Subject: Re: [PATCH] Test: check open list email
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_215715_779337_9F29187E 
X-CRM114-Status: GOOD (  13.47  )
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

Hi, after click Plain Text and test send mail by gmail


On Tue, Sep 6, 2022 at 12:59 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Just check linux-nvme@lists.infradead.org
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  test_email | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 test_email
>
> diff --git a/test_email b/test_email
> new file mode 100644
> index 000000000000..e8084e7bc088
> --- /dev/null
> +++ b/test_email
> @@ -0,0 +1 @@
> +test the open list email address.
> --
> 2.25.1
>

