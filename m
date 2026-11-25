Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CE606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LyhLBg1n;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjXfv89Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=; b=LyhLBg1n5XdjHQ
	m8k0q4tWkC/87DRw4Aiw3CbF0qGs5NMS0/NH9N2NRpkvgfR0ci/roiSXa6V8qLQ/sS3Q26mvS1Tad
	tfTennF0gnhosCFI15KTzK7tEbpqbQR8voUNaJGMZN4ZgjSHxwD9ipHxPN3Vd8JI4E5EKZf4yQDKy
	0mZGwhuVFs2t+f+hpw2tmS8L0sBLuWschf03n2newAC68n5Wxe93vQ24AwkZxdXqIIcI308PuuUbF
	aSE5ovuGVyj3a+mBVwdaxio9edBIxst2z2zzf7Eh/RVX6mIwCDE4uyUjPnA7SV5edB37Qdtpr81dy
	hcMGudaxH+sVzBvBhG1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBxj-00000009nCi-1ucE;
	Wed, 25 Nov 2026 12:18:59 +0000
Received: from mail-yx2-x07.google.com ([2607:f8b0:4864:41::7])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWBxf-00000009nAb-3Hjg
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 12:18:57 +0000
Received: by mail-yx2-x07.google.com with SMTP id 00721157ae682-8a72cead747so10855667b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609134; x=1796213934; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=;
        b=FjXfv89YpL+uSNeDbXRa2HY9lFL1xBkk1x90ddN0u79lShiD7jCjYtqqBdlFxs0Zq6
         S0ZEomTVX7g9a1nzvsM/zu6XKaOiVU/wwsYYoXrgT2xIcXpTmoW0csoFXYbEjhb00/R5
         OKqrtJwCUrectWrFD5lpvXhgTyD9xhql7B8aeX4XqMLfVwgI9FT0R43r8yEjj+uVmAOr
         pz6qR2V1CQQuPX6AdwOaaZ9gYoveL88rHQUU3r8BrpzrlGG7S/m2RS82XfSQNjTBmTo8
         VbtLxbvopC9DTin2hS7Ah3lCLjwZc1307tFsw1G1Awr9rljBhDqOkuDt+UA883sFYQqN
         KbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609134; x=1796213934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=;
        b=FuYqneyk4Io0jJ7rLHQxyC9sJjPe8j6h7uDlmWsD3pMAQh5Xm9+0GCGnr96UQiVEN8
         Vi7PPzd+AbnXeX7OwAwA79RbyVK1Z3/alc5sK2NEtv6g4P/yA4gsIBTC8wbd9MaJnpaS
         cX9/EUjq17FtrBcURTJHBpeBkuIRbjl9IRGkLyGW5FCcfNZWet37DdN4wHMWYyQ37SzR
         Oko8n4laO4gImIyj/zWXgQO4E58kdCuyPFZUafajZW7dDBlN/e8rh19WQoqP3mjgT/Ou
         VflAHzofJ31ou/BnABUmw0prsH4sOnQyW0Ont2kMcKDDxPbcpYBhZupg0Se3HpIGVsem
         CRDA==
X-Forwarded-Encrypted: i=1; AL+hErEJNaUpTkggJFYQj/poTRcv+E/bc4AcY5b+X+ocMwXNHxl4nDO0hgAIwKSUuZsG0EpdKwP+aqcwJ04Z@lists.infradead.org
X-Gm-Message-State: APuU4Z+bY1n08a3O42V1fqJdtQZm7QYHbCC3OQEn3a+bMFuuxOHdnqFn
	1mckg7nKUyOGv5FSDq8qpawKkki6oxAP4Y0ZDIC/21CjUB85sU39Ehna
