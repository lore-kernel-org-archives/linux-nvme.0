Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD926C61DB2
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfZHCVY8wtHOGDef32zSx4cjcZnmSVTZ0eeGpKMpl08=; b=eErOV2g+DZNFFed8DbYNs4Pta0
	LGKKqsblnTvMQibQ6J4IxxHdkQUi3/VN7lrJbvcNTVPxtQc2hCISD/maqBgJKxbUoBgrY3GrGMGhg
	51PHSWcOkd/PG4gkBR2La19Bagy0RraYZdFqOhgDJO0cwz7hsKntai8lQjMnZS5z7/A6WFIbWfe5U
	m87ftGSVG0Ql50klw/1U+I5c1XHiLriRi1kITLbQ3HfONBYq2fLl8aSm3gMDmHs7MqkjHfZ2oUEy7
	3oJt5qx9Yx6P2dNVmHWg7+Jb95Rarh4jBkyQp1DJZyFqBmmWBotm4lyllMxfKvfctDUE2oddSokP4
	1KtssoLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP8yV-00000008Rir-3vi9;
	Wed, 11 Jun 2025 00:05:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP8yS-00000008RiU-0juW
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 00:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749600346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfZHCVY8wtHOGDef32zSx4cjcZnmSVTZ0eeGpKMpl08=;
	b=FQGJNaByZGVrGjyTkxAEV/O832zPmYUJRRtv4wkfAnt2EHCp0igLn2f+z2J4uOjC7hBCs5
	Uw9b+fLfMTE1IFvO7oHpcZGuljJSseueH0l5LJ66EKon0Rd4uacCAeRrSNs/ObIrtcVGM3
	wdUocOfihDdsL3H1DDCf4NexiE90D38=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-n7yh_9aYOlOo6nXgDJNXRw-1; Tue, 10 Jun 2025 20:05:44 -0400
X-MC-Unique: n7yh_9aYOlOo6nXgDJNXRw-1
X-Mimecast-MFC-AGG-ID: n7yh_9aYOlOo6nXgDJNXRw_1749600343
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-551ec3101c7so2458465e87.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 17:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600342; x=1750205142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfZHCVY8wtHOGDef32zSx4cjcZnmSVTZ0eeGpKMpl08=;
        b=VJoPja005Ea7h9h0PSm9MeniGiT9iSC2ctGuU6jOfseW8gYbsnYIrZvftKTdNl9iiT
         oOZFVg+dyLxdYBgs8gRS/kLr6hukrVuFnX2sN8btGBVjKHQS4uK8bk8raR2/1ngwt1xr
         nepgNkCN5N7ynYX9id2tVwQh5g640iX6XST9IF0Nj1iK8STu2Z4diWon8/fcDRxjPXlF
         SPC3GBYRC9hwVWSGtboeSwhlVp79k4Vj22s4msoiwnaekPF3C+J7nggssDNtAwrZE2G2
         ypAwfAG1PpDlGmLuIs1sCSKQxK+2HHmQ66+ZpqmRpgT7+VY7q6oqcEmhGJkq5M5Qc8cp
         uXtw==
X-Forwarded-Encrypted: i=1; AJvYcCUhuZh/6kqnzJYoRl4w9A6AVEgxySB2jWdXW7BE9SBUPZ3OmejDCCUtXJENamNyqtqDKaTambk2XhhL@lists.infradead.org
X-Gm-Message-State: AOJu0YzdAaFqWFINL64GUhpaQoSybXI7wBPBNqBostOCJBd4CR5DRRg4
	tKA+VpDSbGnnh9Fn5eJwtEgSOQow2qU8qEuweVtok10UFmUNrAJTiRMHOysb1lGWN7URTz/IzGw
	hfdkbVA0rylR0O7epB8fS+Xh8nfjI0IS+zbw32Co4pwCWIhsqZZZyDXiCUqGLVjcYnd0q51APHH
	LrfLFG0kgXff2Vw3SZZ5XaMB+4nPNTK6JRvs972zidsKM=
X-Gm-Gg: ASbGnct1C4YzMqosaAAi3kZ+bFyl5QF5FB6YNGUg7ELMezFH7t8Qymm3Vu9zZEA5NnE
	VEKcx45BYlod6hY64wDH4ZbFRF70mhsRMKPKAW0fEpnKpX8sYE58DCe6oJlvZfnqrDvcmBItY6o
	gvMz0g
