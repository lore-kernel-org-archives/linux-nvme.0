Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17576EB594B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6kNdFfMDc3uvl+iKbEdVPzkeSICVZug5PHFm2lM+Kus=; b=30ErgGC9x6+2KJTSDANNZ+YeQb
	r1lsHNul2ETT112Qqg9ATMnHyhNXKd7vxe/q3lxFU7RBMYZqovqo0lNu4P+iVFX7h4CGlAwNskIQB
	EuCUetb4jshQUhbh3PSoPnT0y+6m0UbWY3DYJNIvu8G2+Mqoawi5LzpSCLLTRQDbkXNhZH5COwB5m
	LCtohYn/5Mtw1bDcmmqEyemNxDd9/lArJnTzS/njgKH2r1eBz2rN8DpLwtfMXd+nt3MSRECTKOAvn
	L0lJ8lmGePnOPHw8c1SMArhr5l021zB8ReJw7jEH/LRON7YZElx+58hcOuJ5IRCrkHbr9mTm+6MOE
	N6s12LhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzPg-000000006LE-2TVr;
	Wed, 11 Feb 2026 01:53:08 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzPd-000000006Kg-3EFj
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:53:07 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-567449b868dso524048e0c.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 17:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770774784; cv=none;
        d=google.com; s=arc-20240605;
        b=kTzewb5nK0keGjeeexdoUR28ZncwSTjqzd/8ExV4k0uExQ+lLdvuYebwkL9JnIp6WW
         VKu1QFliGmKjurZ9tJjy1T7wG9J68I+vIJldL6XYSfEMoyuXHEFsC9JFZ1wmVEou9b9I
         GV2s82gyrWneS1j6yHKguvSpFslytPSasShobQ7EyVVsIQRInxkEB+pwPvIvPBnrxzwd
         esWkWwesfO4M8oPReTzxg/xrrhZklKgZPccV1UcllTDQAbb2Ol4xM6QhnjdmCayTvP8Z
         witZ7HB3thQz7v8bQ2IFFYuf0t6xmRU9M9R6vKlebGJwnhxaIAyzEuVPD9rcmDDYnU07
         Tqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kNdFfMDc3uvl+iKbEdVPzkeSICVZug5PHFm2lM+Kus=;
        fh=KTZDKZXOP1oTcdxnFM1vp3DUggsRFqe1zGuILy9LLvE=;
        b=P3kK/MIDjTaiYKCWfN9fCubJEf83B7S0GfIRoKNF/kdk38yCidcshG1l+nwnEKvp1N
         fNzd3yQmwJQItyx1mvfSjHx9ivUqg//bfVWWseNzgu/FMgBdVouJAK9auBUzIcjxo5FN
         NYhuWqL2UQmoWonKOIQaSNYKAFSiEUxcxaG6b2TTb5z3F5EyUdGRoOaocXZDcfB8iTnS
         U2mjT9LH6jFtX8TnJyp5oCz0peBs8u/9fSUeYeLmxgcSva71H29Z7JRLeP3oDEN1uXxZ
         2tIJN232ZTOiH0JbKZ3vQan2BDAHjKB6wDvaysjEmZ4Ja0ev1/8YB5nzx8XKKbmijp3x
         no3g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770774784; x=1771379584; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kNdFfMDc3uvl+iKbEdVPzkeSICVZug5PHFm2lM+Kus=;
        b=LR938reko4CAsaQ+EhkuD7V3x44jYD/F+sjA+Kzurs1EFQdJ3pbKEeob7sXAISaZLV
         wjVmlkKr7iELm2alPZB2g/v1hCtAQ38gVoXmUf3pINv9BTNZvl1QIdGsvVRMCIr9Gmcg
         oTngkrad/YrY1h1HQXYlVtmfd30OQr+g72Wi+wfRolV96BUYvnLU+kNifi/+xrgu3kcf
         bjfrs87EpUFkSs0HLlidAeG3n+1ZgXhrMkdRSMKXhsjalvasJULQZZHolgfb8IZC1e6a
         im6L53ykrow9xV6ie/kObUyEj/8rJEda8+J/xN8dsvdY27ejWFKaFlL15n5hTWgYpN9V
         0CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774784; x=1771379584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kNdFfMDc3uvl+iKbEdVPzkeSICVZug5PHFm2lM+Kus=;
        b=hNLcv8RU+n5Ks7uPch6b9UFO0x4hjt1ZoReh5dpL8tMLPcO1oSVv7x4pK4n67EpDj/
         luVJtx2Ai04ZnK1i50/r9HUXMfRyQt0+bKaRtYpr//dGAv3Y1NL5hArfjNDmkHRs8psO
         hW06HaqcFS6B4XfcX6AS9U3aCfFyzdVYQ37L4IMCQ8U1i94gGAC/aF9Ky18pKbqI4rDR
         5lgzBOQoGgaMPkNYcP+oXckcRGiQyaBZvsUhp0hA2XevEaIib8MEn2M75/L0jiCOzstt
         /C/JSLwDtj/hVikV7pgIh6T5elpqN1ve2YpXntCrXZq4QYfuyuOqH+y2j0Fiuo2+M+8h
         aVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVdxP8mpNScYvfE71TIfnPyGiVoHxexkW6ePvriSvSslpS+SZipTYNHa3GyG92MeyS1AlfeLFHrRX9Q@lists.infradead.org
X-Gm-Message-State: AOJu0YxAu4mRlv9wDRKB4eVcmNwL5UekFHU45aVFmwyFV9W6/3ubMt2Z
	aZfext8xpcgGQQpEsAyK2/wmWN+QpcYAHiw7rEGOJ5wiBgI8Ot+405W+NS9MoUdiu771zlvLZw3
	VHHzLgd0MsvpRwp7KSDM4KG47YGoHNgpcXlHFScEBYQ==
X-Gm-Gg: AZuq6aLmki7rsdnxx1JkiiBrVqdduH4aXg2TCGMaimnmlFtX4BDi6RWT4b3zdhvZ+xW
	0M/he8Hkhs5Pv3jLSl1iRO+JkxInk/NBGegtpREGRIpad2WOCff04kzej56vSfHx2pf2ci3N/V4
	NQJL+LCo3AGstPTq9ngcPa4g4Xmj64kLyuRYgQbTa+szZveY6JvXjh3hTicQecK4jAyzGbFnM/G
	4uYjVZ25oSelBE8g55d3Ecbbxv0t0Chjng0olGhp9qEtWAPwXgTDbMD1Erxfi1vfZSGOJ30FsTO
	XveWScE=
X-Received: by 2002:a05:6122:8c12:b0:566:221a:ac27 with SMTP id
 71dfb90a1353d-56706084eadmr5428055e0c.21.1770774784010; Tue, 10 Feb 2026
 17:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com> <20260130223531.2478849-6-mkhalfella@purestorage.com>
In-Reply-To: <20260130223531.2478849-6-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 17:52:53 -0800
X-Gm-Features: AZwV_QhKFOrh4IF_ceVAm3XT_Kr52syguPeU5c1rt6xi8FRgNDxMGOVsDjzIPoY
Message-ID: <CAPpK+O2as+2GY=CgC-zfWuU+2w1DZD+LTie9P6LB21fgwTbAaw@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_175305_852466_823B2BE9 
X-CRM114-Status: UNSURE (   8.67  )
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

On Fri, Jan 30, 2026 at 2:36=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Send an AEN to initiator when impacted controller exists. The
> notification points to CCR log page that initiator can read to check
> which CCR operation completed.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>

