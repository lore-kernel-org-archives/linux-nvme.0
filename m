Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2120DC77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 04:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cZ5p27Ch8EN3/RSWfPZx6M9xpF1lu0FZ1tREE2h5NgU=; b=cnI7uPtBdlnjGZMrNLlKp6lp9L
	xovS2NpYSDxi4+XA6aTB/NTWhNvXS9lklID5jpzuHy88eBTG0hixp8GFFqJTaM7Hvjmu5dAOJ4Ace
	tQqrgexnMt3BcYuU+TuqAgC56Xzb/YptFoUrFRvkp+i+Pas6rpq0fSyRyhKIA4Kqw+HTwc6dptp4y
	QE7HJG56Luia09Udmft3Nbxzb/UvbWTF+ykpcT409apzJWSkFfbSBKc2+5TdPmz+/y6Gnpp3MtNWz
	UrrWJ2CL+KNQWr3UruoXJ0nYSvVrf/qfwYdbFSB+bTkjeQsTaMKrBx+AYAaWfvcBxZF6JHgOS863s
	AG1QI3Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pthsa-00082T-0N;
	Tue, 02 May 2023 04:44:44 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pthsU-00080P-12
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 04:44:42 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so2189402276.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ds-gy.20221208.gappssmtp.com; s=20221208; t=1683002676; x=1685594676;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZ5p27Ch8EN3/RSWfPZx6M9xpF1lu0FZ1tREE2h5NgU=;
        b=1L05DzbmmgY/HVGeWwo0brU1DNJnNJfWyBGrsOQsDfy8Kb/jSV/wndEY8y/lyyWVaE
         EjjaloHXVKjirE8vDId9XWI37ReKPtjqOooUPZVnECmzE7u8k1g6DCqXPTSBO/JjM4qG
         aI+/nl8SlquVtr84b9yIUdVl1uDvWdsMd0p+i+Khjo3fbvcGC6K/l+VGCg6HGpFk3F3p
         uVwa81FNUOPGFUr+bYYBf80bwTBN2IDQCJQeZhPTk+bQKdQeakTRLLYAtioJrAOKT0X7
         Uai7ohM4GiKc8YZ72GV+F8/dAJoxglT9zfsfozk03gpEGpqm+oz5S1ud3Ut6OCvAiOtQ
         UtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683002676; x=1685594676;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZ5p27Ch8EN3/RSWfPZx6M9xpF1lu0FZ1tREE2h5NgU=;
        b=RrsrE38b8NRAqYs4Ut21EKpVezlqK7ZsxMTayO+s+jl4JupYppMSnw5Q42ii6mkFWf
         6x8VNKmuLLqDNOBV0z3Mqan4FJvYczyZdeKKXuMzXMTgg/VDeWQK06aokMuuychEE99h
         Znr44dLCVnbjTCbNY5JzjxTPHzf7U6nJne/+atFlrJdlaZO7TwkuCeI85SI0Fld4LX2V
         taM7uffMIsvYMSEJdp5P3+3TcvDzY/bvofQKwCF3sBjZXluz18/4ohPV8Oh2EovwwCI4
         RzbZqrSoWsTa/3Aha5Y4p09Yic7y7gNPLqC4jzMV+x3wOaDIWZ6zJPGA+Se2RDDtLpKR
         WRDg==
X-Gm-Message-State: AC+VfDwuoD8XJTlgsqiVuds5r+YRG+kerV3u9TCT+M2TiFaem+6v/xPv
	CqF1v7sE8Lwo4Xq5sJu83GDAFrRn14lAPXR6vGDsbb9Kujpy8Ss6mQ8=
X-Google-Smtp-Source: ACHHUZ6Vheicl3C6RmLdZhRuzB1Jzxy0LP7oSuOj8VB2VV2sSDgl5Ntc7mfR/ouOaPyNTQv8QS1Sx04kO9pVxjcAhzg=
X-Received: by 2002:a25:760b:0:b0:b99:f3ab:8a43 with SMTP id
 r11-20020a25760b000000b00b99f3ab8a43mr17276589ybc.38.1683002675938; Mon, 01
 May 2023 21:44:35 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Smith <dansmith@ds.gy>
Date: Tue, 2 May 2023 00:44:25 -0400
Message-ID: <CAKv4OQ08jfk6r-c0T9U-WtZ6ORt2kbR0ARiH1isav-uFZYoYpQ@mail.gmail.com>
Subject: [bug report] Duplicate IDs for nsid 1 on another drive
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_214438_562784_824E900B 
X-CRM114-Status: UNSURE (   6.33  )
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

Hello, I ran into a shoddy manufacturer which duplicates IDs in disks.
In this case the device is:

VID:DID 10ec:5765 model:TEAM TM8FP6002T firmware:VC2S038D

I was able to set NVME_QUIRK_BOGUS_NID, build, and verify it resolved
locally, but I'm completely out of my element to submit a proper patch
for this.

