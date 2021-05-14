Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF970C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 11:32:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ED7610EA
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 11:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ED7610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t1l+MTvg7YHynEHTIZJ5Gvm6IK8M53tXWz35xlsHUSE=; b=FzeDiaxPH/rMgag7RKAqMCv2Be
	Lw8Dfs2JwKEJtJKDr0UzskMAge3yLAo4VGmeJlhqLBp3G1FQiZySWMWul7tgkFXBUyBMjnKtdexL9
	rzoAsjVRSbU50e6/iVxQAIO1kXfWjyVjlEaaBzite2XjDK2DI6NZ44gRSnjKFuoo+rew+2X5N73FG
	UAgKPbIlidvcOr2KWTeX5bw0JJy2qIh7+w7oM49yck8dvTPyI/DppWP94W7q5HcFW5VyVM5nhW8or
	QIWDk9kI0rmaUtXyiGHBs0He8IHtUDeBd1eH7FDOtct6q6dJLZmL0FHsecu+26FbFp+HbwXew45dy
	mp+4tamg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhW2f-007uMt-Pw; Fri, 14 May 2021 11:31:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhW2b-007uMW-UZ
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 11:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Srp0VXunZH7UFMNTDlAEMdWti+cm4J3ENWCu+rjTgcY=; b=3Gzp+CQiJTkJoF2vsW8vuKG1Yl
 G+n4AvdjKaJiVKgUltGbuMy7X1bL6EyqK3evsoaEgwdcpEoWnVCdtWgiOsxqH4WmCBmE17N1oklDz
 w6BNrggZkE8AUWRx0p8TgF9/nknfyZw/ueGJe8SmbyI6ulE/Za5n2JcQyGTrpx0uTMCapE5MfUeZZ
 EBD+EZOECNiApD7+7NuAr5IigA9S9E3vfohPlUxYNgizbQU13vvBf6ZAmbLw3Vy3JXyF76pczFa/n
 kmdKu8tuJ+0hEFsYbS1rHml7CEkgGhq8QxkKBpjXfifSdbJrF00d5860Lp0dN/wr4DiTI57SI6KFs
 yDyc5FfQ==;
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhW2Z-00BwFj-G7
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 11:31:36 +0000
Received: by mail-pf1-x42e.google.com with SMTP id 10so24562196pfl.1
 for <linux-nvme@lists.infradead.org>; Fri, 14 May 2021 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Srp0VXunZH7UFMNTDlAEMdWti+cm4J3ENWCu+rjTgcY=;
 b=tqJK9JVQZojXe2r/to2RYOXkEnV5vg+o4P6HVhINeLDagrzFbQt6OPjMWqm80ybqcQ
 cy4znyry/zC7rzSx52SrXociGd1yVAFJlKlZVEAMDnrvsdLzHdbKNy6dagd83pgbwEUX
 +Q3ey44Mj/9R8HKfWFQT+J/kjxW+t6+gb4Zg0o5i5SnBiFm02NOAzYNzA6Ore9lTcjVV
 Czj42yUoq5oNuzkRtolLmSNCTk7e/mW24q9Idy5oWFOQzIe0OQMjPSaQZ1gCYqJgn33Y
 D8FharDhYiNhcsnFHDhHzIR2ziZJL5X4PGUidOTIquNDZxAuo5JaR8uHwfx2IwISpOSb
 rPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Srp0VXunZH7UFMNTDlAEMdWti+cm4J3ENWCu+rjTgcY=;
 b=HS2FxI2Lkja9gsJmzyHoEoQdc1J8eDEsnljKAsG2jsF+nRUQ+vs/5KXWGDiQpy8Q1l
 tgYTYxrf0Kon0A/re1Q3atq1gPuNDpL1yv70ARRsDi+Qk7Lr8yZyNl4ENsH5WaAgUcWI
 mflR20i/LO4v0aUjoY835RYcw/UwhYfccbmGPKoue0/K3GFiNXlL8PXOPDGcH5844RPA
 CpUnbjD63flVvicGzZQaORUISzOpK68og1vpcuCtOFfZLd2GyYsO9W1/OZOW3O6Rw/HS
 7fu63TEcFIWHuqWKUutOnLT2mimvj4GzxQhjP6nlbMvZ/ebnbum/5pwPjChx8hPhdSsy
 lTxQ==
X-Gm-Message-State: AOAM532R9AoHMeHGb5+sJ4HmLfRCtc852lzc9mDCTnrEQ3QkBuvLZCOd
 roO8oLs2SgVjsjJq1TStnu68RXR3gff0CWlraow=
X-Google-Smtp-Source: ABdhPJzNz0dlkwxlDNUu8U5xwx901L/3yDr3DskcsO4InYroKpYCNfJes8j1jEAsI+KoasSspEEt1ifm9Gb8O4i0RbY=
X-Received: by 2002:a63:ee53:: with SMTP id n19mr46828553pgk.268.1620991893729; 
 Fri, 14 May 2021 04:31:33 -0700 (PDT)
MIME-Version: 1.0
From: Yiyuan guo <yguoaz@gmail.com>
Date: Fri, 14 May 2021 19:31:24 +0800
Message-ID: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
Subject: A possible divide by zero bug in alloc_nodes_vectors
To: tglx@linutronix.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_043135_561914_58826A6F 
X-CRM114-Status: UNSURE (   8.13  )
X-CRM114-Notice: Please train this message.
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

In kernel/irq/affinity.c, the function alloc_nodes_vectors has the
following code:

static void alloc_nodes_vectors(unsigned int numvecs,
                cpumask_var_t *node_to_cpumask,
                const struct cpumask *cpu_mask,
                const nodemask_t nodemsk,
                struct cpumask *nmsk,
                struct node_vectors *node_vectors) {
    unsigned n, remaining_ncpus = 0;
    ...
    for_each_node_mask(n, nodemsk) {
        ...
        ncpus = cpumask_weight(nmsk);

        if (!ncpus)
            continue;
        remaining_ncpus += ncpus;
        ...
    }

    numvecs = min_t(unsigned, remaining_ncpus, numvecs);
    ...
    for (n = 0; n < nr_node_ids; n++) {
        ...
        WARN_ON_ONCE(numvecs == 0);
        ...
        nvectors = max_t(unsigned, 1,
                       numvecs * ncpus / remaining_ncpus);
    }
}

The variable remaining_ncpus may remain 0 if cpumask_weight(nmsk)
keeps returning 0 in the for loop. However, remaining_ncpus is used as
a divisor, leading to a potential divide by zero problem.

Notice that the code explicitly warns about numvecs being zero. And
since it is likely that numvecs equals to remaining_ncpus (because of
assignment: numvecs = min_t(unsigned, remaining_ncpus, numvecs)),
we should probably also check on remaining_ncpus before the division.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
