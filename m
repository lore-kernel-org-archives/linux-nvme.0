Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04DACAC592
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Sep 2025 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i50LuplJWM+Xi5/sd1zmFgHuGeUoTysJcBAPdzJgAEs=; b=U0Ns7/FIwdIKmX5u4tdGpp/yPQ
	u4JlSHXfFM02bi4yRokgDh2ImEntXZoiaJfu0pW2w4oojeQYZ3aKMWtcFS/Hkbz4Iy1rznh0eyoim
	AzPgY6/xWLnTOy/yh1E/LGkKAD5ejJBdaxJo0wlUKzgDlmvlM7Ne0ZcX6XwGk3XwptAT/9f6ImOcE
	az15cWDlHrkdhEN7Lbma/8bcpu7KJBLn41zjjzdP/3wHKJ2w216AxHkg7inZ1Frj0CsKW2PY8mp+r
	JQy7aJYfPQiYON7cE3ssfxsGMa/MbTh1+1zME1FGoH9Yp4t4d1imJuXGehwqMsbPjB4QY8ADbmdiE
	cu5eW9zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzWFl-00000002DMi-3MdI;
	Fri, 19 Sep 2025 08:14:01 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzWFi-00000002DMM-3zGX
	for linux-nvme@lists.infradead.org;
	Fri, 19 Sep 2025 08:14:00 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-423fc1532bdso20782795ab.1
        for <linux-nvme@lists.infradead.org>; Fri, 19 Sep 2025 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758269637; x=1758874437; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i50LuplJWM+Xi5/sd1zmFgHuGeUoTysJcBAPdzJgAEs=;
        b=AshI+7GcGkvU1OQzkifObCaB+7qLCVAkohLAmKAtyfwZ+4jFLS8UIcnyHXV/zae/+U
         PFV9tmHr1snepR2HH7Yz5WrmSb2NcXIlUVO5rf4AZtVCeEZtsZ5Ct0fKQK1zlCLwcUgl
         h0VQPQwWEqRLlhrXUsfRyF1R1PB+NzWbtojeir8/eF0TWv7CfPdni9uFXUIIsamQZMMh
         YUylrqW1QST6Y3Q4NInPqVPkh/VAgV0sgqpE/leh1HGCUPFFa6aSBwaw92FzsqgPzYXT
         hiA4+UrOY7B4/ADDwE94nMIphx8CMGa9//MBz3gpdgbM+vcdBwP401NbJGasWJSB4k+e
         hTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269637; x=1758874437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i50LuplJWM+Xi5/sd1zmFgHuGeUoTysJcBAPdzJgAEs=;
        b=XdkMj08n8H/2ZuksoG7jXEPjdtf2F7nL7FKnj4GWb/I/iH3GRrgJYHuRCl4VeDpJb0
         5jeS56qSr/H7HvpGvErLJ2BopcLZlAcyNkfzxLw2/DN5j682xXFEM/qAtqZXk6EhHTKw
         6qZqEn/ttc/5lumGg81LeaJu9/97XDNsSK4qyLXq2PenOGnFQUFVwTLCN1BEPYh2nSlF
         eZUcZkkzgsh+sB24IB8Nr3SPamrxgM2+69rQzw2YT6sLkBHh4PLcWiJ1Dz8T3i0ps8Zo
         i80LZ7G0GE0AKLtz2ZFeZ0s032PE3RDMnlqzkMtnDrpYn4Vir3jLmbGpck3Q/uNYfWbE
         cuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVZ2wT/uptn0mgsIdg3/vJWDkDbfRGxcLuk43Tbw6mBmJu5R/TMkI2H6Z1HTPVWkRMBNrKCbG9vSBZ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq4o8iNf+n3O7D17qaiNENKQUKzelHcJHWJT16jOK7zC8vfb3P
	SAqhl4vdL3DlhbOWGGDpo8nIgas1HXCYd6s+7m3oQtXgS/neftUymhYOSh9klwdTekU6xgIwugE
	quXuSGSLePLkNvEVByRygH1DpeUrVzv0=
