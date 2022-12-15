Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CBDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 21:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4IwidVjYeRAGw9i8oj0uK5suXKCULqlTDzDoK7ZSJa8=; b=A4UspJ4++ihNcfhnb9RZ+H6UX+
	H63e6bgvBYUn3hse8Soqk/tlTw6lsrPcQVIsAwdKYQGOdaZ4nybX6ykTBDjYYWtAHtOhQlqPgW1jS
	tCvphbT/Cxvrm6GXxDg3Is8I2qP3iWdlSsCP59Dv4uNQwOlKI7Ck+tkfk8XXNWavjUlp7KyS63n3B
	mZX1U7nN2BEAcaLAmE06bS8MdE0QVcLvso1czNIuayMJ0iFVcPPrUL3iOVWDr2c1uBv6O/7G0gw02
	UgmKFrqrTRVP147kh9m1Nhs5hDtZf4XeWm8Kk26Rm6Kp/bdlzUd7TIO2hdMhD+GK9Ot92G0JLNt4s
	I1kUt+GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5vm6-00BQA7-IL; Thu, 15 Dec 2022 21:28:18 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5vm3-00BQ9M-Vj
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 21:28:17 +0000
Received: by mail-lf1-x131.google.com with SMTP id cf42so504066lfb.1
        for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IwidVjYeRAGw9i8oj0uK5suXKCULqlTDzDoK7ZSJa8=;
        b=STG02usP5nv45iHA85nurCJslKyhhWpluLNqWzX7HoNOns6c9C5KmvuhppIvEdkTNL
         7bD8dQ02O/hCFwpQ91bbnJ4gstfsoVCo2aA+vhFSe6QIK8HXP/iHAaeHqdgr9KYBKYxE
         iJ9EMRfNWU8X6ue/osfGHTVkL52Xf3dPLA+rwJyZQR7MF+XHkDE4NBADrzdbP0agWerv
         +64h4wdi9G/F2pr68w3lWMZShT7NAizaC2Z9w5kJL2TTKzDRXiuN26QGZb+5gL4hyV/h
         yQtxepPx/J9QyWuj2IEbzQw7/oWVjPlJU3vsbBMhmnz3xYMnfu7hV6Mb7slIDZ5ZSpwv
         oAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IwidVjYeRAGw9i8oj0uK5suXKCULqlTDzDoK7ZSJa8=;
        b=MsmXtIyBmrjt9cMjwHPbFdM73/RklO0aC2W4fdy3qA2ZljELVSl+hR2OEiua6TJh5M
         C5VMWgmhMdQhO3eZIf7UdtX1nZ7gdYb7AKqJaZgFrq/dUiDPv6QcigXtTYDrJp4Nbcz8
         54JQTKaqtUCtrHt1Fmjim7RF2C5ob0a93/Bo+LwFNyHxNPGA5VK+9DdFV44mtDzNGE3o
         yCZCoTZvq7BnBBBvD6Mxb9+n53PU+v8573oFvRa+qDI3TctS2HaJWdyUys4m8G5rvIS2
         KMsaZcGa58v1EM2miYg1kwaXhfZINIXGcpJo6JBU3cVdcp6KDg1i48sfXCLqHJKF8wAF
         j5RQ==
X-Gm-Message-State: ANoB5pljBW25cMLbtprGfX62pCq3WFVm5GfN7AExNEhnnG2Wwvmy/eTS
	wqL3zA6k85FgrhfN23vVjSXAz3nyTPyP79Uyi0JsmMltujkjEK29
X-Google-Smtp-Source: AA0mqf54rkWvmKcwkh5a3Vb4nE4VNsirimfUPjq+MFhpuDxyh9/mrOvsgcZl7rdVdhHu4I0s2d4frsg2R88QwGFOWVU=
X-Received: by 2002:a05:6512:2610:b0:4b5:4f95:72e8 with SMTP id
 bt16-20020a056512261000b004b54f9572e8mr10127465lfb.40.1671139692360; Thu, 15
 Dec 2022 13:28:12 -0800 (PST)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Thu, 15 Dec 2022 15:27:59 -0600
Message-ID: <CADqNVTrUOw1VSZLctBeeJpKYe2b1wsLOLvitqejfDDv=Q7rHbQ@mail.gmail.com>
Subject: Consumer SSD listing namespace as nvme0c0n1 instead of nvme0n1 in
 /sys/class/ ?
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_132816_053470_9121657C 
X-CRM114-Status: UNSURE (   8.24  )
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

As part of being careful to not get bit by namespaces whose name
format doesn't match their device
(https://github.com/linux-nvme/nvme-cli/issues/510), I look in
/sys/class/nvme/nvme0 to find the namespaces that belong to /dev/nvme0
.

This has worked well on a ton of consumer NVME devices, and the
namespace has always been of the pattern nvme0n1 . But I recently ran
into a consumer NVME device that listed a namespace of nvme0c0n1 in
/sys/class/nvme/nvme0, and no nvme0n1 .

Running "nvme list" returns the nvme0n1 pattern namespace, and
attempts to use nvme0c0n1 with various tools complain that no such
device exists.Using nvme0n1 as the namespace works.

I've tried reading articles on DM vs native multipathing but it's
still a bit over my head. Is the way this device is presenting itself
incorrect, or is it just an uncommon way of doing things?

