Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D31C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJ0VIEOFyXGmNDehk++CZ7jraQTwFE/vI48bng4SgKI=; b=m+TPD8J2zvJQjNmsUSvddkjosj
	B98aZcrKd9bWskvzwZv/2mAQgLjPuxnIbKNLLy0gyaFUaZe8g4Z7a5EX4nvdAtbZmGseVbWbbmnfY
	Ebj/7Cfor1tbrroyNtfRDUmW2OvzqtktkNvGyPaSTuq8YGyBp2Ji0nX/4wODcgGVLklqd4jfmmP3+
	MdZSrShqB+PXzg6+aBZx5juSD2UIbFGpPAP0p51mB/5aQTRMpWEan/II8vidtoiJrn9LXQkrZHah/
	RvWK3ZbVcEYysZMlmdORSA60bjqVG4iItV1yDFERY4WDO320pJ9rA03Xyk1Jr3nPfUkt+u4gzZ6kb
	jy+0fYpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWxJ-0000000Gy6C-26OR;
	Mon, 24 Aug 2026 15:51:25 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWx4-0000000Gy4D-47Rh
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 15:51:17 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-495437bb891so156205e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 08:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787586669; cv=none;
        d=google.com; s=arc-20260327;
        b=Gbp7oI2ko5WWLipkZEMxlSD2y9oeMS7mEQH4ergGpnm5zBVG2OuNynaotOUX6k2UCf
         NxyL2WGmdU4Xj6ZFKVDROB3HMl+wkmBSIPo/9Hsxz8ZkaXnFl/j5Le7oELOHYVc1LUje
         H0gPeDMnIcbYzRTfKPEFDWq8j93rsbYzjV2lJxo5UqOmzzRdTyEZsQAGutZO48PWFSS5
         MwIYjI5p5auCNJ9qOkl5oRvTPBBUJsNNHwvFa8s/sVCjMiOFNKeZb+V/Ny1CDwrzPDLi
         nmxi5DA1A8rdiodfqkGJVeVP0IYAw0DJkSInVoOXYjHsrNFXbm+NDSNJ5/HaeD5gfUsf
         8HWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJ0VIEOFyXGmNDehk++CZ7jraQTwFE/vI48bng4SgKI=;
        fh=fNPhJGT7j5gC25wgHvGt2gHuqZwM0LNog1uqDCp7Hek=;
        b=p/kuKnbdMJZwVcjRy0jP4OZKrTb0MQcitVDhprb0ZAgy6VIf3pD+KY/o6ZYlYUKcnX
         +YOLIghpRohlRA53lQyX8qXjaoikkGfV/fGeyI6QvogqPxmH5yn4FtUHjx7AgIv4Ljd+
         azR60BtxXrC//t9Rf/8cQmdFXA3D4mdYru2d11Nx3Y5sB3Ph9mjEjgi1x1ltpajyIlkP
         R9LWlEFNWwsQVZc15oYszV2cBCjwuqT2pExWQko8MfwvWTtkDc2CMsUXbLcShhJGQZp5
         9BR+wic7+14qJS5QpQWB/0I8K3BpBmWjX8oBDqFPv7xdBonOuSsOl17HJphgt5DwX6Xv
         +cCg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586669; x=1788191469; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xJ0VIEOFyXGmNDehk++CZ7jraQTwFE/vI48bng4SgKI=;
        b=a6zqnrOucdH9UsxxwmFrK+oiR4p8Bu+JEsvsLISPF/8G0j94wGXZrXDIptFAZpr9Kx
         vLV7LpS0J1OYUbBX+jRxyk+QDuo3CAXftXuVkU90H5GP4IkE6M4eUfIadZ30zU9F43hf
         /rgNdEOagPxzrK2Y0Cmgf8kxXyz/uY3F1jzx9U2GLI7IBbi6sNKIYsipHpiVRCpLaE/A
         LQ0XMxuZq7p6WpQpJ9kHdhbGDlr+FcEYuexUpCHwOdKYSilaoELr0axtu0Nvi4xy5xRS
         ynv41KkAJmL5T6dTzXvIoG4P3T3ockRLsom5Nsi2iBiMXeG732ArFTDvNvFhqNsZmv3X
         8Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586669; x=1788191469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJ0VIEOFyXGmNDehk++CZ7jraQTwFE/vI48bng4SgKI=;
        b=KqvyygNeBGgwe2r2qgZK9ZahOGdenhhjl5SnS2BjQTIwnfhfDQE+pvnQu2Yhs5/rpY
         7ICC2B67cPtt9XJcDUOQ96f6c8CC+mzC+1PIxxjoJP2KXxO45PNZ0wnQcAtJ/ZVbWg7k
         z/CsIHR3KGD9Ojp6jWQAv5d4emVqFMF3OlS6iCi0NxsvhBkmczzB16KF9Rn2wQOV5POY
         /bxGNi2BTxgdXzLzgNDAMXwk9DhZF3z20ZAEv7S5Q1BaiDQxL9fnGSbrI1EIhYgq6aFy
         aOnpoSZRHWT2p9GEW6zTqIckRntAM6PLRVGmmNTHrryd7JaupYuQ5sDVVHGOt5b9amu+
         uk/Q==
