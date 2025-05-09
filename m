Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1393CC3ABCC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76mp0wtsMi4XehQBpRv5yGkgTC8VkP/0gdc4xFJa0lk=; b=hTm57ADgjyYgAmInn+5w6eXcro
	CJO90CmzpEOJ27v8nZlSTF3A/nYREt7jhf/+gDwsrGhEDYJgAlddap5EHD8ORXZRpl8eKYuvrSdXo
	4YPrMPVO9E+8iwVu8lC1UZcEVin9Y52vjJr0g3Wqyq+7VmTwRHePQuZej1Wc2tU2AzJlte6qi790Q
	sSOgGeteoxZdwA97Iug6dqIBRSmTRTbIwaHg772SYjdCDHZYjkNltIOV5AYCVIErI/aTT/+7u1zp3
	62hWuZMskpKvPVe6wN3kghmZAtOb5fguxD4klqcAmybuiSFdZwRPa+wMTkmLjIWhAxp5TwBO8oNWb
	7uxXWi+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJh-00000004oYq-0oKv;
	Fri, 09 May 2025 20:27:33 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRzQ-00000004VZe-1P6j
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 17:58:29 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-74100abab21so292062b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 09 May 2025 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746813507; x=1747418307; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76mp0wtsMi4XehQBpRv5yGkgTC8VkP/0gdc4xFJa0lk=;
        b=WXhPcsFipj/kPErANlWWefmQ8QFLKmqldXJ21cDni0PYeftQFnYnt0FR1NQFozhiH1
         DMLZ8ellsB85J9O4IvMenkEIo24Y5CuW195QzRo5CfFIXMZtsVgbyA4HggbgoYBce0ik
         PYwpZTLi9JM1m3+88jN5J+rML1Xv7xysVzsrcGzeRiascTGFtmlc4TS9XHFqIJwui29i
         iu6b4jFBk7KdyjGuEdKm+HElQS+Aix8t0KaUhCu/Y9DVwvDRd3ksRaREyImoOz6CjQx6
         oAPPvBKtZegJAMVGUN+NiixCCjEX21trhtRif6r+ixga00MNMQIpe8yOEvTNslRnn8c+
         ojXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813507; x=1747418307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76mp0wtsMi4XehQBpRv5yGkgTC8VkP/0gdc4xFJa0lk=;
        b=Gev3V4a02sMrUlQake7brdXzk6AVduOBpAp2V67SAkskCNF9Nl+6iRUIqDntbwbgDG
         a+KYPN47ORaDf+5m/nxe/xRi1QGHwp2wrJjtJCttbG3D7TTlyZzrgv9Tm0sdRcTxQ+/r
         +AtpR+8ZTrLPd8ZmRbmrvrKspHlU7PPb4nnRUZ/kclzE+GrZYkO7yBuAp6FM6hQ5Z0vP
         Pqdx62+YlJFJKB53uDBQ5OOT6aTULqhGHpGNAuqGxiYbY4qAScCAYGuRUBpZVJxDgnbH
         ZI/YnQJGgshJvbU6nC3xNSiDjUbN+Lka7V4V5SFZLbMDehSryzV7brYPxeu6VkSxzy8w
         Rxjw==
X-Gm-Message-State: AOJu0Yzpf64Hy1SyDx7tDcFv6kzNQj3hiapBfQTn0tOkmLcTmmo1UZ85
	FdwAqg/ztL6SMmNkYNM5Si9csSTx8Og3UapfoYOUPm6sBgGs98nAybUDPN4OcOmUPBf3mpEpy3Z
	Aeyv+YDkI/5SyCiOP4TaLKgE3WLPzAljP1wJeIQ==
X-Gm-Gg: ASbGnctHQkz1xnqfCKbrXSE6IJyolwkvYmQpuuCNc0V//kaQYnrSVpBppMVi6CQZbJT
	48cVot9JmhPatdRdJip79DitypTlIrAM1+fe4DRd4xE8kUSsCjx67Qsu33ovnSxeRar8MlT5LmE
	SmF0/K7idnT8cmmL/wi/l4mg==
X-Google-Smtp-Source: AGHT+IFCEKzZm43P4HYtj4ya0OeoeA3pZ8acLM8VlZLbr5y0vDmhyqkgMBcFHk4zzj7DDu0/4HqHmYSlI/CdtYHD8W4=
X-Received: by 2002:a17:903:46c3:b0:22e:7633:1755 with SMTP id
 d9443c01a7336-22fc918bd59mr26440335ad.12.1746813507116; Fri, 09 May 2025
 10:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 9 May 2025 10:58:15 -0700
X-Gm-Features: ATxdqUEhMmEJgkAHydtlOwcAOR-VxdeP8ng8vEY9cufHkiF4PP5WAQx5H1VuJPI
Message-ID: <CADUfDZr_paV6iK-KrABtf5OXTrxD6vXc_HFTAsqgMp8OyDwz9g@mail.gmail.com>
Subject: Re: 'nvme list' shows 100% usage on empty drives
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_105828_417456_EE0EE4FB 
X-CRM114-Status: GOOD (  12.67  )
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

On Fri, May 9, 2025 at 10:53=E2=80=AFAM Eric Robinson <eric.robinson@psmnv.=
com> wrote:
>
> Why does 'nvme list' show drives as fully used when they are not? Note th=
at 4 of the drives show as fully used. These drives have been secure-erased=
.

These values are whatever the device reports in the Identify Namespace
data structure. If the values don't look right to you, take it up with
the drive manufacturer, not Linux or nvme-cli.

Best,
Caleb

>
> [root@ha54b ~]# nvme list
> Node                  Generic               SN                   Model   =
                                 Namespace  Usage                      Form=
at           FW Rev
> --------------------- --------------------- -------------------- --------=
-------------------------------- ---------- -------------------------- ----=
------------ --------
> /dev/nvme0n1          /dev/ng0n1            PHLN112302DB6P4CGN   Dell Exp=
ress Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512 =
  B +  0 B   VDV1DP24
> /dev/nvme1n1          /dev/ng1n1            42W0A02NTCA8         Dell Ent=
 NVMe CM6 MU 6.4TB               0x1          4.10  kB /   6.40  TB    512 =
  B +  0 B   2.1.8
> /dev/nvme2n1          /dev/ng2n1            PHLN112201RM6P4CGN   Dell Exp=
ress Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512 =
  B +  0 B   VDV1DP24
> /dev/nvme3n1          /dev/ng3n1            PHLN112302BA6P4CGN   Dell Exp=
ress Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512 =
  B +  0 B   VDV1DP24
> /dev/nvme4n1          /dev/ng4n1            42W0A02STCA8         Dell Ent=
 NVMe CM6 MU 6.4TB               0x1          4.10  kB /   6.40  TB    512 =
  B +  0 B   2.1.8
> /dev/nvme5n1          /dev/ng5n1            PHLN112302C16P4CGN   Dell Exp=
ress Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512 =
  B +  0 B   VDV1DP24
>
> -Eric
>
>
>
> Disclaimer : This email and any files transmitted with it are confidentia=
l and intended solely for intended recipients. If you are not the named add=
ressee you should not disseminate, distribute, copy or alter this email. An=
y views or opinions presented in this email are solely those of the author =
and might not represent those of Physician Select Management. Warning: Alth=
ough Physician Select Management has taken reasonable precautions to ensure=
 no viruses are present in this email, the company cannot accept responsibi=
lity for any loss or damage arising from the use of this email or attachmen=
ts.
>

