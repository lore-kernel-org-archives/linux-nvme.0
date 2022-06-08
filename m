Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22483C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MoSZEwV/82wQpvzP8+Gbe3702Js/fMZkB3M6VOrzfpA=; b=prUHJiV19plcUdFR0vDlvgx1LH
	IVSu0O/SrfyvDYYqC3RAYWGSCx7dFCfIL/HDMaLneNWoi3QHa9ge9Q244J5FHyIQx+VR3RPK8BnFK
	pB+mH4MAFD21BD1ebI1IbWh2KRto6Cl2rhbZ2oVJ9DNirai/pv9MNLbxZWMVwsMynbiem7YWgA1b5
	1nEv9xkXM6fxrffbYTm5w9thvWT5lMfAxz/o7Qn59NWkF77ILIwfMn/zXHcUuRkCFY8I4yzFRX8FW
	REIThwfup0RMhg/F6CSdHFz5/ORmWNqIDMTXV895zZBAXJ5qlscwVd+SLp28oy3FCHg/MIEn1OkLD
	QW9K/OiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqeP-00Bo1Q-Hx; Wed, 08 Jun 2022 08:02:49 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyqeL-00Bo01-Li
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 08:02:48 +0000
Received: by mail-ed1-x529.google.com with SMTP id w27so25926507edl.7
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jun 2022 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MoSZEwV/82wQpvzP8+Gbe3702Js/fMZkB3M6VOrzfpA=;
        b=MlfQ3ATfw2gaEaz79JTCw5VZ17o0zrdsEmyQUWNrzJoYjbrv8zk4YvRlWDS5ehubsE
         SX8zHoclHL6iwN8ujl14bmNNLBb/zBqgcIcJTiJ6R2ehhGvswiqe/zzfIO5rdso9gonf
         2Xa1FE0Dscb6BKCwX/0mFDFC7diUekr1309B/j7R0AK2SiC9lM22xydykXmO8qDWQiIH
         wy2V08yk3RuXEr45UJhFbOHexF1YaoOH3xGjjMEeeln2SWgjN/8XOCWNFrqQ4J+kuh1J
         vD6i462nxDPkaWuTMUAF3q2QGzENppM0a0kDXet47px25Okenv6p2zdtoki0NhJWTLAO
         d/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MoSZEwV/82wQpvzP8+Gbe3702Js/fMZkB3M6VOrzfpA=;
        b=BUA3rudHCbAADqQEqVaHOOZekR1xYfG9bQ3D3eMX+rTYGGbqIRx2IkIx4oo7V8/60Y
         ONj6NICjjQuhtjDBW0uqXoXECy3L8hcoQ/x3ipimPWdJTuKZ7FTuSdNBJdFLMygATRQj
         rvdxqB3dTuf61CVVdevNof8hM1gKKacp6+9I/qrd4V60kldwMQdnd0cT7FU50sYN4U8l
         V0UvN4Kmb0c05IGFn0eSk7RDf3V8hkmexOHcLjK8w+mu/P6qW8/j8PN+tnWb+biGY+o0
         l4MkpJv9g/LxkvANILiJqaSviChmDXdiEgIDIrBzpH5YxXoPESiY6KRXumx3B1yvmoc0
         TOwQ==
X-Gm-Message-State: AOAM533ft89IFx/pFfas5kT9tcOBjcIXoUd2vBQoFwmnFjJvGlmecjNS
	qIrTl3tbRnZ+1NRCx26yz3kw3v71TTmOAs7vLSXe6uPlx8ppaA==
X-Google-Smtp-Source: ABdhPJyzSf0nPK14Mw5lkslcrghM1/Cxn6VtWycUtCW7kiBA0uGMj2UoWRAsu4OEkgop5WZKcScIf+Bop4R6l7uPodc=
X-Received: by 2002:a05:6402:b45:b0:42d:bf43:8db1 with SMTP id
 bx5-20020a0564020b4500b0042dbf438db1mr37421742edb.100.1654675360633; Wed, 08
 Jun 2022 01:02:40 -0700 (PDT)
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 8 Jun 2022 10:02:30 +0200
Message-ID: <CAMGffEmx1xk1MP30NTzn1tcS27Mc5fVudnkfYeqJrOxs_HYZfQ@mail.gmail.com>
Subject: [BUG]LTS 5.10 regression NULL pointer deref in nvme_ioctl
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_010245_831969_7C42528D 
X-CRM114-Status: GOOD (  13.20  )
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

