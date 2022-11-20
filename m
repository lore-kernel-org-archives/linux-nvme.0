Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA5FC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:From:
	Date:Message-Id:Mime-Version:Reply-To:To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A/l1Y0qAN4hTYqzDIPOQtrpLivbhrove9YLZsjDBhXY=; b=nJCqGIIdnAnVPl+ZKX/Nak7vMm
	aR3Zu2JAxwrqyBUV6IoykYipX1E53wKP8AcRFZuIxm74p4duMYVVcO1OfqOVCltCWBsBVTkzcQRYr
	jrMcYPMYNc4iBj7AIxyReQv4gEaPuV6YgE8pB3jkLeWijdgl2LhV9IRDzAmDTPBAwdE6gDoLPLKCO
	TP++WL4OUHPE6FKw74gCNmSsuuen9F3ISaw7L5WN1RnuI+yLdiRm3FdbnrGf8sIfn/c+94KUNbYfe
	dqInoacEi4fcwcOR3oVLbxImael/EZ+Kp9SmXEPdiNZJ2/5x0UYKg8w7Xku+hvQc3EXKsH/z4yVvO
	NgoiCyRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox0aT-009yAH-HU; Mon, 21 Nov 2022 06:47:25 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owqcm-006lAH-Oa
	for linux-nvme@lists.infradead.org; Sun, 20 Nov 2022 20:09:11 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C24665C005B;
	Sun, 20 Nov 2022 15:09:01 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Sun, 20 Nov 2022 15:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668974941; x=
	1669061341; bh=A/l1Y0qAN4hTYqzDIPOQtrpLivbhrove9YLZsjDBhXY=; b=N
	hb9+fYrrigI3KxlY/Xw+wwrh6mktNlLsNpp1wZLwIGqB1B2JtlV83df3Syq/fv6U
	DY43+W9JA5FipwBbm7e3CflcgGL3ybluWQvqag22ucC0/SUsXGMqkAY79F5fRnQ+
	nx8IJoboDUWORpH/lwaZyzVniympVlUqGqvVjrRAHaYgnWBfCvHXp9Ibmg8X3FNR
	vbaOYDzvQtaQbEhjn4W13LXjwmmIJBm6ts1ObFnk8dLBJfXbRe6RH7hrlyCKHlg2
	uWFLkvKRPcCu7NBe1mB/GdzsMM6n/IlFdex2yu1LIO8kIJKTgnb8jAZTv+YLzWUE
	8sX0xM70zN86NFJgxisOw==
X-ME-Sender: <xms:XYl6Y8t4iF2FtDL21rfqdGvf7DIDGTeIduwo60ChBM76xNlMsDVWPg>
    <xme:XYl6Y5fsuxw5fl106vN6fYr4fGtX4OC7s6f3vcO6RXgkrdGMe-EYryzT5vVFQCw9L
    D7nVHDhlgxXcvVabJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftd
    dmnecujfgurhepofgfggfkfffhufgtsehttdertderredtnecuhfhrohhmpehthhhomhgr
    shcuoehthhhomhgrshesphhouhhrrhhivghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fftedtffekieffjeetteelieehgeekvdevleehheejfeevfefgffegfeefveeludenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfrhgvvgiivghsrdhsohhfthifrghrvgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgr
    shesphhouhhrrhhivghlrdhorhhg
X-ME-Proxy: <xmx:XYl6Y3y-Jxfhiqpz3Klus1WKdbDQjdOsgCYLRyyTjXzjV1CY2kTDAw>
    <xmx:XYl6Y_PuQvhH2m-DodW9LscMm2a7gHN45iOSUDHXPD2KpG4NrhorbQ>
    <xmx:XYl6Y8_TdRXKQyJGF7F9rKTclKlZxFzhgWLrPNHqXr6KiHZ6dlCK_g>
    <xmx:XYl6Y-Lrc92Hyltj9pAnlkdLFFkPrKiC92B98wbeRVoOvSecLUo6ew>
Feedback-ID: i1ac9442a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3785C31A0063; Sun, 20 Nov 2022 15:09:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <364007fe-1575-4609-a183-835ca1015d77@app.fastmail.com>
Date: Sun, 20 Nov 2022 21:08:37 +0100
From: thomas <thomas@pourriel.org>
Subject: [Bug] NVME controller down (Seagate FireCuda 530)
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_120909_135891_F8C0BD79 
X-CRM114-Status: GOOD (  11.19  )
X-Mailman-Approved-At: Sun, 20 Nov 2022 22:47:24 -0800
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

Following a recommendation from https://bugzilla.kernel.org/show_bug.cgi?id=216709 , I'm posting this here, in the hope that it finds a resolution.

# ISSUE DESCRIPTION
A few seconds after GNOME is started, the NVME drive that is mounted (but which is not used to boot from) is inacessible. dmesg output is:

> [  281.692677] nvme nvme0: controller is down; will reset: CSTS=0xffffffff,
> PCI_STATUS=0x10
> [  281.778102] nvme 0000:04:00.0: enabling device (0000 -> 0002)
> [  281.778436] nvme nvme0: Removing after probe failure status: -19
> [  281.797929] nvme0n1: detected capacity change from 3907029168 to 0
> [  281.797947] blk_update_request: I/O error, dev nvme0n1, sector 2786568960
> op 0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 0
> [  281.797972] Buffer I/O error on dev nvme0n1p3, logical block 308281696,
> lost async page write
> [  281.850852] FAT-fs (nvme0n1p4): unable to read boot sector to mark fs as
> dirty
> [  343.901432] EXT4-fs warning (device nvme0n1p3):
> htree_dirblock_to_tree:1067: inode #77070337: lblock 0: comm ls: error -5
> reading directory block
> [  343.902354] EXT4-fs error (device nvme0n1p3): __ext4_find_entry:1658:
> inode #77070337: comm test-nvme-write: reading directory lblock 0
> [  350.028540] Aborting journal on device nvme0n1p3-8.
> [  350.028548] Buffer I/O error on dev nvme0n1p3, logical block 223903744,
> lost sync page write
> [  350.028554] JBD2: Error -5 detected when updating journal superblock for
> nvme0n1p3-8.


# WHAT I'VE TRIED (without much luck)
- I've managed to install ZorinOS several times on the drive, so the drive works long enough to have everything copied and installed.
- On the first 2 Samsung drives, I've managed to install Windows. I did not try with the latest drive.
- This is the 3rd drive I'm testing (tried with 2 Samsung 970 EVO plus 2To before, and now with a Seagate FireCuda 530 2To)
- I've tried with either kernel parameter pcie_aspm=off or nvme_core.default_ps_max_latency_us=0 and finally with both, but I get the same result in all 3 cases.
- I've also tried with various values for nvme_core.default_ps_max_latency_us (starting with 5500)
- If I boot from the drive, starting in recovery mode, and resuming normal start, seems to postpone a bit the freeze of the system but only by a few minutes. But it still freezes.


# SOFTWARE / HARDWARE
- Linux Kernel : 5.15.0-53-generic
- Distribution : Zorin OS 16.2
- Motherboard : GIGABYTE B550 AORUS Elite V2 
- NVME Drive : Seagate FireCuda 530 2To (latest firmware)
- CPU : AMD Ryzen 5700X

Thomas.

