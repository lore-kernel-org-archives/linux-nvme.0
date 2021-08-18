Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D67C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 05:31:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F189C60E78
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 05:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F189C60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dI3+mWQ2oSEuLdht1XR2CtSVV/D+r0Uiw20xg2+lV5M=; b=Yhe1APWSLsdrSa
	gyEGbVvvXVSbDjzALXaER5ZXelGW3TQaz6WEMaSq8MiXH87lZpCYj3VL+AT8whw0kdwuWdCS+Id+s
	GI9RQIzM0kgA2p9FVbqnDdq5j7fop90V3sBU/Y0dIAo154n6945sbgUpCuAdjrIknRhkYjP0SDvkM
	MiYRw4kaQuka1rYaZsAaoZMRC+QToOUaCBcx0HuOJmkfOH7kwnXpAfSaXa71Jzz6QIG6g09G3nljN
	ffTNIx7EDdM3rZ8t1e1+q3h8IKbCf1l8rqFJxr8ubbCDNGNYCukBivWcly3kK3U0yYLGEs+3l9x5w
	ux2WZRR+czxd/U9t5hkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGE9t-004FXI-IK; Wed, 18 Aug 2021 05:30:37 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGE9q-004FWl-Gn
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 05:30:36 +0000
Received: by mail-ot1-x335.google.com with SMTP id
 e13-20020a9d63cd0000b02904fa42f9d275so1390733otl.1
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rQwS2RmRK5/K9FRuvip/E8i6e8PV350rtHh4i/F6PvA=;
 b=RoonnfWNxGg34QJv0EENvNAfskfPF1s676HnRefH3Nm6PTg5JomewiRp546aERrny8
 dMD5DpaIvF8XkaGFNCeds1UMhtQT+k1wivApK/AvbYP7HCnWm3LMkqBMqYBj0mZ3I2st
 vJ1oFpjZJ+Tl7EstNABmcUKKzBc3pt+EL3yhism2W3WQ0TdIyeqaWNAMvMAE+hniUbbl
 h35fe/EZPMizgPG5rutX0uGo8zZUl/S2Rp5JyD7yitadxQvkueM35Em0lBSp+MHodUv2
 5s8MGZlAvgDiI3Efn5jyDVblZQrnd3wMJXcwOl3//h+CyQzMON0yNmoeJC3qUM7a543A
 uePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rQwS2RmRK5/K9FRuvip/E8i6e8PV350rtHh4i/F6PvA=;
 b=WHzjIttPeVlxpqBPfL35xVSWuVWZaOzgGdlpcBbxIcEWJh92TlhyOny/ADxAc+Ec5a
 PwqTWS/LUN2qQuBbWxUaFXa02f64y3cCwkMQHQ9Lt0fpAv2Ofa3eHiiqNeNrJWbsoViA
 JIFxsdggVoZ7wr1+c2Wnwdktl6UuV3qN8l5vphzext2yh/YLxsKtKyYqFxsTqbZ3qrNZ
 ZCZK0ZhP0FDr8akPjbVJMl8dWrZKl1H2Fa/EtKPpNywfhUcR3wLlF6eHBp25lh7wCfxM
 Cr/81EIAhMKHJROxfDGy3MX1qlkqoTgYjEU0ezMN4LoYjj8SPc4ZFnNqU1yOG1YL29OQ
 Qv/A==
X-Gm-Message-State: AOAM5308RuQbmb/AXQKIq7Q/EklKJJCFaaXg62qAwTsWbBFp1M151FT0
 oz5aX4EXPuvz7na2SkSjX/cG/JYad5HAf+pF1Mw=
X-Google-Smtp-Source: ABdhPJznZa9XZ7d0+a5LirBLWlTrL6Cb0569TMrxoLLrvjgXwTyP6ITquN2WTBLDRI8h+12fIDugyQnyiJpz3jZu/rQ=
X-Received: by 2002:a9d:541:: with SMTP id 59mr3749140otw.278.1629264632885;
 Tue, 17 Aug 2021 22:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
 <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com>