Hi folks on nvme list,

We hitt the following crash when run "nvme list" on kernel 5.10.115:

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/kernel/dumpstack.c:
359

 #4 [ffffa80c7a5c7d10] no_context at ffffffffa7062467

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/mm/fault.c: 754

 #5 [ffffa80c7a5c7d78] exc_page_fault at ffffffffa77c919e

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/mm/fault.c: 1327

 #6 [ffffa80c7a5c7dd0] asm_exc_page_fault at ffffffffa7800a6e

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/./arch/x86/include/asm/idtentry.h:
571

 #7 [ffffa80c7a5c7e58] nvme_ioctl at ffffffffc10c1038 [nvme_core]

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/drivers/nvme/host/nvme.h: 609

 #8 [ffffa80c7a5c7ec0] blkdev_ioctl at ffffffffa73f6bc5

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/block/ioctl.c: 237

 #9 [ffffa80c7a5c7f08] block_ioctl at ffffffffa72c3329

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/fs/block_dev.c: 1893

#10 [ffffa80c7a5c7f10] __x64_sys_ioctl at ffffffffa7292fe4

    /build/ionos-linux-pOGXys/ionos-linux-5.10.42/fs/ioctl.c: 49



607 static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)

608 {

609         get_device(ctrl->device);

610 }
The same commands works on kernel 5.4.

kernel 5.10 panic while processing nvme2 which is  a bit different.

some more info regarding the disks:
$ sudo nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     S4BGNC0R600336       SAMSUNG MZQLB7T6HMLA-00007
        1           1,39  GB /   6,40  TB    512   B +  0 B   EDB5202Q
/dev/nvme1n1     S4BGNC0R600346       SAMSUNG MZQLB7T6HMLA-00007
        1           6,40  TB /   6,40  TB    512   B +  0 B   EDB5202Q
/dev/nvme2n1     S4BGNC0R600335       SAMSUNG MZQLB7T6HMLA-00007
        1           1,37  GB /   6,40  TB    512   B +  0 B   EDB5202Q
/dev/nvme3n1     S546NE0R600295       SAMSUNG MZWLJ7T6HALA-00007
        1           7,68  TB /   7,68  TB    512   B +  0 B   EPK9AB5Q

sudo nvme list-ctrl /dev/nvme2

[   0]:0x1

[   1]:0x2

[   2]:0x3

[   3]:0x4

[   4]:0x5

[   5]:0x6

[   6]:0x7

[   7]:0x8

[   8]:0x9

[   9]:0xa

[  10]:0xb

[  11]:0xc

[  12]:0xd

[  13]:0xe

[  14]:0xf

[  15]:0x10

[  16]:0x11

[  17]:0x12

[  18]:0x13

[  19]:0x14

[  20]:0x15

[  21]:0x16

[  22]:0x17

[  23]:0x18

[  24]:0x19

[  25]:0x1a

[  26]:0x1b

[  27]:0x1c

[  28]:0x1d

[  29]:0x1e

[  30]:0x1f

[  31]:0x20

[  32]:0x21

[  33]:0x22

[  34]:0x23

[  35]:0x24

[  36]:0x25

[  37]:0x26

[  38]:0x27

[  39]:0x28

[  40]:0x29

[  41]:0x2a

[  42]:0x2b

[  43]:0x2c

[  44]:0x2d

[  45]:0x2e

[  46]:0x2f

[  47]:0x30

[  48]:0x31

[  49]:0x32

[  50]:0x33

[  51]:0x34

[  52]:0x35

[  53]:0x36

[  54]:0x37

[  55]:0x38

[  56]:0x39

[  57]:0x3a

[  58]:0x3b

[  59]:0x3c

[  60]:0x3d

[  61]:0x3e

[  62]:0x3f

[  63]:0x40

[  64]:0x41

[  65]:0x42

$ sudo nvme list-ctrl /dev/nvme0

[   0]:0x4
The Samsung pm1733 marks the 0x0041 controller as the active master
controller, we only attached one namespace to controller 0x41.

sudo nvme attach-ns /dev/nvme2 -n 1 -c 0x41

attach-ns: Success, nsid:1

$ sudo nvme list-ns /dev/nvme2

[   0]:0x1

For both kernel CONFIG_NVME_MULTIPATH=y is set.

As it's a production server, it's hard to do git bisect, I was hoping
if anyone have an idea what went wrong here, my guess is the namespace
handingly somehow changed.

Thanks!
Jinpu Wang @ IONOS