X-Received: by 2002:a05:6512:4014:b0:553:390a:e1d3 with SMTP id 2adb3069b0e04-5539c21963emr399116e87.48.1749600342311;
        Tue, 10 Jun 2025 17:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhOwVg7qeZZrEJh3wXJfQSzlFm6zGutZuBN5xDRC8nXKoNttq+Vt9q600CPbttEqRfVRvzxoNO4NqZzc7hoPs=
X-Received: by 2002:a05:6512:4014:b0:553:390a:e1d3 with SMTP id
 2adb3069b0e04-5539c21963emr399102e87.48.1749600341765; Tue, 10 Jun 2025
 17:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
In-Reply-To: <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Jun 2025 08:05:29 +0800
X-Gm-Features: AX0GCFtXtK7nhGg3Nm1ng3gsx-sa9wTrJ8gk24-QSYZSQ98ORg_haL1rsWNIdew
Message-ID: <CAHj4cs9qZ2wGDJbrRhxbExfwjD1cwAZKO+rpt9-yxCfBCJtr=A@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144 bdev_count_inflight_rw+0x26e/0x410
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "yukuai (C)" <yukuai3@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yBoY4COEOcCcYK_dp-qflCg884IhD2d2O9pKnMQu1EE_1749600343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_170548_757717_52A66B3B 
X-CRM114-Status: GOOD (  12.18  )
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

