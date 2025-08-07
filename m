Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E6BC87FDA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=; b=Bjc9LPUITdKAunYfgBWAKYe/NM
	GOUb1l6AqU5em0ehH7sF8YxYKEF2iks5FkZwSeb3qSbkS4PZMDcKisY1DxKMOPIdFT+fbJtW6b2ZG
	92BwW5wxOC/4/DzgIKPCDypsgTx/b8AY1K/a1PuWKtEgVBsrtNuSLkIncyzqxRhX8HIAferRivzAS
	U2V9tGS6yji25Edrbkt76hA3Lr5bhROkVkG2/8ph8cbGPr1sgpMdaaIOXg6RDPizkPqC9Xh/cB6lA
	Zlp7+iqjSfVlhHCUf7Bxj/qXSvJr9toyZ1Yc4knsbSLzrET4e34zOF9r2bMSjFXF2jDvh3P0M6rTz
	XLqZobzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk26J-00000000upR-2cpa;
	Thu, 07 Aug 2025 15:00:15 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk1nf-00000000q9h-2DBt
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 14:41:00 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so10124665e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Aug 2025 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754577657; x=1755182457; darn=lists.infradead.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=;
        b=JT99dNFfBrtWfPb+fTnFKQB892QTNN4UcglVhXvAy2BOrjsBBShNBViXTwOZ2D+43k
         /Ef+vicC2YrE+oV1sNuCSLPfsdcUl+5tckMtrtLGMrYDlddWVnX2oj4H5grcHS+eri7S
         GLuyE8hDg9J75a4FETuDzK3oPqOqooZYA8Lh213r2VZgY1SlHNIv4VvRtynUY8Ge1/J9
         cuJV+cgAoo5Z2jsANn53y2mrTcQRrWRbs5Yhdl2235DBLYmTaJzpOP4SHd36nF+uDIcP
         K8nZr5uojz1tHH/FFn4WgSDeWAwOvQPYBsw6CCGen7rZ+qT6PrIid8ZdZJoDlEDP8Vlt
         iYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577657; x=1755182457;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNvtAxmLROgNUzbc11bBNIMDhX3I5pMyJHrrae5iWIY=;
        b=QKdtLdz3GvXFKSbH1riquvl0nqfn2/NJIWk7qtusOp+zMJ+dIdVVB/ZpAk6nzRAp16
         sAaAvaa2kwg3M/Aw5fPCtkoI6O9ZH9dZ0dXK99IpeSnICRrG93z4rnhbJYX88YMVHq1l
         iLWxbNdJ3kNEyr1swO2eWD82DKvZBQ3/w7rbZ2HpGti5QOgaNoZxgLw81pYdpGQLcumW
         Y1Htpkg7Z6N4Q3RZ+yNhA5RFLkoQThHZ6/Q4BkPeG4m0aSvaikAPwue2byzBV+eSH5tx
         vkEtZ+EHonJ02U3m0nQ+co1eeW/ucAvcAPPIJSmyQzs1k3uSC0FEUu/reBavDb2KjLT8
         AwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjlroYrlgzgMoFh1LFXGYIN8K1Bd85/YnL3uf1+wDUFAy9o7yJTgRHpZ2+1DkvglYfLyxC3yttD3Iv@lists.infradead.org
X-Gm-Message-State: AOJu0YxIRvP2TfA3kzWxt17PDDq14PrSpiHh5ryFmBrV4pQHRCNS4A0F
	uB5udDYae5UUAqDOdc/w3kkciWKdO4zSj1QZlsq6h4zHWGaTQzn2YmcAVc1cBZPqXmk=
X-Gm-Gg: ASbGnctQPCU4jDzYdfylydcwSwlJFzTgarYMEPLnGEn6GP/KJBHywNA+hdBDe8O0tSt
	nA75kiyfrpA7tR6m9Jh2xL8qIJGGUbLi01Bv3M2c2D20kX/4pHOanxHldSVhDoy5AG3BqW2LcpF
	BBexWah5UE247wpQi1d2YXzsZyaHk5yWdqIzz6Fq06cW/bbnRmhQxckWt2Pia958Km1K/VpuB6b
	nRTCxyTxpTICN4YVIOKRaAlaRyMxamQDPkrU2Cm1mmYDmc9VGYx95wwdQTeNZ2Qo14xs8WQ1EnA
	9SYihwRrJ9ixH5ygXeB9WudTNndaldUNK6JS/RgTKGEczc7H0Wi5ymPuGhbQAT/mwUkV0YZOdIR
	Yc84ZRDnciOEIprUBCHOQML1/tjHlAro544DeGOKZK2gbTLp8zhn0cv6Xtt6N3YDrzEBsbJFsIb
	nbOvQH05yMG4stx5OJXLK83Bcem7yk1xBeZrAa/i+xZ3QEBNdrgno2
