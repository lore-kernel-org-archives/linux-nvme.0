Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AE7EF99EA
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hzAcMNxzGFVoBJHSBAtqKuAOtCcpoA1NrLiV6qgL7yE=; b=yPOcWddQOgatWfLWwfwUMYV9pF
	xxyq6gRs48IIWiEqDW96XjGzHhun8UvHygQH/yyG8IlrqeHnUjlQK/hOq/IrWSF15xE2olXuNSywM
	VK9oEzvOF7hnQbPzGogUwcSD5dWaWvDpEb/LB7zPBCUKpgwCgB9Yu9QKsLb47S9ZYKuiFfxh3hCCp
	D8oxX0DhzfYU9ZbMGMjTnev+QT/cZ5pavmItvOKIz6YXSmYe/FrD8HmUBdpZPKTnDUCQcgcR+vw2D
	s92GUQYGmwJuMLxW4PzTlhOcmjZe2hu+5zCsrXXz4VuKOSGVgStWWTL3DhyjD3XDJXocCGbJpHjFl
	q5KXiCFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr4A0-000000047Dx-1xej;
	Sat, 14 Feb 2026 01:09:24 +0000
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr49y-000000047Dd-1g41
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 01:09:23 +0000
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-56739adfa1aso922200e0c.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 17:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771031361; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4N4nwPRjtGyMv0xekJpnqaFCy900/CNqJZbuW5LxZ8fXFit3K6wWQ0t2hl8teKpVO
         QVrre4+NUpqacNdIM3WOpSF3Nnz35/WwaRnGg/yixgx0/0eRDEckeRCekk5hwJulyP/M
         xAJGROjIwN1Mx3Dj68OhnIvEaR48Daqyu/ZMpG+/sxuznSxRaTgSKpr1i6PgZIRDsk9J
         xudk0CfEfN3bMrWyRzGbHEWgq0jpVdagSOJ9UZNcMNzLhj3TY9H3lmkwTJSzSYJJriWX
         6gkgqfZ3BVOVaTQB3J/W87OGGGY1T63tHJTTCHBhfDwRH9YHpFWuc7wLuoJV6iKQposG
         456g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hzAcMNxzGFVoBJHSBAtqKuAOtCcpoA1NrLiV6qgL7yE=;
        fh=LAPb+9DQUwjUmSnmD5+cClQxTRUTCNbK7yHQv0B+XB8=;
        b=LFCIC3Jpglpx+vUxoHP/GUEcIeVodWlN51OJTTaLSnmGI4wEyIltqRsmaQ+qAxM7jd
         d3LX5xfElfRU6LGGK/Y/eqFdQgwmVYTYpugaWzJMLYT0NoljcHaSn0ZEplB6+65GRVt3
         /hrLJlKQ/+g7Z7OpUeWcPJ+xfc8wTDAR7UyOQztfX6BqZuemODiyo013owVLPDf4Lxjm
         SAp0B+P5KEuNARwG0iigLcWKOSRx9ts1P5ICXpqfc0yDvtDf9FLMZyTQuIt/LBw9ZXiB
         mCU8OYZxlJa7+hWB33FlxSs5Fsyxr1xdrLc4XSBJBYkrNdg2vx91VVSbYsGsXyx5r+Z4
         zkmQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771031361; x=1771636161; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzAcMNxzGFVoBJHSBAtqKuAOtCcpoA1NrLiV6qgL7yE=;
        b=dHxkcnKdhh1xnr30SFf6wUVuR5TZvH3NcTtpqDBSvl682KMnrMpv2vYGWhghOM/1Qo
         H8eFkNgZuQUvE8zqADz+FdU1Hzy7MgE++x31ikK7KODPHaFqskm0uvTomfpE0FbbxUrX
         yLWN4BhYwOSIcIPar9KH3Po+mj1shNtWG/wWjae8HI3vvht5jhAaJwnD+x2NCxGK427V
         6ic+LYiGCjZJn+764JRiE1Lfd6/lPbi+hQQWE+awxR9ea7yoH1hxhYUSyIFNzReJvXdw
         pQ7Mu9BAGF+klfoGCypmMibxJ3Fqo3WcJ5Sd/FPkCSlolntKmnVzkY9futYRdyiLEuy0
         4E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771031361; x=1771636161;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzAcMNxzGFVoBJHSBAtqKuAOtCcpoA1NrLiV6qgL7yE=;
        b=b4wRigRz7WVZG+7KVdLMcOXz4fDnhfdvO4v8aFhyd2IXou18mEdqWmUMR0lnJo28u3
         6PwVPpA+hgTejQVL6d5QyRICwkqR5/Su0m7xF0QG8+2ygcndDjPQ2Ly85hkxWa1F105T
         lyZpcL7FeOPy76Aye6AiyvmAVSTszszPihckl1JRMQzYoAJytGvkM2V0lQ8QvDW6knW3
         4BRRmXp6gkDnSLhSkyO1ddzPIL1Wm5p6twmvHZdslQExXwXORa4d0iIEnJBUALaLHhdD
         mASuvpnbk7NkT/v+MOVzZgO2qQTef8iLg3qQmVWJBtwv8q9BY6xFB5fFNMrkbSeB2b6k
         XFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWgCAF0XXQVq/m7yaWYuFmP70zt816rNG+v4W+s3GQCnVfiXYikqVE0CqtCkCJ3eCLYZws2XDe/45PB@lists.infradead.org
