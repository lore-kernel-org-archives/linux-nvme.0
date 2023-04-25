Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F92AC6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bM1e7JYX4nkVcBf9j99zm7lHq1vFlv4ovy2ffsRwbkU=; b=1+8OhYLxJGm2lwQpmPIguQ7W5k
	Ra0tHeTJf3QEabD+4TwfgCfRs0cpA6634NopcP8UUv7T7iSM5fOcuw2fk2YcjEgXfvf+4WKJ/S6Gb
	bCEFAIT2cJPGWx2qy1Qy0ImdsMqpGypOoqYG28HJd8g2VzmftfzX2ySC3qADURXgeuXTQ1AoZddfj
	crlhGZsfILKg3ua+BCU2b23aJzUM9qntpsIFAaOnDGe38NIlLPFQ7kAfL0FUuAYrhECAO/h9TgqlO
	+C072gwLLMzmrrVNDaUXitqPodkfvFjmfe8bFHWe1sG7Jnl1CG6WFLq94kkTW91UYX/N9rQ3tRXma
	FexMrZrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prE7F-000XIJ-2J;
	Tue, 25 Apr 2023 08:33:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prE5P-000VqL-27
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 08:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682411501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bM1e7JYX4nkVcBf9j99zm7lHq1vFlv4ovy2ffsRwbkU=;
	b=Ki3bJvUQocWRDzAdrTdrct9jODQSJOWU9ydWPM17Y/HL1VsAkSoLDVm4lhpuA5opR04wN0
	Z/IhutHzbPK0vuEsTYn9jcaNvrxCEDyD0R1XttsTfDFg0Q2or9CeXWiFUjmfcLZ9tmIrJv
	T/LsjxyD1ifdm8dxwxWyNTvRXj9Msb4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-65cLSKJJPS2929j1R_ujCw-1; Tue, 25 Apr 2023 04:31:39 -0400
X-MC-Unique: 65cLSKJJPS2929j1R_ujCw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-246f13f35f1so3110346a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 01:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411499; x=1685003499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM1e7JYX4nkVcBf9j99zm7lHq1vFlv4ovy2ffsRwbkU=;
        b=Km0PZuyD9Th2Hwg5Z5nL4sCsacedpkRuw4jFDWHluxOF9ssO6zwkL42Jp9r6KP6sMF
         xMKIkGSNm8RnkkfaJ7htZjd4JIfs/jpuBVIsUNOIc0Drna0I8iTHoqp41W9fmRN4A0vJ
         zrncql17oBlTN9x15SeRdheOlPyREwLO04DAV3jhQqsKyEloyVj+nrmuHqDW3rd21PL3
         t3VCWw9v5ITReeSRTIXAnJJ1ylY9J+YOlcEk61hQRxFTp8WyjRCLOzp5FuI6A4OTyU53
         Y2aRsXx9a0a7VSzAySViiDN8BNdVaOjehXHI6V0xPsUA2rwJDaUukxcnFSmNCapj0P26
         ZQJw==
X-Gm-Message-State: AC+VfDzMDdDCfNynpLr9nKjiO2HLF1eDQGI0pea8umZ9A2Jqn+GHspLK
	A8qd2HnowlDYmmd/7xLH7JZG8DDrZMxfHRjl1hgMmxgNwur2vhlektICEnLSjsSyHSppY3cACnW
	SLE+u7QYaxq5LpeQAsR888V9bU7FOCBv/5DCO5I33n58=
X-Received: by 2002:a17:90a:bd01:b0:24b:da56:84fb with SMTP id y1-20020a17090abd0100b0024bda5684fbmr2305606pjr.37.1682411498350;
        Tue, 25 Apr 2023 01:31:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ARIZ68ESLzAIs7fl929gbxYXAtER2ufmEXE9uWXevCar4FITYo62WQlucAUdYyy43mHaK4PM9TKfrxYSLDic=
