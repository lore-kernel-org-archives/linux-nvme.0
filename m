Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C585C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=; b=yVqdqP8sVR4seRRWJiRS+HTM5B
	N9gJMOVWmCwtACVyQyrCWbhPrusDtqsNECjAcU5yJhDBrf5462bxwqo9oRUzDqbIizSqyd+zXGRks
	70JZzuMPMEQyT5HuWQmhWqtpoTUJw6KORR793kDTenG6gfAwfIv88iLY1wJyDnLbJHgq43Cwc0hlD
	KudBVX6A3kOZA8tnJ/e162SGQRVJi77391thMkUf3+HeHBnHE8IsdBl7PUxc48xWBEtIu2Pc8phBj
	ZbPr2mJ5FHwiP+xJfonoIeqQiq861pxWML2HRyEIMEm/J6aQm/UHbC1IIA+7AFtbi10knkAWMnc5l
	AenB1HKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poJbi-00FG9g-0y;
	Mon, 17 Apr 2023 07:49:02 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poJbe-00FG7d-1H
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 07:48:59 +0000
Received: by mail-pl1-x636.google.com with SMTP id n17so8757424pln.8
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681717731; x=1684309731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=nFlhCc39H9KHnsfKxPUrqKoFYe0nizIWXf+rPLilZlWO47hZ/CdS5Few5q9kvf7QU6
         2kLhsBXG+jZ6+VUoSb1jo2W6nUs/0zgREsY3gKEAWCwo1IxBwwGPdcjUYEcJeHapKRRC
         gVgjNQfuwqpxdnxYBQc9n+YGM1TFJZwbvX1uHWILxQf81H8RQAKugie9DZEQ5bBZt336
         i3YGA2sUMlS9R9cGaq8om1H/UQRfgefxqi1y7TUSiLouh8zCVgTzq+5n0jldEE0fukGu
         Iwwl7gI+CcKy3xirfbqGbvylQg7icZrKAcEWDgn9sADhy9Fzwl8zP31QXQgvfh0/ERMK
         wkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717731; x=1684309731;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoxNZpdn1HHFFTHQnEQSPesnrC0r0JBqOwFpAAsz2Tc=;
        b=lb3YTvGzgdovCzvelL6pHT/9K52TraiTjHj1JwYu9yq6n2Xl0rPCEyuCpe4QsBSwUo
         0HPM1q8x15SuIEh5mY/A0d34PmSQaU0jJ8K4SYWkJxen3HQ1OfQCCCrCS2pbh5adD/AQ
         R/iO0y+ZeYNc72PRn7ydYuwapHCilbCc/poZsEjpQ3P8sG4YpWaKK8qJ6FXLqjY5IbE5
         W8zoDQCi9+SivImEYRNTOl13BhgW0ogKC6higAiDTwkNsuc/rEPTgLrZ4pxg1ce/08vt
         G1EBXUlvQOY24GCt9i9GF41dXxdejjv7F6inU2eRb4yM+Lw3DXBygHg53PCmH7G93BIi
         qk4A==
X-Gm-Message-State: AAQBX9eiuLzK6Sg7sQ1H7I0PGLVpiqHsYJmtHDIoNy8O1BXu6hRRjk6b
	8uE7zU2C/Swx/Vv3NHcJ2N0=
X-Google-Smtp-Source: AKy350Za9LWc+u9SpDYBXSZNLVNaUStLL42eU/h9/NkP/65mV2jBfzHrCdpGUrihF8eMfGdhB3pAdw==
X-Received: by 2002:a17:902:c405:b0:1a1:a8db:495d with SMTP id k5-20020a170902c40500b001a1a8db495dmr16485143plk.4.1681717731019;
        Mon, 17 Apr 2023 00:48:51 -0700 (PDT)
Received: from smtpclient.apple ([47.243.123.68])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b001a1ccb37847sm7047135plb.146.2023.04.17.00.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:48:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From: Li Feng <lifeng1519@gmail.com>
In-Reply-To: <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
Date: Mon, 17 Apr 2023 15:50:46 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
To: Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_004858_432881_D7F50723 
X-CRM114-Status: GOOD (  15.12  )
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



> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=883:37=EF=BC=8CMing =
Lei <ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp =
will
>> have a bad performance.
>=20
> Can you explain in detail how nvme-tcp performs worse in this =
situation?
>=20
> If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
> on other non-busy CPUs via taskset, or scheduler is supposed to choose
> proper CPUs for you. And usually nvme-tcp device should be saturated
> with limited io depth or jobs/cpus.
>=20
>=20
> Thanks,=20
> Ming
>=20

Taskset can=E2=80=99t work on nvme-tcp io-queues, because the worker cpu =
has decided at the nvme-tcp =E2=80=98connect=E2=80=99 stage,
not the sending io stage. Assume there is only one io-queue, the binding =
cpu is CPU0, no matter io jobs
run other cpus.



