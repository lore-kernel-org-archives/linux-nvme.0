Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4382DE784AC
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=rorPIP5j5NnvLe/VG3SBvJuviukORjr0ptic0PGw4zI=; b=CUYaXID00Iyzut
	fYDC6arsShKtaXJe+aeNO/mEi06dLkV/kiScFrrpiF6Or68Z1itxtMO8plAKWXW1e09LeZ9yz+jNo
	MRooxhde26U3WvsWPulYvw5fuyDN71yk70zFFM6CZcQKajX9da0ZrLofukGNo/cBYHTMfiNHUXxfh
	+2P5wrCNF4Kb2zaot6oaN6j3ST4dxirIZbUDpNX5BsQPaTL8Kmw/AGHW/jYegRu8Ew4pAjYFTgA/i
	trlZOvkFvrcv/P7J2CMS31EThPJSpiyx+IsAeHAWv3BWCyCMBuI2UF8UcGOrPi6rzBLxIq5pBJAYc
	oj/sIa+zxUQlQeqsCsiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnIf6-00ClEV-1h;
	Mon, 02 Oct 2023 13:08:36 +0000
Received: from mail-oa1-f71.google.com ([209.85.160.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnIf3-00ClDk-0R
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 13:08:35 +0000
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dc580ed1e4so33828552fac.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252109; x=1696856909;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rorPIP5j5NnvLe/VG3SBvJuviukORjr0ptic0PGw4zI=;
        b=bL4Vl8XSynEoulUkDFM4NTFo9lY163KCwlTpXK5ayCEs2PtSAjgZGAGOZkV6S5pDq6
         xcOHNQMCygPPkmzSLqeOsn0lvDo4fyO0Onsj2NvpRBN/WejISYd+DXo71Q4bF98A1NPo
         j0ir7dOZIBMSh5kKQPqoNVLspA/aUC3DmECMdWWcwdN+SyyRKxvW5EWf+zuOGQ0hfeFF
         Pozgd0S0N9DJk8AXsqQSXsUS7nH37RRFtD8F3v6FpbXXzPHoN58FUOqcDPhAL3+giWbc
         X+S2tKb5IeDb7KJaakhrfIPw9ph5n9iy+Umas2PBEAEP6vjJpThC1MJ1PVgVkq0w1BIT
         IK9Q==
X-Gm-Message-State: AOJu0YwWzqFEKgALrXdkd6U9suzsYHe4hz0FZh0TAqkCBVK+DzSyx/8y
	iTxUljh5pYnferxhBGFOf+7uvhkUuHXuJuUrN3ujdMHMIRha
X-Google-Smtp-Source: AGHT+IH15olfXP89zOaUgPnZ+A3LWHTnmJnCU4ut1cZEZzpYg/G4sHkoNl3GWJ2A8/7WTnzttgIAQ3N4O8oSXKkeG9zcRAHK4fyE
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aad:b0:1c0:e7d3:3b2d with SMTP id
 dt45-20020a0568705aad00b001c0e7d33b2dmr4872328oab.7.1696252109232; Mon, 02
 Oct 2023 06:08:29 -0700 (PDT)
Date: Mon, 02 Oct 2023 06:08:29 -0700
In-Reply-To: <000000000000c4c9d405f2643e01@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ba21a0606bb78f9@google.com>
Subject: Re: [syzbot] [bridge?] possible deadlock in br_multicast_rcv (3)
From: syzbot <syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com>
To: amcohen@nvidia.com, axboe@fb.com, bridge@lists.linux-foundation.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, hch@lst.de, 
	hdanton@sina.com, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us, 
	kbusch@kernel.org, kuba@kernel.org, lengchao@huawei.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org, 
	roopa@nvidia.com, sagi@grimberg.me, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_060833_176900_670F8374 
X-CRM114-Status: UNSURE (   4.53  )
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

syzbot has bisected this issue to:

commit 0ae3eb7b4611207e140e9772398b9f88b72d6839
Author: Amit Cohen <amcohen@nvidia.com>
Date:   Mon Feb 1 19:47:49 2021 +0000

    netdevsim: fib: Perform the route programming in a non-atomic context

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13afdae6680000
start commit:   2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106fdae6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17afdae6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaa4b45720ca0519
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aea34ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13001e91c80000

Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

