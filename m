Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247D1C02193
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbZRn949fqsNY8W637R9IOTV62nIPAK7Olzkl6YQ3nc=; b=zVv7gSYvMhW6s1dcElkfQNlirX
	EX3gJlrHM+IeaylYvh+FihWqyvudPHs+xuNDhwCHq1EnqxRG2iLPz0JL4ToEhXj+I6WxpDftPlu6v
	n8vDaxK1f7VA4OVUL1DNILMg1KrokcbhnxBgzacpGiFuMmm6h5OjB+JPZcK+ci89J3JQ7nNK/nsv3
	HDtQRpVvM1Mynj0auQ8Ty+T7qn10iVRcezU5UyQynO7jSqrmpVO0U9Ta9A3/9VtOQFHvXkQlxQ+l6
	XCPYJW8BUQ36JC4YsRKy9XR/MLOiE1FFmmVN55srMc8jkIhVJ5gWoj34Ut8tZyAZNoIQ8pOqgBvyz
	5ZN9XZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfRI3-00000001glB-1Wxw;
	Tue, 04 Feb 2025 22:21:07 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfRHx-00000001gix-3Ua6
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 22:21:06 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2f9d1e44bcbso173734a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738707660; x=1739312460; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbZRn949fqsNY8W637R9IOTV62nIPAK7Olzkl6YQ3nc=;
        b=Wh8+EFXgJD+2HhIW3dMsa572zFSuVVDPhftPOj7DUOAxNm8+crizC0ZjLGcjkci3Va
         JEgbR7Hazjyr+P8v6v8phyF2D6rqrj0Fe+mi2wMq3gpKzzL2votlqrybkg5MvSiDRqum
         uIRLLRvKERvfBlmCUQZXDhwXa5huA0QwhUzC+0AImtHTpP/R5cVX9y1YwVtUcZlblWyZ
         cmIRuxXkQfVvVAPRc2wIp13ZBDfcSZ1fBJJS/nJPlDHn9PlaitYIerPBOlMXTXnEw3la
         UE5Oa/CR9Rw4nYh6Sj0aioTFLQAfCofN2iEQhRI/9BBn3ZxheqFhsxG05mobcG/V2ynY
         CVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738707660; x=1739312460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbZRn949fqsNY8W637R9IOTV62nIPAK7Olzkl6YQ3nc=;
        b=oCl0/pSMy7eKgXmkP4PaPDEMk4aZMwvUdzUBjV3/GLwe3xhZyI+XssjucErWQDnNwj
         wmXmh/fHfLAdkI4WlqSA+CrgONn3Wr3GyXiGIoppsM5IooF5knFP0APgZRtwy17QbYmx
         JjbRV1KbncgtmivlWHqF2cVpFyQS8qb3G5JgUE74UiDURqmpGzl2IzXy+U+3qfBS3zX1
         5FuNr9Ho7ysfVxsR3X9X3Nr9JXfRVhOkbZ5tR85UZpQUaXXNyg0O5xTVOpi5HZW0yWX8
         MwJWnuiw7VCvSk3kwUYWf7eFOa1/qRcuEfT6Dyo9VcwKEgxexBvaapDQyucSTH0AuADC
         4DJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUz9FaLRdPR9TbWKYY/9PGpSLyT1SB+a4mqI+nMcx1DLF/YGGUFy4vntr94C6nktxJ7LdJgO068V0X@lists.infradead.org
X-Gm-Message-State: AOJu0YxH775XH5JzqbOMKd9fLvMVxVmInya96rPo50x0mGmK7+IzEGIe
	iz21xzYw70xZmfBLAyO9sF9f/7xBkxn8kEavqZArsv3WGelsm/bi5wP7STnA1+Ru/UcAzQIsXHa
	tW+Bb2gPBPNYv8RjQK2rcz0vxWVEjsGFvNk2ifQ==
X-Gm-Gg: ASbGncusas8OYZtxKaBvEtayxF32S2Gk2sWeU9jFmGhUnyVOoSuxufoEIimVqoaLeSg
	baxwd8h7Sf/YU0TH3ic7O0kzzY+rNUOW6mOmAdQpEobKY6YMZvbySEpO47kNsrbUkIs4PiWc=
X-Google-Smtp-Source: AGHT+IG+hNUNubJqc2VORFiJJg7jqwxIdTac6Uw6w4/SIcexLofVy6de51cnD/zzEReswrk965OaxzRXydmvs5Gy/so=
X-Received: by 2002:a17:90b:2883:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2f9e0867b55mr241172a91.8.1738707660267; Tue, 04 Feb 2025
 14:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de> <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me> <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
 <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de>
In-Reply-To: <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 4 Feb 2025 14:20:48 -0800
X-Gm-Features: AWEUYZljLajXeyBXnqrK0EM7weu9z3aaeGY93wupCoZbhd-J_3h7jiMfa2mzDM0
Message-ID: <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_142101_916415_E8B2A264 
X-CRM114-Status: GOOD (  14.71  )
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

On Sun, Feb 2, 2025 at 11:20=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
...
> The PSK identification has to contain the host NQN _and_ the target NQN.
> So you need to call gen-tls-key with both in order to generate a PSK
> with an identitify which can be found for a connection attempt.

Got it. With "--hostnqn `cat /etc/nvme/hostnqn`" added to the nvme
gen-tls-key commands, the discovery and connection succeed. I see the
same behavior with and without my patch.

$ nvme connect-all --transport tcp --traddr 127.0.0.1 --trsvcid 4420 --tls
$ nvme list
Node                  Generic               SN                   Model
                                   Namespace  Usage
  Format           FW Rev
--------------------- --------------------- --------------------
---------------------------------------- ----------
-------------------------- ---------------- --------
/dev/nvme1n1          /dev/ng1n1            d95671fe6e0ebf8c199c Linux
                                   0x1        268.44  GB / 268.44  GB
  512   B +  0 B   5.14.0-5

Hannes, is there any other information you need or do you think this
patch can be merged?

Thanks,
Caleb

