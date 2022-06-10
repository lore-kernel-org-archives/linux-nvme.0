Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3345AC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5CVVmPWSO7zI246F9uV3CZ1bRVCVCwFzDhYUz7mGPgE=; b=uzkT4mgw5q9cnDrG31SaMUPAqj
	aaM4sndkMbTftJFCp5w5zFIlZ9Oljh2W65kShioHo8kBk7r8/b1+JfJMKW0pM0BR/etpjrdujGCUj
	PM4vlzFVXPmB/yVtQyt32D5n6lcTEZj02F9byod4n9P8HP2Fbv3+EQEq1/bfRUXn/2efXhJJwXZ05
	ZPfZAEme0iYk3goXwdO4YqMNJkvZTzV0rPH4JpTpn62oPF03WnbCNS8MRlOLtag72iwAVbHLQmD0E
	yEQaEF73/95gFRaSPl0/d7OFgX7TcOQyQncFvw/Ghjv+DoUtWvRVp82Lw6IlOtRm24VMaPcisD5bD
	oRY4Mw2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfa9-008amg-TA; Fri, 10 Jun 2022 14:25:49 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfa7-008am8-IG
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 14:25:49 +0000
Received: by mail-oi1-x22f.google.com with SMTP id q11so20442421oih.10
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CVVmPWSO7zI246F9uV3CZ1bRVCVCwFzDhYUz7mGPgE=;
        b=L41IyThktbiXhXabGOVAovvmqaD4z43eMTIIpxdb5qUblHOx9GI+KNErtzRgJB1dYB
         dn5kYJzX8dbQ8NN4/nV/AoJdGD2nESLtAEiSdd/NfxT/EjSTPLWpW31YBmxSKasFLTcA
         7IEOxK6u5YKDbUl6PJFLSivi40Zf6riKVObUWBAadhmV4bDdmZmsp5k+6MFad7qurZAl
         +cxo94ZkQ8i5SQoNS6L3tWpfXBFN2jK5F+wcSxFq7133WxUCxG6Ray5SloxII9jsWA3V
         TxuE5wMAP+60t0LRipeWZoS8fmfAApPxVRfTLE4XphE7kyIss8A8TNN6yzsIjh8JRVZf
         HTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CVVmPWSO7zI246F9uV3CZ1bRVCVCwFzDhYUz7mGPgE=;
        b=ow7zw5C24vu8B4P4OZ8dKms/t/LWHsh3oWwamEwoP6+AHSG6x7I04viKYIVuqH9LWl
         s2A2qaxDN6SAgVjO7eJDC77QqigLnIwEgc45EW7V637N0/0bSYQ+ftZ4lo032Z7GR2xB
         1AxagUP8nAgJKTAKlMNC0OMvrPTD5RnHfIv8TSlbeqRrrPFZTQco89tsMN77nQ81FL6p
         hbUx2/YUgFqyeQFqkojYkgCmmN7g5GWcH23LYN3XjEP8CTEhhjTD5qfk4VtOtnRTUjTw
         6pR7Nvhpa1qjNrYerLh6m3l9WYk+FpOvygdgxJRLTOEh4/t+ob4li82NLJOdbyDWd2K/
         lF1Q==
X-Gm-Message-State: AOAM533CHbTpW0lLkCZrGv9UnQzZiWd+8niR03mWvFodeNRgBxBkp5QC
	9yn2OQr24P7SS1v9nutn9nqNxpKr9KLq8rXE874cZw==
X-Google-Smtp-Source: ABdhPJxQjmkmS7q9mv78xn58V84JS4D4wWQKH1XfVscr4mkFvtIUVYpNssaisTp6PwyVm4/fcduSuRhcUu/pYAcCVE4=
X-Received: by 2002:a05:6808:bd1:b0:32e:431c:2c4f with SMTP id
 o17-20020a0568080bd100b0032e431c2c4fmr3218oik.269.1654871144282; Fri, 10 Jun
 2022 07:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220609173734.381654-1-vitaly@enfabrica.net> <20220610055957.GA24331@lst.de>
In-Reply-To: <20220610055957.GA24331@lst.de>
From: Vitaly Mayatskikh <vitaly@enfabrica.net>
Date: Fri, 10 Jun 2022 10:25:33 -0400
Message-ID: <CAF0WxhmQZS-7WYj16ZOXcOSWZ9Og8GoA88OV5r4325gaSnYgfg@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: allocate MQ disk
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_072547_995884_A240E686 
X-CRM114-Status: UNSURE (   8.06  )
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

On Fri, Jun 10, 2022 at 1:59 AM Christoph Hellwig <hch@lst.de> wrote:

> This can't work.  Can you explain hw you came up with this idea and
> why you decided to send it out without any testing at all?

That was a mistake in my setup that I misdiagnosed. Sorry.

The patch actually worked (as in "nothing crashed") in the simplest test.

