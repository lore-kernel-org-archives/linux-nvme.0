Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD756C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:
	Mime-Version:Content-Transfer-Encoding:Content-Type:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+0MdUCVV4O7Hy+DSTt/GEWee6SmkG+e+DuQNObNAooc=; b=D+EO+U4VMNYFCv0iErDYr75Moy
	YDIb2sjG7g6DH1oS5nhTUP//Luq2B4qDPTDLmITR8jiMxNNc8cSQ0lcBYrVxnYFmdZoCzQe+poCAv
	Y2lkIwapaZnZN4UcEebPIRLuStNtvbeuf/uOqWJnM91QhC5A44n6xRMZZ1Wu3BaDHv9lGCmFFK1Mz
	x/iXP2jYTGHvelRrpTE5iy2A8PbKCiGoqw3L5te/JMgbS86Rj7GAsyJnwYHL0AkPaclBPM2hAXOke
	szL5KCDXErjDPV0k23oyZRYSa7wFNJyUHtUAMDVd9p0pf+UHUwR5GGBTfJo21x+yZofdeicRwDlUY
	tb09Gvmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIDKy-00000002Bn0-19fY;
	Thu, 22 May 2025 21:20:24 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIDKv-00000002Bme-40Nx
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 21:20:23 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3a4bdee0bf7so914688f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747948820; x=1748553620; darn=lists.infradead.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0MdUCVV4O7Hy+DSTt/GEWee6SmkG+e+DuQNObNAooc=;
        b=BmawnqFIb86J38Co8bVz2za+f57hpT+BHbWrKzJ+k0LZNn/ZLQxLm/ADu50oK8ysYa
         ov+H3f+CNbjk1V9VgvEPJZOizzB9lxBXmlAoslRYbH/7zRq2/3h1533gKeDiQzRhmp/F
         cka/mxCPyTBvDDEM7tHxDtOKJYSt+qgzfH4zNe7+AO9eponIzlf5bmiHRXTiYbvzjdgZ
         DqDun7Biv+YST5n+Bma3A7Tnf2+g2/zaMJInx9h+oD/WuH52ZMB5egkt0jddgAwfBFyn
         et/dVDPxltt6nvdSTXwci13ptbVbNH0ZcjCt8ZuPWb4a+mNMWjYdSWit1ij0KIHeTMX8
         FWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747948820; x=1748553620;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0MdUCVV4O7Hy+DSTt/GEWee6SmkG+e+DuQNObNAooc=;
        b=Vy+11jzrkmP9xamfPSBrHnXaXagdljmuHG/pFd8a7zi8QFkvdXr3lgnJKroivK9eTu
         KdetWpYYlzjSBnLnkLmvAhseQfiV7B9le85f24TWhjPyfa3iTInEwN2uYd9xpp3XUHXY
         NehfKmePPmUNqPS2PZByP5x4SiAnB4F3Xutc4QpwJSEPZw7rXyXAJ8iur4DpEGGAgxRp
         pT2ODE5Ck9jqDFf/1ItvRmMLOKTD0HmvDgcRbF8nX+/+ZwgTB+BZPGfO1eNCpRpy2jSZ
         d/X1pEhJ428UsnOxVsaGIwA9SFQMiV33KvjS6N9ZrrSRUS7IBGHLBdpj0kq/Qk/eSqna
         fuDQ==
X-Gm-Message-State: AOJu0YyflIXSP6NXZHEHmaPeGniaw7Y6YFfbWdnxCCp2RKN4N/n4iYii
	+hgEqOYd+PXfoWaO5dbWkJRaYJcHXyFTuCRMuABluut7UOf84HBZOSqO2R6jEg==
