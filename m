Return-Path: <SRS0=5HbI=KR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5977C04FF3
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 00:13:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6339A613D1
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 00:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6339A613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvUzy3Cjfqd3H+jXSgkG/+ftnBB8JlIIB6zrVlmDLl4=; b=YUQGYkW8U4UBxMjFCnWkPIeOsT
	OM3+Q4qKaCAbsO+oX1qEXzF9hUhbkrV/v2rR/xqj58oHixEp86oRSxYj0+sjEVud2ufgPMXltX35h
	S/F+JmAvjQqmOCHEnV/iKYnd/KnPMLRM+ngOP/I5lKiYLpA56G2FwVi+mr/rQHfIw1FXhjA8JeJ0F
	BMqa2yYuAiS6A2UVCiCCG0WJCZWtJGLgr1Yp1SSGgzxlCZbSO23tO/mXyHlFLtRFnDhv+dnOQLFib
	wzk115ELC9SEMgYoQ2CrC1JfyXsSjbK5RqXoAaMNInprjaZubAOpyVCN12QeVpJRCxfFBxq7MHMrC
	mXpz5jRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkFG3-001SMs-CA; Sat, 22 May 2021 00:12:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkFFy-001SLo-5U
 for linux-nvme@desiato.infradead.org; Sat, 22 May 2021 00:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=c+odWPSl3v3mfZWgIWNqi4kiLbmQLAmKL0MpUDMHdyQ=; b=wA9FqjY37nUmyeMogJ5vYXEGR7
 qj753Ns32xQv6VQCiFUX0M5Vp0LhbETyz16T9u6MoC0i7Ur1ZssStkotg63IOZr6rZ2r28/coVP3A
 zEPx511XkQCmzZNGKHi3+wLUMp/xzFoGGJNKNO/yPeF3bGaglN9zoSm+t6ZU/TqPbOvDnCE41vHOK
 bFe+HzYEYFcWbwFwm1GW3BPnQcZitYfcls1Q0nB1yb6C/SDId5Hp4iy3u56xS9lR0OzoUOJRtvPRq
 z8K5DWOOaYqq+iRcWijpXCkdieislwLJ+cq0EcQcAIMIDEPKNxBgHHNNo1CRPAfIPDcKbQrh303vW
 iw4pYBuw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkFFu-00HVf2-KJ
 for linux-nvme@lists.infradead.org; Sat, 22 May 2021 00:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621642356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+odWPSl3v3mfZWgIWNqi4kiLbmQLAmKL0MpUDMHdyQ=;
 b=aB495qPDdl3UBoLe0fzVTydcQNTnYURfZgYBVtNeq21PGpDs+oSxyayFgPLe7QxTue937i
 +JXBK8Xk6Zjkjup0vp2pVK/VTLdEik1ET43bGUPALgqX3MzodMAHW1zeulOVbnKtGnHRd5
 TFBagpw2XVHWKAkQ6UsyRw4923uwdD8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-3y5BEbYUPCiNlbEoUMm1MA-1; Fri, 21 May 2021 20:12:35 -0400
X-MC-Unique: 3y5BEbYUPCiNlbEoUMm1MA-1
Received: by mail-yb1-f199.google.com with SMTP id
 k34-20020a25b2a20000b02905149e86803eso14676009ybj.9
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 17:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+odWPSl3v3mfZWgIWNqi4kiLbmQLAmKL0MpUDMHdyQ=;
 b=ahxEUfFfz+0N9ps/mEBX6SvfS/EJ0NwOE1p3N6ies3avBQw9vKy/THYzh34brzv9P0
 ei02xadbBQZ2geSBvQSwhfV/q7XMwi7lQiTcLeWgj9A4ir6VGvqzPEClcCEuI2eveZe5
 UM15vxpb1CpSqH2cn+yTFIDtuRojoZ/5uUCXl4tpY74t2OYfMVq9pM26DWr2jd1dpB8o
 0KKXLhrC0vTBl4m9vC5hybhewSd+fY+G0pPfHZpWZ28dewdvD07ES0iUJYT9F+g2e+nM
 qJJWyV9QSlz3o8BogL12yqSsh1BVh0eBsVXxJtFteEimnVg46OMkUuPdsa9HIA98oqVC
 PMDg==
X-Gm-Message-State: AOAM532GjKs7H+BnHx0Bhpsn1xt2wgVeFlRontkX2jWuTUU2eteOAFpJ
 AR5NsPls/2U1nR4NFrERW3ktiS2ptdtXT/rb+/4e3xprdDIehArUop1X77czGaGHVSLpDmOXimM
 WSRgy+rlBPeipfUPHqpCjRrRu2jECkeM/Z4IYXTnMW3Y=