On Tue, Jun 10, 2025 at 10:02=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/06/06 11:31, Yi Zhang =E5=86=99=E9=81=93:
> > Hello
> >
> > The following WARNING was triggered by blktests nvme/fc nvme/012,
> > please help check and let me know if you need any info/test, thanks.
> >
> > commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> > 'block-6.16' into for-next
> >
> > [ 2679.835074] run blktests nvme/012 at 2025-06-05 19:50:45
> > [ 2681.492049] loop0: detected capacity change from 0 to 2097152
> > [ 2681.678145] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 2682.883261] nvme nvme0: NVME-FC{0}: create association : host wwpn
> > 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> > "blktests-subsystem-1"
> > [ 2682.895317] (NULL device *): {0:0} Association created
> > [ 2682.902895] nvmet: Created nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [ 2682.970869] nvme nvme0: NVME-FC{0}: controller connect complete
> > [ 2682.970996] nvme nvme0: NVME-FC{0}: new ctrl: NQN
> > "blktests-subsystem-1", hostnqn:
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > [ 2685.498124] XFS (nvme0n1): Mounting V5 Filesystem
> > 3f19217c-d3fd-42af-9dbe-aa5dce6bb607
> > [ 2685.567936] XFS (nvme0n1): Ending clean mount
> > [ 2746.161840] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 0 fctype 1
> > (I/O Cmd) w10/11: x00000000/x00000000
> > [ 2746.163061] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0010007a/x00000000
> > [ 2746.163126] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001000ba/x00000000
> > [ 2746.163175] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001000fa/x00000000
> > [ 2746.163220] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0010013a/x00000000
> > [ 2746.163265] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0010017a/x00000000
> > [ 2746.163308] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001001ba/x00000000
> > [ 2746.163352] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001001fa/x00000000
> > [ 2746.163396] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001d8618/x00000000
> > [ 2746.163441] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000d9d88/x00000000
> > [ 2746.163486] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00014be0/x00000000
> > [ 2746.163531] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001bb168/x00000000
> > [ 2746.163585] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0006b620/x00000000
> > [ 2746.163639] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000b6688/x00000000
> > [ 2746.164885] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000581c0/x00000000
> > [ 2746.166593] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001468c0/x00000000
> > [ 2746.166681] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00080780/x00000000
> > [ 2746.166732] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00147338/x00000000
> > [ 2746.166780] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000acee8/x00000000
> > [ 2746.166826] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00016e20/x00000000
> > [ 2746.166872] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0019add0/x00000000
> > [ 2746.166916] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001bdab8/x00000000
> > [ 2746.166960] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000ea0f8/x00000000
> > [ 2746.167005] nvme nvme0: NVME-FC{0.3}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00006328/x00000000
> > [ 2746.170320] nvme nvme0: NVME-FC{0}: transport association event:
> > transport detected io error
> > [ 2746.173629] nvme nvme0: NVME-FC{0}: resetting controller
> > [ 2746.175966] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.177234] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.177571] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.177916] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.178228] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.178576] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.179173] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.179476] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.179807] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.180146] block nvme0n1: no usable path - requeuing I/O
> > [ 2746.232899] nvme nvme0: NVME-FC{0}: create association : host wwpn
> > 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> > "blktests-subsystem-1"
> > [ 2746.238446] (NULL device *): {0:1} Association created
> > [ 2746.239620] nvmet: Created nvm controller 2 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [ 2746.259174] (NULL device *): {0:0} Association deleted
> > [ 2746.296717] nvme nvme0: NVME-FC{0}: controller connect complete
> > [ 2755.870750] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [ 2755.873263] nvmet: ctrl 1 fatal error occurred!
> > [ 2769.422990] (NULL device *): Disconnect LS failed: No Association
> > [ 2769.424288] (NULL device *): {0:0} Association freed
> > [ 2801.582208] perf: interrupt took too long (2527 > 2500), lowering
> > kernel.perf_event_max_sample_rate to 79000
> > [ 2830.657742] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000a06a8/x00000000
> > [ 2830.657865] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000994d0/x00000000
> > [ 2830.657916] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000263b8/x00000000
> > [ 2830.657965] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000ecf10/x00000000
> > [ 2830.658010] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00054418/x00000000
> > [ 2830.658071] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001f42f0/x00000000
> > [ 2830.658088] nvme nvme0: NVME-FC{0}: transport association event:
> > transport detected io error
> > [ 2830.658119] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000bb588/x00000000
> > [ 2830.659087] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000fd620/x00000000
> > [ 2830.659134] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x000d66b0/x00000000
> > [ 2830.659189] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00188488/x00000000
> > [ 2830.659233] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00086fd0/x00000000
> > [ 2830.659276] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001a0950/x00000000
> > [ 2830.659345] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00136340/x00000000
> > [ 2830.659390] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x0013dc60/x00000000
> > [ 2830.659433] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00193530/x00000000
> > [ 2830.659500] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001d3ff0/x00000000
> > [ 2830.659545] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00101455/x00000000
> > [ 2830.659589] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00101495/x00000000
> > [ 2830.659650] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001014d5/x00000000
> > [ 2830.659758] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00101515/x00000000
> > [ 2830.659842] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00101555/x00000000
> > [ 2830.659889] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x00101595/x00000000
> > [ 2830.659904] nvme nvme0: NVME-FC{0}: resetting controller
> > [ 2830.659941] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 1 fctype 1
> > (I/O Cmd) w10/11: x001015d5/x00000000
> > [ 2830.660321] nvme nvme0: NVME-FC{0.4}: io timeout: opcode 0 fctype 1
> > (I/O Cmd) w10/11: x00000000/x00000000
> > [ 2830.660348] nvme_ns_head_submit_bio: 81 callbacks suppressed
> > [ 2830.660362] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.661765] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.662070] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.662367] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.662660] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.663046] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.663337] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.663627] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.663976] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.664288] block nvme0n1: no usable path - requeuing I/O
> > [ 2830.700704] nvme nvme0: NVME-FC{0}: create association : host wwpn
> > 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> > "blktests-subsystem-1"
> > [ 2830.706376] (NULL device *): {0:0} Association created
> > [ 2830.707571] nvmet: Created nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [ 2830.725113] (NULL device *): {0:1} Association deleted
> > [ 2830.745872] ------------[ cut here ]------------
> > [ 2830.746780] WARNING: CPU: 49 PID: 1020 at block/genhd.c:146
> > bdev_count_inflight_rw+0x2a6/0x410
> > [ 2830.747730] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
> > nvme_fabrics nvme_core nvme_keyring nvme_auth rfkill sunrpc
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency
> > intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
> > intel_powerclamp coretemp kvm_intel vfat
> > [ 2830.748536] nvme nvme0: NVME-FC{0}: controller connect complete
> > [ 2830.749958]  fat kvm irqbypass iTCO_wdt rapl iTCO_vendor_support
> > intel_cstate intel_uncore pcspkr bnx2x mgag200 i2c_i801 tg3 i2c_smbus
> > lpc_ich i2c_algo_bit hpilo ioatdma mdio dca ipmi_ssif ipmi_si acpi_tad
> > acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dax_pmem sg
> > fuse loop nfnetlink xfs nd_pmem sr_mod sd_mod cdrom
> > ghash_clmulni_intel hpsa scsi_transport_sas hpwdt ahci libahci libata
> > wmi nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod [last
> > unloaded: nvmet]
> > [ 2830.752807] CPU: 49 UID: 0 PID: 1020 Comm: kworker/49:1H Not
> > tainted 6.15.0+ #2 PREEMPT(lazy)
> > [ 2830.753650] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
> > Gen9, BIOS P89 10/05/2016
> > [ 2830.754291] Workqueue: kblockd nvme_requeue_work [nvme_core]
> > [ 2830.755188] RIP: 0010:bdev_count_inflight_rw+0x2a6/0x410
> > [ 2830.755503] Code: fa 48 c1 ea 03 0f b6 14 02 4c 89 f8 83 e0 07 83
> > c0 03 38 d0 7c 08 84 d2 0f 85 59 01 00 00 41 c7 07 00 00 00 00 e9 75
> > ff ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f
> > b6 14
> > [ 2830.756887] RSP: 0018:ffffc9000ad973e8 EFLAGS: 00010286
> > [ 2830.757221] RAX: 00000000ffffffff RBX: 0000000000000048 RCX: fffffff=
fa9b9ee56
> > [ 2830.758007] RDX: 0000000000000000 RSI: 0000000000000048 RDI: fffffff=
fac36b380
> > [ 2830.758831] RBP: ffffe8ffffa33758 R08: 0000000000000000 R09: fffff91=
ffff466fd
> > [ 2830.759609] R10: ffffe8ffffa337ef R11: 0000000000000001 R12: ffff888=
121d16200
> > [ 2830.760405] R13: dffffc0000000000 R14: ffffc9000ad97474 R15: ffffc90=
00ad97470
> > [ 2830.761226] FS:  0000000000000000(0000) GS:ffff888440550000(0000)
> > knlGS:0000000000000000
> > [ 2830.761724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2830.762472] CR2: 000055aa8905b038 CR3: 0000000bfae7a001 CR4: 0000000=
0003726f0
> > [ 2830.763293] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 2830.764124] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 2830.764921] Call Trace:
> > [ 2830.765087]  <TASK>
> > [ 2830.765625]  bdev_count_inflight+0x6d/0xa0
> > [ 2830.765921]  ? __pfx_bdev_count_inflight+0x10/0x10
> > [ 2830.766604]  update_io_ticks+0x1bd/0x210
> > [ 2830.789758]  ? __pfx_update_io_ticks+0x10/0x10
> > [ 2830.823941]  ? nvme_fc_map_data+0x1d0/0x860 [nvme_fc]
> > [ 2830.861999]  bdev_start_io_acct+0x31/0xe0
> > [ 2830.893416]  nvme_mpath_start_request+0x222/0x390 [nvme_core]
> > [ 2830.934768]  nvme_fc_start_fcp_op+0xc4c/0xfe0 [nvme_fc]
> > [ 2830.973158]  ? trace_nvme_setup_cmd+0x149/0x1b0 [nvme_core]
> > [ 2831.011196]  ? __pfx_nvme_fc_start_fcp_op+0x10/0x10 [nvme_fc]
> > [ 2831.050102]  ? nvme_fc_queue_rq+0x1b6/0x4c0 [nvme_fc]
> > [ 2831.085274]  __blk_mq_issue_directly+0xe1/0x1c0
> > [ 2831.117939]  ? __pfx___blk_mq_issue_directly+0x10/0x10
> > [ 2831.153586]  ? blk_mq_request_issue_directly+0xc6/0x190
> > [ 2831.189705]  blk_mq_issue_direct+0x16b/0x690
> > [ 2831.220964]  ? lock_acquire+0x10b/0x150
> > [ 2831.249564]  blk_mq_dispatch_queue_requests+0x31c/0x640
> > [ 2831.267274]  blk_mq_flush_plug_list+0x187/0x6a0
> > [ 2831.267940]  ? trace_block_plug+0x15e/0x1e0
> > [ 2831.268164]  ? blk_add_rq_to_plug+0x2cf/0x460
> > [ 2831.268799]  ? rcu_is_watching+0x15/0xb0
> > [ 2831.269033]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
> > [ 2831.269316]  ? blk_mq_submit_bio+0x10cc/0x1bc0
> > [ 2831.269969]  __blk_flush_plug+0x27b/0x4d0
> > [ 2831.270200]  ? find_held_lock+0x32/0x90
> > [ 2831.270426]  ? __pfx___blk_flush_plug+0x10/0x10
> > [ 2831.271079]  ? percpu_ref_put_many.constprop.0+0x7a/0x1b0
> > [ 2831.271380]  __submit_bio+0x49b/0x600
> > [ 2831.271594]  ? __pfx___submit_bio+0x10/0x10
> > [ 2831.271843]  ? raw_spin_rq_lock_nested+0x2e/0x130
> > [ 2831.272506]  ? __submit_bio_noacct+0x16d/0x5b0
> > [ 2831.273157]  __submit_bio_noacct+0x16d/0x5b0
> > [ 2831.273805]  ? find_held_lock+0x32/0x90
> > [ 2831.274035]  ? local_clock_noinstr+0xd/0xe0
> > [ 2831.274251]  ? __pfx___submit_bio_noacct+0x10/0x10
> > [ 2831.274901]  ? ktime_get+0x164/0x200
> > [ 2831.275127]  ? lockdep_hardirqs_on+0x78/0x100
> > [ 2831.275777]  ? ktime_get+0xb0/0x200
> > [ 2831.276382]  submit_bio_noacct_nocheck+0x4e1/0x630
> > [ 2831.302650]  ? __pfx___might_resched+0x10/0x10
> > [ 2831.334528]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
> > [ 2831.371424]  ? should_fail_bio+0xb5/0x150
> > [ 2831.400963]  ? submit_bio_noacct+0x9ba/0x1b30
> > [ 2831.432384]  nvme_requeue_work+0xa6/0xd0 [nvme_core]
>
> Looks like this problem is related to nvme mpath, and it's using
> bio based disk IO accounting. I'm not familiar with this driver,
> however, can you try the following bpftrace script to check if
> start request and end request are balanced? From the log I guess
> it's related to mpath error handler, probably requeuing I/O.
>

