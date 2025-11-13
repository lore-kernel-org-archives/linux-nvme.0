Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F96ACD98D0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Tu/gd2+Qo/3wWM34T9vyVaIbJm5PzirrTBwTyzzXvE=; b=AVxZlKMsxBJuWo5j9ArPngbk5b
	DXvuvjiqeWbWcllnlk0a6SFwbnS7v1LHmL+53izJtJrtIuTz1Os51lxf2WVg+Z19KG0CftEysV/06
	Hq+KFV0J1tCvYSavdGTgnqBy1LOoYgIG9XX8nNDujy11SLm2gAmtdgr0zylRjzshEW0e/rqcn3ZUU
	xQts5spCuX+1JLsj8NCIYxC/UBzecXZK+GfBhfniFI171mMBWTbxy98R0Tlf/bTN5klW6sTqEjfFF
	sKAL561s6RI2BpS6v+qAWr0TD+i7MMYClKfc6Y3uLwqmHXI6wwxJvWLJ317/eiJFw4Fx0bFmjys4F
	nVaHzQ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdYV-0000000B3it-0emD;
	Thu, 13 Nov 2025 20:04:31 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdYS-0000000B3iD-3jK3
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:04:30 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-88044caaa3eso11109226d6.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 12:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763064267; x=1763669067; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tu/gd2+Qo/3wWM34T9vyVaIbJm5PzirrTBwTyzzXvE=;
        b=M+ruAjZtHkzH9TuDIJoBNQi7cSkBbIzmaoGhX8yaKag+pMSfn7mEgxnjnrihX+S/PT
         6/OIn3vgPIY8Dfw3GOCQdyRsf7zzhK/xJnsMahbpduiZxLSaym0aeNiS4i2HiG17SaC9
         uNhXojrSGK6JKyG+i+U0g4vdqJDM9BiGwr8/2k/7Tx+FM88YPLKCIjZ5OpJaeluNbyHQ
         E9D34YsvF/pl32x4d6Zlkqo29EdHQjK/UK86ndSkmXrIv7NFy019/Jk/v249WuSwNQin
         2N5hCwcIx2jCWFZtHttceyBcAT7j+2x1dKeTQn/03eE426jPxlnXG3RGaIhSU+JqRCPI
         vNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064267; x=1763669067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Tu/gd2+Qo/3wWM34T9vyVaIbJm5PzirrTBwTyzzXvE=;
        b=sVca/f9IwiJ8xxwEqx1I0R1Fg65BJ14L5ziMyh+xaVMhyvZMkLkUKdGHxYHs69Jb+m
         hFXmBr9YpwEUOjn7z9EMh7p/dYXL2zaLecDkvfI1lu3kkU5owYcSt5W+l0cUKo21sUDs
         Xw0ekElOKwc+X0/fy+4ohdyYZ4M09TNwziQseCDABHkQTMd8zAKnVYPVouX15oNgZ/p4
         UkDNfyhduxfmkSPSM7Y/zd4x+I+zR90+RMadOK+1DvWmSWZ5kU+5+oC8tDmZIhVbdZOS
         3LAEl1N4sU+qOq7CVXwIS5hWh2UAhNQMGd9xDHUwsWeasztqBHB/71FGDHCkqrlE1S2A
         whzA==
X-Forwarded-Encrypted: i=1; AJvYcCXqniltBzyeV0JUmRoCuDVSKte84otIBWKvw3PqLKmp0QbVDWcK6EvrFmeQaQ28Rac//w4GY6dnVIev@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9pP7waSZG7f9lCDH1CjS/LjsW6DDpO02oQCBni8DM+LXEBPwv
	7U32ejCD7b/0GPVf/veKFHZHxegeIx5ZKzk/Rpwh7KtsctrNqQaFwytE
X-Gm-Gg: ASbGncsLhJyZv3HWnx5Ne1qbdNPAi+iWseixqgVbnprTdwvoOHzcjKD1VwsC4vj1/V5
	3mD1y0xXPBFVDv1RkofIxn6/5IcLqUP17QK/uNxZJkbp9swsHtWLAgDsy/xmdnWeYHFfMtZZoc0
	Kd71f33f4MQuKtA7vX9fDttieJvIw52KOLjvksOST82QZED5dtlgULMEa0qoAD9sRMOf+53bztO
	l6MU8ScL33HTW9Pxx7Z4t+GWmf71g7VZRQlme7C28KwjX9g0gd/COhMHQW8SP/AVXQN6tJ9OxfI
	tE1B+x5jyjy9w7ZShm2GxrIvRFMwvUVnJPTO4yC2FDLC+klMLieLb6HgXNaZGSmKJoWeGU3XxZR
	QJ57eqJ8ztmyB7/a2ZNp0FObVS0PMkheFwPwquHGMdiEYUqsUSWI4DlN+VmpW+QSkd2Zl+qodNe
	MGA+8QaHC0c1sZnzy3Ri7s5lLuVGLHSybBAlCmWZPf
X-Google-Smtp-Source: AGHT+IGrx0FrDHr5X0Tz6kLKlVGflXMJORlOkolbSkhTGNZbsFYBJY1W9gQiUPtZK8T5GerMtFv9rw==
X-Received: by 2002:a05:6214:2a8c:b0:882:5124:24b2 with SMTP id 6a1803df08f44-8829263b776mr6217716d6.32.1763064267020;
        Thu, 13 Nov 2025 12:04:27 -0800 (PST)
