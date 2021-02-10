Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 18:36:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BA264E0B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 18:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA264E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9tGj/TlN9R4F/cxJs97Ujm3Pi2yFSI1Pyq+W5ajIVag=; b=KVefsi8Y4bSzDOSss1lwZ/XF6
	O7TgTetHuVQPgLUAq66/NffcnkYLArpub0jLDrL2U7YZ+EKeV8B7i2xKwuMzsNpW0ANQateCHpbHM
	JEKxBgqcci/F6rebjoCYY+pc86yrzMhGiaQQ1Mz9K1tewdXU59WVfYqailzQanC/i8oWQNAGE5aQF
	A4C68l8yfubA1F3JvNFYT9BSLl1f9WynxwkZ9hZ7EEbOPLZs02pVMG7zZg8+ZTMZs+sC+8T1pxQak
	dSgLWQGqaw4ycwp2pP8nUx9TgWzbVCxj377ZJD4E3Jer7kI3dtU7mhIz4P1cB3tnkdmI+jyO4/opL
	govpYKhUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9uLW-00075c-IG; Wed, 10 Feb 2021 18:36:14 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9uLT-00074M-JN
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 18:36:12 +0000
Received: by mail-il1-x131.google.com with SMTP id q9so2803168ilo.1
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lBDCvyJpnRoMGXXlPlEf1Flpq8L16c/Bw3NNP/aH7+c=;
 b=RaFWiE/gqCdewkU49GZyCM4ypktTMiXKfWwE2CmdWR4TXVjmS1TDrDKbZxoIieyxXW
 ppFP8qYOwTLvxLZFqanyWwga6ZoqHKqQnSSmdj6WiyNx0a6v0LEdoKTeQd7RqQM20P8U
 BWDOEyQT9lHe/2Gf5HM+hFwDm8pfx5nZR12x6shF3GSYfwO002nMuZz83B3qfoJcyn4X
 fnjptCWVPopo8rU53wvdJdO+hT53jMko16i11R49QVmLQce9IxaiUXUcJew8uWulG6yl
 +kq603S0rEjAseK1wAYCRyGoVpQ54nEFaCJsvFA8pkfdEWObUbIUQyZYsjR+uGDb/W7W
 g6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lBDCvyJpnRoMGXXlPlEf1Flpq8L16c/Bw3NNP/aH7+c=;
 b=eBymzmu2fYVt9zMruTzWJpK8S7GijSqdZJB2eESTLdYFUKPbA+OjscQBrEVEMXshDj
 0N2BCOFgXbSfm/ondsYthPo15MLavQ06ptDlHFyEvitbBEIRs0+ueoFaVgFuHl16KhnH
 X1+WEnwaoBCaQXy8xVjOMh9aQuEdxwaC6l2osRsFV6R1drqhOWSgbRmJCiQWhSQZGDEF
 f7LCwLz1Pe7eQP98N3wKU/1C2FYi+CG/Kb6qzMDohEd4bPPZEyeYF2Q5ofZyIRjc2ApR
 uO4DXLt314B/oq7JhHgX1rra8QlujtVp+Dpv5mqqwK1B2rQCn4hwncboFZj5LiLgBKnz
 GUqg==
X-Gm-Message-State: AOAM532p2KurKOKxRqjsihp+85+iNjFW8sNkkuKVwl2kqxitCWPyB0Pi
 HEIMzvJteB4X+0yjUyEzeZR3vIU1SHbYBnbPyZk=
X-Google-Smtp-Source: ABdhPJxKTfKkr8g59IBH4ahpsBo+oKBYbD3kJmiSDivIl2VFY3OUw9t3klNWWdCxlhcDUkw6ZUt9WN9LPiS7J4e2o9s=
X-Received: by 2002:a05:6e02:13e8:: with SMTP id
 w8mr2252236ilj.273.1612982167923; 
 Wed, 10 Feb 2021 10:36:07 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR04MB5656896D86A830305A2AFE31EA8D9@BYAPR04MB5656.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5656896D86A830305A2AFE31EA8D9@BYAPR04MB5656.namprd04.prod.outlook.com>
From: Eric Curtin <ericcurtin17@gmail.com>
Date: Wed, 10 Feb 2021 18:35:56 +0000
Message-ID: <CANpvso5nv0LO6XwAVtj8Lc=4HbxUjjNnTmj9T7ap5F=3mccKoA@mail.gmail.com>
Subject: Re: NVMe CLI Commit - Input expects device name without /dev
To: Jeffrey Lien <Jeff.Lien@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_133611_655853_8C4A7C0C 
X-CRM114-Status: GOOD (  12.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Alex Gronseth <Alex.Gronseth@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry yes, it made sense to print this error for this case:

https://github.com/linux-nvme/nvme-cli/issues/879

But not for others, I'll remove that fprintf line. Here's the fix:

https://github.com/linux-nvme/nvme-cli/pull/905

Apologies for any inconvenience caused.


On Wed, 10 Feb 2021 at 18:21, Jeffrey Lien <Jeff.Lien@wdc.com> wrote:
>
> Eric,
> The subject commit (ID dcfe0156360deaefa26b1d00053a791eefe397d1) is causing the following errors with the Linux 5.9 kernel:
> Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/hostnqn: No such file or directory
> Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/hostid: No such file or directory
> Failed to open /sys/class/nvme-subsystem/nvme-subsys1/nvme1/hostnqn: No such file or directory
> Failed to open /sys/class/nvme-subsystem/nvme-subsys1/nvme1/hostid: No such file or directory
> Failed to open /sys/class/nvme-subsystem/nvme-subsys2/nvme2/hostnqn: No such file or directory
> Failed to open /sys/class/nvme-subsystem/nvme-subsys2/nvme2/hostid: No such file or directory
>
> I'm seeing them on the  format and nvme list command.  They don't seem to impact function but do generate questions.  Do know of a way to resolve?
>
> Thanks
>
> Jeff Lien
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
