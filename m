Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6043C5AE59
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=; b=bYpcgmF7hT/SngmsZuJzV8zQLm
	9KiweJRXpJCOlaltIaFp6moizLgiE3iqR/ydg6KApFVi6XDBWX3atuIy9+lCDqIw8f5k7gydi25oB
	RgdhkdaLKP17ulNp4/vj3PXpAAyw1YPBP6vDGxdEN7+dO1pIYxGi98ef7D8VgdQSb+b/vwlYdvp4M
	AZmWqYPjliUK1x4RBsqYGWpG1lv7IGmx5mWvRts4D/7kivPfVnrqSL9XQKO5KNj+7tmPE8kQM/+hh
	9KMspH7BHYcn6rSE9letrPh6MrFRoock2iK4c1VzSenytUWo7bUVcTggcBp1e431OoF0ABilS6qfp
	Z2xD3ocQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMTB0-0000000BEC3-3YUD;
	Tue, 03 Jun 2025 15:03:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJoKb-0000000A6pJ-2tva
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 07:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748329356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
	b=JqPpYETwDR9apyi4F98zawnyfJY15s11vKJifcLqjXQED0w3msmaVvrHe80yO0yfX0dI3v
	ofRVKNRVpLJ6hF32w4Lps8Q+ovtgMbDpgJcDVFAIEpgHEM4Q4bQCIiEbcaRX0ksY6zP6mm
	zGoMtxTsxb2mCKRF6pyCYEhO+LU1Iq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-6pTQWsCTO62ejfidDaAxJA-1; Tue, 27 May 2025 03:02:35 -0400
X-MC-Unique: 6pTQWsCTO62ejfidDaAxJA-1
X-Mimecast-MFC-AGG-ID: 6pTQWsCTO62ejfidDaAxJA_1748329354
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3561206b3so1238251f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 27 May 2025 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329353; x=1748934153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
        b=CwgfXc7DfyLPpy6D4dzJdJH7yAfoAqkqZtQ7n5uCHd/+56sSftS/IKyXS/nrplkp66
         p1w9vqmMt+026UM/4/TyBAKAhVedPa6GoIkTQjPq2XGpyjfxQsRpkk9/Nerz+Ns4zp4W
         FlhGj3XgXzjKuwE01/pDy82xc7u3eqeRrBdjAwd+yzLqqi52MiuRFf+c42jMAbgrVu+b
         aLvprtNTmpi1e5LqFnD5N016U4h3HV4YN61WxNUANZ3tv0kggyFlbOq2wl+evwS230Ep
         jhQa7twKrAjSLwfRv4iSZWUKoltOQNy2iZq8eEwrpJbw+5qbXptEYYSqHAzqL7axFsme
         f7kA==
X-Forwarded-Encrypted: i=1; AJvYcCUueONp4Uq2HJ7Jn0fdRABiNnXyRSKg089jt7eEV28vPxS2goLWy2UgMrkWgZ9vOjTDHhAqZ04C17Zr@lists.infradead.org
X-Gm-Message-State: AOJu0YyhUhec4xt2WuK1UoOCn+E4JSu+LErMhB7LPc84kUQOsz5L0yjd
	eAxtwKQ4zCccVrrLqRIxT2TQrr1fi9pThpBdLHjyT6Zge8Ij9W9PUwFC2ViySL68lVgPPMSzlCy
	h7RlrCQTE892wYGVI8ugXxR7pZ2XnzdmbfSLIsWVt2KjKvg6tNM9uU9OHJgFzEjMCSumo
X-Gm-Gg: ASbGncv1xhpg0npRpVxdSplINwoiC67EQip0F3NUcJAoigHAV81Z7gWB28zqKePPu9J
	4mil5pS4h3uMFTZn3ZN28NJvusRaueQBOgVVwTqtev+R81ikbgP20QqCuW76pgb9B0mvzrrcA3/
	Yvg7A2ZpvGCOQ9tw26fAW8cZnEPYKjxSvBf9L3oG56MJNmo/mhkOpV8t+mWBBOENwVHacTrCgs4
	BfkrWr9M8YzsBg/oI1pf8vAHYfM2xBf37KMVXsMMpsEpO/2FZ/LGM9V3VTXK6HNf1ntgoLQQDxU
	ZX4JZXl5llPk/QdChD6QoJzWNa+B8Gk3e1VQiu+l7v4bH04qzFYZWYKiarw=
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608614f8f.57.1748329353535;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGex5mHhM/OYaq2gRKUAD/HxHUJY3MptMrHBU8jm/eQhY8uxpjEvS25/QUCzUXZRuezIVGAwQ==
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608571f8f.57.1748329353087;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cc52ab88sm9930473f8f.11.2025.05.27.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:02:32 -0700 (PDT)
Message-ID: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
Date: Tue, 27 May 2025 09:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Maxim Georgiev
 <glipus@gmail.com>, netdev@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lei Yang
 <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Philipp Hahn <phahn-oss@avm.de>,
 Eric Biggers <ebiggers@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521204619.2301870-8-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fThrz2_P8wBWcNYSxkvTc_bTBdE4mNq0uGK3BnEaBWc_1748329354
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_000237_887168_8E74AF24 
X-CRM114-Status: GOOD (  11.50  )
X-Mailman-Approved-At: Tue, 03 Jun 2025 08:03:41 -0700
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

On 5/21/25 10:46 PM, Kees Cook wrote:
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index fff13a8b48f1..616479e71466 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
>  		return dev_set_mtu(dev, ifr->ifr_mtu);
>  
>  	case SIOCSIFHWADDR:
> -		if (dev->addr_len > sizeof(struct sockaddr))
> +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
>  			return -EINVAL;
> -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> +		return dev_set_mac_address_user(dev,
> +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> +						NULL);

Side note for a possible follow-up: the above pattern is repeated a
couple of times: IMHO consolidating it into an helper would be nice.
Also such helper could/should explicitly convert ifr->ifr_hwaddr to
sockaddr_storage and avoid the cast.

/P