Received: from sydsfwlab01-x2.apac.dell.com ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882863923fcsm17995966d6.25.2025.11.13.12.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:04:26 -0800 (PST)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: mkhalfella@purestorage.com
Cc: adailey@purestorage.com,
	hare@suse.de,
	hch@lst.de,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	randyj@purestorage.com,
	sagi@grimberg.me,
	wagi@kernel.org,
	Shai.Dagieli@dell.com
Subject: Re: [RFC PATCH v1 0/7] nvme-tcp: Implement TP4129 (KATO Corrections and Clarifications)
Date: Thu, 13 Nov 2025 14:04:07 -0600
Message-Id: <20251113200407.398321-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_120428_939827_C531960C 
X-CRM114-Status: GOOD (  29.02  )
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

On 2025-03-24 17:48 Mohamed Khalfella mkhalfella@purestorage.com wrote

> Hello,
>
> RFC patchset implementing TP4129 (KATO Corrections and Clarifications)
> for nvme-tcp. nvme-tcp was choosen as an example to demonstrate the
> approach taken in the patchset. Other fabric transports, nvme-rdma and
> nvme-fc, will be added including the feedback received in this RFC.
>
> TP4129 requires nvme controller to not immediately cancel inflight
> requests when connection is lost between initiator and target.
> Instead, inflight requests need to be held for a duration that is long
> enough to allow target to learn about connection loss and quiesce
> pending commands. Only then pending requests on the initiator side can
> be canceled and possibly retried safely on another path. The main issue
> TP4129 tries to address is ABA corruption that could happen if inflight
> requests are tried immediately on another path.
> 
> Requests hold timeout has two components:
> 
> - KATO timeout is the time sufficient for target to learn about the
>   connection loss. It depends on whether command based or traffic based
>   keepalive is used. As per TP4129 the timeout is supposed to be 3 x KATO
>   for traffic based keepalive and 2 * KATO for command based keepalive.
> 
> - CQT is the time needed by target controller to quiesce in flight nvme
>   commands after the controller learns about connection loss.
> 
> On controller reset or delete cancel inflight requests if controller was
> disabled correctly. Otherwise, hold the requests until it is safe to be
> released.
> 
> Jyoti Rani (1):
>   nvme-core: Read CQT wait from identify controller response
> 
> Mohamed Khalfella (6):
>   nvmef: Add nvmef_req_hold_timeout_ms() to calculate kato request hold
>     time
>   nvme-tcp: Move freeing tagset out of nvme_tcp_teardown_io_queues()
>   nvme-tcp: Move freeing admin tagset out of
>     nvme_tcp_teardown_admin_queue()
>   nvme-tcp: Split nvme_tcp_teardown_io_queues() into two functions
>   nvme-core: Add support for holding inflight requests
>   nvme-tcp: Do not immediately cancel inflight requests during recovery
> 
>  drivers/nvme/host/core.c    | 62 +++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/fabrics.h |  7 +++++
>  drivers/nvme/host/nvme.h    |  5 +++
>  drivers/nvme/host/tcp.c     | 56 +++++++++++++++++++++------------
>  include/linux/nvme.h        |  4 ++-
>  5 files changed, 114 insertions(+), 20 deletions(-)
> 
> -- 
> 2.48.1

Verified the patch fixes the Data integrity issue for which TP4129 was written.
Tested-by: Shai Dagieli (Shai.Dagieli@dell.com)

Summary:
The test included two parts:
1. Part 1: testing with original kernel without the patch to verify the test can 
   consistently reproduce the data integrity issue.
   a. Result: the Data integrity was recreated.
2. Part 2: testing with a kernel version with the patch.
   a. Results: 
      i.  The data integrity issued was not recreated with the patch. 
      ii. The messages seen on the storage log and dmesg are as expected based on 
          the test error injection and the patch expected behavior and messages.
3. Conclusion: the patch fixes the data integrity issue.
4. Additional comments:
   a. TP4129 defines an extended delay before an IO for which the host did not 
      receive a ‘command completion’ can be retried on a different path. Based 
      on the test logs, the extended delay is applied in other cases where the 
      IO is retried on another path, even when the host received command completion. 
      For example, the extended delay before retry was seen when the status returned 
      in the Command Completion was ‘status code type = 3h’ (Path Related Status) &
      ‘Status code = 00h’ (Internal Path Error). Applying the extended delay in cases
      where it is not required increases the potential performance impact of this
      patch and should be fixed. 
      i. Recommendation: Modify the patch to limit the extended delay to the relevant
         cases: IO retry, on a different path, when the host DID NOT receive a 
         Command Completion status.

Execution overview
- Test ran continuously for almost 24 hours with periodic SDT disruptions and host I/O validation.
 
Findings
- No DIs or I/O errors observed in Vdbench error logs (errorlog.html remained clean).
- No host panics or abnormal behavior were reported.
- dmesg shows expected TP4129 recovery messages, for example:
[18:52:28] nvme nvme2: holding inflight requests for 15000ms
[18:52:43] nvme nvme2: releasing inflight requests
[18:52:43] nvme_cancel_request: 123 callbacks suppressed
[18:52:43] nvme nvme2: Cancelling I/O ...


