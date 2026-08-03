Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1470C55182
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2026 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzdrwxnOeI42jalFJKKyP2A/LKKccq6CTT2yDPP7wa4=; b=QYoTSaK+QvwZ/dY8wDkCgG5C0I
	sFu1zR60vl3iyhWFKFsap/Jt3eu3gCEuCxfAGXaTSOpqLASHt7zOFfxfcMOsrDUg1oQwNw4vvu/hx
	JySWjQ6aV1N/FlW0Sd1f2xiFouMyHAPZNM27aADdVyasxcL32qZR/f6PbZft4l4IdG9SUMR7gBASb
	jN9w4md4axig7u8T9JKN79soJ0/WX9JWs8/cX78gitmQEFDK6qahglajM04wv9Gyz6NOYNSUxckVv
	PT0sz1tHRJGdtszkawTJ6jFnmRsWBD0N8PAlZlqYV3YUK//0xV5v7IlvLZGGt04SFpJNiop0DUS+5
	aNrRbzYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqtC2-0000000HHcw-48lw;
	Mon, 03 Aug 2026 13:59:02 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqtC0-0000000HHcO-3DKn
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 13:59:01 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d004f135b1so33759685ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Aug 2026 06:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785765539; cv=none;
        d=google.com; s=arc-20260327;
        b=RASUyeq6RMkfjuxqeVkuT7FZTRbjJSI7mjcPX5lO/aVBwHAQBKBcW/Z0BYzHy4+UHc
         dZLK/TYfxgG82lvFvmjaJd1VopSEUX+IshOlrnM+mTGM0XsgoBm8MwU06T6w6cBZFAxA
         cjhRHc7cZc3cJhVECFDU2PYw2v3maPM+n4X5qXkATiegFAaKd8TEUObl4T+oD3GrJDRs
         hjlX0PEvxbn9bq+h3d822IssDJG9KisVhc00O8Dy5R6a8xMxmJ3gTXgbV1KMfHcbzAA7
         65Xnl5CgvwIXp1oKdDljSPuhiAI++dKXIuZt1xgr+goWwBTH2raPMtFUVRV+6IBq5NMP
         8ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uzdrwxnOeI42jalFJKKyP2A/LKKccq6CTT2yDPP7wa4=;
        fh=03hlMil4kOgvdvGQpbfvQ+uPV1YgbRjse/YXLlY15Gw=;
        b=qdqBc5hH4jMBYkPzYpeIME2RzBT9OmoWtKUwSix5poPkPCNONMzfuJVsnIHajk2OSx
         fXwZ95JLbeNQPI7mZkJuE55IT1iGtVs/5h3rne8zB45sBcEuGCfgeZxUn0NtECaVXBkb
         UUCT4ZffGCb0kfczPauh4j+Bg0rCiT99Va8FBeSbKTPBZzv30UvyZHhn1W9bC+F6dsQG
         8ePAkSJblZLtV1Jhwmh2dkAV0esWT+F0NIdB8judAAndggAbe9DIONv9mVMn8yZibPah
         4srgNGUkZ60Gpbese/SVCoeh0lBOmPD2nlXuB+zSwa5uDIp36k2kdtmpDuom1A9f3HiY
         z/DQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765539; x=1786370339; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzdrwxnOeI42jalFJKKyP2A/LKKccq6CTT2yDPP7wa4=;
        b=gbU1LJ4Z9OoUMhxMc0rNJ/D0WGak0u24U5BLr3JhlMjdvh7Iv1efk7VtwZggZ5sYqB
         njibxs+6qghshhpWCqRGCrv5qvXpoD7+TuIcLoHkjfewEWvW0XwZqhD/2exIlWkHgplu
         ShX9wIf2kTyl35TTXAtrPWGoFEbWhyhg3vocteeErbMVWfomMIKDzZEqKQ8X05tWjHBA
         TN/5ux+ie1/A7NITmat8sPHF28N+PlgzuU5oLhLSpMw7EMvBhjA7w1CoZ8JhchtWrfJe
         sEu7CDTU/WrPGJCgjNUzQDgx5Sm2MQBPIEYyD6SVncWKKmOfn3Win0f2wHwyFWL1bSPG
         KV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765539; x=1786370339;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uzdrwxnOeI42jalFJKKyP2A/LKKccq6CTT2yDPP7wa4=;
        b=MzPA7Gdx2Mb7i1gtpLZUCCMEHVWsUVTKe6m0nPmlTM4n37Ai2fErkJrmh2x/WXVvxJ
         EgBxxUo29gs9G9OJk/X/Oi23U1sAjE1qLIOM7HTuTrFbSJfQ+3AVg5MNtoh2cYeCx7ww
         /HAcHD5CnXW9jXSFnWi9eBqUSY5O/KC7iQAN/cHEveg3pGX7HmODlbkT3PLmQozdiW9p
         6hy8NXV7Wg+4JoL4GaulImd8sLY7txAetP5gg8nEQ2ImrTGCpe/MCE9O+znhyxnEDcRO
         Ur+msdIXVg4dQEiwVnIq3UfufuMgDV31u2uGMZlQb3Ti8V11//dhjAbE5EK9+fof8N8Z
         pElA==
