Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09798FD4F08
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=; b=Qsr21L96tjteJx/1rlrIOJLm5+
	wqQ8kbbIIZNbckSLCqd6ytW3p+g2cGcmXk+dKScBkOjg9vszP6XRpvVahi+rcQ9olGYYRZTmMhTcv
	uzakHxi3RraJ87tYranIs4fPrJcCpKKg+mjtWXrhDw+e9Wj0cj0+ENcFw9+TvVBZCp+UWTzTpWWap
	dLM+iSJJRUiXOr0fgC47tfBzvRbI6XygVgSdlg2FvdwcySxAwWVjlBNr0QUZaV+WVXq+zEd5Lj9iN
	Ja53NWNHkSnOKop/8TxR4wuHpWUXmF+5XgxjjbXf/mQw9CPRpmnzdvNk+zd02QQyQTm4wHDou+z6u
	Iu3dTf/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w00ek-00000009xFl-0QWV;
	Tue, 10 Mar 2026 17:14:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w00eh-00000009xF0-0RxN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 17:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773162841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
	b=DQXry6i+ssTQTzNsvZ0j3+OIaDqg1mx7LSgWv3OwSWueV8stAxCrXSma6T2hsGGdNVJQv8
	Ew+vujzevSlXJPJXw2cnjftO7Dz1IUlmOHTa+RPKX97ShExDBI1ex5BNAwR5VRw/yzuUmm
	LGAId9vT5PfZNdB3ZJjXMCBlrlq3POM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-2ELmQixVMZCP2ZccAqAcbw-1; Tue, 10 Mar 2026 13:12:18 -0400
X-MC-Unique: 2ELmQixVMZCP2ZccAqAcbw-1
X-Mimecast-MFC-AGG-ID: 2ELmQixVMZCP2ZccAqAcbw_1773162737
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-649f0d26e5eso18925034d50.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 10:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162737; x=1773767537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
        b=vjp17SSeJMKvPIbe6wbolAAGIFSPksql/DEWrTqQpBzakDgkjtuBagZaXm5cZY20vZ
         smAi+Zy1cie7g6fGCw01El3XHIKnzreMEtJIQy7bB0NheUWCJpuWYVORe81QNmozQMIS
         0jLtaAJ4TrgMws2VC1QWiCUkE8MZ1rnLsX4zqix1cCHK8h3baDIL1ZCZcM0uK2M3/t+3
         Kys6sUAIwwVlF3wSlPBRNKNcD33eiSq56ffFlvZjwPxbY/spkx9nnyL9UIscRnMkoi+c
         PGIfARq2VgXoJoIt5Fuv0BuOyu1T03wyVe6DHp5E/3c1nzlhEjSzMttbxJyHCgywl3It
         RCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXj1UoIMu0d2OHpiKJRP+EUk6PPXT6PVuMPPyMrpCVEGdIDxnnWF6AqH9gPvGu1KP7Ydw4xHJ8fci13@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3+hff5Nuw4TGi1xeQo/8DqIEuy5NJSRuef3b+BytGI3Cqcjwp
	GVALHbyNST+Y0Cc/52NU/sYPzxOWvlOhhPY+oyczB1HyY1ZIaKZ/cCDK3ye5YNkIdMB2R5Jvc/o
	z4qrXsaekRucwGTBsF5xMYPdIpVo+o1exYxmT0Cn7gLydYezzlqJ99hv4Te7dh1rCeiZR2UQE6V
	dYNJ2TkVaTDk4VxmstffPLvV9+XZ2Hkbhq+JEUGsmr1X0=
X-Gm-Gg: ATEYQzxXed+1tVeMcqIUUfkjQg77Ay0ysK2zPv6c9bhGVjNTX7a5TgcVWwD0rb00HeG
	04K67k/puRiIdB4CERmTcTotYoHHfg9I9zYZe+XjauHolvYMH/y+xWD2Tn9HYL79vyZ7Luk7hs8
	a3Hq6y4kJjs2i+qMcQz4tEw44sCXOfJWatL8UQadhCUNB+rlRPRn72Ugc62tfaUQvgEpC+IzEX5
	0h8lki3/yy3v/Wb/lIPhPXj0oN7nrDfritnfbPiGHAen0fU+6X4dBxYdTDl9/U=
X-Received: by 2002:a05:690e:b8c:b0:64c:9f87:ffc8 with SMTP id 956f58d0204a3-64d14113af0mr15223665d50.27.1773162737151;
        Tue, 10 Mar 2026 10:12:17 -0700 (PDT)
X-Received: by 2002:a05:690e:b8c:b0:64c:9f87:ffc8 with SMTP id
 956f58d0204a3-64d14113af0mr15223605d50.27.1773162736479; Tue, 10 Mar 2026
 10:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <aZnuSC0qYfw0hiwM@kernel.org> <aZ5GbVxDT3gcS6WE@redhat.com>
 <0a6ec8d3-7623-4809-b275-3eccb94419d4@suse.de> <a1e5c1ac-fb5f-46f7-ad7c-e21a545e128d@oracle.com>
In-Reply-To: <a1e5c1ac-fb5f-46f7-ad7c-e21a545e128d@oracle.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 10 Mar 2026 13:12:04 -0400
X-Gm-Features: AaiRm51xvGgBZM7WloiUzJR7AfTdxoMiAkW59yuvLN8gxk-OMb2WC5hFQKpQwAY
Message-ID: <CAGtn9rnreF=AjejdZ_66Wicc6dhQjbjkK3BY4wdaRm3_bgC8tw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: John Garry <john.g.garry@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, Benjamin Marzinski <bmarzins@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	dm-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gu8KLve_wzzui0sGvkq78y7CR17_ate994Q6-ug_TQY_1773162737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_101403_223244_5230E58B 
X-CRM114-Status: GOOD (  14.19  )
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

Hi John-

Sorry, I was out for a couple of weeks and have been catching up...

Re: sg support, there were issues in the past with people attempting
to do SG_IO through dm-mp
assuming that DM would handle retry on other paths, which it didn't.
You also have to be aware
that non-idempotent commands don't work right if retried.  My
recommendation would be to avoid
implementing it, although there has been interest in a better way to
do multipathed "generic"
commands (e.g. virt pass-through) I think that is a more involved
project than you want to do here.

I see the discussion has progressed re: ALUA support in your later
patch postings, which is good.
As Hannes said, a Native SCSI MP would be useless without it.  You
don't have to support the
older non-ALUA mechanisms though, those arrays are way, way old.

SCSI does not have the equivalent of NVMe's AEN, so you need a way to
ensure that your
ALUA info is up-to-date.  DM-MP's path checker normally does this by
sending commands on
which the Unit Attention can be reported so that the code can fetch
up-to-date ALUA info.
Hannes made some optimizations years ago to avoid excessive RTPG
commands with large
numbers of LUNs which we would need also.

It will be necessary for the functionality to be enabled via a module
option, at least initially.
Introducing this in general use will be a big change for people who
have Enterprise SAN
configurations with their own custom path monitoring tools.  I believe
we put some functionality
into usespace multipath tools so e.g. Native NVMe devices can still be
monitored/observed
which made things a bit easier for people.

Unfortunately I will not be able to attend LSF/MM this year.  I am
sure it will be a good discussion.

-Ewan

On Wed, Feb 25, 2026 at 4:27=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 25/02/2026 08:11, Hannes Reinecke wrote:
> > And I _still_ want to have a blktests for persistent reservations ...
> nvme/054 supports resv testing.
>
> For scsi PR, we could use util-linux, which has blkpr.
>
>
>


