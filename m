Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3EE63FE8
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=; b=1hsXTkiDpWZAHHMw3oqHDeFTfc
	+Stm6zUOPWTKWosZ5v3l7rfwUJ4bLrXkdNBMEeBWai2RUrVraINRDxAO0sn73crpaAgHFtBQXF9QV
	1aQSM1pfHiQtloZqwdQShttCphh4yswBumrsxyXnh5qbSSVQRHtEV+H+UzkEcllt+G8mJhJ9chNWW
	A02dTZaOiUoYANi36qOucCDOiSIBFazSn1+9TFV+gK6G6ysSo1mBJU0Piyf5VJBFLXpobrh00BPpG
	trP9lSZ30kjbIdzxfXzKQZoiSsGVrw0Vv0eih1jaHDsts47WQZruJexDs/CeZBlCjrZ7dTuNCpLQu
	4HRn8hmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LgL-00000004AMj-1toj;
	Sun, 05 Apr 2026 11:30:21 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LgI-00000004ALv-3EOt
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:30:19 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-66ee02e2c55so295180a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388617; cv=none;
        d=google.com; s=arc-20240605;
        b=ND+3kv6hWbIAm6q6jt2Y2dHv37BX8YcTGHdbB08cTvxl1L9s0noWYlZsQgUt9Uwe4b
         P48SLzWbh9MiPjlmUlhZNzbhrT3a3crLARLGHMZ5fS72KiuCF97L+vGXbvRzyl+ShSwM
         Kq3/LkpzXKiSEDFzMNK7p1FXU1jlR25cvPRqll2YHCxcRxCHbsnd3NkhmU8OSbuRoQc8
         ciWrZj2WsBAhH7Yc/MWY4TFo20qAbycuo/3xllcJ7NTN7SgbWMw9GmKrI+HlBpj73RN9
         ekQ9yJGPVforknb6BFFP9No6cot7/GfuUz177ShQ2aeMJjDa0hTvRlvAR7FJThNCmmfT
         8ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        fh=fTq+cOkjGNFjSwebdh5o0m60QoBlY/gIW4gpcC+Sf9g=;
        b=ROdkJ20DpH0K9eoCP2EjtMh9R664b55kdLz0ggdmviVuZOrLk3cydqcEPDbfbhDPtE
         ANGgoUZjgIqe9YwI6wYHWjaN2ipaOtCuKwT7xbWxf5amj8UvebsBksvr8Hz/1iFA9WY6
         LDV6mnMiaIges+cONZXvzgNqUwkdXffUgn/8BapZtv1VgRyEyNhC7l1aFuHrRSZZarlJ
         nQRGDFjPs/Nx7COig7YGol1zyFAFdf3Ugnx8McU82a+43myJmrJdpEtuyVZEvWxwMO20
         oRYjhyHhXZR26KsW/W5XxKQZG1oXvJLjIyz7BPUUMhdgNZxz+wjBLj6ijq0SXnFfLlJh
         0a3A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388617; x=1775993417; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=gr9gNN+3U98jVklXqNSzqV1XIDgoGfQivPAb5a9q0/4D+5uCtie2gYNYvpYyf3a79p
         R0ItoBZOBreVAj3V8d4j4wfXP+EnAUSi7DPRgIbGneXiDyWQh8XIAAYr87E49y+cs9np
         QMU1qnjapk+NVDaT4/y1oKVHtS029YxDL9jDjhtjpc3P4fqLfdOLTJaActJZ93BgoYGf
         dcJpxhVzrlSA5mjv1WELDz1Iv2cBe9TJbOT1MqbVboj5Jc6af8rExNoUN42bx1IlVH9C
         N+8fS6M65N3BqoC6vHupm7irVkAHY+wx+NoJ5oHNPEp/VBePMmKvLzw6XpOfqA/eYtFj
         1V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388617; x=1775993417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=IaRTygymtKgsPZSHY+xIh1hdIZ+672e6H+HOLJk9NoIcQeO0YvPZ1guEuIPD109uGZ
         dv9MqOjSsZzXRH0CMKY0P79qkEVvBV/cgQ6Tlp7548C0zZTDJPwx64Q+1DCiARZOkkqy
         Jv7xVB+xiUHFCtFFJojGSYf75uutSDoeU9IAfxKYTml+wQpMGO3ScgVf8fTHqXAfZNIn
         zb7Z4P/A63Syd5ubtV+3WvAw6nxaUVDj1tu+A9i07Bvv8Z87YaZXwAZeYxPc0TGAeGPy
         EndLlHVBUVB4dMwETcZGYvzdkFXOOtOvvcdh2NcJuE/Q+nFe5kHrLAq+0v8IIrleOF8U
         PeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt3tBV3e1QG03VZBHJJTd94u2gRP1PnKN0TNv7ZEboueijB7AseqWq/iJ/loGFMXbnWXIX+9sgwZGJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxi8vbL9eZWG19e/Yy47Fgv+qwZHEbZqv8VDkisE9P9h+79wby5
	M7kz4gBAHYUqMI6oIx0B14mn/sKoDhPgcQRU5VWYi/G8w2q0pehDCRzMYZsGANIbKFtK+ICV0zn
	PLGPE7p8yJEb9n/VVR2B8V/02Rnbekw==
X-Gm-Gg: AeBDieunwasd8/F/YutD+S2uQlF/FLAdeZMm29WCYm0v4MwvcmGmQ6wP4dyXxAuFYIn
	1nyg2L/y+bpDC7z9BGYejPyVyurTfci+PHaUr0WKL86paky9x4/QUSANGK+J/QR/smMrdULx/Vy
	g7Dvcp5Bh8ozrjZ6K/anHyr6A9x+2/LEPW9KSt3HEYG5QIQOOC2S/dPzYCNXz1YW+okIrK7aJvu
	+cOlUs5LEhkngfRe1ryTN0GXciHobbfE5Vboee6IPaPK63GmgP7QvdBDkAeiDrY0nV5AWwpdci2
	Xn0QubvnvVW1CgDGztRMhOzvu9mo4sVezk+fbWbzkdh0wpthfApixL6zxR42CzSe6F0/Uw==
X-Received: by 2002:a05:6402:324c:b0:66e:df62:8826 with SMTP id
 4fb4d7f45d1cf-66edf6288a7mr338829a12.8.1775388616842; Sun, 05 Apr 2026
 04:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-7-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-7-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:59:38 +0530
X-Gm-Features: AQROBzA2rcbT0pZ0-7PJWuNuCAXgpXg-lAQtO03rLOJpR9_lw8vMvBFgqpf-qwE
Message-ID: <CACzX3AsN9osGEHdaZu-qKpKhR+JGTxaSvx3PhqWt4N9HSbj63w@mail.gmail.com>
Subject: Re: [PATCH 6/6] target: use bio_integrity_intervals() helper
To: Caleb Sander Mateos <csander@purestorage.com>, Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_043018_818400_AFF06B12 
X-CRM114-Status: UNSURE (   6.62  )
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

Looks ok to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

