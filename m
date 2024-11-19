Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873E5D44141
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CVNQRUfkfoGYcoSAdMe73y6I/zgaSHZvc6n4x9QFnE8=; b=n1AUU4v+bEpnapI/c6SMuW+9tA
	05zzp5JcMe5EB0fhzbmrtp0WB0XBj54wBA5LaYgURwuiHQsPT8tKOzh9JDFJHnBLDdG1uwFR6Hrs7
	c57uhsDYkkJrBBVMua7UOU3Lh3BVFascBXt/vbTzgPg/D7jFzegAn+DeTxyAO2+qnypSftiTXUbbx
	0JV62v1t/n7HgCTkOxLyx8PYIN8OLKwBrDfVMFzcMQgiOedw3yx99IxEqdbE3sZMOUb7bZ10SrI+P
	UxDRxbahDhJrDhg5S0ar2e4CfVTw0trTiIp4jBEDFnn5/g+1l8FjuXwTrf3HkgeGMHWEAeXTB52EQ
	rHykxhPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDM2U-0000000CAFU-1Dpy;
	Tue, 19 Nov 2024 11:04:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDM2R-0000000CAEQ-1Nhu
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 11:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732014293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CVNQRUfkfoGYcoSAdMe73y6I/zgaSHZvc6n4x9QFnE8=;
	b=UnNIYVGcut6vFi09pVhtepv4dzcrG8/T+tdM7CVeG8HcI08FelJrBokGbzzUVmO8NrD38M
	5mpEYh3dBUO48VQWISqdp2/Ih+1uveVXtF34/1mWd8xva52ASAFJsMygkbMYM6I/g+R/2V
	ztTEtwG/eLn5P8JTa9XxKNdy4wjY1Q4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Qqn23NskNx6c_pnysXkybA-1; Tue, 19 Nov 2024 06:04:52 -0500
X-MC-Unique: Qqn23NskNx6c_pnysXkybA-1
X-Mimecast-MFC-AGG-ID: Qqn23NskNx6c_pnysXkybA
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb6509b841so26485321fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Nov 2024 03:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732014288; x=1732619088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVNQRUfkfoGYcoSAdMe73y6I/zgaSHZvc6n4x9QFnE8=;
        b=birwwgPhnJ/e0F1zyYT3ghIdPeVnd+7UUlLVtzSrwJlXB1a4/S1klKyD9+ZEQV+QY3
         yXowOXlsH2hpFa0DWCkvtGvvHeJsTWEIVnn+TnNvX6o5WLpEvA1Hi1Xroeaq4t62QZOm
         52HudMptmVxaf+62xEQkg2Hk2tw7lwuILObiKc7AqsNtPZujOYwknTB4bd4l7eMyZCOM
         xdnhtNELdQRUOd96sFi0ORkXHzG2vvexsoSlAhS7WRxV/G4Vm8wvCWovDQA5MpHRSV0h
         LPfT3iA1N0CSCswY/OSxcUGRKGpRsY1WJ2SKvp8GOqIgxUWf9fPuIqBMia+dDevN6fLV
         HRGA==
X-Gm-Message-State: AOJu0YwL15HdXTLqMW6aO7PJCjJpaeJ7FfL7le5O0CxqO1mH4BKCvSzV
	7xoBjoKie/Rg6ExHCqk8wTs1dRc9yS2dsU0Y+EETfPAnY3OTykAGRUrlMtQKmpzw/MUN94sF4FH
	+Y6Il3jJtpnxnuJaKSynbtLzUqmFjMoZ36v5eWgf5vggUtlpBVFxqeg6imNqVriusLTGcuehbQC
	DqM4kXxEzhfHgQs4zBt4lL6wf0rYRZixEHLQ3uro3e4CrCg6F+hKad
X-Received: by 2002:a2e:b88f:0:b0:2fa:d464:32d3 with SMTP id 38308e7fff4ca-2ff83bfaa0amr8723481fa.20.1732014287928;
        Tue, 19 Nov 2024 03:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw9hWtRQ36WeUA6tryuJv+7RFXjfeJ3JnkFd26jA+54+oX7BRyjUQCwmTZR/jdqpldtGgNTuRkY8B1R8r3T2s=
X-Received: by 2002:a2e:b88f:0:b0:2fa:d464:32d3 with SMTP id
 38308e7fff4ca-2ff83bfaa0amr8723411fa.20.1732014287557; Tue, 19 Nov 2024
 03:04:47 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Nov 2024 19:04:35 +0800
Message-ID: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Subject: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yh_JSG9p-jphnbDp8FKnH0aM8gXNNIUIaef8EVBTNyo_1732014291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_030455_439272_76AF805D 
X-CRM114-Status: UNSURE (   6.16  )
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

Hello

CKI recently reported the blktests nvme/029 failed[1] on the
linux-block/for-next, and bisect shows it was introduced from [2],
please help check it and let me know if you need any info/test for it, thanks.

[1]
nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
interface) [failed]
    runtime    ...  1.568s
    --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
    +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
2024-11-19 10:55:13.615939542 +0000
    @@ -1,2 +1,8 @@
     Running nvme/029
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    +FAIL
    ...
    (Run 'diff -u tests/nvme/029.out
/root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
entire diff)
[2]
64a51080eaba (HEAD) nvmet: implement id ns for nvm command set


--
Best Regards,
  Yi Zhang


