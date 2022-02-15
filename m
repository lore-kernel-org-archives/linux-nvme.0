Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCE4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBSGPnudzBrKEXp5NRVGAeF51JTUDG01yqHEiAX39T4=; b=YQSSMwf4N2vdOXgG8X31WdCOpy
	hq7+268vLlJV6oWx3Xzt6YaRUL09h7OZaTfNus+32ZDJwEqrclUm9D7V3Nx57WFDkJWX0xVth3ZVX
	qio3h0UwjretV/rfOk8LCU3poFAPmXz/RtOtREwkNZx1iqfNKwdG+R0o4pV0yC3fEZWHPVwo5gqw1
	1NWaskPp9HKR6VSDcGFy408YSSt5yFXuhHzuup9Tte2gWLePYJbcebSI3P1I7JLiKGI6Yr3sSM+qR
	iLrIEf0vJQCvv1kNEvVEGI8G5FlnJg/CiFkpznYY5UP7N3OPp4gp4Uhjeg9uVY08aPEMe9c6w1X+Q
	+Q2LL6JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJyGI-002uiz-Dt; Tue, 15 Feb 2022 13:52:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJyG9-002uhE-Pm
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 13:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644933166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBSGPnudzBrKEXp5NRVGAeF51JTUDG01yqHEiAX39T4=;
 b=I0SV9AAIpiAYG1crWMY9VGctJ9F1vwt52COL72y98dFg4LJVyp9Qhq+5CChr90XYfMGqG2
 Pc3/uLHc2jpL/eCtWHDawu+Ch36fUoG0Wge6RuPhKfeXCN0iwgzeRgm6dkY+tsNTQ03dXB
 dJjfvxCNL6stn2Gc62xvfa98fQed5U0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-TLLUdaKzNsW0WLuNeFcryw-1; Tue, 15 Feb 2022 08:52:45 -0500
X-MC-Unique: TLLUdaKzNsW0WLuNeFcryw-1
Received: by mail-pj1-f72.google.com with SMTP id
 md16-20020a17090b23d000b001b8bd5e35e2so13146961pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 15 Feb 2022 05:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JBSGPnudzBrKEXp5NRVGAeF51JTUDG01yqHEiAX39T4=;
 b=1YK+/0LH8DKKMjuZnXv8rNZmsALf1rZxxiZ71m+5PhDPEKxNB2lRnM3RpNurc2jegr
 OsYmY/sJ/AZN5jW09YtvA2WCEIrFUb+ayfDqkOZhoVkUQMBSmuVoeWUPxhs9qRi3C4Pe
 0R+KGjFE2QB2PK1pyZGgLq26tXPL3fuL7tPPbJ0Vm6u1gOBbKXiRSKthfV0u2EwcaR1B
 t3gCnQh45fPv5B4rPHOgJfew5cHNurdMKPEtXT9byOB/PpspCrAM43n0iJnp3rJjRDAJ
 ybCVDNEdQHCDSAvHjwQzqdAn2nMAIiHjijVOomSJ2GeqQloXraXYPfnnuNFy/3OTA4Mt
 hDjA==
X-Gm-Message-State: AOAM533vCpVdh7mUYYctzREFxN7agmA3/8rLsCToghRXSh59UABRgazM
 DsBDFZ1cHj+vaOkkhjqCDnNvpGLirrIlbhyb0RMaxSQAyPp3pLf3nOKCyUQAty8T5lWbRWLD6oP
 p86bAJgnmTn1lTCXBxIcpUZeILzMw/R35Dsc+B6odt9A=
X-Received: by 2002:a17:90a:c28d:: with SMTP id
 f13mr4426427pjt.163.1644933164641; 
 Tue, 15 Feb 2022 05:52:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUuvtMJHu1khNAbVDaMzNWUDumvqg/KOPW0E/a0wLtTfxvHfoBSjUKSKK+z2AuJtw03QwlZqAnzNA/5cphJ48=
X-Received: by 2002:a17:90a:c28d:: with SMTP id
 f13mr4426400pjt.163.1644933164247; 
 Tue, 15 Feb 2022 05:52:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
In-Reply-To: <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 15 Feb 2022 21:52:32 +0800
Message-ID: <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Haakon Bugge <haakon.bugge@oracle.com>, 
 Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 OFED mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_055250_096449_6C585983 
X-CRM114-Status: GOOD (  25.60  )
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

Hi Sagi/Max

Changing the value to 10 or 15 fixed the timeout issue.
And the reset operation still needs more than 12s on my environment, I
also tried disabling the pi_enable, the reset operation will be back
to 3s, so seems the added 9s was due to the PI enabled code path.

On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
> >
> >> Hi Sagi/Max
> >> Here are more findings with the bisect:
> >>
> >> The time for reset operation changed from 3s[1] to 12s[2] after
> >> commit[3], and after commit[4], the reset operation timeout at the
> >> second reset[5], let me know if you need any testing for it, thanks.
> >
> > Does this at least eliminate the timeout?
> > --
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index a162f6c6da6e..60e415078893 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> >  extern unsigned int admin_timeout;
> >  #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
> >
> > -#define NVME_DEFAULT_KATO      5
> > +#define NVME_DEFAULT_KATO      10
> >
> >  #ifdef CONFIG_ARCH_NO_SG_CHAIN
> >  #define  NVME_INLINE_SG_CNT  0
> > --
> >
> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
> the connect command
>
> >>
> >> [1]
> >> # time nvme reset /dev/nvme0
> >>
> >> real 0m3.049s
> >> user 0m0.000s
> >> sys 0m0.006s
> >> [2]
> >> # time nvme reset /dev/nvme0
> >>
> >> real 0m12.498s
> >> user 0m0.000s
> >> sys 0m0.006s
> >> [3]
> >> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> >> Author: Max Gurtovoy <maxg@mellanox.com>
> >> Date:   Tue May 19 17:05:56 2020 +0300
> >>
> >>      nvme-rdma: add metadata/T10-PI support
> >>
> >> [4]
> >> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> >> Author: Hannes Reinecke <hare@suse.de>
> >> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>
> >>      nvme: sanitize KATO setting-
> >
> > This change effectively changed the keep-alive timeout
> > from 15 to 5 and modified the host to send keepalives every
> > 2.5 seconds instead of 5.
> >
> > I guess that in combination that now it takes longer to
> > create and delete rdma resources (either qps or mrs)
> > it starts to timeout in setups where there are a lot of
> > queues.
>


-- 
Best Regards,
  Yi Zhang