X-Gm-Message-State: AOJu0YypCreN5D88QAACM22kLLWm/c/eofEKrjjA9QCAqtZmQ+41/DMx
	p0W438N7LtlhnTkHTJyOo6MTd9XLhOuDXjZLZA1uKcuRDK7W0+5i22xCNWMzYedi4DngRGxx9E1
	IAXU0D3QFjISWZsg+3kv26VV7AXDTafceoMDOOg2mNQ==
X-Gm-Gg: AZuq6aLMHQVjfOoYiOrgg0MUOJlBfPzDoyd/nH6e8JxjhpcSgnGGcfx0CHXnls+yJeh
	kmZAayK5ASgsSkw1Dffwkg4OkiUNee21uqUhycFD56qfbuXbdJAd20Mee15Txzpyz1+MYGVUA+W
	/0uNDpDk08N0H8Zh0WSo3L2+HxpBJE8sDW+swBUgDi6XV7ZcZniDU6v+bCBmtmS80yhPOi0mIx2
	7SysL5eIb4qLYZo6X1gHudkJcTiq4uCHm98S/HZ94n6wTgi9whpdVnlIvjIe46teLPEMxj2hU2E
	ndHVdpq/
X-Received: by 2002:a05:6122:8444:b0:566:36b9:ef5e with SMTP id
 71dfb90a1353d-5676ab10909mr1405840e0c.21.1771031360720; Fri, 13 Feb 2026
 17:09:20 -0800 (PST)
MIME-Version: 1.0
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 13 Feb 2026 17:09:09 -0800
X-Gm-Features: AaiRm52vXXbJPb0cdDOP-OnuqMJi5P5qGnBB5h9dOnynkWvw4yIrVeGeISJyrPQ
Message-ID: <CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Implementation of Cross-controller
 reset/Time-based recovery (CQT) in the linux nvme driver
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_170922_460351_05C6DFD5 
X-CRM114-Status: UNSURE (   4.64  )
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

I'd like to discuss the state of patchsets related to implementing
Cross-controller Reset and Time-based recovery (CQT) in the linux nvme
driver for fabrics transports.  I expect to present performance test
results that show the impact on read, read/write, write workloads with
packet drop and storage controller failover scenarios for different
levels of implementation (none, CQT only, CCR+CQT, filtering some
outstanding requests (probably just reads, maybe some admin
requests)).

Current patchset is:
https://lore.kernel.org/all/35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me/
Although, I expect it will be updated shortly.

Sincerely,
Randy Jennings

