Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A392AECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w2jmY5c/VJFR0cMGF07LWkMDg3U9MOujoTH2mCBuU1U=; b=uPpo37bY6VkIiTHb7xlL8qo6W9
	sWA58QrbkIYvksFVaD+Olnkh3XUGws+TQMqXqIKKItHp3SIWmRr0hy03+eGtOxnnbzrh0IT44KiGh
	3ZZUVcj2SjIS7hFZ1yQSGRSVTczMsS9LO9UmvZU6XbSQ3IDhtX7mJ1hr0y6c8xOBLrUI8nYuLge1z
	mqNxYLJN12H+E93egzF6MQSnzeHTS+4cy57m4slx+0KoS9C1Wl9JR1wfV2jGJwaKBG8a/HIgv4Zes
	1LtGssDZL9lr0n0KQg973/8vOvWNc548aRAbxhRhBKrwwNO7xYnp1u6v6VdcR0VkvIJ6xHDRKOFSR
	0ljy1qLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoBv-0033Re-ID; Wed, 07 Sep 2022 06:05:39 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoBq-0033Pk-4I
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:05:35 +0000
Received: by mail-qk1-x731.google.com with SMTP id w18so9777714qki.8
        for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=w2jmY5c/VJFR0cMGF07LWkMDg3U9MOujoTH2mCBuU1U=;
        b=Ir5LnnHhr9d9cxFZOEFH0jYbgxxaLwQ9lvm9X65Miw31xsRbTLUujUcLpKDjnH0X+I
         yznjHfAPBRydlrd0sfnP4uOgrA2Jg5GG0rrY+MpwzTPUH2c1R4CtH9BCRTo8fyWqjLFJ
         8cwGDJDZUu57B/JvVmvSEmm1OiFBM6sLtbqPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=w2jmY5c/VJFR0cMGF07LWkMDg3U9MOujoTH2mCBuU1U=;
        b=MPta2jUUnW7+qbcdq/jciJurY9hnZus47lhVB9QWa8CC5hW6i9hVPi1hvo9FFuRaqm
         LSHtCM9UoLSDxMDwpUX6HXNKuxZ9FEqpQywJ6nxU999IK43taFB14XLqBfMLxIagMXO0
         FfvVu3YvYugPxxSLWMN0Z3rf/EC0u0aGtj0CDL446onOENBz0dEMrZuGPkAnL3IGkL94
         k0EWTJp0J+Ic+1weNrF44R/0ZAViwel9WO5mnqBWwQ9CQdw9o2J3W0lSxh9xHZXG5wfW
         W8upO7B9zBe1VFDAV8s5GQ1MTn2CGLeiukDwhXUE4JNolNYfgYztl++v2BYxkKWXHuto
         gVKQ==
X-Gm-Message-State: ACgBeo3e6sMEBOfxqO61M3j60g5E8VqRNNLV4045IHTfi1dLXqskvNnc
	g2prh7XvanXH7BsyjNjtmHnwC5w1xjULMLbtjc5ItHN2XMI5mA==
X-Google-Smtp-Source: AA6agR6eUiCryPl2D1H8dBAGdQZaH2uJtPODy24EZ7rhp623BEEW9jaJ0iS3mlFSwBEdumoWF5AuvFYRR7ZxOekGgko=
X-Received: by 2002:a37:c84:0:b0:6bc:2562:d756 with SMTP id
 126-20020a370c84000000b006bc2562d756mr1586133qkm.556.1662530731164; Tue, 06
 Sep 2022 23:05:31 -0700 (PDT)
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 7 Sep 2022 08:05:05 +0200
Message-ID: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
Subject: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc. NVMe SSD
 Controller" from 5.19.y (issue bisected)
To: linux-nvme@lists.infradead.org
Cc: niklas.cassel@wdc.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_230534_400159_018734A3 
X-CRM114-Status: UNSURE (   7.00  )
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

I would like to report a regression issue in 5.19.y in NVMe driver.

The issue is reproducible at AWS EC2 instances with local NVMe storage
like "r5d.*". Kernel report "IO queues not created":
[    2.936641] nvme nvme0: 2/0/0 default/read/poll queues  <- EBS volume
[    2.939493] nvme nvme1: 2/0/0 default/read/poll queues  <- EBS volume
[    2.940797] nvme nvme2: IO queues not created              <- Local volume
with 5.19.y (kernel 5.19) and the nvme storage cannot be used.

I bisected the issue to commit
"aa41d2fe60ee2e4452b0f9ca9f0f6d80a4ff9f9d" (nvme: set controller
enable bit in a separate write). Reverting it makes the nvme device
working again:
[    3.025599] nvme nvme0: 2/0/0 default/read/poll queues
[    3.032467] nvme nvme2: 8/0/0 default/read/poll queues
[    3.040040] nvme nvme1: 2/0/0 default/read/poll queues

Best,
--
Jaroslav Pulchart
Sr. Principal SW Engineer
GoodData

