Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12924C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=; b=3M1zA+UPHOcHRs1MZY8NgbxaN4
	s/nPb+CdEMhU+SafOrff8Nh3akADKYC/iscFGA2hQAUvrEXmmtuVKuxe55+P6fhpACfoSAccwtEgM
	Tx5o8up+++283Ik3WxEhq5KkLPNivE8dXc8nOqWjbFIA6aFRp+5oDeT7oj/kwQ4x5m7cEOG8t9a50
	PulnLvxuEOZDJwvRa/Njek4DydNWRc8nxL5HeMAIF2IXrNk6GwF+Jkg8zErYaYIKbMwlhUUpAXPlU
	klDX1RJEdwwCZPmU4b6VSiwR49iKSNi70180GcPBnxI//iGPW2CiL1m7BkeZKaXw7OYNakr01eoUH
	ab2ucB/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLY3-000000023Yf-1pE1;
	Tue, 06 Aug 2024 14:52:27 +0000
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJwz-00000001eLD-17CB
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 13:10:06 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5d5d0535396so369467eaf.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Aug 2024 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722949803; x=1723554603; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=;
        b=Ka3MUS4HhXWXGiJlM62eK2u/IuVOjl4GTiF+T995jvJaSx9wJlzcS/TzaTTpmGWlOg
         LTtUIBQTZWB4z3eDAdrF0cMSy6kgAucmwrfLXK1ZIp+HuqA8HdqRZvHmR1U8UVFwHVYC
         PTY1J0c789fzaNXUcBGSS9v07yYeaQstF2M34zubnLa6x1lNFJUpZ/7zTh86JqNNEtST
         E0emhwAY77QQt5HqOIjku9M+yLl3GPDyG9D/zfzMz4BZSXooT6+TgcAQH2dFhzx0otKq
         oAvAiQU6gggge1Pdi7nEarRPR29dVkq1hvma4rufE0buTymBygYnvf0jIWShg2QlnjCE
         1tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949803; x=1723554603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KREccnRV9/lcz1AxarrngZjnkiUg2IvSSWsvWfX4xFM=;
        b=QMDkGAVXqaqMafWAoI3vCBASPLUnbxM7QqUbLu2H1OTliQHq9MFqorvVvlDWGyc9kF
         YOf84FA34+X+zqwLPFBouSl7xGlKluo97enLeEvRxaKVNLo8sQvCACZj/AaN8XHPPj6P
         Px9qCC3vSyW0S6LUHec6RQ3QHWDn3bCoQA2y+Llc9ZobAyyBMALw+pZ+YYmUO6/2Eg8S
         px4D+I3Ok52s2afZbHcTkbv0ksCjr/7VJfKB7gN6fIgpDomkl0bBhU2TZMTVT1/gdY9L
         gxAZqxhM80qk/UguN2Yl+x4+QdO6rv2YbRL4PbDECGm3QO43Atp03wOecTapF7xXn7K0
         jVzw==
X-Forwarded-Encrypted: i=1; AJvYcCWxDWuoB3DhnfRF/7n1ABW+4cbCB05G9o+se4UW03pmTX8f16TzT7t6LOgxxC8vBMo3qwLV9zMVo0hUG9UHhgavTJxGm8VoRozIaBPTHQ4=
X-Gm-Message-State: AOJu0YwNlaqb6opswHDzAvUly/ElUmaHXwThENfTj0v6Rv65cnBp3cE4
	LsAABcVFF8GM/JCOxtpiB+xfsL8hok813uXLtaUlOkjuvKvFzGpwx+DsLulgaWhK+WJKvnbFlr2
	5gJcf8pzC85P/tnx4IUsYZcd1MLM=
X-Google-Smtp-Source: AGHT+IGVJxX/HbV5Wr6MzBf+fuxb+mIBQRp2TWTznpKDIx+yrOgDwhY5P4ZF8kRUebG9zXa+VAy7m3G1u1r+X9IB2Rg=
X-Received: by 2002:a05:6870:50d:b0:259:8b4e:e71a with SMTP id
 586e51a60fabf-26891ee1b6dmr17272867fac.46.1722949803427; Tue, 06 Aug 2024
 06:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Aug 2024 09:09:50 -0400
Message-ID: <CAJSP0QVod5DA2hdNFrpN+HZcfm6Bg11teRmt5d+MBTB1wH4vZg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] honor isolcpus configuration
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Jonathan Corbet <corbet@lwn.net>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, virtualization@lists.linux.dev, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_061005_330172_FFFA5D1D 
X-CRM114-Status: GOOD (  14.27  )
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

On Tue, 6 Aug 2024 at 08:10, Daniel Wagner <dwagner@suse.de> wrote:
> The only stall I was able to trigger
> reliable was with qemu's PCI emulation. It looks like when a CPU is
> offlined, the PCI affinity is reprogrammed but qemu still routes IRQs to
> an offline CPU instead to newly programmed destination CPU. All worked
> fine on real hardware.

Hi Daniel,
Please file a QEMU bug report here (or just reply to this emails with
details on how to reproduce the issue and I'll file the issue on your
behalf):
https://gitlab.com/qemu-project/qemu/-/issues

We can also wait until your Linux patches have landed if that makes it
easier to reproduce the bug.

Thanks!

Stefan

