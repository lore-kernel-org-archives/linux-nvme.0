Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E197C982EA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8U+8SxW0lyN1A81qRgj2j8WvsjVH/+wIIVddT2WDUf0=; b=vLmE3LV77kGVEMJ+0Exp5Dk9ZF
	tLoPeS3cQQjbTH7o0YX+0C4UcjH39q0UdTHRbATOH+eq49FAmNrDww/IcNnAame/KdIsGWOBcMttA
	Y9kMzdSyre8RFjmXmTgrGy7tmTFZyC/QfQSFBfaaTtP6Qb4syLuIIbVvYfPsxCH5OLyWkpWFVDOzq
	AOOyWA7/pVHUL16DuXfqXXeNP2iGsY6VO3ec7LcZ+c9l7s0kWNwua1pIOaNU/m0Cs3hiNq37K2txW
	JFvQi5rHxKibXcrl9c7Gfqh8dVIWF0ixNgVo4BDvqT5l3Q0XVMMdcRxMWIyoCqoXdArDkGYmeVOAe
	pSCFhncQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Efp-000000077Co-2pnz;
	Wed, 23 Sep 2026 04:33:37 +0000
Received: from mail-ot1-f69.google.com ([209.85.210.69])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Efm-000000077CE-0nVm
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 04:33:35 +0000
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80621978fddso451704a34.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 21:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790138012; x=1790742812;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8U+8SxW0lyN1A81qRgj2j8WvsjVH/+wIIVddT2WDUf0=;
        b=dU+NF1Ld1B7MI1qT7T8DIfveyBCfrymEkH5aNVGMvxkIlUjIJEa0ieOJ73O0GmJXC4
         gyp+gzUEgF/uLKliM5zJ3DgLZhycS1jlnd8AbHBHf9eOC6DQ2039o6XhxsX5QeAce4Lh
         MUlAVm6nqg/X7oQRQZUIaPO7j08L7YCpi8tIMDbBoIdNYVcp/6reGb+dkXTsbXyatHTh
         zTfokDUPGLYP0Ocve+7e3NF+8Tyk+IvzM6dCvl+6sM1V+sllRDtpQH4YsTieta6bQLB7
         1OY7RX7QB1PvSJg6xVu/17StMAM27XVyt4wUAUtHVTpG46rF+Sv5rqkiFtK8rdjMopFo
         BpBA==
X-Forwarded-Encrypted: i=1; AKwUvBxCpR4Zg772LeiwCGweeSKf7CFi6YkIxS5zYltJrLLcoCfpahy3SpHvlc2f+xnfuPjIYOi93z7srYeQ@lists.infradead.org
X-Gm-Message-State: AFuF++kWm/SMLO7LLNTUtl2HokeDKNwBsbVMCadB8FqVPmrbnfISZ6NN
	hj7EU9wdAD3IPB8wVvFp2zK2yIsg6Y16X6OXW7r/ugdB2ldrMitmYXbe7GK47xvqCAY7FNuKrHZ
	8bEpE+7lVe+2b5o6j9GpMqF0mbfqlmfre4V6ATxfAXf2tWpylVUXZR4cl7sg=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b0d:b0:6bd:df1c:23b1 with SMTP id
 006d021491bc7-6d2cf847b8amr1362403eaf.15.1790138012446; Tue, 22 Sep 2026
 21:33:32 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab3569c.514bccd6.255447.0023.GAE@google.com>
Subject: [syzbot] Monthly nvme report (Sep 2026)
From: syzbot <syzbot+list003bd56f9e8b27f9d049@syzkaller.appspotmail.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_213334_231205_ADE8D3B4 
X-CRM114-Status: UNSURE (   4.96  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello nvme maintainers/developers,

This is a 31-day syzbot report for the nvme subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nvme

During the period, 2 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 3 have already been fixed.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1       No    WARNING: bad unlock balance in nvme_update_ns_info
                  https://syzkaller.appspot.com/bug?extid=64bc2169c92ee55ad31f
<2> 2       Yes   KASAN: slab-use-after-free Read in nvmet_port_subsys_allow_link
                  https://syzkaller.appspot.com/bug?extid=b0996ac2197dd7420c3e
<3> 1       No    KASAN: slab-use-after-free Read in fcloop_t2h_xmt_ls_rsp
                  https://syzkaller.appspot.com/bug?extid=2a31ef5d37a9d722e987

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