X-Received: by 2002:a25:545:: with SMTP id 66mr18369515ybf.251.1621642354715; 
 Fri, 21 May 2021 17:12:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4GA8HzaI+pUON6BY+Ygi9YkU4/okMiv4ZllCUPu7jOfpfPmoDMEdf6RpPLGeYOBfsN4AKrzLeS+3p5+x6xHM=
X-Received: by 2002:a25:545:: with SMTP id 66mr18369488ybf.251.1621642354484; 
 Fri, 21 May 2021 17:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
 <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
 <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
 <CAHj4cs_NVzgA8=gC9MKSakdDgBR4ghLQv6H8tw_BgxUUvA+Uew@mail.gmail.com>
 <d0bd7905-9741-012f-ff7a-f211d8170088@suse.de>
 <CAHj4cs8XEVdZKK1J0GHZxEzBkApOaO9T-uONGiimM-_qR8Kjaw@mail.gmail.com>
 <3cce5b25-c8f3-536b-6285-9ce5aab1572f@grimberg.me>
In-Reply-To: <3cce5b25-c8f3-536b-6285-9ce5aab1572f@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 22 May 2021 08:12:22 +0800
Message-ID: <CAHj4cs9p0ckNUT7jvcGs-u=sbbX6U5787smgeYrUE+ZM_vk6tg@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 skt-results-master@redhat.com, Bruno Goncalves <bgoncalv@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_171238_869100_ADAA24A0 
X-CRM114-Status: GOOD (  29.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 22, 2021 at 2:19 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> What about this?
> >
> > Hi Hannes
> > With this patch, no WARNNING/NULL pointer this time, but still have
> > 'keep-alive timer expired' and reset failure issue, here is the full
> > log:
> >
> > # ./check nvme/022
> > nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [failed]
> >      runtime  10.646s  ...  11.087s
> >      --- tests/nvme/022.out 2021-05-20 20:16:31.384068807 -0400
> >      +++ /root/blktests/results/nodev/nvme/022.out.bad 2021-05-20
> > 20:24:27.874250466 -0400
> >      @@ -1,4 +1,5 @@
> >       Running nvme/022
> >       91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >       uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >      +ERROR: reset failed
> >       Test complete
> > # cat results/nodev/nvme/022.full
> > Reset: Network dropped connection on reset
> > NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >
> > [37353.068448] run blktests nvme/022 at 2021-05-20 20:24:16
> > [37353.146301] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [37353.161765] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:6a70d220-bfde-1000-03ce-ea40b8730904.
> > [37353.175796] nvme nvme0: creating 128 I/O queues.
> > [37353.189734] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > [37354.216686] nvme nvme0: resetting controller
> > [37363.270607] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [37363.276521] nvmet: ctrl 1 fatal error occurred!
> > [37363.281058] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> >
> > # ./check nvme/021
> > nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
> >      runtime  10.958s  ...  11.382s
> > # dmesg
> > [38142.862881] run blktests nvme/021 at 2021-05-20 20:37:26
> > [38142.941038] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [38142.956621] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:6a70d220-bfde-1000-03ce-ea40b8730904.
> > [38142.970524] nvme nvme0: creating 128 I/O queues.
> > [38142.984356] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > [38144.014601] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > [38153.030107] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [38153.036018] nvmet: ctrl 1 fatal error occurred!
>
> I think that the main reason is that there are 128 queues that are being
> created, and during that time the keep alive timer ends up expiring as
> it is shorter (used to be 15 seconds, now 5 by default).
>
> nvmet only stops the keep-alive timer when the controller is freed,
> which is pretty late in the sequence.. The problem is that it needs to
> be this way because if we shut it down sooner a host can die in the
> middle of a teardown sequence and we still need to detect that and
> cleanup ourselves. But maybe we can mod the keep-alive timer for
> every queue we delete, just in the case the host is not deleting
> fast enough?
>
> Ming, does this solve the issue you are seeing?

Hi Sagi
The issue was fixed by this patch. :)

> --
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 1853db38b682..f0715e9a4a9c 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -804,6 +804,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>          percpu_ref_exit(&sq->ref);
>
>          if (ctrl) {
> +               ctrl->cmd_seen = true;
>                  nvmet_ctrl_put(ctrl);
>                  sq->ctrl = NULL; /* allows reusing the queue later */
>          }
> --
>
> We probably need to rename cmd_seen to extend_tbkas (extend traffic
> based keep-alive).
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