In-Reply-To: <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Wed, 18 Aug 2021 13:30:21 +0800
Message-ID: <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
Subject: Re: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_223034_624630_3138F989 
X-CRM114-Status: GOOD (  22.67  )
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

On Wed, Aug 18, 2021 at 1:09 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 12:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> >
> > I found rdma_rxe doesn't work with blktests on the latest upstream, is
> > it a known issue, feel free to let me know if you need any info/test
> > for it, thanks.
> >
> > # nvme_trtype=rdma ./check nvme/008
> > nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
> >     runtime  0.323s  ...  0.329s
> >     --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
> >     +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
> > 00:35:11.126723074 -0400
> >     @@ -1,5 +1,7 @@
> >      Running nvme/008
> >     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
> >     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
> >     +cat: /sys/block/n1/uuid: No such file or directory
> >     ...
> >     (Run 'diff -u tests/nvme/008.out
> > /root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)
> >
> >
> > [  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
> > [  981.470796] rdma_rxe: loaded
> > [  981.474338] infiniband eno1_rxe: set active
> > [  981.474340] infiniband eno1_rxe: added eno1
> > [  981.476737] eno2 speed is unknown, defaulting to 1000
> > [  981.481803] eno2 speed is unknown, defaulting to 1000
> > [  981.486865] eno2 speed is unknown, defaulting to 1000
> > [  981.492862] infiniband eno2_rxe: set down
> > [  981.492864] infiniband eno2_rxe: added eno2
> > [  981.492904] eno2 speed is unknown, defaulting to 1000
> > [  981.497957] eno2 speed is unknown, defaulting to 1000
> > [  981.504338] eno2 speed is unknown, defaulting to 1000
> > [  981.510442] eno3 speed is unknown, defaulting to 1000
> > [  981.515509] eno3 speed is unknown, defaulting to 1000
> > [  981.520580] eno3 speed is unknown, defaulting to 1000
> > [  981.526600] infiniband eno3_rxe: set down
> > [  981.526601] infiniband eno3_rxe: added eno3
> > [  981.526640] eno3 speed is unknown, defaulting to 1000
> > [  981.531693] eno3 speed is unknown, defaulting to 1000
> > [  981.538052] eno2 speed is unknown, defaulting to 1000
> > [  981.543115] eno3 speed is unknown, defaulting to 1000
> > [  981.549088] eno4 speed is unknown, defaulting to 1000
> > [  981.554149] eno4 speed is unknown, defaulting to 1000
> > [  981.559211] eno4 speed is unknown, defaulting to 1000
> > [  981.565201] infiniband eno4_rxe: set down
> > [  981.565203] infiniband eno4_rxe: added eno4
> > [  981.565242] eno4 speed is unknown, defaulting to 1000
> > [  981.570306] eno4 speed is unknown, defaulting to 1000
> > [  981.576724] eno2 speed is unknown, defaulting to 1000
> > [  981.581785] eno3 speed is unknown, defaulting to 1000
> > [  981.586848] eno4 speed is unknown, defaulting to 1000
> > [  981.599312] loop0: detected capacity change from 0 to 2097152
> > [  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
> > [  981.622586] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > [  981.622830] nvme nvme0: creating 32 I/O queues.
> > [  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
> > QID 32         ----------------------- failed here
>
> Recently a lot of commits are merged into linux upstream, can you let
> us know the kernel version
> on which this problem occurs?

I mean, the earliest kernel version on which this problem occurs.

Zhu Yanjun

>
> Thanks
>
> Zhu Yanjun
>
>
> > [  981.772647] eno2 speed is unknown, defaulting to 1000
> > [  981.641676] nvme nvme0: rdma connection establishment failed (-12)
> > [  981.777715] eno3 speed is unknown, defaulting to 1000
> > [  981.782780] eno4 speed is unknown, defaulting to 1000
> > [  981.799443] rdma_rxe: unloaded
> >
> > --
> > Best Regards,
> >   Yi Zhang
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
