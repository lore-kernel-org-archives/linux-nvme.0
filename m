Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63856C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MmxjGGPwDYHJkRGyQ1esN6WfIsgZwdKYJuG78gz9R3c=; b=hg+j1jRL/erm3yCDLK40t0kwC8
	3DVRy9wbhohZFI+leRM8pyr8LVQv8VlT+RGTd6fMuqvDQ3sE6fxopgtRy5embymeVMmyvU5d+NVNw
	9AWUqjWHs2+ziPiRJlSgvBW+KPvWF94WUXbnoNMbbkxKSTLk5ZyTgE7pJA3DzIGALBmW7XAV5ZXkK
	Wk2YOReKlSo8A/gfupLDGe//Mvpr9O6RADQyr5hdto8wmiizWUzTbUUneKTAwjJdDaCQt6l/yaUUs
	HXaPLvcZD6hLjSx5zSE0d56hCJbWnrgFmnXtXnr/xV1Ghsec16aZEkraAqgRXekHQgs8zPDrNJhs7
	92hB3x3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOri-0000000DKt1-3EIe;
	Tue, 20 May 2025 15:26:50 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOZ0-0000000DH7C-0pA6
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:07:31 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6016d401501so6702270a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753648; x=1748358448; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MmxjGGPwDYHJkRGyQ1esN6WfIsgZwdKYJuG78gz9R3c=;
        b=lNtUHxpi3huCyhp0HcO9f/nxSnSfUlgwiLynQ7X0Xu+hLligyfEWYOKr8/CUejmHKq
         qkJv0x/wgD47jgEfzXqE0sWjpot+C0VlL+nK/XTXxGwCY7sG3ztG7DnDHK389msqx3uV
         Tj6OkVRZxOkr5a3qfRGpjNzdAnwsc48zhnymxkRGjlbgA6BYxJAYZE2pSo+rS/62r9/r
         OWEcJxd6nYEJqkbpX3B38rMGg95FWWp87z2sJtZ+unnDJKY6r/+seRt4kX4mXClvpKdX
         2rZKGqCggXJqsHp0+9JtxflxbY4Mtxy3/Psrh5Fd1vBaDW9Nqt6zP91o8wNQq0Zo7Kl/
         8kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753648; x=1748358448;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmxjGGPwDYHJkRGyQ1esN6WfIsgZwdKYJuG78gz9R3c=;
        b=R00g9Y3kId3ddc3cSfSXa/Od5Krh3jHD8XjpMOhls+jrzkSWF7L51kDJJiGhCDJrX7
         V0odlsR3PMJkaUHUm+59abEIJ4N0TGZLuTU6OPlsvmecDhFVA4Djhyr7BjyqEZ0j6SJC
         6bs23YQwgKsnQbtEYknSYrPIOkHNYqDCE3P06VYfOBMa6Yn9Ze4OKjSRKkz3VlNXMRZT
         zzGSENA0uQTG8DwWl/5JXvwXzEzyW0jvkihVDYRc/DygYtxds0z4KTfySOgZOjcdFYTT
         QcBvDtCkMXr/zQhpWG8huRZx3Q+PnKbqWPYbRJC3gQFwc7ykRJZIZBDAa6W9pl23ZisE
         AIsw==
X-Gm-Message-State: AOJu0YwPQeEaahabffsxgr28rB3TN6C+HpEu7R10CEFTNKblRYVnxRb4
	PsTe60/SEr7r1w5WaiZ7pX1mZRjbzyP76s0jSJP6Einpi4CUebIi03cPdNO39pjWglqopEPF2DG
	6/1MKU/Ccw1ru+Cn3Lty3Pra+RrExMtZnBVpD
X-Gm-Gg: ASbGncsgq7vRe2u1/o0VwfStYgGFeA8KSnL/k/j167ILK9ch6uJQvUnGXAaEwkUClmf
	tNhx12/T3dwbwSW7LTJhc8Nh1u9eyj5f8WPF5IPhqj89iveUNpLK+Y6zQCFj+gt19IAU9PTiNJ9
	WDiMfHn7JF/+MzeY/5JEIW3LaatEq8zzmJlG8z6yXYUdSaMMhYwymVkuuEvPFFxTQV0Q==
X-Google-Smtp-Source: AGHT+IHLvfP2HFigZ/tvdFp9HJ27M/5ElI5wgpg+qzJAWbcsRiG1UQcv2nWsKl32oVMMzxbfJ4RbFkiGvYDP5rsv+Nc=
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id
 4fb4d7f45d1cf-601a6814f05mr9977516a12.32.1747753647795; Tue, 20 May 2025
 08:07:27 -0700 (PDT)
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Tue, 20 May 2025 20:43:19 +0530
X-Gm-Features: AX0GCFvVZqrslYxiYCYlBHJ1_Hok_Et-X9eEAzZN-2fAQRa7xJApj8qFgi1CK5E
Message-ID: <CAHxc4buuyDM18H=FO5fuvRLXz2QQkjJmdr5kzLOWmgt3vRSrqg@mail.gmail.com>
Subject: seeking beginner-friendly nvme bugs to work on
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_080730_241535_986149A9 
X-CRM114-Status: UNSURE (   7.63  )
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

Hello everyone,

Thank you all for improving, enhancing, and maintaining the nvme driver.

I am new to Linux kernel development. Until now, I have only one
contribution that fixes the checkpatch.pl warning. I have also
attempted to create my own 64-bit Unix-like kernel from scratch for
x86-64 PCs. I implemented my own NVMe over PCIe driver from scratch in C.

I want to begin solving a few beginner-friendly bugs. I searched
bugzilla but I don't know which ones are for beginners like me. Could
you guys help me in seeking bugs to work on?

Regards,
Dileep