Seems it doesn't work.

# bpftrace nvme.bt
nvme.bt:1:1-27: WARNING: nvme_mpath_start_request is not traceable
(either non-existing, inlined, or marked as "notrace"); attaching to
it will likely fail
k:nvme_mpath_start_request
~~~~~~~~~~~~~~~~~~~~~~~~~~
nvme.bt:4-6: WARNING: nvme_mpath_end_request is not traceable (either
non-existing, inlined, or marked as "notrace"); attaching to it will
likely fail
Attaching 2 probes...
cannot attach kprobe, Invalid argument
ERROR: Error attaching probe: kprobe:nvme_mpath_end_request
# cat nvme.bt
k:nvme_mpath_start_request
{
         @rq[arg0] =3D 1;
}

k:nvme_mpath_end_request
{
         if (@rq[arg0]) {
                 delete(@rq[arg0]);
         } else {
                 printf("leak end request counter\n %s\n", kstack());
         }
}

> k:nvme_mpath_start_request
> {
>          @rq[arg0] =3D 1;
> }
>
> k:nvme_mpath_end_request
> {
>          if (@rq[arg0]) {
>                  delete(@rq[arg0]);
>          } else {
>                  printf("leak end request counter\n %s\n", kstack());
>          }
> }
>
> And can you test the following patch?
>

Unfortunately, the issue still can be reproduced with the change.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
> index 878ea8b1a0ac..ad366f0fd8cb 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -200,14 +200,17 @@ void nvme_mpath_end_request(struct request *rq)
>   {
>          struct nvme_ns *ns =3D rq->q->queuedata;
>
> -       if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
> +       if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE) {
>                  atomic_dec_if_positive(&ns->ctrl->nr_active);
> +               nvme_req(rq)->flags &=3D ~NVME_MPATH_CNT_ACTIVE;
> +       }
>
> -       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> -               return;
> -       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> -                        blk_rq_bytes(rq) >> SECTOR_SHIFT,
> -                        nvme_req(rq)->start_time);
> +       if (nvme_req(rq)->flags & NVME_MPATH_IO_STATS) {
> +               bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> +                                blk_rq_bytes(rq) >> SECTOR_SHIFT,
> +                                nvme_req(rq)->start_time);
> +               nvme_req(rq)->flags &=3D ~NVME_MPATH_IO_STATS;
> +       }
>   }
>
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>
>
> Thanks,
> Kuai


--=20
Best Regards,
  Yi Zhang


