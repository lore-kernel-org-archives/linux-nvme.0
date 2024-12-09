Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4693E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=; b=1+KGZFIRedKqN1FVSurl+7XPJl
	zu0Ab96gQ+S2I746k49PYT1xAfjCxXl0dufVImhwj/fMUaeDo5IRym3AQhfKhqulimePsLPqx3JMe
	MeRIVMZAATlgI0/m3ej0UYnDKev68CsDEORn6WD0fBrBOiMwfv/ji7Kaw1iXbaIVslPLA36yURvgI
	qu4W4J5SdP5nqgz+MSX3lgQRmv1zyenHn4QrL3zy+FOTx97aO8CICuMKIXia5XkvfDxRP5bMbPFfM
	B7KXlm+YAeqHZ3YDf4OG2XuUug9wbGUp01YCI+eksu+/aJblrK5vdhAdhHV8pBzkaPFIW2eaP+KNM
	PqrR0+Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfl7-00000008P3s-0doJ;
	Mon, 09 Dec 2024 15:33:17 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfl5-00000008P3O-21nh
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 15:33:16 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-84198253240so192709439f.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733758393; x=1734363193; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=;
        b=AY/qTzkKnwxJBUiDxzL62rryHUsbHwCh2RS19ymHjJIWJOUZo4oBYSeL75dGZWdXFO
         dGMYh1RYmU3po+3jKNl5r25dpGELQje6MNMUZJBS+2G8Gn394f/mcKEiVJjW87d7mjlg
         6HuJCzG6+4F30ygDjVstrcw+P3gKCwwX3mYIhdEN4owPpdvlhbO9eh+rP1GIcs1jeQRg
         i5mfy15uP+WJWMb8S71NsaStWB5bQhkoWbO6eHdt/xbMAhAEjSddKpUsZCdZyID1WSyV
         8A/ddPekDYKSx7m/pmJDoAoQRHL3jphkXnhkLV4e6knJDgyMn6vNGFKDVwQmU3c+w1ne
         nJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758393; x=1734363193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=;
        b=YfCOehDcstlTTdxBVjxxrwnUXQvCVfpa2Nb1pwaklz56HDlvX+bhjFiU7/94/S6q9/
         lErVYQqHTyCj2KFiTJJc7pa0PYo26ySKIkke9TnMt3T7A+FoGPfoN3JbZmuIKvjIv2QF
         8jpGRzwfjozTw4Rp9PWKIFSp+m0DueZyqCKgkoy3n/QSeCu4u3kKhvamz/lNmuCNQroE
         iMbBfGMpVpTAreYzGRGKtoaVkuvz3dBrBizGyjk9jDW6nHOWmVx2gUmmhEE/TjBwU5ND
         4ydel2n/drszCyAwdS6gA5bWTmpaMilZZJZbOzxFWGusiaWAeW12E2Eho7wJh5cbxBKC
         qgYw==
X-Forwarded-Encrypted: i=1; AJvYcCUEQdDEpzzihJIIPBEb5yHSV49D3DnDsogs5RG1r+IKHwFXpf8T4/Yz8/YQ8zmkVbVwlzGHobTUsehV@lists.infradead.org
X-Gm-Message-State: AOJu0Yxoh+hq5uMMMsEnvwEor+IywDwYZWzSU6oqUZpYgklvdbQ0tDRA
	uI5BRezDmIWBgFrVG+eVnPSao9NsznSbxEJ2Nnd7EA+/7aSGknFqOJXbotXsr+xiyENdY3NrX3e
	YtMwuvS1HckWsWpXgRK7gEwaW70mMKDoTIk4u
X-Gm-Gg: ASbGncum1RS8/e1ecEHzOnWz2y/jNrsOUTS1UIxgur4KVGVNPT4Mu2AYDDVwyQ02ejP
	WOvIZCi8at61P6Lq78b/OyhRyLKecByg7
X-Google-Smtp-Source: AGHT+IE1vUeXksBGYj/fVfeZqb61vi0AIrQrVPcz604WD1GcglXwYuTO7YT3c1pWPT0x4nTEFbw+Exdcyf5ny4QNm5U=
X-Received: by 2002:a05:6602:6b88:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-8447e21c305mr1740812339f.6.1733758393175; Mon, 09 Dec 2024
 07:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com> <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
In-Reply-To: <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 9 Dec 2024 16:33:01 +0100
Message-ID: <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe <axboe@kernel.dk>, hch <hch@lst.de>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_073315_520946_36FC2FA4 
X-CRM114-Status: GOOD (  14.14  )
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

On Mon, Dec 9, 2024 at 1:33=E2=80=AFPM Robert Beckett <bob.beckett@collabor=
a.com> wrote:
> [...]
> I have no further updates on this. I have received no further info from t=
he vendor.
> I think we can go ahead and use the alignment patch as is. The only outst=
anding question was whether it is an
> implicit last entry per page chain vs simple alisngment requirement. Eith=
er way, using the dmapool
> alignment fixes both of these potential causes, so we should just take it=
 as is.
> If we ever get any better info and can do a more specific patch in future=
, we can rework it then.

I think the 512 byte alignment fix is good. I tried coming up with
something more specific, but everything I could think of was either
too complicated or artificial.

Regarding the question of whether this is an alignment requirement or
the last PRP entry issue, I strongly believe it's the latter. I have a
piece of code that clearly demonstrates the hardware bug when run on a
device with the nvme bridge. I would really appreciate it if this was
verified and my explanation was included in the patch.

