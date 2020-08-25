Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E741C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E152071E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r334SqG8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8bDUn1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E152071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HXMpaG/z6bf80+C62Lp7s/aNSQMl1J1gZQt1sNclrXU=; b=r334SqG8L/lWHPckn0fHRofeFO
	9Slu4V9VrdJqT+JdD7nMPdjKso79dr5OHWTskJMqEynBABbRJy9jt77Ynv3DtqtiQwTzthxzgRjqE
	TvYf3S/A4JkeGC1aeGV5Q0SP7v73kDEiSN8ty7USWZrJ+ZnhFq3fcPeTGGsRVbENmFqQGXh0zkCiY
	ABHlOUqeFIWFtadk9gL2tLa9pAH5kYPqnnHRoBPPdPz+Ec18pWQP+ElIQgttWPtAlkWXRgKK4kaL+
	L5X4McCVV8vIEpjjnggoiY4P6suYyJ4lnhvUhKC3q9Ed3aOjNN29G3Nz7B3pTgFXjmGNprTzmC0SL
	5oTjnc2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAgys-0000Td-Sc; Tue, 25 Aug 2020 21:59:50 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAgyl-0000Sy-CC
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 21:59:44 +0000
Received: by mail-oi1-x232.google.com with SMTP id 2so141365ois.8
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=YgPHDWqfeJwgveyoe/qd9ydi/JgFHWjG0Ak65BwpmcE=;
 b=G8bDUn1hc27Kt4r8tE8u3ZQT8CgP3gG+b+YMspROfjcoL7bjLgokEtvOrIv01sRGsN
 PB7bKGMmyIN7/1fGwFJg8QBMewoNXfdOpGjCnMHNUtuDimr2fmuK0A8RXU0cTV46cQbp
 AdtAqMDu/59rNSeBcAI/9rNsPZnkEaLdmRv7ROHNnJGFa7wXzNQXDFcpvjFRRKCGRKUK
 XJa8UHHO03NPrHgyYmU8b4tXt4LPFQ2R+RPU7dPWFYLHzg6Ml5OGBTeTby9cItrsotjp
 L0wFc87UKrPllUH3GssEVHHq3r9so80TNB7eHdDkpoUO+s0oagxSd7vLa1KQXP3azuEn
 o6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=YgPHDWqfeJwgveyoe/qd9ydi/JgFHWjG0Ak65BwpmcE=;
 b=SGjjU3s7C0X3MRKgUsXNBpH1eI1frtio6HB1QSBl1sHYDSM4RrSdgLBxqRswc2IcXb
 mH1N13Agsu0z+9EeLgBPE1ODHi/xzRKV/mAZFbFnTwi8RkoInLyzKp7javtCcZOtDST1
 MWH8w9fDpP6Ff0dRTDG4Q1JqNhP0NS4tL7GO+igR/Rwd96xX+mSRgTb+XqiCOYGRkvfV
 1fTr+TFW9R4PjLAVf5JY8YFdYtADcIkHn25i7XUkLBUCXk4tTFcpI3dEQlX/hOhuQqhl
 ITkS7IkwGIO+i6V8YRYGeLuTc7Exzv94y4LXtRXG0ImZyT60JMYVKcYyWXkwgkIBsZ3e
 qTnQ==
X-Gm-Message-State: AOAM530qx9JcGi9OaDY2y/rCLwN7PW5+sT8iPAKpbAUl7QoDi4rXmyHO
 OIsIpyvychlVNFqo2pGSoU2kTxbV3kY1mAoNfJ5p/kvB31o=
X-Google-Smtp-Source: ABdhPJxp38jz/Mo5YKINlFVVGrkCmH8Afmagf+SY/tiZuO/nYQ3SrJvktW278FC2WJdZSqTvlpmU1rAqP1tPizO+zIU=
X-Received: by 2002:a54:4513:: with SMTP id l19mr1321454oil.115.1598392779797; 
 Tue, 25 Aug 2020 14:59:39 -0700 (PDT)
MIME-Version: 1.0
From: Chris Worley <worleys@gmail.com>
Date: Tue, 25 Aug 2020 11:59:28 -1000
Message-ID: <CANWz5fhgxK5QDJpKKnpDYQ9qfuOmru9M=oLdGEf8OkaW8bd8uA@mail.gmail.com>
Subject: "Connect rejected: status 28" from "nvme discover"
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_175943_444406_0F7DA106 
X-CRM114-Status: UNSURE (   5.43  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Running CentOS 8.2, using native drivers but following instructions at
https://community.mellanox.com/s/article/howto-configure-nvme-over-fabrics
(but not overriding the native drivers with MOFED).

Hardware is connectX-3 HCAs.

Target setup goes okay:

[root@localhost 1]# dmesg | grep nvmet_rdma
[ 6366.612458] nvmet_rdma: enabling port 1 (10.4.0.6:4420)
[ 6376.078826] nvmet_rdma: enabling port 2 (10.4.0.6:4421)
[ 6385.662419] nvmet_rdma: enabling port 3 (10.4.0.6:4423)

But discover goes awry on client:

[root@localhost network-scripts]# nvme discover -t rdma -a 10.4.0.6 -s 4420
Failed to write to /dev/nvme-fabrics: Connection reset by peer
[root@localhost network-scripts]# dmesg | tail
[ 1688.058291] nvme nvme4: Connect rejected: status 28 (consumer
defined) nvme status 0 (unrecognized reason).
[ 1688.058410] nvme nvme4: rdma connection establishment failed (-104)

Systems ping each other.

Hnts?

Thanks,

Chris

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