X-Gm-Gg: ASbGncuwdheG9Vewq4qDrcerovvmKI5GwOw9sBHpc2cS87YzbwdWvv3Gy50SmihG4Ml
	Vq40lquH/RYIH0IXk0nXVYAClrdsuxpitlO15P4W9IsFcrVuIGpQQnlmqIJETWVg+3K9uDAow3c
	Yi0OjS1Kf3WdGd0F6ogZKTkWHU7XPe7qQzI6fvab3tWH0moFFKX4FlBvL5QAJefiV48C34Nuq+H
	QN9PPhzN4qpRGqhqDqPdWYAbeJAvsuzWkk/MwCO8ptL96YfzU35U/LJ7BQMgvRnAzU2KLQehzVE
	hgeqnwayMCi/KeWCHMQMLfgT9FBqYTuOOkFhWuTd1xKOvYoJ1MlURLN5UsaAydmzKZFRVzYW8VC
	sgReTHLMzLV318NIAGd5Fd2wrZdWvo5I=
X-Google-Smtp-Source: AGHT+IHZA0XZKtXaeqjKvBkyxLj54xo8mXy+BIN+t94qo+ramkLDVuzeEnzzJNy4GewyUsJTDboEKQ==
X-Received: by 2002:a05:6000:1866:b0:3a3:4a1a:de6f with SMTP id ffacd0b85a97d-3a35feab1bdmr23233256f8f.26.1747948820106;
        Thu, 22 May 2025 14:20:20 -0700 (PDT)
Received: from smtpclient.apple (net-37-179-88-46.cust.vodafonedsl.it. [37.179.88.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5aba3sm23880518f8f.40.2025.05.22.14.20.19
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 May 2025 14:20:19 -0700 (PDT)
From: Andrea Mencarelli <andrea3000@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: APST not working on Intel p1600x
Message-Id: <0DCCBCB0-EBDE-402C-94BF-50A3CA6D58B7@gmail.com>
Date: Thu, 22 May 2025 23:20:10 +0200
To: linux-nvme@lists.infradead.org
X-Mailer: Apple Mail (2.3776.700.51)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_142021_997621_692A47F9 
X-CRM114-Status: GOOD (  13.45  )
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

Hi,

I=E2=80=99m reaching out for help regarding APST not working with an =
Intel p1600x 118GB drive.

I have a system running linux kernel v6.12.24 with 2 nvme drives:
- Samsung 980 Pro
- Intel p1600x

APST works correctly on the Samsung 980 Pro, while it doesn=E2=80=99t =
work on the Intel p1600x.

The available power states for the Intel NVME are the following:

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +     5.50W       -        -    0  0  0  0     1000    4000
 1 +     4.60W       -        -    0  1  0  1     1000    4000
 2 +     3.30W       -        -    0  2  0  2     1000    4000

It supports only operative power states.

If I show the auto PST entries with this command: nvme get-feature =
/dev/nvme0 -f 0x0c -H
I get a table full of zeroes (I=E2=80=99m showing only the first few =
entries)

get-feature:0x0c (Autonomous Power State Transition), Current =
value:0x00000001
        Autonomous Power State Transition Enable (APSTE): Enabled
        Auto PST Entries        .................
        Entry[ 0]
        .................
        Idle Time Prior to Transition (ITPT): 0 ms
        Idle Transition Power State   (ITPS): 0
        .................
        Entry[ 1]
        .................
        Idle Time Prior to Transition (ITPT): 0 ms
        Idle Transition Power State   (ITPS): 0
        .................
        Entry[ 2]
        .................
        Idle Time Prior to Transition (ITPT): 0 ms
        Idle Transition Power State   (ITPS): 0

As you can see, APST is enabled. If I understand correctly, this table =
should show idle times only for non-operative power state, is that =
correct? Or is this the first clue that something is wrong?

I tried both setting default_ps_max_latency_us to a value larger than =
5000us (ent_lat + ex_lat) and by setting force_apst=3D1, but the drive =
remains on PS0 at all times.

I can manually put the drive at PS2 with this command: nvme set-feature =
/dev/nvme0 -f 2 /dev/nvme0n1 -V 0x2
but I can=E2=80=99t get APST to work.

Do you have any suggestions on how to investigate this further and make =
it work?

Thank you
Regards,

Andrea=