X-Gm-Gg: ASbGncsPDeMOpntUEb4gTFMxPWY6p8cmVz3RImcJokLQ2BojoJ6v5HBj81U3KNrc73P
	4ozR3wrcII5Bmp+yvJurBm2DK+gNNzqLbW7sRRNqeiPd/DoDb10v6Lx9ED855LAm89SQegha7Jd
	wkU5I81vZHkHNrAP9NLRZ3AhPzOBUh3d1amHJQOfyM9V20rJM6e5zNeRCnMIyQzIcSdQt1oAC5Q
	CAdj0xAHRhsxpnVSk4=
X-Google-Smtp-Source: AGHT+IGXAxXb1EixEIk//rFN/Ay8Z8lm2iQjmLx9i3pjfgGtG1V3YBMjJc2PrAsC/lJZhwUwemj9Env/B3yLDWxOYZk=
X-Received: by 2002:a92:cdaf:0:b0:3f3:86f:520c with SMTP id
 e9e14a558f8ab-424818f7f03mr34444905ab.7.1758269637406; Fri, 19 Sep 2025
 01:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <CALbmT6fF+1n+W1r+JNyr8+yY8Ub7PB6yYT2gpS12MBLbuHk9hQ@mail.gmail.com>
 <aMbR0aWqFjklHzfR@kbusch-mbp> <5836da67-1fdd-43ac-a039-58705ba1f370@nvidia.com>
In-Reply-To: <5836da67-1fdd-43ac-a039-58705ba1f370@nvidia.com>
From: Apachez <apachez@gmail.com>
Date: Fri, 19 Sep 2025 10:13:46 +0200
X-Gm-Features: AS18NWDkQpa8IgupzCQ4gDir8vKjDZ4Zev4u0ZmDqMwGXjz-nmapUZ87rsMeEiI
Message-ID: <CALbmT6ecHG-yhPfAUMBOStug6vc+TtjYQ+812jyqxAHJYpAG_Q@mail.gmail.com>
Subject: Re: Increase maxsize of io_queue_depth for nvme driver?
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_011359_009328_3A230E22 
X-CRM114-Status: GOOD (  21.71  )
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

On Fri, Sep 19, 2025 at 2:29=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 9/14/25 7:31 AM, Keith Busch wrote:
>
> On Sun, Sep 14, 2025 at 02:45:35PM +0200, Apachez wrote:
>
> I would like to propose that NVME_PCI_MAX_QUEUE_SIZE should be
> increased from 4095 to 32767 to match the current NVMe specification
> regarding MQES and to give the sysop ability to fully utilize the
> performance of the hardware being used, or am I missing something
> here?
>
> We use the upper bits of the command id to detect duplicate completions,
> so we don't have enough bits to tag commands beyond 4095. As far as I
> know, though, we haven't seen such breakage in a *long* time. It's more
> of a sanity thing to know with high certainty that duplicate completions
> are not occurring.
>
> But I don't think you'll see any performance difference by increasing
> the queue depth. Devices saturate the link at far lower already, so
> going higher just increases completion latency.
>
> Apachez, can you share the performance numbers where it shows clear win f=
or the
>
> performance difference woth above mentioned queue depth number ?
>
> -ck


Hi,

I currently dont have any hard data if io_queue_depth larger than 4095
would improve
anything other than that the NVMe specification defines MQES as a 15 bit nu=
mber
meaning (as I interpret it) that the NVME_PCI_MAX_QUEUE_SIZE should be max
size 32768 rather than 4095.

And one of the features with NVMe storage over HDD or SSD is support of a l=
arger
queue size.

Its often claimed to be something like:

SATA <=3D 32, SAS <=3D 256, NVMe <=3D 65535.

As example Micron 7450 MAX states in their datasheet that the drive
supports 8192 as
queue size but Linux currently only let me set this to 4095 as max size.

Using a large io_queue_depth doesnt seem to hurt on above NVMe drives.

Im currently using this for ZFS and NVMe:

# Set maximum number of I/Os active to each device
# Should be equal or greater than sum of each queues *_max_active
# Normally SATA <=3D 32, SAS <=3D 256, NVMe <=3D 65535.
# To find out supported max queue for NVMe:
# nvme show-regs -H /dev/nvmeX | grep -i 'Maximum Queue Entries Supported'
# For NVMe should match /sys/module/nvme/parameters/io_queue_depth
# nvme.io_queue_depth limits are >=3D 2 and <=3D 4095
options zfs zfs_vdev_max_active=3D4095
options nvme io_queue_depth=3D4095

Kind Regards
Apachez

