Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64547C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 03:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YkZJ2FmfvZkHadYpDW8t4reFTcTKRda4JrY5UE63qU=; b=zUgdFOKvwkP1mYqvic1917JDwr
	x+CQ9SrlvwIZyF0SQAmUaSBpItQTRH55SQtNoVNmqcrDFmPOOUDsrjDpRljJHslxJB8bVKm5fUUzm
	EhW+Uwrha0TEqOWKp1zF042spA8ygG7GUBm4//A9VWaUXlEupdMcBnDeQTvp2xanIS7Av1mhOtXbm
	X+hai+5drvrig2knoUXd9mGBgYxG4r++3rMXL43h8o2souruVyLdLg4znHG6f17rFh4xSlvfSqs9n
	LfhalD1UUyB8mvn57rUh15eTfbrb1onG9X3zjYJOwMdHt3v6DL2rpm3yUC9Pd9swPFe1YvH9pKBqM
	X5oVXMLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neTHh-00GTjh-Gl; Wed, 13 Apr 2022 03:03:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neTHc-00GTiU-7B
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 03:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649818981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1YkZJ2FmfvZkHadYpDW8t4reFTcTKRda4JrY5UE63qU=;
 b=bxLMWsKvqwm8enGvpil9xdS7GOUJ2J/sAo6Yg7QijskhGkbl5dQLOtbzsbeUXNxx/Lrd1H
 KvaORqTCFLUphY6H9Vrj/Tx/56PURx/Ph1L6beHcfcvqVZ3twBg1t7OfoE6Afpt9nloBoa
 GNL9c8LCUKj1gksMeOaHxgA429MkCz0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-oz_Ui8m3Pni5E9lb-vGDrg-1; Tue, 12 Apr 2022 23:03:00 -0400
X-MC-Unique: oz_Ui8m3Pni5E9lb-vGDrg-1
Received: by mail-pj1-f69.google.com with SMTP id
 l10-20020a17090a72ca00b001cd46918af5so403713pjk.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 20:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1YkZJ2FmfvZkHadYpDW8t4reFTcTKRda4JrY5UE63qU=;
 b=f2/ZoSc+DEosD7O4X6jgnxCNkGxbb7e/K3za+36352VAEntIVyzWON4GFJDLkEhlUt
 1ImbG5GWKAiaX6RUq2+YtE5Ygacxg51Lv7963kheGKSdKeCOPmwNvE51aq4x6rCR8DDG
 nqR+GEFzEzqpd3bYgx9M1r3asCypIBaZv+ghmHbN7NU/ZCWvExN3mjXYXP6DqCV+lLWs
 C4VSVzYlk53PEndmmi0JQN75erTHZtx5IjjUHbHgq/KIzvGCchhr95MdwsPxGo8PFbcJ
 zcvWzAGqKHUqIiHqWmqZqZYj/I3h0vEWqAOowjds3x/IAh90GGRscPjNdRxtDBy+A+DS
 0esg==
X-Gm-Message-State: AOAM530pF/5p5qaZWg+fp4MN6JpUVe8uFZCv5/5S0yE+sStaDIzO1bSD
 z7CGJASzRHm/Qdyq4GqUPrXlbL2iG4QZORvAD2Fx5hTDVmuOHf0xkHu+Q0oqoOhIBuoG8qq/k8e
 IhoIwHkKZQQftHMn6Dt4zEdEFNw/p/wsCWC/x/Dkh2Ek=
X-Received: by 2002:a63:1821:0:b0:39c:c771:dc2 with SMTP id
 y33-20020a631821000000b0039cc7710dc2mr24117764pgl.507.1649818978936; 
 Tue, 12 Apr 2022 20:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFjVGyHvK8chYl/HqZK3kSid3N5u26Wdnk+x9sl3TieR62BnlG8/FixYxuXZdob36SvCIArHwrJyNqfxRcKfo=
X-Received: by 2002:a63:1821:0:b0:39c:c771:dc2 with SMTP id
 y33-20020a631821000000b0039cc7710dc2mr24117749pgl.507.1649818978715; Tue, 12
 Apr 2022 20:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 13 Apr 2022 11:02:47 +0800
Message-ID: <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
Subject: Re: can't run nvme-mp blktests
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>, 
 linux-block <linux-block@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_200304_373911_EB900AE7 
X-CRM114-Status: GOOD (  16.14  )
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

On Wed, Apr 13, 2022 at 8:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I do have CONFIG_NVME_MULTIPATH=y but I also have:
>
> cat /etc/modprobe.d/nvme.conf
> options nvme_core multipath=N
>
> And yet I always end up booting with:
>
> cat /sys/module/nvme_core/parameters/multipath
> Y
>
> So trying to run:
>
> nvme_trtype=rdma ./check nvmeof-mp
>
> I end up with the warning:
>
> nvmeof-mp/***                                                [not run]
>     CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module
>
> Are there times where one cannot disable multipath? I'm not using
> any nvme drive at boot, but I do use one for a random data parition.

So the multipath is not updated with N, pls try manually removing the
nvme_core module and retest.
Or just reboot can also help update the parameter.

BTW, to run blktests nvmeof-mp, the correct way is:
# ./check nvmeof-mp
# use_siw=1 ./check nvmeof-mp

>
> Any tips?
>
>   Luis
>


-- 
Best Regards,
  Yi Zhang