X-Gm-Message-State: AFuF++mFhUax4f0Wc+AixyoRJmtSxXzLox9C3IByugEmsnsykW85ytbD
	RK3DXsf1DdF9MWu3DtN914T/3pGZVY237KKtclFC8LvTrjf7LEDlL02nZQLXzxyXT7wAsOmOyhU
	qSyNPebX4pDexo1FPd5iuaT79qR2v4jtsQgE7
X-Gm-Gg: AR+sD11F7GYn/CCJJ8nqTFwZ5T6cZqHmj6wwilKSGC/Z7wA7fYLp3X79rq/XbKAbbij
	dRMdwpieA+02NGdI18e2ucGRP0wprtSXdzRC5oiGwxxx6aWY0swsMHgLjdMZv1TRBPcQQw0hDeu
	9SA+y066/M6Z3lCPifepd9/DVL8mTuNZ3tCkbn30m5FmavdxSBT+/boibYvXMoAVWNiCl9l0m4j
	1qC97EdNXXVARppyKq8BjqR2w4DmRvVqg8PFBkE4wKbpqWEXW26H3KF+Pw7rQLdgDAVkQk1IEjF
	XfVW5JeiOodja3PUvBcXq1z41ocuW+mGNaqZtkz5gqk+wSQ=
X-Received: by 2002:a05:600c:8587:b0:499:a7ac:e1f0 with SMTP id
 5b1f17b1804b1-499d6362d66mr1734425e9.7.1787586669120; Mon, 24 Aug 2026
 08:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
In-Reply-To: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 24 Aug 2026 11:50:56 -0400
X-Gm-Features: AcwNN1XNzuQ7NRwHEv39XmkIkak6l2-LerCEZ2fSPg81se8u6tm8JYX4zS8QJ90
Message-ID: <CA+ysrSJrZYi=QgdA5Ami160RegtNfODLcSrfN+EgDRU3JpcvUQ@mail.gmail.com>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Ibrahim Hashimov <security@auditcode.ai>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_085115_551650_B0FAFB6F 
X-CRM114-Status: GOOD (  16.51  )
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

On Mon, Aug 24, 2026 at 11:42=E2=80=AFAM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> Hi all,
>
> I originally reported this issue to security@kernel.org on 2026-03-17
> (Cc Sagi), Message-ID:
> <CA+ysrSJUFi8cHzU8g9Nrbbkcuo0F7vh8CMn3ht15gSk3BbK45A@mail.gmail.com>
> and posted the first patch for it in this thread,
> "[PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()"
> (2026-03-19).
>
> Commit 4a3f002 ("nvmet-tcp: bound SGL data length before allocating
> command buffers"), merged for 7.3, adds the same NVMET_TCP_MAXH2CDATA
> bound with the same status code.
>
> These things happen independently, and I'm glad the issue is fixed.
> Would it be possible to get some acknowledgement for the original
> report?
>
> Thanks,
> Shivam

Adding Maurizio and Christoph, who reviewed the original patch.

To be clear, "this thread" above refers to the March thread, not this
one, I meant to send this as a reply there. Link for reference:

https://lore.kernel.org/all/CA+ysrS+fsJQ+4x7jHoSEX_tiYRQJC8LEhuH2stKA6Q4qSK=
-MWA@mail.gmail.com/