X-Received: by 2002:a17:90a:bd01:b0:24b:da56:84fb with SMTP id
 y1-20020a17090abd0100b0024bda5684fbmr2305558pjr.37.1682411497215; Tue, 25 Apr
 2023 01:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com>
 <8ee89033-d454-072a-6fe2-e2bf24ece2fc@oracle.com> <c8c21fdb-ec06-2b4a-a42a-b4c8c34df673@nvidia.com>
 <2d08af18-d7c0-ead7-31b5-104a4f181b8c@nvidia.com> <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
In-Reply-To: <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 25 Apr 2023 16:31:22 +0800
Message-ID: <CAHj4cs-Z=vDHM93bR=OQ=15D4S9bkq9+kEhUj8nQrEvnvHbPhg@mail.gmail.com>
Subject: Re: debugfs message during creation of the NVMeOf controller
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "alan.adamson@oracle.com" <alan.adamson@oracle.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_013143_963639_A6BD2540 
X-CRM114-Status: GOOD (  20.45  )
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

I also hit this issue on the latest linux-block/for-next with blktests nvme=
-tcp.


On Mon, Mar 27, 2023 at 1:32=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 3/26/23 16:48, Chaitanya Kulkarni wrote:
> > On 3/26/23 16:44, Chaitanya Kulkarni wrote:
> >> On 3/24/23 15:34, alan.adamson@oracle.com wrote:
> >>>
> >>> On 3/23/23 1:18 AM, Chaitanya Kulkarni wrote:
> >>>> Hi everyone,
> >>>>
> >>>> Whenever I create NVMeOF target controller using nvme-loop
> >>>> transport I'm getting following message:-
> >>>>
> >>>> [18318.052193] debugfs: Directory 'nvme1' with parent '/' already
> >>>> present!
> >>>> [18318.053164] nvme1: failed to create debugfs attr
> >>>> [18318.053239] nvmet: creating nvm controller 1 for subsystem testnq=
n
> >>>> for NQN
> >>>> nqn.2014-08.org.nvmexpress:uuid:bb0a23ee-0be3-4285-8d8a-b47fcad11fe1=
.
> >>>> [18318.053369] nvme nvme1: creating 48 I/O queues.
> >>>> [18318.058812] nvme nvme1: new ctrl: "testnqn"
> >>>>
> >>>> It is certainly coming from
> >>>> host/fault_inject.c:nvme_fault_inject_init().
> >>>>
> >>>> any idea about this ?
> >>>>
> >>> I may have seen this before, but I can't seem to reproduce it. Can yo=
u
> >>>
> >>> provide the script the creates the targets?
> >>>
> >>> Alan
> >>>
> >>
> >> with latest pull on the nvme-6.4 the message is gone.
> >> It was coming from blktests.
> >>
> >> -ck
> >>
> >>
> > sorry I take that back, the message is still coming but now only for
> > testcase 045 in nvme category in blktest, and its 100% repro:-
> >
> > blktests (master) # ./check nvme/045
> > nvme/045 (Test re-authentication) [passed]
> >     runtime  3.979s  ...  3.906s
> > blktests (master) # dmesg  -c
> > [  735.980552] run blktests nvme/045 at 2023-03-26 16:46:36
> > [  736.007927] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > *[  736.021838] debugfs: Directory 'nvme1' with parent '/' already
> > present!*
> > [  736.023130] nvme1: failed to create debugfs attr
> > [  736.025394] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:aa415685-2775-415b-820f-192873a29f17
> > with DH-HMAC-CHAP.
> > [  736.034222] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  736.034227] nvme nvme1: qid 0: controller authenticated
> > [  736.034275] nvme nvme1: qid 0: authenticated
> > [  736.034459] nvme nvme1: creating 48 I/O queues.
> > [  736.439534] nvme nvme1: new ctrl: "blktests-subsystem-1"
> > [  737.478680] nvme nvme1: re-authenticating controller
> > [  737.487865] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  737.487872] nvme nvme1: qid 0: controller authenticated
> > [  737.512037] nvme nvme1: re-authenticating controller
> > [  737.517684] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  737.517689] nvme nvme1: qid 0: controller authenticated
> > [  737.538995] nvme nvme1: re-authenticating controller
> > [  737.544676] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  737.544680] nvme nvme1: qid 0: controller authenticated
> > [  737.575276] nvme nvme1: re-authenticating controller
> > [  737.742283] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  737.742290] nvme nvme1: qid 0: controller authenticated
> > [  738.058253] nvme nvme1: re-authenticating controller
> > [  738.198552] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  738.198558] nvme nvme1: qid 0: controller authenticated
> > [  739.541920] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> > blktests (master) # ./check nvme/045
> > nvme/045 (Test re-authentication) [passed]
> >     runtime  3.906s  ...  3.891s
> > blktests (master) # dmesg  -c
> > [  748.692757] run blktests nvme/045 at 2023-03-26 16:46:49
> > [  748.720701] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > *[  748.734004] debugfs: Directory 'nvme1' with parent '/' already
> > present!*
> > [  748.735247] nvme1: failed to create debugfs attr
> > [  748.737923] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:f58ec6ca-076c-49a7-8644-344dc03164f6
> > with DH-HMAC-CHAP.
> > [  748.747012] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  748.747018] nvme nvme1: qid 0: controller authenticated
> > [  748.747076] nvme nvme1: qid 0: authenticated
> > [  748.747328] nvme nvme1: creating 48 I/O queues.
> > [  749.157989] nvme nvme1: new ctrl: "blktests-subsystem-1"
> > [  750.194726] nvme nvme1: re-authenticating controller
> > [  750.205283] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  750.205291] nvme nvme1: qid 0: controller authenticated
> > [  750.226349] nvme nvme1: re-authenticating controller
> > [  750.232060] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  750.232071] nvme nvme1: qid 0: controller authenticated
> > [  750.253677] nvme nvme1: re-authenticating controller
> > [  750.259398] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  750.259404] nvme nvme1: qid 0: controller authenticated
> > [  750.280421] nvme nvme1: re-authenticating controller
> > [  750.451835] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  750.451843] nvme nvme1: qid 0: controller authenticated
> > [  750.736873] nvme nvme1: re-authenticating controller
> > [  750.875202] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  750.875208] nvme nvme1: qid 0: controller authenticated
> > [  752.233868] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> > blktests (master) # ./check nvme/045
> > nvme/045 (Test re-authentication) [passed]
> >     runtime  3.891s  ...  3.927s
> > blktests (master) # dmesg  -c
> > [  756.082248] run blktests nvme/045 at 2023-03-26 16:46:56
> > [  756.107701] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > *[  756.120529] debugfs: Directory 'nvme1' with parent '/' already
> > present!*
> > [  756.121856] nvme1: failed to create debugfs attr
> > [  756.124149] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:fbf72a00-890d-42a8-a2e9-fc1aa74b565d
> > with DH-HMAC-CHAP.
> > [  756.132708] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  756.132715] nvme nvme1: qid 0: controller authenticated
> > [  756.132756] nvme nvme1: qid 0: authenticated
> > [  756.132976] nvme nvme1: creating 48 I/O queues.
> > [  756.541422] nvme nvme1: new ctrl: "blktests-subsystem-1"
> > [  757.578586] nvme nvme1: re-authenticating controller
> > [  757.588968] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  757.588975] nvme nvme1: qid 0: controller authenticated
> > [  757.613757] nvme nvme1: re-authenticating controller
> > [  757.619329] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  757.619332] nvme nvme1: qid 0: controller authenticated
> > [  757.641450] nvme nvme1: re-authenticating controller
> > [  757.647279] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> > dhgroup ffdhe2048
> > [  757.647284] nvme nvme1: qid 0: controller authenticated
> > [  757.672671] nvme nvme1: re-authenticating controller
> > [  757.839209] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  757.839217] nvme nvme1: qid 0: controller authenticated
> > [  758.138670] nvme nvme1: re-authenticating controller
> > [  758.274816] nvme nvme1: qid 0: authenticated with hash hmac(sha512)
> > dhgroup ffdhe8192
> > [  758.274823] nvme nvme1: qid 0: controller authenticated
> > [  759.634987] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> > blktests (master) #
> >
> > -ck
> >
> >
> and its back again happening with all the testcases:-
>
> 20644.784334] debugfs: Directory 'nvme1' with parent '/' already present!
> [20644.785718] nvme1: failed to create debugfs attr
> [20644.785843] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20644.785947] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20644.786405] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20657.377878] run blktests nvme/018 at 2023-03-26 22:18:38
> [20657.392879] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20657.401812] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20657.403723] nvme1: failed to create debugfs attr
> [20657.403860] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20657.404093] nvme nvme1: creating 48 I/O queues.
> [20657.408942] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20658.446332] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20659.257678] run blktests nvme/019 at 2023-03-26 22:18:40
> [20659.270807] loop1: detected capacity change from 0 to 2097152
> [20659.284836] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20659.294208] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20659.295880] nvme1: failed to create debugfs attr
> [20659.296017] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20659.296175] nvme nvme1: creating 48 I/O queues.
> [20659.299767] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20660.329352] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on
> the char device!
> [20660.334061] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20661.191368] run blktests nvme/020 at 2023-03-26 22:18:41
> [20661.205624] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20661.216199] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20661.217246] nvme1: failed to create debugfs attr
> [20661.217361] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20661.217483] nvme nvme1: creating 48 I/O queues.
> [20661.221961] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20662.251556] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on
> the char device!
> [20662.254836] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20662.994186] run blktests nvme/021 at 2023-03-26 22:18:43
> [20663.009589] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20663.019226] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20663.019801] nvme1: failed to create debugfs attr
> [20663.019875] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20663.019977] nvme nvme1: creating 48 I/O queues.
> [20663.022963] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20664.057674] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20664.850874] run blktests nvme/022 at 2023-03-26 22:18:45
> [20664.865418] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20664.872636] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20664.874045] nvme1: failed to create debugfs attr
> [20664.874128] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20664.874308] nvme nvme1: creating 48 I/O queues.
> [20664.879089] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20665.907374] nvme nvme1: resetting controller
> [20666.523365] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20666.523443] nvme nvme1: creating 48 I/O queues.
> [20666.529276] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20666.561245] block nvme1n1: no available path - failing I/O
> [20666.561253] block nvme1n1: no available path - failing I/O
> [20666.561255] Buffer I/O error on dev nvme1n1, logical block 0, async
> page read
> [20667.360199] run blktests nvme/023 at 2023-03-26 22:18:48
> [20667.373763] loop1: detected capacity change from 0 to 2097152
> [20667.393400] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20667.404004] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20667.405127] nvme1: failed to create debugfs attr
> [20667.405248] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20667.405388] nvme nvme1: creating 48 I/O queues.
> [20667.408810] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20668.446287] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20669.020309] run blktests nvme/024 at 2023-03-26 22:18:49
> [20669.035692] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20669.043813] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20669.045067] nvme1: failed to create debugfs attr
> [20669.045208] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20669.045359] nvme nvme1: creating 48 I/O queues.
> [20669.048895] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20670.081426] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20670.574043] run blktests nvme/025 at 2023-03-26 22:18:51
> [20670.588725] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20670.599186] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20670.600439] nvme1: failed to create debugfs attr
> [20670.600544] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20670.601317] nvme nvme1: creating 48 I/O queues.
> [20670.605296] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20671.641710] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20672.237537] run blktests nvme/026 at 2023-03-26 22:18:53
> [20672.253805] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20672.264814] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20672.265933] nvme1: failed to create debugfs attr
> [20672.266072] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20672.266286] nvme nvme1: creating 48 I/O queues.
> [20672.270418] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20673.304111] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20673.857316] run blktests nvme/027 at 2023-03-26 22:18:54
> [20673.873541] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20673.883490] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20673.884711] nvme1: failed to create debugfs attr
> [20673.884825] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20673.884954] nvme nvme1: creating 48 I/O queues.
> [20673.888718] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20674.923949] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20675.486284] run blktests nvme/028 at 2023-03-26 22:18:56
> [20675.502113] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20675.512146] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20675.513108] nvme1: failed to create debugfs attr
> [20675.513192] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20675.513319] nvme nvme1: creating 48 I/O queues.
> [20675.517138] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20676.553741] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20677.064989] run blktests nvme/029 at 2023-03-26 22:18:57
> [20677.077651] loop1: detected capacity change from 0 to 2097152
> [20677.091348] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20677.101478] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20677.102595] nvme1: failed to create debugfs attr
> [20677.102682] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20677.102817] nvme nvme1: creating 48 I/O queues.
> [20677.106751] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20678.252072] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20678.822651] run blktests nvme/030 at 2023-03-26 22:18:59
> [20678.843012] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20678.851603] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20678.852585] nvme1: failed to create debugfs attr
> [20678.852676] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20678.852753] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20678.853100] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20678.892791] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
> [20678.902062] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20678.903143] nvme1: failed to create debugfs attr
> [20678.903243] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20678.903337] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20678.903812] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20678.930842] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20678.932021] nvme1: failed to create debugfs attr
> [20678.932127] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20678.932221] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20678.932658] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20678.962410] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20678.963429] nvme1: failed to create debugfs attr
> [20678.963509] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20678.963596] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20678.964061] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20679.017937] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20679.018690] nvme1: failed to create debugfs attr
> [20679.018777] nvmet: creating discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
> [20679.018855] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discover=
y"
> [20679.019235] nvme nvme1: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [20679.216119] run blktests nvme/031 at 2023-03-26 22:19:00
> [20679.228186] loop1: detected capacity change from 0 to 2097152
> [20679.241606] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> [20679.248382] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20679.249743] nvme1: failed to create debugfs attr
> [20679.249839] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-0 for NQN testhostnqn.
> [20679.250001] nvme nvme1: creating 48 I/O queues.
> [20679.253603] nvme nvme1: new ctrl: "blktests-subsystem-0"
> [20679.258027] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-0"
> [20679.258057] block nvme1n1: no available path - failing I/O
> [20679.258067] block nvme1n1: no available path - failing I/O
> [20679.258069] Buffer I/O error on dev nvme1n1, logical block 262143,
> async page read
> [20679.645411] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20679.652140] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20679.653278] nvme1: failed to create debugfs attr
> [20679.653357] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20679.653500] nvme nvme1: creating 48 I/O queues.
> [20679.657333] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20679.661393] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20679.661502] block nvme1n1: no available path - failing I/O
> [20679.661513] block nvme1n1: no available path - failing I/O
> [20679.661516] Buffer I/O error on dev nvme1n1, logical block 262128,
> async page read
> [20680.062365] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
> [20680.069809] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20680.070678] nvme1: failed to create debugfs attr
> [20680.070759] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-2 for NQN testhostnqn.
> [20680.070899] nvme nvme1: creating 48 I/O queues.
> [20680.075204] nvme nvme1: new ctrl: "blktests-subsystem-2"
> [20680.079372] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-2"
> [20680.080421] block nvme1n1: no available path - failing I/O
> [20680.080474] block nvme1n1: no available path - failing I/O
> [20680.080476] Buffer I/O error on dev nvme1n1, logical block 262128,
> async page read
> [20680.543317] nvmet: adding nsid 1 to subsystem blktests-subsystem-3
> [20680.552554] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20680.553317] nvme1: failed to create debugfs attr
> [20680.553409] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-3 for NQN testhostnqn.
> [20680.553542] nvme nvme1: creating 48 I/O queues.
> [20680.557566] nvme nvme1: new ctrl: "blktests-subsystem-3"
> [20680.561332] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-3"
> [20680.562464] block nvme1n1: no available path - failing I/O
> [20680.562477] block nvme1n1: no available path - failing I/O
> [20680.562479] Buffer I/O error on dev nvme1n1, logical block 262128,
> async page read
> [20680.992208] nvmet: adding nsid 1 to subsystem blktests-subsystem-4
> [20681.000542] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20681.004782] nvme1: failed to create debugfs attr
> [20681.004898] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-4 for NQN testhostnqn.
> [20681.005101] nvme nvme1: creating 48 I/O queues.
> [20681.009392] nvme nvme1: new ctrl: "blktests-subsystem-4"
> [20681.013446] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-4"
> [20681.013491] block nvme1n1: no available path - failing I/O
> [20681.013498] block nvme1n1: no available path - failing I/O
> [20681.013500] Buffer I/O error on dev nvme1n1, logical block 262142,
> async page read
> [20681.607008] nvmet: adding nsid 1 to subsystem blktests-subsystem-5
> [20681.614267] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20681.615499] nvme1: failed to create debugfs attr
> [20681.615621] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-5 for NQN testhostnqn.
> [20681.615774] nvme nvme1: creating 48 I/O queues.
> [20681.619802] nvme nvme1: new ctrl: "blktests-subsystem-5"
> [20681.623966] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-5"
> [20681.623994] Buffer I/O error on dev nvme1n1, logical block 262059,
> async page read
> [20682.112446] nvmet: adding nsid 1 to subsystem blktests-subsystem-6
> [20682.120717] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20682.121717] nvme1: failed to create debugfs attr
> [20682.121804] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-6 for NQN testhostnqn.
> [20682.121962] nvme nvme1: creating 48 I/O queues.
> [20682.126046] nvme nvme1: new ctrl: "blktests-subsystem-6"
> [20682.130240] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-6"
> [20682.130272] Buffer I/O error on dev nvme1n1, logical block 262052,
> async page read
> [20682.513159] nvmet: adding nsid 1 to subsystem blktests-subsystem-7
> [20682.520677] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20682.521649] nvme1: failed to create debugfs attr
> [20682.521739] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-7 for NQN testhostnqn.
> [20682.521881] nvme nvme1: creating 48 I/O queues.
> [20682.525818] nvme nvme1: new ctrl: "blktests-subsystem-7"
> [20682.530238] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-7"
> [20682.530326] Buffer I/O error on dev nvme1n1, logical block 65, async
> page read
> [20682.969916] nvmet: adding nsid 1 to subsystem blktests-subsystem-8
> [20682.977931] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20682.979166] nvme1: failed to create debugfs attr
> [20682.979281] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-8 for NQN testhostnqn.
> [20682.979437] nvme nvme1: creating 48 I/O queues.
> [20682.983334] nvme nvme1: new ctrl: "blktests-subsystem-8"
> [20682.987759] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-8"
> [20682.987909] Buffer I/O error on dev nvme1n1, logical block 262128,
> async page read
> [20683.423737] nvmet: adding nsid 1 to subsystem blktests-subsystem-9
> [20683.431841] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20683.432829] nvme1: failed to create debugfs attr
> [20683.432913] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-9 for NQN testhostnqn.
> [20683.433040] nvme nvme1: creating 48 I/O queues.
> [20683.437306] nvme nvme1: new ctrl: "blktests-subsystem-9"
> [20683.441443] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-9"
> [20683.441557] Buffer I/O error on dev nvme1n1, logical block 2, async
> page read
> [20684.084636] run blktests nvme/038 at 2023-03-26 22:19:04
> [20684.308070] run blktests nvme/040 at 2023-03-26 22:19:05
> [20684.322637] loop1: detected capacity change from 0 to 2097152
> [20684.334817] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20684.343259] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20684.344122] nvme1: failed to create debugfs attr
> [20684.344219] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20684.344355] nvme nvme1: creating 48 I/O queues.
> [20684.347982] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20690.389949] block nvme1n1: no usable path - requeuing I/O
> [20690.389951] block nvme1n1: no usable path - requeuing I/O
> [20690.389952] block nvme1n1: no usable path - requeuing I/O
> [20690.389960] block nvme1n1: no usable path - requeuing I/O
> [20690.389967] block nvme1n1: no usable path - requeuing I/O
> [20690.389968] block nvme1n1: no usable path - requeuing I/O
> [20690.389967] block nvme1n1: no usable path - requeuing I/O
> [20690.389971] block nvme1n1: no usable path - requeuing I/O
> [20690.389975] block nvme1n1: no usable path - requeuing I/O
> [20690.389980] block nvme1n1: no usable path - requeuing I/O
> [20690.798785] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN testhostnqn.
> [20690.798862] nvme nvme1: creating 48 I/O queues.
> [20691.804912] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20691.805035] nvme_ns_head_submit_bio: 15 callbacks suppressed
> [20691.805039] block nvme1n1: no available path - failing I/O
> [20691.805042] block nvme1n1: no available path - failing I/O
> [20691.805044] block nvme1n1: no available path - failing I/O
> [20691.805048] block nvme1n1: no available path - failing I/O
> [20691.805058] block nvme1n1: no available path - failing I/O
> [20691.805068] block nvme1n1: no available path - failing I/O
> [20691.805078] block nvme1n1: no available path - failing I/O
> [20691.805081] block nvme1n1: no available path - failing I/O
> [20691.805084] block nvme1n1: no available path - failing I/O
> [20691.805144] block nvme1n1: no available path - failing I/O
> [20692.356673] run blktests nvme/041 at 2023-03-26 22:19:13
> [20692.377677] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20692.392652] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20692.394028] nvme1: failed to create debugfs attr
> [20692.394166] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:27bb0b7a-36b7-452b-826a-9abe11801e78
> with DH-HMAC-CHAP.
> [20692.394181] nvme nvme1: qid 0: no key
> [20692.394185] nvme nvme1: qid 0: authentication setup failed
> [20692.419213] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20692.420148] nvme1: failed to create debugfs attr
> [20692.420261] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:27bb0b7a-36b7-452b-826a-9abe11801e78
> with DH-HMAC-CHAP.
> [20692.426815] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20692.426842] nvme nvme1: qid 0: authenticated
> [20692.426986] nvme nvme1: creating 48 I/O queues.
> [20692.709018] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20692.729362] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20693.280677] run blktests nvme/042 at 2023-03-26 22:19:14
> [20693.298789] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20693.316242] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20693.316973] nvme1: failed to create debugfs attr
> [20693.317073] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20693.323767] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20693.323790] nvme nvme1: qid 0: authenticated
> [20693.323915] nvme nvme1: creating 48 I/O queues.
> [20693.610683] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20693.628467] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20693.994652] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20693.995222] nvme1: failed to create debugfs attr
> [20693.995324] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20694.000899] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20694.000925] nvme nvme1: qid 0: authenticated
> [20694.001053] nvme nvme1: creating 48 I/O queues.
> [20694.279725] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20694.296494] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20694.663958] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20694.664799] nvme1: failed to create debugfs attr
> [20694.664891] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20694.671316] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20694.671340] nvme nvme1: qid 0: authenticated
> [20694.671476] nvme nvme1: creating 48 I/O queues.
> [20694.958326] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20694.976780] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20695.372799] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20695.373745] nvme1: failed to create debugfs attr
> [20695.373856] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20695.379912] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20695.379988] nvme nvme1: qid 0: authenticated
> [20695.380187] nvme nvme1: creating 48 I/O queues.
> [20695.663955] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20695.683205] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20696.045862] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20696.046645] nvme1: failed to create debugfs attr
> [20696.046743] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20696.053115] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20696.053143] nvme nvme1: qid 0: authenticated
> [20696.053275] nvme nvme1: creating 48 I/O queues.
> [20696.335944] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20696.354023] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20696.751270] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20696.752126] nvme1: failed to create debugfs attr
> [20696.752231] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20696.758629] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20696.758647] nvme nvme1: qid 0: authenticated
> [20696.758770] nvme nvme1: creating 48 I/O queues.
> [20697.049246] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20697.067503] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20697.429525] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20697.430557] nvme1: failed to create debugfs attr
> [20697.430678] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:7af96074-81bd-4263-84c1-87553e27eeab
> with DH-HMAC-CHAP.
> [20697.437109] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup null
> [20697.437147] nvme nvme1: qid 0: authenticated
> [20697.437367] nvme nvme1: creating 48 I/O queues.
> [20697.722852] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20697.741643] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20698.289161] run blktests nvme/043 at 2023-03-26 22:19:19
> [20698.305987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20698.319754] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20698.321147] nvme1: failed to create debugfs attr
> [20698.321260] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20698.321426] nvme nvme1: creating 48 I/O queues.
> [20698.325643] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20698.342940] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20698.709971] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20698.711496] nvme1: failed to create debugfs attr
> [20698.711606] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20698.711774] nvme nvme1: creating 48 I/O queues.
> [20698.715683] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20698.733593] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20699.083391] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20699.084185] nvme1: failed to create debugfs attr
> [20699.084286] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20699.084412] nvme nvme1: creating 48 I/O queues.
> [20699.089405] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20699.105364] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20699.469994] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20699.471353] nvme1: failed to create debugfs attr
> [20699.473627] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20699.473879] nvme nvme1: creating 48 I/O queues.
> [20699.478098] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20699.498489] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20699.859234] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20699.860696] nvme1: failed to create debugfs attr
> [20699.865456] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20699.865673] nvme nvme1: creating 48 I/O queues.
> [20699.870227] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20699.889141] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20700.253779] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20700.254606] nvme1: failed to create debugfs attr
> [20700.266540] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20700.266852] nvme nvme1: creating 48 I/O queues.
> [20700.271452] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20700.290526] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20700.662981] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20700.665008] nvme1: failed to create debugfs attr
> [20700.687205] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20700.687443] nvme nvme1: creating 48 I/O queues.
> [20700.692174] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20700.706675] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20701.068216] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20701.069366] nvme1: failed to create debugfs attr
> [20701.104464] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:eb0ec0a8-631e-41df-9b20-54390bbbc7b1.
> [20701.104610] nvme nvme1: creating 48 I/O queues.
> [20701.108663] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20701.126594] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20701.657146] run blktests nvme/044 at 2023-03-26 22:19:22
> [20701.683714] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20701.698794] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20701.699592] nvme1: failed to create debugfs attr
> [20701.701834] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:176d62e1-c34f-47bf-85e4-59a78f8f5e8c
> with DH-HMAC-CHAP.
> [20701.711538] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup ffdhe2048
> [20701.711572] nvme nvme1: qid 0: authenticated
> [20701.711715] nvme nvme1: creating 48 I/O queues.
> [20702.115744] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20702.133057] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20702.498056] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20702.498978] nvme1: failed to create debugfs attr
> [20702.501210] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:176d62e1-c34f-47bf-85e4-59a78f8f5e8c
> with DH-HMAC-CHAP.
> [20702.510942] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup ffdhe2048
> [20702.510947] nvme nvme1: qid 0: controller authentication failed
> [20702.510989] nvmet: ctrl 1 fatal error occurred!
> [20702.511555] nvme nvme1: qid 0: authentication failed
> [20702.539757] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20702.540257] nvme1: failed to create debugfs attr
> [20702.541773] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:176d62e1-c34f-47bf-85e4-59a78f8f5e8c
> with DH-HMAC-CHAP.
> [20702.551062] nvme nvme1: qid 0: authenticated with hash hmac(sha256)
> dhgroup ffdhe2048
> [20702.551067] nvme nvme1: qid 0: controller authenticated
> [20702.551112] nvme nvme1: qid 0: authenticated
> [20702.551310] nvme nvme1: creating 48 I/O queues.
> [20702.973433] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [20702.991245] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [20703.356942] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20703.357989] nvme1: failed to create debugfs attr
> [20703.358001] key crc mismatch (key 021fa81b, crc e08833d2)
> [20703.539426] run blktests nvme/045 at 2023-03-26 22:19:24
> [20703.566746] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [20703.579992] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [20703.581398] nvme1: failed to create debugfs attr
> [20703.584688] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem



--
Best Regards,
  Yi Zhang


