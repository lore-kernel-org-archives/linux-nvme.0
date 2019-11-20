Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CEC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E9620878
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UKtsnBlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEBj5tLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AlYpmR+iO+YfU16+WRkQ9mg6S6REtTTgWKR6bFFm+eY=; b=UKtsnBlkt/v8me
	YiznYdcN+gCp66LottVPWEGu5ZHfceiDOySgIZh+be2xrM3Ibu1KtyP9BulHmnTANlSq6ZBxsCCk4
	Pn3WK1HQjjn1fP7b4lJb+bN5DEZ0ER0m/2qHXSunuPRnUkU2qQM9s7TJSoI42Pnu2emD1KBD1R1PT
	jyM+6FkUBQ5TRUa/rIUiXrPfBq1sdKzRGpArxNlsQJc26Q/aCgIq9UeV/sjC+sH23FywNuUv8S5fL
	7hgvz4bd/XQJuhx9AUcjy9rl92k9FFizFbP9Kz8MLaxzK2Pel9cTqg3pveBPtU5zxvTfmixNsdpxZ
	hHpNU84Wy9NMY5cgEHeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXURx-0003Ah-33; Wed, 20 Nov 2019 18:11:33 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXURu-0003AD-Cg
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 18:11:31 +0000
Received: by mail-vs1-xe41.google.com with SMTP id n9so278277vsa.12
 for <linux-nvme@lists.infradead.org>; Wed, 20 Nov 2019 10:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbMt7aNsnFs2xSDDDaZLDq4sf3zd2Pd5jaVLPYKJO2k=;
 b=lEBj5tLVBzc5Dr64K0KvJZjBBjtgDMJljsmxZzoBPMltOH2kAq+uhOKkXh/pC9q5rt
 xDUVwYOVB8wqUSeWYOPzON8d4+JFOlnmxxvRuzz3ablnRtrPYTnS/+bzs6N3cpqZI6rZ
 SaOj3/wpFU0Xvxkr/Vs2T3eR03gQ783VmNb5I2Gu1jpUg2dPI5tgAqPvC4AgmaC7pH5F
 I8I+QzkiylylmgQGDYbqMxJcOy2noXL5MtYYZXlLF3UM90bBHeihSvqH4OZm9sX4JAzg
 8ppXrNX8GXBJmwD45tqsrTfzyFB+70u+9zhr2Vn4sKAphovyAmcNK63+3dgCQz1+0zub
 gr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbMt7aNsnFs2xSDDDaZLDq4sf3zd2Pd5jaVLPYKJO2k=;
 b=hHn9VXEPLivdcMOiFuAPIwb4c9g4casC0BPMfwgv7owabScTbDHTika1CcZJH2nDvm
 czJzthISnpoAeU3sXvpUczuqsi3jzp2ThDkxoyia2BhiM3SwyZmmzuL85yPIstiU+m4g
 czS1XitLZFBa/zUVT1b7y79EGVF7pO3V3258mk4WY+3zYq0IVVwJH+P4Jwau8nQGOOYc
 bqdIo5eXsFlqfNS0VwVDVeJiDNnUHtH2InM8LnOzuocMHAQ7e+KmsWsc5bBwwNHLvAn5
 czxRth/fi339Rye80IfAH9CBW2BC6d9bNLA5Sgg4nykmVQmZW4VS6+KqFzlvrc2NULTg
 PAvA==
X-Gm-Message-State: APjAAAXDiSL0woxu4UW/TQIMSHRP4IKcyexYZ8M+0GJdqbnEQVjmI28b
 hFpFgGSNTXOFee7Jjd8yS19fQ3szHUtT91MZaVgB81tu
X-Google-Smtp-Source: APXvYqzEb5lGb2ITCMJ0cGaSSV2FF8nD5n9BNxJgiG3yHJaF24+b1FcircAFF/Peofc5sQ1jd18lUgdA9dZVmouFsmI=
X-Received: by 2002:a17:902:740c:: with SMTP id
 g12mr4149869pll.140.1574273003148; 
 Wed, 20 Nov 2019 10:03:23 -0800 (PST)
MIME-Version: 1.0
References: <CAOoKxP99U8E=oAY23wA4_JVQNbPXVnkpcL6_-_zcwCnYDCoBaQ@mail.gmail.com>
 <20191120152935.GA9426@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191120152935.GA9426@redsun51.ssa.fujisawa.hgst.com>
From: Sushil <sushil32@gmail.com>
Date: Wed, 20 Nov 2019 23:33:11 +0530
Message-ID: <CAOoKxP8XWhuF7ROKsTHmUpsaUvwCJS0ZH7xOXJGUKQvqUOrU+Q@mail.gmail.com>
Subject: Re: NVM Sets supported on Linux?
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_101130_455666_0DAED2FD 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,
Thanks for reply.

Basically, currently  I want to create NVM Sets on an NVMe disk and
export these NVM sets as LVM volumes to VM instances using Openstack.
Later on try things like Endurance, PLM etc. with these NVM sets.
We don't have any physical NVMe controller with NVM sets though.
So I was thinking whether I can use the 'nvmet' Linux target driver to
create kind of logical/virtual  NVM sets
and therefore whether target has/will have support for NVM sets. Its
like how namespaces are created on-the-fly
in Openstack during volume attachment using the volume path -
/dev/vg1/lvol1 for ex. - and the Nova compute node
then nvme connects to these newly created volume specific namespaces
and attaches them to the VM instances.

So I am thinking instead of volume path, I create NVM sets and
corresponding namespaces on-the-fly using the nvmet target
driver and then the Nova compute node nvme connects to these NVM sets
and attaches them to the VM instances.

Thanks.
Sushil.













On Wed, Nov 20, 2019 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Nov 20, 2019 at 01:58:29PM +0530, Sushil wrote:
> > Hi All,
> >
> > Are NVM Sets supported on Linux (Endurance, PLM etc)?
> > I could find the userspace command option "id-nvmset" (and the ioctl
> > NVME_ID_CNS_NVMSET_LIST) in the nvme-cli,
> > but nothing in the Linux kernel host and target.
>
> It makes sense for an admin to query this kind of thing, so tooling
> has support for that. It could possibly make sense for the target to
> implement sets if it can determine that two namespace resources are
> independent from each other, but what do you want the host driver to do
> with that information?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
