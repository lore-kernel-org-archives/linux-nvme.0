Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6D6FA3740
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pTxAEVObSLtaTlmkhmOoX55bsSwOFzCTAa6efsJQdds=; b=U68aFIUMzxScFs3TkZAxipLedn
	mp9j92ioqMOi7YKiCUX+YIAHSm1/4pDEOuY58F8A5ea/2skoScxlXxlJXYOS2H6qOviAh6EarQN71
	Tui4EPceG0V7XsILZT6JEBgCUxOzVNIPkbhJd1dh5LrlMQCMHQPNm3rGW09i4ZYs+Y/A7jL2vT0fY
	UHJGyGHnVh4WG0O9X9jBaAYse4+PThCMGDeGtjjorgs6fQAeBWZSRJ9xjU0TJjmf8eztekfQIUdVQ
	FU93oKAH2/9SFriL/aFZ2PJDW1Sl1Uo8sFR1p7E9vBt6bCyvMEUBjAHejH3dLcDSHkhME3D8gvGWK
	qaABizvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opR53-00A5Hk-Vj; Mon, 31 Oct 2022 09:27:42 +0000
Received: from odysseus.binarus.de ([144.76.90.229])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opR4z-00A5CQ-Kj
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 09:27:39 +0000
X-Envelope-To: <linux-nvme@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=binarus.de; s=b201601;
	t=1667208455; bh=InHLuHtSV14fN4WSIqA0dipS+lxbkBg9orRsPboPHig=;
	h=Date:To:From:Subject:From:Reply-To:Subject:Date:To:Cc:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:List-Id:
	 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	 List-Archive;
	b=Vo4yYg8iXckFr7dh2U2eNwZ8XeCOQpQbGPNpAIytSqeV220VeNyD8bT84m8sPCurx
	 atWaGGToa3bVvYUy7FlVeS/sj1HVxPsrFxYgMEM8X2dA5EF3DhXMVSdqeyD1Pw9J6o
	 OzntKq5Qqga0EmbtRFtSjKvMloj4Pj6xY81drarYI+AX5pGlPusZfgm0S5j/s4SmBt
	 K+JH/E0nXIm4ons1gfftgHVk+34VuRKYSsCTTffi+s696Q3j1TPZL0fNxOc9VhQ+fz
	 csqamwYe8eKpxrDk0Annq3BRfrOfgh85TmKIGBLgDnxoyN7awUzGTkzA4+MPX3UpQW
	 H6G/gjn68YdFzdHECx/crj+bLsXmuk4C8hbNivwxVRW5v75GrX2oogvuTQad3vIUAF
	 4+Hzr1SpU3b0bJL3lot1Xyc1z1uXQA4ASIhTnSJ7zXsJOOvAx8j6Xl+5A0FocpaXJe
	 8MGZWVS8LN5U4WF7cqnJb645wo6jFC0fIPn6/Jd8xDi9kR8UBFiTJay66GnCd6vjgA
	 aJB6y/9HFoDozo4Cy54R/BKrBHoPbtWofr564XHysEJATHWb3KRjh18qfqMf7/weiw
	 Vx4D/1HXu/igzbh+MHLkcLvuJcX4XbB+JmjkoHe/Msru5I/V5UBCsMSD/xGK1CQHjD
	 djddNHnlxe2KOXfTGaKJHnMc=
Received: from [192.168.20.110] (pd9fb9b07.dip0.t-ipconnect.de [217.251.155.7])
	(authenticated bits=0)
	by odysseus.binarus.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPSA id 29V9RYRD011910
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 10:27:35 +0100
Message-ID: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
Date: Mon, 31 Oct 2022 10:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Betterbird/102.4.1
To: linux-nvme@lists.infradead.org
Content-Language: en-US
From: Binarus <lists@binarus.de>
Subject: nvme-format: protection information enabled although metadata size is
 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bin-MAIL-FROM: <lists@binarus.de>
X-Bin-RCPT-TO: <linux-nvme@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_022738_052010_CE09CCCC 
X-CRM114-Status: UNSURE (   9.15  )
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

Dear all,

after having read the subjects of the posts in October, I am afraid that 
a dumb newbie question like the following may be inappropriate here. But 
due to the lack of other options (tried other Q & A sites without 
success), I'll be brave ... Having said this:

On a machine with Debian Bullseye and nvme-cli 1.12, I have formatted an 
Intel DC P3700 the following way:

   nvme format /dev/nvme0 -l 3 -i 1 -f

That command has been executed within a few seconds without any error. 
But in my understanding, it should have failed. '-l 3' means 4096 bytes 
LBA without metadata, but '-i 1' enables T10 protection information 
which needs 8 bytes of metadata.

Afterwards, I have checked the output of

   nvme id-ns /dev/nvme0n1 -H

It is quite long, so I am shortening it; the relevant lines are

   dps     : 0x1
     [3:3] : 0     Protection Information is Transferred as Last 8 Bytes 
of Metadata
     [2:0] : 0x1   Protection Information Type 1 Enabled
   ...
   LBA Format  3 : Metadata Size: 0   bytes - Data Size: 4096 bytes - 
Relative Performance: 0 Best (in use)

As expected, and according to the format command, a metadata size of 0 
is in use, but the protection information is enabled.

Could somebody please explain that in simple words? How can the PI be 
enabled although there is no room for the checksums, and how does the 
device actually behave now?

Best regards, and thank you very much in advance,

Binarus

P.S. From the revision 2c of the NVMe base specification, page 172, I 
also got the impression that the format command shown above should have 
failed. In figure 190, in the first table row, there is:

Invalid Format: The format specified is invalid. This may be due to 
various conditions, including:
1. specifying an invalid User Data Format number;
2. enabling protection information when there are not sufficient 
metadata resources; or
3. the specified format is not available in the current configuration.

Item 2 reflects the situation described above, doesn't it? But then the 
format command should return an error, and actually should not format 
the device, correct?

