Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ohu20Gei/ORrqs2QS7qZhTZWRQML4W4vk+6nw675mBs=; b=nMiEDiZtn6BFLj650FJ9ujuLUJ
	z9xgtFGcDTOb3zX/eD+ujMkHHRJcRgYnH9lGaa/YWXXXO8xGnLFmPHeXa05DSxn9bvYRRgWW/9LMU
	cLdCvNLS29QvfZ/AvCMtdGCIni+k5zVdgQjAAXpQDni1oIaPZbbED9G58JJavx428B9zZGZKZh6n5
	+iVs5ULousOOJJNYNCI6LV6deKUtqaBFHuPl10F7g0sOsmHmFkYZ7zbwNyZY4C2UUZ/ll+N3YimAn
	ApHMaN2caBsYpDX/73+phmftUpBFFlnPj0rpTIwjWUxM+E6KCANTUX8PW0NLB54YhRMhHKR/Tt8tD
	GVN8CJUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqvib-00DQ5M-6f; Tue, 17 May 2022 11:50:25 +0000
Received: from mail-io1-f69.google.com ([209.85.166.69])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqviY-00DQ2b-7S
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 11:50:24 +0000
Received: by mail-io1-f69.google.com with SMTP id
 l9-20020a0566022dc900b0065df0aa8372so6306377iow.6
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 04:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=ohu20Gei/ORrqs2QS7qZhTZWRQML4W4vk+6nw675mBs=;
 b=BhZfO6T/zczmt0dfJXAb9EUcTwV/dTzfNv7gLAdYb1rQREx3wqa+TN5HYCe+aq4s6q
 QxHFJZckUU6aQuHd5kDAKGFvsCsmiGhgsDdYYAI8AdwjYTcNyeJQJ3OzS2rkAFH4GdgT
 267XI4wYR3qrSLZh0HTHUdeoxWtLgkSxuPcnr3rCEu5LFpmu0SNnH6w0OenTVvqW0jEJ
 oN1vSiWwZf93c4R2xL7uADcNiwX2MpSbgPfaZEni6rdS1kCAjtinYbnnXWRjBXLDD1Km
 u956+0q21htxNCrRR/ArV1EHeJXgBEayy2N8Ad4tNU5WTbJgpGKTgRWPwnH/gFdBiJUa
 RN8A==
X-Gm-Message-State: AOAM530xncZIlVHqOnOCvtD1Ig2XNWgXRKktG3526WmOQ2vouI0ZohBn
 GglPJ+3tF0fLeMYlgOrhieYo+PZsfWSzvzzQBBlJukIsO+ar
X-Google-Smtp-Source: ABdhPJzGQpSEEHGpXaDF+BwJwyVS5yee9rx2BeXMo+M4VKfJGc/JNONGpbBDwPiPxS5/InacMv1SoM7iYfNMnRNAlUiGhc/OEguL
MIME-Version: 1.0
X-Received: by 2002:a05:6602:400d:b0:65d:bff5:4f35 with SMTP id
 bk13-20020a056602400d00b0065dbff54f35mr10076844iob.199.1652788219320; Tue, 17
 May 2022 04:50:19 -0700 (PDT)
Date: Tue, 17 May 2022 04:50:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3a1f405df33be01@google.com>
Subject: [syzbot] linux-next build error (13)
From: syzbot <syzbot+7013da477748d0b624b9@syzkaller.appspotmail.com>
To: axboe@fb.com, hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, 
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
 linux-nvme@lists.infradead.org, sagi@grimberg.me, sfr@canb.auug.org.au, 
 syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_045022_319992_29714E0A 
X-CRM114-Status: UNSURE (   5.72  )
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

Hello,

syzbot found the following issue on:

HEAD commit:    47c1c54d1bcd Add linux-next specific files for 20220517
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137f0301f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95ad7f734b04ada9
dashboard link: https://syzkaller.appspot.com/bug?extid=7013da477748d0b624b9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7013da477748d0b624b9@syzkaller.appspotmail.com

drivers/nvme/host/fc.c:1914: undefined reference to `blkcg_get_fc_appid'

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

