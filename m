Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE46C48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 18:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D37F61249
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 18:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37F61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gG5/9/dlNDnTWVB1f5/J1EGUhIboRMpeIGK38TjOlzo=; b=ZhM0lx6ZPeP97e
	9iM1SG8Pvmqo2fGuCmlUfHrFxVZa0URBnd+drX2x5ESrAm+zsXU9Cz1vQvsyKhXrTwpqQt0SAVfsS
	16hyqY5sAlLfvUFpDZQeTbdJIGtLX5VPx3/SufICkXjkVT9si4IJkDXCyaWw7XeNLr+tDnuWLI3kW
	35Ab+ubFU8XbacpsNBeVarMAmWoKA21NGnHbhEnfy5uz7/xMeT4PPcex9AiuioaKqtRasqHRoRbaL
	7TGuMDgNVyv2kYhFGaQ1lQnh0gEJ7Yg0RYE15mrEzNY0sJhEpaj0OGeHJw85NFic2akxvxEP+ZsZR
	jTCdd+Ntd4QdMPL10r5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr34L-00FYly-Qm; Wed, 09 Jun 2021 18:36:49 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr34I-00FYlW-ST
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 18:36:48 +0000
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 85AD91280BFB;
 Wed,  9 Jun 2021 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1623263802;
 bh=8E8YKM08zSHfgTf3XjWtoAyBeXxzwQfdx7IcdysE4Ak=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=Ij+9FJMYjcHbTV812FtaOf0Wz75pVsyP6BuDpTFhtbzHHhLVxkRIOhx81nENT6Hx7
 18Enbes52dfELuBVNm7FpkbD+e1BUlJQhxeMwPAcHS17XtxjCOVglUpXRmSrunGOV0
 SgNwLQSZCnvqBc8YHwA9/E3nDyXs2q+VX89crh08=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id Jze5ftrexVPf; Wed,  9 Jun 2021 11:36:42 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown
 [IPv6:2601:600:8280:66d1::c447])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 215791280BF7;
 Wed,  9 Jun 2021 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1623263802;
 bh=8E8YKM08zSHfgTf3XjWtoAyBeXxzwQfdx7IcdysE4Ak=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=Ij+9FJMYjcHbTV812FtaOf0Wz75pVsyP6BuDpTFhtbzHHhLVxkRIOhx81nENT6Hx7
 18Enbes52dfELuBVNm7FpkbD+e1BUlJQhxeMwPAcHS17XtxjCOVglUpXRmSrunGOV0
 SgNwLQSZCnvqBc8YHwA9/E3nDyXs2q+VX89crh08=
Message-ID: <485837f392401bf35fb7fc8231d7a051f47b53d7.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] block namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hannes Reinecke <hare@suse.de>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, Linux NVMe Mailinglist
 <linux-nvme@lists.infradead.org>
Date: Wed, 09 Jun 2021 11:36:41 -0700
In-Reply-To: <a189ec50-4c11-9ee9-0b9e-b492507adc1e@suse.de>
References: <a189ec50-4c11-9ee9-0b9e-b492507adc1e@suse.de>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_113646_966523_41C64C4F 
X-CRM114-Status: GOOD (  28.75  )
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

On Thu, 2021-05-27 at 10:01 +0200, Hannes Reinecke wrote:
> Hi all,
> 
> I guess it's time to tick off yet another item on my long-term to-do
> list:
> 
> Block namespaces
> ----------------
> 
> Idea is similar to what network already does: allowing each user
> namespace to have a different 'view' on the existing block devices.
> EG if the admin creates a ramdisk in one namespace this device should
> not be visible to other namespaces.
> But for me the most important use-case would be qemu; currently the
> devices need to be set up in the host, even though the host has no
> business touching it as they really belong to the qemu instance. This
> is causing quite some irritation eg when this device has LVM or MD
> metadata and udev is trying to activate it on the host.

I suppose the first question is "why block only?"  There are several
existing device namespace proposals which would be more generic.

> Overall plan is to restrict views of '/dev', '/sys/dev/block' and
> '/sys/block' to only present the devices 'visible' for this
> namespace.

We actually already have a devices cgroup that does some of this:

https://www.kernel.org/doc/Documentation/cgroup-v1/devices.txt

However, visibility isn't the only problem, for direct passthrough
there's also uevent handling and people have even asked about module
loading.

>  Initially the drivers would keep their global enumeration, but plan
> is to make the drivers namespace-aware, too, such that each namespace
> could have its own driver-specific device enumeration.

I really wouldn't do this.  Namespace/Cgroup separation should be kept
as high as possible.  If it leaks into the drivers it will become
unmaintainable.  Why do you think you need the drivers to be aware?  If
it's just enumeration, that should all be doable with the visibility
driver unless you want to do things like compact numbering?

> Goal of this topic is to get a consensus on whether block namespaces
> are a feature which would find interest, and also to discuss some
> design details here:
> - Only in certain cases can a namespace be assigned (eg by calling
> 'modprobe', starting iscsiadm, or calling nvme-cli); how do we handle
> devices for which no namespace can be identified?
> - Shall we allow for different device enumeration per namespace?
> - Into which level should we go with hiding sysfs structures?
>   Is blanking out the higher-level interfaces in /dev and /sys/block
>   enough?

First question is does the device cgroup do enough for you and if not
what's missing?

James



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