X-Forwarded-Encrypted: i=1; AHgh+RrYi73Nb6vxmu5fYUTKq/fBl2RdFeQEl1qkZ+OotshqmksVftW2yNpiVq+W/x7smsl2ssU2xdDLeH2h@lists.infradead.org
X-Gm-Message-State: AOJu0YxUcU0Hm34b7PkSnK52nCc3iZLjIUWXzXGtn4q4c9L10YZlas1W
	RZwSuK93iZrlEHFE2ZIxYvtqRHr3mVvvvhfLQ1h81y7jVXHy95YgKLz8Uf4G1hKjfa4rQ62WkA5
	Nu8Lv6wuH6/6lJGzsDJxZ7MkGes5o2JI=
X-Gm-Gg: AR+sD11EngkxjeEbAsBji4c9VLMx2H1NeJxkW3nHiUKBWjUPvdvNGhI9AA3Qja1AE/E
	Y/R+i3XJS/DClLQpAbHGxkQpdlaI4mOuqF9jF+T0zQpH8Bf/W6w1m1L8NoHZHu8WILR0cDEFl9h
	bZasV8GPSPW25gIRC3JKqCm2x+U82WKU47AvYzNNF6Gu2iVw3HNINmefk5gUpxldSvEKQneX104
	0CvQO6EFxxNtkLROuiNvE/1MeCyCkquGNVeFii5BffKXmgHbrQ33xlEuVGkY2p5vlGepE+uvUo6
	wbLUHZd0XRBSx93cbncxltqeAv861ScGq1bGbNxnx5SEmVGqTlYyrtPSud7f1kGXzpwjpBVISPy
	L6l0/gdhAvQ==
X-Received: by 2002:a17:902:fd83:b0:2c9:d88e:f996 with SMTP id
 d9443c01a7336-2d0521ead59mr103504935ad.9.1785765538550; Mon, 03 Aug 2026
 06:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260725135111.14041-1-harimishal1@gmail.com> <CGME20260725135125epcas5p26801513d440f066295ef2d44035ce3db@epcas5p2.samsung.com>
 <20260725135111.14041-2-harimishal1@gmail.com> <7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
 <96dadac7-a072-48ba-b282-356d29ed789a@samsung.com> <CAMmC+=ApjmaGpnsxYBo7C-0BsROWJ=ffDc9FQSs9fn4wr7Amxg@mail.gmail.com>
 <f6c67294-adad-4d77-b8cc-a29447506496@samsung.com>
In-Reply-To: <f6c67294-adad-4d77-b8cc-a29447506496@samsung.com>
From: Hari Mishal <harimishal1@gmail.com>
Date: Mon, 3 Aug 2026 15:58:47 +0200
X-Gm-Features: AUfX_mzmlivUpD9C2J4-2YZ6ReQQtjvsL1CwWLl_FBmNHjZ2K08-8QJMfCYgdUw
Message-ID: <CAMmC+=BrwwNLfsH-YC8REHBRVxkYxiK4rS69-pU11+igxEXJWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_065900_806813_34FEDD60 
X-CRM114-Status: UNSURE (   8.82  )
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

> Or, let me know if you'd like me to respin.

That works completely fine with me!

Cheers,
Hari

