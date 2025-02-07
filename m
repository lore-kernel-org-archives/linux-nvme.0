Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA790C02192
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 05:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pN1redW5a3r001y5kSBLm3FCgBKn5nNRc5eU1yMCAbw=; b=Y25WGcknWqpGSwIazIxnZz5BFM
	2tkDXhsEhk/yPqQYffLJk8y7KT0XNIGAvKKr4DaKLhqCPRcp89ELmNlZcNAhuSGc2C4VFFo1P7ukh
	204BGdyWAfExwOHKoCmFN1k2hov0i1vkXDzz+JuX/rShxmPOQ7QV79BZzwInn7X1VNY8ms79R4vCr
	hEA6PkcWLvdHYzKNbts+SQQ4GBJsxt6ERdWxXodsVIVOvNCX2xzSNN7wtdeN60+2Cxfo/jjEx+Yju
	1JhQ0FI+27EI1M9hpfUrJNRb9mprZZi3EVAuo50SrciI7SokPLlkXOFGXGGEKYPzY55C+uzObpL1W
	kit6SK9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGq1-00000008MTR-2Bml;
	Fri, 07 Feb 2025 05:23:37 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgGpz-00000008MSr-2oY7
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 05:23:36 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7b6eb531e13so87962885a.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Feb 2025 21:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738905814; x=1739510614; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN1redW5a3r001y5kSBLm3FCgBKn5nNRc5eU1yMCAbw=;
        b=OzLWIjo2360K+Gu21a6HVGNPm3o47xiU71G49+uda0eOCGZtGnTms62sG+GhEn41fi
         qUe3IqgUEo9kwA70EOFyV0CcXo/ryigeUb3pF+hAYnR8jrX7HEmvtFoRKmvuQsVNxG0I
         b2sKLphGbwDDu+m/rN9Km/2cLhKdVG7/QDyUT0Ox8E5U8gcyAqjMGKfVdG0Dzc35vkST
         im58/8AVdl55yZTalCNvEhSK7OVCeZyNulB5khIeEzWXNuwjINSDBATnoIZQqfYYTd7b
         JmKqhLBshZisu1NVJTQ2LXR7gNb1ItvGfiLrEt+i/T8KOLV1p8dknMrzaCJAgtahJL2c
         hrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738905814; x=1739510614;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN1redW5a3r001y5kSBLm3FCgBKn5nNRc5eU1yMCAbw=;
        b=e5Cv9XjNkCpABoQp9OnzT3xxWrzdqsdhBAIBVYkpu98rdpwiFtmZ55mZPKxnP47Fzq
         f8kORGf0sj0oNHYbYeb6IlqkQQ7hRVlm5rGwpLRiRYO2VtOEIlNTjxxLfXck7KMVlgod
         +OVu7v2v0H0gGYtKNJaqgWPYae0OneD/AjR4eBJHR6wx22W9xdS6+tbn9lYi9LpAqkCE
         /qZlOaayH2nTrb5YOjsl6Jh/Myhr6eozGh3R9ksGZsyolUahSCFUXXIDLEdW1vKD2R9V
         DcO8Fs8aMl49SLOQdIORYiC1NeRpR8VPJ/mamxPfmW3lcNLADwzReW1C8zyDD3IS9jw1
         5jQA==
X-Gm-Message-State: AOJu0Yw5e+ZGwsOLf3Yzjz/pRwkaJmykXOJWM+qUKRKHGIrlXd1p5Vtr
	hqJabxPAs4+aFNlsvsJ9Dq4nZi5kSe/yukasVJqkeYYnRo6tVP9fMZy1jN1O
X-Gm-Gg: ASbGncukEkODwPlzDN3vnkTZQuIg9YzzRohY4cwCKDBUt/CqJzHJubRSXd8N2nYYJ2H
	d5Ly/iYB+mdxM1j51Zutgs10oGjsz11uFpNhWFhD25XfgDdLVn/cKTbAPQr+yF+loFTiC8JdKMc
	8sj8ViRqGLUSu2YwKOWzUrp+lh3xrqT3jjRFUSYcUl0Z5RIfm0p41oQr1nYl6wlZ0A6lkWygIAd
	mSyC3j+AJxUC2PGKLaZVs8TljmFhsBlrzTe1gvmi0Cv7A/fkQ6EDcTXR1Tqsl/NMKUyhCsn1wNe
	mQ9E5p5/FOfQMtIrDdpK3Y3Usw==
X-Google-Smtp-Source: AGHT+IFYIIB3LxwU6R5q2lJVn1YhWIONV3LOb5MAGaoQhnREFy9EFa/I5Qyw4e1fHoX88luCrCkdnA==
X-Received: by 2002:a05:620a:4309:b0:7b6:cb07:24bc with SMTP id af79cd13be357-7c047c49886mr329013685a.48.1738905813708;
        Thu, 06 Feb 2025 21:23:33 -0800 (PST)
