Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0013BC369C2
	for <linux-nvme@archiver.kernel.org>; Sat,  3 May 2025 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=br3AFfEUnRj5fngutK9i/jnbo6o4VEmVTfhs6OGnjfY=; b=WgaEyhx1NQC1o510IUFyh9qp2s
	hGMGvUv37GCdi1/aSy88rqWkm5TWqthWPkmcm93dcVoNGwKWTEuNLnS8g9015NbTSPHXkXZcaqL4u
	5RhQCsH5f37JdWkqtrsXkVvG2Mw0jUXYl6lb8bAz+9XehROeW9PazgdCoRGhHspN+r0pR31M1qsiA
	abVpw7pAUoRPY/Yie1M0GxvEwjEX3miKJAyy2jjOj6jH3YPZJw5KcmKLbJ9mNA72wEdRanQhyVNZm
	WsA//kV8lXgMCad+t2FeSG5diaFuDLCg5alCxgNDSIBKlxaGzE40DuKqEaYTPpZn8nnxXzivuNm8M
	pMC/bgvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBK2B-00000004VNs-3vdL;
	Sat, 03 May 2025 21:04:31 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBK29-00000004VNW-1uoG
	for linux-nvme@lists.infradead.org;
	Sat, 03 May 2025 21:04:30 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-703cd93820fso26349087b3.2
        for <linux-nvme@lists.infradead.org>; Sat, 03 May 2025 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746306267; x=1746911067; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=br3AFfEUnRj5fngutK9i/jnbo6o4VEmVTfhs6OGnjfY=;
        b=axd32kaYD52sZ5bklD3n9eWy+NmtBXYySkYm9ntQ3yXME2WYt2WSZ5Yavj8LlvIJLB
         wNE6kBtKfS24wQd4ULruttmHP5FoBCjueW54cXbdToPBiHHFwUB5SqmvHagyDFAHSykl
         C7V3i5WeBBOBJltMRFXZ0xFFM4LARBmZfiOoPYeuCrnJeCeX1PjckZw9YowpkdUvOTSd
         /1xaVYZiTfAkCdnLbtMEOwkL+6IgAVZjaRMBVH4qmXr3QIr5cqBErZ7aatFjImaT1u9J
         nppHA8mcW5wWzgmTEGKUruDxTZBBI792t9Cy4DyY30cA0jkJdedIrJKYw8IuOmrCBB/4
         nN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746306267; x=1746911067;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=br3AFfEUnRj5fngutK9i/jnbo6o4VEmVTfhs6OGnjfY=;
        b=k132NaWosOfLgIMd2/P1n6P/h7dmmhl+YUw0aDNfD0ByWOWiFQOZXWoVDRm5kKhMq2
         y3NO3f59hBCverCZTZTLCZuEFIT9DSPWmZvXyn9b9VY1vvRDsjdXcbdg5p2FWNvqNhzC
         usMU28ElE8lwWduraYPiLnKSFdnE8dqXTuiVIbQw8M7tvHl4V/XFmTDdtNjfBAmos4aN
         80H+ycrCZ8gcOkMEKRClLP++Nk14CWJSq+vrt7tlwXyPNa1Xo+fFXUo5LrrUx5IDiY68
         OOT+5am48Dox9Qsb8BNKkS25bbBACTVdo2V6YGMzfrqovlfie8C1pexNqDxpny4QO2eV
         IR3w==
X-Gm-Message-State: AOJu0YyPs9Zwu2xpDgEMAxkrr5wnqaBJ/KpuQ8A+fteKJII06osfpKg+
	YN8QstwrfSuKc+B5Hje7aXCDekJ/XR1DZeKL7yybSOMyXDeLPLZ/AmpAlT/fLkvb8wFY3b3wF+a
	qhRu6mpumPyZchJm9fmlYfBmlMuy3lahL
X-Gm-Gg: ASbGncuIixZ+jGP6uOPEDBLUj09xaPBaw2+8iXjYRnCEORlWL3dqZ5uQova5opngfpA
	doos5VWfHVibeYTsktwIsGylne/w2RtKsO4u7mk9zwC/sBYP7rkOeeESjq3nbPaZMpgPiSlx0FA
	iO4JE1CNtSTc7VipEOiNJ57kk=
X-Google-Smtp-Source: AGHT+IHjWMwIpVGk5acPczMKOLon4kb4Of7gY7UH90xYcJMj3Qz1mxC67hPh9/VUlSLK8VvSInnDjskvLmOwYFf1MzM=
X-Received: by 2002:a05:690c:6885:b0:6fb:b2c0:71da with SMTP id
 00721157ae682-708eaf6ebd3mr30699717b3.36.1746306267614; Sat, 03 May 2025
 14:04:27 -0700 (PDT)
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sun, 4 May 2025 00:04:16 +0300
X-Gm-Features: ATxdqUFr-5CKZ9PwkiQVFmKolcwZrtyZDYs9OA0G7N565qFChOI4t3qYlcqjGec
Message-ID: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
Subject: Sequential read from NVMe/XFS twice slower on Fedora 42 than on Rocky 9.5
To: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_140429_496992_3E4D80BF 
X-CRM114-Status: UNSURE (   3.78  )
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

There are 12 Kioxia CM-7 NVMe SSDs configured in mdadm/raid0 and
mounted to /mnt.

Exactly the same fio command running under Fedora 42
(6.14.5-300.fc42.x86_64) and then under Rocky 9.5
(5.14.0-503.40.1.el9_5.x86_64) shows twice the performance difference.

/mnt/testfile size 1TB
server's total dram 192GB

Fedora 42

[root@localhost ~]# fio --name=test --rw=read --bs=256k
--filename=/mnt/testfile --direct=1 --numjobs=1 --iodepth=64 --exitall
--group_reporting --ioengine=libaio --runtime=30 --time_based
test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=libaio, iodepth=64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=49.6GiB/s][r=203k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=2465: Sat May  3 17:51:24 2025
  read: IOPS=203k, BW=49.6GiB/s (53.2GB/s)(1487GiB/30001msec)
    slat (usec): min=3, max=1053, avg= 4.60, stdev= 1.76
    clat (usec): min=104, max=4776, avg=310.53, stdev=29.49
     lat (usec): min=110, max=4850, avg=315.13, stdev=29.82

Rocky 9.5

[root@localhost ~]# fio --name=test --rw=read --bs=256k
--filename=/mnt/testfile --direct=1 --numjobs=1 --iodepth=64 --exitall
--group_reporting --ioengine=libaio --runtime=30 --time_based
test: (g=0): rw=read, bs=(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=libaio, iodepth=64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=96.0GiB/s][r=393k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=15467: Sun May  4 00:00:39 2025
  read: IOPS=390k, BW=95.3GiB/s (102GB/s)(2860GiB/30001msec)
    slat (nsec): min=1111, max=183816, avg=2117.94, stdev=1412.34
    clat (usec): min=81, max=1086, avg=161.60, stdev=19.67
     lat (usec): min=82, max=1240, avg=163.72, stdev=19.73

Anton

