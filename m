Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A3C3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L8n3qXfnGWQxspDxfSGkwgtKVwzUiL9sbiMeF5o/i3s=; b=avyPK+RKZ5p9z7m91PFDTBKDUn
	uB5a3ZkY2mN07lcnrueXBdIV6aFJUQR0uf+OsEWvpu++GLWmSmuH9G4H4LSYk5fAWLv8WN4bLarAz
	BhbGDx3bQglx1OjWpWQaIq1u7k1VIalEtM3YKuwGZFfUnbgu/MOij1/ewyp6YcHFUk3NG1VVfHDIF
	NyeQUVEZsksaRvotzlxBTvqn+QSV4Y9zPHc34oo2J3paV9Nw5poqYNXc+5LAgB5yXEdy6w0+EXDC2
	mjR6JR9KapW/3vT8o5OpF4A5LHQ1tit4Xj9TxSernSidWBiUgDufE3PnAd1gJqJNVo+YndIiUDBSM
	ux8I7K4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaMu-0000000EnjV-3aHB;
	Wed, 07 May 2025 08:43:08 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZXX-0000000EbLW-2UXr
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:50:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so55762875e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746604202; x=1747209002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8n3qXfnGWQxspDxfSGkwgtKVwzUiL9sbiMeF5o/i3s=;
        b=c4JAxQgQ8Upr3X9k09V4m9ZZ5cTJcV1nPd79fbtJGclOgt0fGMmHhaRQAZWblv92i4
         gYfI66XmC9KjjkqhqCP6qyJEKTHjh7htEJFUyfXVLkcE1CwdVG1bLN9OPssFJHOOjWfR
         6Os1j7iw2DhR1lM6TfbyX/0zmVcUDffNWioPKlQj7WozGsL1SWSe8jGqd08psUYuRJ39
         w8zrYx4b1rzGC+bVyylikFyXE8ka8rBFMgoiZUP3t+r7atKkVZT/b2X8TkTylrUMGuTL
         DWpesXrsltlxM7VMfvao+gYBt81E2QagDDJJeh9lLw4MIJI7ktFSOW0Zi1HuyAVRvuVF
         S5zg==
X-Forwarded-Encrypted: i=1; AJvYcCVwLQ5pcrysQjdonszbReZ8OQn8v0qwzfjJYfIvc57GlLSSYclOs+5KYp+mh9oYNyrZY+2B4ey34I/a@lists.infradead.org
X-Gm-Message-State: AOJu0YxaCXZxtUJiPVewEZOp4ThfliMsJNuUND5LHQokgsEfUvBp7nJg
	plOWrrEIepAr+bIn8eeLuaZ5tbMcIIne0Mg6AtSsdUjk4TLhklDD
X-Gm-Gg: ASbGncuF7O08DAPtV9tkdTVBy+BlnKVqCKUVDTYFU1eGZ3StVBRe7sbj/KE6bex4er4
	CZ9dZdfH0qdM4kuEqYYHS3ftss4OmTzqFugtl1ghYsnP/ffx0Zi9cv+MaP/lLaNjUTiw6CYzmtj
	sv++9pe3QTn0ZB9LYaL+YarOzMCwD7fAczmxbXJ0AibhhvIsOYVzjxxS5+aVt7KDA0b/CkrRV3+
	lY47R+h3ud1wGoT3LkNKotSsXYmu/BwbLNlvwvMWslopb3YGRbxS93f9g1b49nxBm5QMowKp/72
	FxbB/N6+EE0dfGRqCiQBtggfM6s4g8YHz2dVwH60qIBZMyrEBph6UXVE9W3koDNLKIBfIzkk3VR
	xuoi/Vg==
X-Google-Smtp-Source: AGHT+IF1vprA2n5E+jroTf7GicLPh1OLjR2W+OefRYgngvbtY0+MbtGhgFvbp4eTOgWyLhqV7bQbVw==
X-Received: by 2002:a05:600c:4e48:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-441d44d7c33mr15941505e9.27.1746604201603;
        Wed, 07 May 2025 00:50:01 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43a764fsm21071985e9.37.2025.05.07.00.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 00:50:01 -0700 (PDT)
Message-ID: <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
Date: Wed, 7 May 2025 10:50:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aBoCELZ_x-C4talt@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_005003_634233_CF394C1B 
X-CRM114-Status: GOOD (  21.00  )
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



On 06/05/2025 15:35, Christoph Hellwig wrote:
> Hi Chuck,
>
> let me use this as a vehicle to rant^H^H^H^Hprovide constructive
> feedback about configuration of the tls upcalls now that I finally
> got around playing with both NVMe and TCP over TLS.
>
> For modular systems configuations the amount of monolithic state
> in tlshd.conf is a bit unfortunate.
>
> For NVMe it isn't all that bad, but having to hardcode the .nvme
> keyring still means that:
>
>   - we need userspace configuration past just enabling tlshd to enable
>     any kernel subsystem using TLS upcalls.
>   - hard code the keyring used in the userspace configuration
>
> Can't we ensure the upcall passes the keyring to use and avoid
> this issue entirely?
>
> For NFS hardcoding the keys and certs in tlshd.conf is even more anoying,
> because it limits to a single client key and cert for the entire system.
>
> I have a hacky little patch for the NFS client to pass keyids for the
> client key and the certificate as mount options, which seems to work
> nicely, but it still requires adding another keyring (see above) or
> giving the user read permissions for the keys while it would prefer
> that it would just work and we would not need to give any root login
> session a way to read the keys.
>

Christoph,

Just so I understand, this is a separate issue from passing the keyring to
tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
similar to what nvme does?

Note that nvme also allows the user to pass its own keyring (never tried
it before - we probably need a blktest for it //hannes). So in this 
case, the
possessor will need to set user READ perms on the key itself (assuming that
it updated tlshd.conf to know this keyring)?

