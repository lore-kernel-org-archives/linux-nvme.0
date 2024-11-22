Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE2E65D29
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 05:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqLIUso4tQH5JQgm1n9hufVV38KZMRy/YQqOEuyyBVo=; b=YcjgEGjFIHb8vO7lA3yPOi+zhv
	R6ZAkMNBW51xM2NMq+pESM7zpF2LtVN3jOV3z4oijNJS7PBo34DqNfwufCx10aTCXDYAzoQvPNGrA
	lzPjjZwk58qPZNZAExA447e7jLBLCxImfVNJ2BNaH9J2F9uRNUZm1J1LJJzYCLgDl8Nwc8jSYZtVC
	Id7qD22xxZjo6UsBbMDgqe7eEtWnHiekbfGbfpKwYFWwjuvif2ImKU6ILZ+vxHBOgaJqJDs5vfKF5
	9PsBW07hBiaMbg/o1o+BU36a50EAeLxxpUAslhBHucxXWcwB5jdT1VpB4SWShExYnIniPYwFLhahX
	Qjli7NrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEMNF-00000001ftO-3WsD;
	Fri, 22 Nov 2024 05:38:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEMNB-00000001fsp-2jj4
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 05:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732253906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqLIUso4tQH5JQgm1n9hufVV38KZMRy/YQqOEuyyBVo=;
	b=J5Zozu7XglA1/dFhjnTF2dSRbyyxylPy0mT+27crTZvfBkqszAPYzXSN1w58Q7KKJETqKo
	lO3SeovtYA46yE7LvgRa/gMfVSSVNu8fA4Ua/A67Tt0WYBibSnNnM8qFpcEwI9BCrPtppC
	WxXbPrbRFlpFDnffpY0kBkWLCbHatyQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119--B_Bw_e3NFyxtGppQyYN_w-1; Fri, 22 Nov 2024 00:38:24 -0500
X-MC-Unique: -B_Bw_e3NFyxtGppQyYN_w-1
X-Mimecast-MFC-AGG-ID: -B_Bw_e3NFyxtGppQyYN_w
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb58d1da8eso11066051fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 21:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732253903; x=1732858703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqLIUso4tQH5JQgm1n9hufVV38KZMRy/YQqOEuyyBVo=;
        b=ZHt8OG+ZlgJdycEHr/2u7yWbKIurnIGODS/tAiIc2A/+5PACKelz3I60jqBgpju3jb
         rIBzlWRPNPZopMdedl4Gh/doXRMtogyKMag/xlllOPNykrmhKzyqNgFNT4o9CmlIusqG
         kT4MgYVZmZaTpgdTDNzE8fKkZPUxfrViPUFLx+IurCmFxYK5PuMV4fSOsar2JR0+EgIi
         70ltiN9EI5tcCOlD6lzpc4mpecF99xViFhyUmyiAhADRHRk57zPvhTsm55R/m1TyEdzf
         jhbcc+WahvrI2aeYmBfopn0n6F/s+lEjB3XzfcUf886poUwjfDVnVS1xgoOxZtQD+OZ/
         uF3Q==
X-Gm-Message-State: AOJu0YykeUam0/qoHEQhvS6uTQPitjIzk3baGP6kcez912Q+nyx3c+sA
	I87YaXu6K00bqX9PAkZo8UUYXSNdwqzUsQFftiEqZkKcRGoqgvx5Tk8c0jCIq4nDJj6vjDqN3TK
	YLpP+akmXt8LIKRPwah2/FGHiVeriOxkhD/SzwFAas93eoPJOj+8O01p+BQT8xrF6Pb0NWr3A+C
	X87fs2UwOdMALsfDAEn2K17vq5aHSVvEGWdyOylOc=
X-Gm-Gg: ASbGnctoMJSLNCX+oQfj6wPR+4qFl13ecyvoHlqx8zK9Bw4nmw38ZlOkvF2V9bxueA5
	zFWKnDhlsNvHEy0UCTijAtswbVXI2Oj3/
X-Received: by 2002:a2e:99cc:0:b0:2ff:a8e9:a648 with SMTP id 38308e7fff4ca-2ffa8e9a718mr1387141fa.9.1732253903182;
        Thu, 21 Nov 2024 21:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyiHYbnShueV2QlXyoqutfmjwmFNVa31kdxiDclSeTsg/UZjBfpV4Xcv8hm7EQFaLHVWAq1LagBSGG3TA0lco=
X-Received: by 2002:a2e:99cc:0:b0:2ff:a8e9:a648 with SMTP id
 38308e7fff4ca-2ffa8e9a718mr1387101fa.9.1732253902828; Thu, 21 Nov 2024
 21:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
In-Reply-To: <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 22 Nov 2024 13:38:11 +0800
Message-ID: <CAHj4cs_nbdbzo_Rc+LDp9NS_Ffi1FTmk-9XKw-6TAav9LM4__Q@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E9lOfCGBIwOMZ3F4EbBPks00kUuAQwjpu0PHXWnFO2I_1732253903
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_213829_799659_040247BD 
X-CRM114-Status: GOOD (  25.63  )
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

On Thu, Nov 21, 2024 at 7:10=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 11/21/24 08:28, Yi Zhang wrote:
> > On Wed, Nov 20, 2024 at 10:07=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.=
com> wrote:
> >>
> >>
> >>
> >> On 11/19/24 16:34, Yi Zhang wrote:
> >>> Hello
> >>>
> >>> CKI recently reported the blktests nvme/029 failed[1] on the
> >>> linux-block/for-next, and bisect shows it was introduced from [2],
> >>> please help check it and let me know if you need any info/test for it=
, thanks.
> >>>
> >>> [1]
> >>> nvme/029 (tr=3Dloop) (test userspace IO via nvme-cli read/write
> >>> interface) [failed]
> >>>     runtime    ...  1.568s
> >>>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
> >>>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
> >>> 2024-11-19 10:55:13.615939542 +0000
> >>>     @@ -1,2 +1,8 @@
> >>>      Running nvme/029
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     +FAIL
> >>>     ...
> >>>     (Run 'diff -u tests/nvme/029.out
> >>> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
> >>> entire diff)
> >>> [2]
> >>> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
> >>>
> >>>
> >>> --
> >>> Best Regards,
> >>>   Yi Zhang
> >>>
> >>>
> >> I couldn't reproduce it even after running nvme/029 in a loop
> >> for multiple times. Are you following any specific steps to
> >> recreate it?
> >
> > From the reproduced data[1], seems it only reproduced on x86_64 and
> > aarch64, and from the 029.full[2], we can see the failure comes from
> > the "nvme write" cmd.
> > [1]
> > https://datawarehouse.cki-project.org/issue/3263
> > [2]
> > # cat results/nodev_tr_loop/nvme/029.full
> > Reference tag larger than allowed by PIF
> > NQN:blktests-subsystem-1 disconnected 1 controller(s)
> > disconnected 1 controller(s)
> >
> > I also attached the kernel config file in case you want to try it, than=
ks.
> >
> Thanks for the additional information!
> Now I could understand the issue and have a probable fix. If possible, ca=
n you try
> the below patch and check if it help resolve this issue?

Yes, the issue was fixed now.

>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 934b401fbc2f..7a8256ae3085 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct =
nvmet_req *req)
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       void *zero_buf;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +       zero_buf =3D __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> +       status =3D nvmet_copy_to_sgl(req, 0, zero_buf,
>                                    NVME_IDENTIFY_DATA_SIZE);
>  out:
>         nvmet_req_complete(req, status);
>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang


