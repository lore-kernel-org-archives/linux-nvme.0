Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E1C369A2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1jCfji+oTpTQEhNT+Xk4RwpldLzt25kGtRohlOTdQGc=; b=jH5+e33nYpxfPY4E1iqwK8+JOd
	mlOxpEttLhOjBcadmmdNLp+ieOArfQWqdD5BHCr6+S/oD7PVNmLx+y+w/FF25HXiDNLW9be2ILVUf
	pRMSDK9wr924N9fG5KK7G/+EK24RfyFCbs68E7FHHPAb7CBP7W2Rgdt72wteUPhFoKBKkvAu3zpsQ
	RUIj+4Y8fvTzAvxOGELVBzlf06FtzLMqf1T4nnKU5VztHEzd3d2mtymBbwkJCEC94MaDace7l4jIL
	fpgsqUcsCjH8iV57U+xaLRcbPQRr07eq4+WrOQIB/i2nOkOfLYhZCQMU8+svMiBcCCiac/hI4N4OW
	MZ6SQSzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mSe-00000009aIr-1Qla;
	Thu, 10 Apr 2025 07:36:32 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2lsw-00000009SDJ-13Ki
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 06:59:39 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-7020d8b110aso3908717b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Apr 2025 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268377; x=1744873177; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jCfji+oTpTQEhNT+Xk4RwpldLzt25kGtRohlOTdQGc=;
        b=e4oKgggRV7LJ/WfE+vCfNYjZngYljHo41Jj8CWuDz65PhQJADFQUz+duL2NXNmQnWL
         MS4Bn4+ZifVnQw8iT5w+T7ty0hDAhWjJuyPS6bFnRrZBoSe6y3CwhKE4Tpp19czQ5qNH
         KTr3QYJWXjnysi0VMbFGktX1ryNop8xpyRWYu6E1wO269cSGxilFTlMSYxOtVkPYql5z
         5R1n/NrCD0vwO50F9P7iI3tLLVzeQiiQROiXiyTV5bXXe8W7iV3MBOAM0V/J7n6NEqW+
         YSztszBVyWVtj+WwOLbLZAtjdc/KmJAYmYN/HZGezsgHTSUC83J2S5ah+z64vc8ydzsM
         Eu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268377; x=1744873177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jCfji+oTpTQEhNT+Xk4RwpldLzt25kGtRohlOTdQGc=;
        b=LpuG2Jd9YGnzBZpdYpRIYKu8NmykiyITknRi4GAhVdIjfRHv6JbobuX915eQMVQ1Mn
         MZ9uGBl5YmnAdHqPnMBW4WB4acUtB9bBIiV5YfCYb0ePG3xO5we8Yrn1+hgej0BchnQ5
         Cve1PDyy2wWZwTeHQrhvbGtUpl4L+L7YKOVQ0gTOkPgy1ZS5SFfIigDsLOd+2+ZwSmu2
         3VNBxnoI8D0sF/qevRh4deHC7jPH0TIv/Ef7bQr+a5b5wZkz8zubv9Vf46z1MyA8Qe7N
         w0OUPermJEM2cV5FwSvtraM6usYkXhA1hzM4562ijICtgtWN+XSfzpDlI7BeSm3g1xNr
         yipA==
X-Forwarded-Encrypted: i=1; AJvYcCXkXSKxn6ZS+Qkv7I471PtYn3fAKThrYFwq//77xCScofUxckq6ACml5jRjmY90c/7U4jD4Pk1yYoxp@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1BFtY6Tf+q36Ih28wZJr9FC9Xz/MgyEipOi16HAlB64uSaPod
	ef64OtUIE0dolCvtNHh7XymFgfnwKSQWIx8AYtGFRGss7qq52qoSmG4iIkASfibb/8nURw3eioJ
	xaTWdl2i1kcFdv2Mb+jrpgQ2UdpQ=
X-Gm-Gg: ASbGncu5i3nq88F+OTGVZLBJ/HcOilocpIJPux43qLHHKUmKSQo3g7zE8xzvwHOVq5s
	3M7O97Mo92doqI4cfJ/0mxaN99YyLoZRcN4ZQGyM74z9lIkoF2AUEgqR/eSKRx47wz1XWapjn6A
	ZTSW1BGPubgt4r5L30dLdTK+M=
X-Google-Smtp-Source: AGHT+IHNJkihfPKETQR6VLGD5Upe00vZyk6MVsz3Wc4VC4Rdk3WxESkUe0YvtZb480VM7kNU/XNnFHvmzLQuRPcBVTk=
X-Received: by 2002:a05:690c:7204:b0:6fb:1e5a:fcd8 with SMTP id
 00721157ae682-7054a13e73amr27085097b3.28.1744268377081; Wed, 09 Apr 2025
 23:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org> <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
 <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com> <823c825c-a777-4c84-a833-39c7d4a6be54@suse.de>
In-Reply-To: <823c825c-a777-4c84-a833-39c7d4a6be54@suse.de>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Thu, 10 Apr 2025 09:59:24 +0300
X-Gm-Features: ATxdqUGH_f9NnpPSfQp4lS9HU9OpsVWhnlYZHFF6UbQ8repHB9rCTSwBeMj0xx4
Message-ID: <CAAiJnjo3_bxDepmpSza4ivDuK_-ijZ-HBEp2ox8pFjjqZE1v1g@mail.gmail.com>
Subject: Re: nvmetcli restore fails in add_subsystem
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@infradead.org>, Daniel Wagner <wagi@kernel.org>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_235938_347457_5D95F43E 
X-CRM114-Status: GOOD (  26.69  )
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

I'm going to do tests with currently best available FC and Ethernet adapter=
s.

I have Ethernet NICs

Device type:        ConnectX7
Name:               MCX755106AC-HEAT_HPE_Ax
Description:        HPE InfiniBand NDR200/Ethernet 200GbE 2-port
QSFP112 PCIe5 x16 MCX755106AC-HEAT Adapter

and I will compare that with 64 Gbps dual-port Emulex HBAs.

Sure, for best performance network and storage traffic shouldn't be
mixed and good design is required.  But at the same time, NVMe/TCP
will work anywhere iSCSI works, and this is an advantage.  And also
there is a possibility to switch to RDMA (RoCEv2/iWARP/Infiniband) if
required using the same Ethernet NICs.

Over 20+ years I promoted FC as best for storage traffic.  But now I
think it's time to change, Ethernet (NVMe/TCP) is already mature
enough at least for POCs, not just in raw performance, but also in
management, congestion control, security etc... Especially with
upcoming tx/rx zero copy techniques (io_uring and devmem-tcp)

Anton

=D1=87=D1=82, 10 =D0=B0=D0=BF=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 09:10, Han=
nes Reinecke <hare@suse.de>:
>
> On 4/9/25 13:58, Anton Gavriliuk wrote:
> > Hhmmm.....
> >
> > The link - https://documentation.suse.com/sles/15-SP6/html/SLES-all/cha=
-nvmeof.html
> >
> > is quite confused me,
> >
> > 17.4.3 Marvell
> >
> > FC-NVMe is supported on QLE269x and QLE27xx adapters. FC-NVMe support
> > is enabled by default in the Marvell=C2=AE QLogic=C2=AE QLA2xxx Fibre C=
hannel
> > driver.
> >
> > So if "the qla2xxx driver or/and the HBA firmware do not support the
> > target mode anymore.", it is not clear, will NVMe/FC target work with
> > QLE269x and QLE27xx adapters or not.
> >
> It does not. The HBA model is irrelevant as the code to run nvme target
> mode on QLogic HBAs is not present.
>
> >> Though he was able to get the target mode running with a Emulex HBA (l=
pfc driver).
> >
> > Long live Emulex!
> >
> Kudos to James Smart; he was the main driver behind the NVMe-FC effort.
>
> > P.S., I don't like FC, but I want to do some NVMe/FC vs TCP
> > performance tests, so I must set up NVMe/FC for the tests.
> >
> I am not sure how far you get with that. There is a differential
> in transport speeds (10/25/50/100 for Ethernet, 16/32/64 for FC),
> and the best you can hope is to reach line speed.
> In my tests we reach line speed out of the box for 10GigE and
> 16G FC. I did some tests with 32G FC, but that was inconclusive
> as it _heavily_ depended on the hardware setup (How many CPUs?
> How many queues are exposed? Which backend did one use?).
> And I do expect the picture is even worse for 100GigE.
>
> But it'll be on my agenda to do some benchmarking here, too.
>
>  From a practical side, FC is far more robust than Ethernet.
> Thing is, traffic on FC is well managed, and one can expect
> reliable performance characteristics throughout the lifetime
> of the connection.
> Ethernet, OTOH, is prone to outside influence as typically the
> switches are used for all traffic (not just I/O), and hence packet
> drops and performance drops are for more likely.
>
> Which in the end will be far more important than raw speed.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