X-Gm-Gg: AZFdTZeOkhOBHyqP/x35S4Vzwn4MH8TKuX+8x53Efg1B0mzfuAK4unDNN/WA3Rja6Fw
	oUiadQBtq9L1Tn90kqoGfzXQypxKF+PoI62ua4N/Wxt8mvFQNCSDSHxR8OC+s4moFSlgUZSXvax
	9UNgMtTx+Pn+VvQ/qd9rswwxzzEkw8h8kDKx1Gdxfgny7LzOb0vg2rN7Kch4RdHLuMwCGUfSuvH
	sSjHakQi9bwAEsgrMccVi4+qPLiqnCNk09xmMHadWzwAovPcaHIm2ijAaHhlRzWok3pFAEkwsbz
	mJv+XDWB5JM1t92PqZOPx1KhRh78B6PlV/xe8coZ4fA4fNRAf4iSBnRzNAZMlHdg+xvvfSKs6r7
	pOLTo6MVzGuytBj0Ic60yzGl4OTQEGIAxZhCCLny/wslkq4E4Uox+/8TMY/dROpzilST4Heztzu
	fdOJeg469QbmjgnEuyMFv524XVrDx3nVOmcQaDKOP9xlFXLfoED81otZpef6LYoZMl8Uz9HoIIj
	lc48mgejnGK4pl1SDAG0YGr+oLBr8nFZJRR3qisDFde3ahS8pGQYfmJ0xSPIzXmAvoMrXN/5UR5
	4qMqQf3MhjNIPinAoDWsiFL9N8HaoPb6J3Y=
X-Received: by 2002:a05:690c:905:b0:8b4:dfc2:bea3 with SMTP id 00721157ae682-8b5204e9094mr85848277b3.50.1795609133907;
        Wed, 25 Nov 2026 04:18:53 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202b09c6sm72601307b3.17.2026.11.25.04.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:18:53 -0800 (PST)
Message-ID: <a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com>
Date: Wed, 25 Nov 2026 07:18:52 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Hannes Reinecke <hare@suse.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
 <20261124213222.GD2227373@google.com>
 <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
 <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_041855_925773_83F5756F 
X-CRM114-Status: GOOD (  22.62  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/26 02:26, Hannes Reinecke wrote:
> And the other problem with your approach is that DH-CHAP
> key don't actually have 'names'; they are just binary blobs.
> If we want to refer to them by name we first would need to
> agree on what the name actually _is_.
>
> What we could do is to store the key serial in struct
> nvmf_ctrl_options; that would allow keysd to provision
> the keys and rotate them via 'keyctl update' (or whatever
> it's doing internally). And would get away from the
> business of having to come up with a name for the key.

Yes, a key serial works for me. The kernel then needs no name for
the key. The key description stays a userspace matter:

- The admin names each secret in the configuration: the connection
  configuration of nvme-cli or nvme-discoverd refers to the secret by
  that name, and nvme-keysd's configuration (or the KMIP server) holds
  the secret under the same name.
- At boot, nvme-keysd adds each secret to the keyring with
  add_key("dhchap", <name>, ...). The name becomes the key
  description.
- At connect, libnvme takes the name from the connection
  configuration, looks up the serial with keyctl_search() and passes
  the serial to the kernel, as tls_key= does for TLS. libnvme already
  does this lookup today, to check that the key exists before the
  connect.

For rotation, the serial must stay the same when the secret changes,
so that a connected controller uses the new secret at its next
authentication. For this, v7 needs an .update operation in the
dhchap key type (user_update() should do). nvme-keysd then rotates a
secret with add_key() under the same description, which replaces the
payload of the existing key. nvme-keysd does not need to know which
controllers use the key, and no sysfs or configfs write is needed.

For the sysfs and configfs attributes:

- For a key from the keyring, a read returns the key serial, as
  tls_key and tls_configured_key do. The serial names the key the
  controller uses. The description is available with keyctl describe.
- A write of a serial is rejected. The serial is set at connect, and
  after that the keyring is the only way to change the secret. I do
  not want a second way to change a key: a writable serial would be
  one, and it would let a write point the controller at any dhchap
  key on the system.
- A write of a raw secret (DHHC-1:...) keeps the current behavior,
  because existing tools use it.

The same applies to dhchap_key and dhchap_ctrl_key in nvmet configfs.

Martin


