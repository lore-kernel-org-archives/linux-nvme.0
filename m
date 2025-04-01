Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE57CC36010
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rddeG/stg1FXDdM108mZ/CrahMcvxxmkAlZ0USWhxg=; b=Kjc2GFDkYwxnbPsqw2fXkZ5089
	moVA5gOQYQ8WI+sbe+F9pnKQipj8rONUj+wL2JmzVMF8kse0Wh+JW/2kmnoFBsLKLtfTIH4hSnOUO
	yTMUrBUJcBSUu18XBF7QW7HvTiu7hbvJtjUt0iPjhIP91HqYWjOxw8dsXba72H8Vg37P6DA7mXh5T
	ZPL/DYNu4wMzEZG0MzrGsFf/+qAXX4J9FTnzMVRe0ZWa1HVZO4UdL3hrQ+ppZENAVZkPFN+rIT193
	RXKNgEzx16YN/FOIz6E80lZTmrGdcOKFjLT59gdet+3z0BdFtvNrmlVDx0WFZ3GyqrzA6dMrQEUlU
	p1HpH3mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzjM7-00000004TAG-3Ihv;
	Tue, 01 Apr 2025 21:41:11 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzjM3-00000004T8p-1yLs
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 21:41:10 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1387063a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 01 Apr 2025 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743543666; x=1744148466; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rddeG/stg1FXDdM108mZ/CrahMcvxxmkAlZ0USWhxg=;
        b=J/VtZmft14jFqQvSuPz01tYxJyw+Tfj2hp8Sep2rjmdKLoFvvDnf6XZZu45miT6kkr
         VgQYIlgvuke8NB68PHEc6VogSr/C5euCtKq3cjNf7nex6DBdF26mOajIIV0zcVXkIhNO
         70ZaJBLVzZIY3jvKb59FwHxrGo3pBY1G57gAkJpAl56kiU2zUCuQNZ+YCzB5WWv+JMVX
         oL25MRVtLtIljlisBIvWMCWcfsGPSrs+Vil2BhKkzcoEXrcGXWg/2uvumXdnRfkD5OgC
         DM9+yxrV13YNoATI/8z8oJU2MGut507dZ3+c9pTAyIelJsVDLV4ckP0uGnWRY/OPtWKH
         qANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543666; x=1744148466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rddeG/stg1FXDdM108mZ/CrahMcvxxmkAlZ0USWhxg=;
        b=nVllndzegqrpiMfYCfGmfI13qMDSfhfrLQZnfP+zkj81imiE9uZOJgexezJGhmmDDA
         wZEAPOYVm2PVOz8IdNIYm5GWuYeNoIVfxsTrtXXItJBUDpY/jj4/TzTQjklcL3IHyprR
         0ZKBZp4+e98VtI0Qkyg1p9GWyn7IhGN1FSQsw7gMFMpVciEftaYzLV92Roe6nUEnY/Zd
         DwLFFxPovmDZgF4/KD2iyGM/iosqkBi07z0fijnvP8LWDD8Ej324kMscXvtx3rYOk3HS
         MDF7q+7k9nyMN/xDdh41e+fN9AC3mKgZNNzI3bi4Y8TSzDWkKct9WDg9CfBPx+w6i/K2
         pN8g==
X-Gm-Message-State: AOJu0Yzetb9qyWRVagiMLrJ66VSFv9KqTxF9Z+QDTRrhEX88PQyvQY6t
	eT8OwgIrrVjyyF27l3TZExJHmTYvtsFRrjqjUxSgSwdxW6o0ZYFjN8m+JrPcZw9JoMcjn1UXRt0
	PdxoENRtmFbVGy+NzdvOdIxcCg3IocZd8nFsJnQ==
X-Gm-Gg: ASbGncvh317Xikoj7ppQVbEpqKgb/Mw09PswBJAX3wvRoEjFoo2nOgqC8MusXSWwSoo
	LZLcFFzR95ZqHKK/PlanfywxugDGZ4bsy1UEeia+oApwkh6RWXvzVQn+ph/1sFNKa/naLAYO5yA
	EzkVk7UUnSl7+WnlRC+bL2utGm
X-Google-Smtp-Source: AGHT+IHCPMsfXZnN6OS8GUWLEUkuqY1tgOQu2G9GvcXneaYTJjr8IU1qpzF3fjBYOs+tg10EpsWxOutrjpZKJtMZVeo=
X-Received: by 2002:a17:90b:3b51:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-30532165e83mr8384655a91.8.1743543666430; Tue, 01 Apr 2025
 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
In-Reply-To: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 1 Apr 2025 14:40:54 -0700
X-Gm-Features: AQ5f1JqyApgkiSR8MTKlnycfWrTGqMdlRfZT0jAg5CcEdJAdnqZfd1nIlydpk-0
Message-ID: <CADUfDZoa8sVX2D599k=kaWTwc7sWdbqCyOo9ov4QiJ_P_1G+rg@mail.gmail.com>
Subject: Re: nvme-cli connect regression
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_144107_547995_788408D5 
X-CRM114-Status: GOOD (  21.62  )
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

On Tue, Apr 1, 2025 at 8:25=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wrot=
e:
>
> Hi,
>
> Luca reported that "occasional failures in the systemd integration test
> that uses nvme-cli:" [1]
>
> [   10.378713] TEST-84-STORAGETM.sh[316]: + nvme connect-all -t tcp -a 12=
7.0.0.1 -s 16858 --hostid=3D95fe8041-3f53-415b-bc40-1bbd8932e7e8
> [   10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
> [   10.397326] TEST-84-STORAGETM.sh[340]: failed to add controller, error=
 failed to write to nvme-fabrics device
>
> I was not able to identify any changes in nvme-cli v2.12 which could
> explain this problem. The kernel in question is a stable kernel (6.13.7)
> which got following commit back ported:
>
> 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp
> PDU").
>
> The change itself looks okay but I think introduces a behavior change
> for the initial connect attempt.
>
> The error code is EINTR, should the kernel retry here, or is userland in
> charge to retry? Assuming we should retry... Thoughts?
>
> Thanks,
> Daniel

I am not sure what an error code of EINTR means in the kernel. It
looks like the kernel_recvmsg() is performed on the thread that writes
to /dev/nvme-fabrics, so it's possible that there is a signal pending
for the userspace thread (i.e. nvme-cli)?
The kernel_recvmsg() should block until it receives all 128 bytes of
the ICResp PDU. It can also time out if the data is not received
before sk_rcvtimeo =3D 10 * HZ. But I would expect it to return EAGAIN
in that case. I was going to say it doesn't look like 10 seconds had
passed yet in the quoted logs, but they also show time going
backwards, so I am not sure what to make of the timestamps...

Best,
Caleb