X-Google-Smtp-Source: AGHT+IEdsq/70nzbECt2XZv20aIclJJnJG4WOaVhcMt6Kol5NiFtvhP7+awwyCp70aSiqlFjENFKWA==
X-Received: by 2002:a05:600c:840f:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-459e6fb8315mr72888315e9.0.1754577657329;
        Thu, 07 Aug 2025 07:40:57 -0700 (PDT)
Received: from ?IPV6:2003:e5:872d:3c00:27e3:fc0:fb5:67a3? (p200300e5872d3c0027e30fc00fb567a3.dip0.t-ipconnect.de. [2003:e5:872d:3c00:27e3:fc0:fb5:67a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm27487389f8f.4.2025.08.07.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 07:40:57 -0700 (PDT)
Message-ID: <e52e54f9-5f46-4d52-b02b-3ddb497d5ed9@suse.com>
Date: Thu, 7 Aug 2025 16:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/16] xen: swiotlb: Open code map_resource callback
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Alexander Potapenko <glider@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Stefano Stabellini
 <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 xen-devel@lists.xenproject.org
References: <cover.1754292567.git.leon@kernel.org>
 <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zbc1rtf2MP4v0hwBljje0R4r"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_074059_577365_FA7305FD 
X-CRM114-Status: GOOD (  12.42  )
X-Mailman-Approved-At: Thu, 07 Aug 2025 07:59:41 -0700
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zbc1rtf2MP4v0hwBljje0R4r
Content-Type: multipart/mixed; boundary="------------9ZSgHGkw4I0gfARYLaBix7N0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Alexander Potapenko <glider@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Stefano Stabellini
 <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 xen-devel@lists.xenproject.org
Message-ID: <e52e54f9-5f46-4d52-b02b-3ddb497d5ed9@suse.com>
Subject: Re: [PATCH v1 10/16] xen: swiotlb: Open code map_resource callback
References: <cover.1754292567.git.leon@kernel.org>
 <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
In-Reply-To: <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>

--------------9ZSgHGkw4I0gfARYLaBix7N0
Content-Type: multipart/mixed; boundary="------------MyLdgWVjx6doOE9CX8bqeBuf"

--------------MyLdgWVjx6doOE9CX8bqeBuf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDguMjUgMTQ6NDIsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVv
biBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4gDQo+IEdlbmVyYWwgZG1hX2Rp
cmVjdF9tYXBfcmVzb3VyY2UoKSBpcyBnb2luZyB0byBiZSByZW1vdmVkDQo+IGluIG5leHQg
cGF0Y2gsIHNvIHNpbXBseSBvcGVuLWNvZGUgaXQgaW4geGVuIGRyaXZlci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQoNClJl
dmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdl
bg0K
--------------MyLdgWVjx6doOE9CX8bqeBuf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------MyLdgWVjx6doOE9CX8bqeBuf--

--------------9ZSgHGkw4I0gfARYLaBix7N0--

--------------zbc1rtf2MP4v0hwBljje0R4r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmiUuvcFAwAAAAAACgkQsN6d1ii/Ey8T
2gf9Fig/dfNm6Pc7N5CfTbfrvQeHxFrx0A+Lbz3wE1LBralSuURdjPw+wrBAGuNq/agCOFH7OBqC
ayEkBjEdcL5kEblmVCgSWfcKQRq0vW5y0zkrzYglQyfuWhihBm/d56LwWxjbGku6QYLMnb5dGvHG
wtjPE58yPWlaVaZa/NiWJLKtHyLc9Ep3+vhGNksayAXIsaRoqhk6g0dlVfOZUhQB2CTSQmBN8Cjo
yhy4qsUiY26xJ0qhoNBaBahj9XRBQX5jz0z6IXT0xVJOTx5MoVU/ciBTMU97RmC1WbR0D5dAFfaA
bgpP4QE+654uwyPjna/thpNWrTTm0kf3W+lFK/6fTQ==
=Fe2s
-----END PGP SIGNATURE-----

--------------zbc1rtf2MP4v0hwBljje0R4r--

