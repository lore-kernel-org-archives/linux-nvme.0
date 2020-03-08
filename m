Return-Path: <SRS0=8bm+=4Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C93BC10DCE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 23:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEFF206D5
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2020 23:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4Du699r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvOzg0Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEFF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=gN7TKVvSxLOUZxSQ33ntGv5cYjudcK7FU0EWwrNyLWk=; b=u4D
	u699rhbr7HSj+DMVbwns27ahwAp7PuxjOG03Ph63Iu1UqOLeVman5qM4X6wKmBHo8vaE+NkDASPU4
	bQNynLw4RgwlScX6b7j6+1KJeoWiCKS7ggrDgi8WxyUKcGfQgLObsF63Zc80GELbJwDey6b0H/RIN
	W/o0yM2fSsvbeGD0biy9xdnN5m7FBRR+jX8cZzv6BDQKZ1izZNz2rG2PnXUA8T+Yhb8BHBikwD7ri
	8iV4Yc/tXxfpEmjo5t0wXIond+uRL7qI9eDsr7W+WjYU7RuueMvjYCHfUzkevrKhqnPL7pr2DYQrP
	/wnZLr0M9B79vNSzKsdHpjNYWMjPKQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jB5d4-0003MM-RB; Sun, 08 Mar 2020 23:46:42 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jB5d1-0003Ls-UK
 for linux-nvme@lists.infradead.org; Sun, 08 Mar 2020 23:46:41 +0000
Received: by mail-lj1-x235.google.com with SMTP id n20so4971476ljg.3
 for <linux-nvme@lists.infradead.org>; Sun, 08 Mar 2020 16:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=WrEQo0fxjLuxSsMKiCUU4lFEo1LrvQq2dtfANUgbpTs=;
 b=WvOzg0LgF/neHwYPhoIindl2uSoymm71V3n/BwNFVx4GH1lHatghi08MFhR/XUefyH
 9kmnllxiyJyLw6tGfNBsxXvR8OqcrVpe7S/oP6wqcg9S3R2D787+g2RHcD/x0YO8q10n
 joz0Db3S3b5Hb3XDXRlCkXW0OaDkXw49zLc0H2G1IaAyr7efEIrG/n+nlsjrhkYtKfpK
 crag0VzsXyugrQWcPiclAXdR2QAY7mR4xvp5JgLTliVOlZqs1xvH4MxqTZjiVMAFDKW9
 HYRPEmE5cAyc5dwh9eEK7WDB6JHRQZxZtEps31vDBE+IvMHTH72M3yPDkGYOQC6q0WMi
 LsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WrEQo0fxjLuxSsMKiCUU4lFEo1LrvQq2dtfANUgbpTs=;
 b=OjDCkx98/0gL27aICMNlZsw/owMK616Deb+sAUi0fkgpGvGPWWowRWgTNGQUUrSuu1
 cfJBlW/QX14cBannWvIYUlWgTKFU///3E+Uar6lupaxlUDr5o3ESCmnd4/YvkYdbyHJS
 Irp+9VmKXcQIA0t/L2iZlLbwcCYkxC4cxWB57k+1ormmUoS5aVPqs7muwWjLTuowUHSm
 fw0geBLM8zKEbEZGtUa171YwY0/oZTvEv0xbBaOms0vkd8jwzbGw3wxD6/Oqmr3YzWY6
 oqfKdcX6nZK5N9c2fxm+5tSdgFZEQAsrMq15jzNmn2pw2Dhjcizo6sWQGPuzxLit2arz
 dJCw==
X-Gm-Message-State: ANhLgQ0XMi0pG7yETSlXQZ0KabJYofdOD5XconbnC5uZZrvIlY1UbC1m
 disOad+0GX6xHGqhg1ZMaCKqqtcFtwlx0OGQsVRbdk+3
X-Google-Smtp-Source: ADFU+vvLEiHfPL045/PPYdVBav0t58IJgmahZSEbIV0717M35to6UzPKhxtzthqEb/ZEAq63rnaYx37wZV/7zm4HPSM=
X-Received: by 2002:a05:651c:38b:: with SMTP id
 e11mr4358002ljp.37.1583711195683; 
 Sun, 08 Mar 2020 16:46:35 -0700 (PDT)
MIME-Version: 1.0
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Mon, 9 Mar 2020 00:46:24 +0100
Message-ID: <CADS+iDV5S+QyfhE4M+fSwXuczx4WCveU+UyhKpx7HY6pfHfc6A@mail.gmail.com>
Subject: NVME is not using CPU0
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200308_164640_001499_A7E70A08 
X-CRM114-Status: UNSURE (   5.67  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello! I found that my nvme disk is not assigning any queue on CPU0. I
think, that maybe it could be a bug, related to admin queue. Function
queue_irq_offset return 1 with note that this is for admin queue. But
on my system, admin queue is on the same CPU as q2. Here is part of
/proc/interrupts
            CPU0       CPU1       CPU2       CPU3       CPU4
CPU5       CPU6       CPU7
 127:          0          0         28          0          0
0          0          0  IR-PCI-MSI 2097152-edge      nvme0q0
 129:          0     155413          0          0          0
0          0          0  IR-PCI-MSI 2097153-edge      nvme0q1
 130:          0          0      23274          0          0
0          0          0  IR-PCI-MSI 2097154-edge      nvme0q2
 131:          0          0          0        954          0
0          0          0  IR-PCI-MSI 2097155-edge      nvme0q3
 132:          0          0          0          0       1541
0          0          0  IR-PCI-MSI 2097156-edge      nvme0q4
 133:          0          0          0          0          0
1376          0          0  IR-PCI-MSI 2097157-edge      nvme0q5
 134:          0          0          0          0          0
0        851          0  IR-PCI-MSI 2097158-edge      nvme0q6
 135:          0          0          0          0          0
0          0       1419  IR-PCI-MSI 2097159-edge      nvme0q7

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