Received: from smtpclient.apple ([191.101.132.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ecf505sm145243385a.116.2025.02.06.21.23.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2025 21:23:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [nvme_tcp] possible data corruption when host detected path error
 and resubmit IOs on another path
From: Jiewei Ke <kejiewei.cn@gmail.com>
In-Reply-To: <3184caaa-7254-494a-948e-4a3aefd05f4f@redhat.com>
Date: Fri, 7 Feb 2025 13:23:18 +0800
Cc: linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E189096F-DBAA-40B4-BB57-A1B4C81C869D@gmail.com>
References: <DD72B155-35CF-47F6-A342-13445A9E432F@gmail.com>
 <3184caaa-7254-494a-948e-4a3aefd05f4f@redhat.com>
To: John Meneghini <jmeneghi@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_212335_715834_F5081CC2 
X-CRM114-Status: GOOD (  24.19  )
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

Hi John,

Thanks for the info. This issue can be reproduced by this way,

1. The NVMe Host connects to two paths with a keep-alive time of 20 =
seconds. The I/O policy uses the
NUMA method, with only one path used to send I/O at a time. First, we =
try to use fio to generate I/O
and confirm which path the Host uses to send I/O, referred to as Path 1 =
below.

root@localhost:~# cat /etc/fedora-release
Fedora release 40 (Forty)

root@localhost:~# uname -r
6.8.5-301.fc40.x86_64

root@localhost:~# nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=3Dnqn.2020-12.com.smartx:system:linux-nvmf-subsys1
               =
hostnqn=3Dnqn.2014-08.org.nvmexpress:uuid:fef62b42-0c64-8019-065b-edf0617f=
74f8
               iopolicy=3Dnuma
\
 +- nvme0 tcp traddr=3D10.10.130.83,trsvcid=3D8009,src_addr=3D10.10.130.20=
6 live optimized
 +- nvme1 tcp traddr=3D10.10.130.84,trsvcid=3D8009,src_addr=3D10.10.130.20=
6 live optimized

2. Inject a 40-second I/O delay at the Target side of Path 1, exceeding =
the default NVMe I/O timeout
of 30 seconds. This delay will not affect the keep-alive. We use our own =
error injection tool to add
such I/O delay.

3. The Host uses dd to send two write I/O and one read I/O on the same =
offset.

root@localhost:~# echo 234 | dd of=3D/dev/nvme0n1 oflag=3Ddirect bs=3D512 =
count=3D1; \
> echo 567 | dd of=3D/dev/nvme0n1 oflag=3Ddirect bs=3D512 count=3D1; \
> dd if=3D/dev/nvme0n1 bs=3D4 count=3D1 2>/dev/null | hexdump -C

0+1 records in
0+1 records out
4 bytes copied, 30.3181 s, 0.0 kB/s          <<<< I/O 1(data: 234) is =
delayed and timed out, and then
                                                  completes on the other =
path successfully
0+1 records in
0+1 records out
4 bytes copied, 0.000483626 s, 8.3 kB/s      <<<< I/O 2(data: 567) =
completes successfully

00000000  35 36 37 0a                  |567.|     <<<< data is 567 now
00000004

4. 28 seconds after the Host sends I/O 1, the Target side of Path 1 =
shuts down the NIC.

[root@node130-83 10:55:34 ~]$ sleep 28; ifconfig port-access down

5. Wait until the Host completes step 3. After a while, the Host reads =
it again but gets 234. Data
corruption happens.

root@localhost:~# dd if=3D/dev/nvme0n1 bs=3D4 count=3D1 2>/dev/null | =
hexdump -C
00000000  32 33 34 0a                  |234.|     <<<< data rolls back =
to 234
00000004

Here is the explanation,

1. At 0s, the Host sends I/O 1 (data: 234). I/O 1 reaches the Target =
side of Path 1 and is delayed.

2. At 28s, the network card at the Target side of Path 1 is shut down.

3. At 30s, the Host detects that I/O 1 has timed out, triggering error =
recovery. At this point, the
Host may close the connection to Path 1. But since the NIC at the Target =
side of Path 1 is down, the
Target cannot detect the disconnection and cannot abort the I/O(It must =
wait for the Keep-Alive
timeout). The Host retries I/O 1 on another path and completes it, then =
sends I/O 2 (data: 567) and
completes it. The data is 567 now.

4. At 40s, the Target side of Path 1 continues to execute I/O 1. The =
data is rolled back from 567 to
234, data corruption happens!

5. At 48s, the Target side of Path 1 detects the Keep-Alive timeout and =
disconnects the connection.

There may be a question whether adjusting the I/O timeout on the Target =
side (e.g., setting it to
less than NVMe=E2=80=99s default 30-second I/O timeout) could prevent =
this issue by allowing the Target side
to abort I/O 1 before the Host detects the I/O timeout. However, if the =
network is poor, the Target
may have already received the I/O after a long delay and would not be =
able to abort it in time.

I think the patchset in [1] cannot completely fix this issue. To fix it, =
after the Host finds I/O 1
has timed out and closes the connection, it should wait for 2 * KATO to =
let the Target detect the
connection loss and an extra CQT to let the Target abort the inflight =
I/O, then the Host is free to
retry I/O on the other path.

Feel free to let me know if you need more info.

Thanks,
Jiewei

[1] =
https://lore.kernel.org/linux-nvme/1cea7a75-8397-126c-8a2e-8e08948237b1@gr=
imberg.me/

> 2025=E5=B9=B42=E6=9C=887=E6=97=A5 00:13=EF=BC=8CJohn Meneghini =
<jmeneghi@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Jiewei.
>=20
> There have been issues reported on this list[1] were some NVMe/TCP =
attached storage arrays are
> experiencing data corruption during error insertion testing. These =
data corruption issues have
> been attributed to ghost writes in the storage array following =
commands replayed on the host
> during Keep Alive Timeout testing. TP4129 was developed to address =
those issues by introducing
> a Command Quiescence Time (CQT) timer to the protocol. TP4129 is now a =
part of the NVMe 2.1
> specification.
>=20
> My question is: did you find this problem through some kind of testing =
or is this something
> you've seen during code inspection?  Are you reporting this because =
you've experienced data
> corruption with your NVMe/TCP controller?
>=20
> If you have a test of some kind that allows an easy reproduction of =
this problem it would
> be helpful.
>=20
> /John
>=20
> [1] =
https://lore.kernel.org/linux-nvme/1cea7a75-8397-126c-8a2e-8e08948237b1@gr=
imberg.me/


