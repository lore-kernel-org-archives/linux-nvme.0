Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C9C98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JEgLSFj1Jyzae8Gv+oqdmPoAbEVAiNn+0UlMSLjIzD8=; b=vBcUdz6agFGeTDi6r7RsyBjfjZ
	HptMpvMEPMFxqLibrAgzghiE18rFUfd+dvxYqnSSJR/YrUnSc/dIvARBXVlor4piC4xw/MN7CGgd5
	kMESQ17BDKdANNaxsfHC2qjfglOyEDOo87d2EUq0AgDX/adEgXGUAJlawAFbHzIRDTTNX1k9IQV9T
	PGoVl9+nL8RfMbetq+GL4iH3hbyAQ4X5FWoJLosQHkkXT9rddFIOsK9+EfdJRBXzijx91FyOMnDGA
	Es+2fbe4uVf/GziaWuJY2XBZfLW8FN6uwLRzmFTKYrLWOoG7dhilBAb6FbaLFJdUkw6Eeyngz+Bzi
	avefuaKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9NPZ-00000008Slb-0kIm;
	Wed, 23 Sep 2026 13:53:25 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9NPX-00000008SlA-23E3
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 13:53:24 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747ec6185so4077835ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171602; x=1790776402; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEgLSFj1Jyzae8Gv+oqdmPoAbEVAiNn+0UlMSLjIzD8=;
        b=oQffiUZYvsn7wgb+f6hJO6F2IBGAbCysARkPOWPMVWlSmk3vF4gbpCe9xsdS1Z8m6Y
         /bTQnT5baH4I2+Xw3ivsIukbh78cc0G3sNMjI3vBMyDmFSvd82zSZYzUtUJUdxf9iPxZ
         xmCjjQr4ZeraueSag5Egpjf0dlcQLxSFX6AFMlnqfGDhT6Wqq+A+Qq8+fuhU9ip7MV0B
         3LCCot/mHuZGUxmMLhYUvimBgNdILHheL0ZjHkqbx92LgsdcIDo9bySaFXEjlDdMgdwi
         uoAempdxfrpRH7EOvrhm0Rmd1e6sTCEqu2OZfZBYP1PJcNJbfUPIDnQogd7SouuYzvSP
         iGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171602; x=1790776402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEgLSFj1Jyzae8Gv+oqdmPoAbEVAiNn+0UlMSLjIzD8=;
        b=oIBdJGqcab/pixnWoJ5CdfnEYfUq+aSg7HZwfZGIDSqCwKS3bJHjXlelmNR0NqCEuY
         Al8myBAo0jR8dNaKI+6Uz36gQXyGnIy5Pss6E8myxvJQ66QiNKqVh8lVjjMsUoE2ZXmT
         /9trb96s9YmR47tpGilwifl/eSYm2ab4gh2DEiz77lLoy/0lECLplcNq0QH5R9JFOp4w
         +wx055BHDt5bt8o+bm3bcgrOJwTvM4fJ0g2e5GP0BxpprWZmGpJEQZj0D6tiCNvoYyGj
         gqoZcGsMnXSgNWl1aUjufynRIn9p+dFirB2mNLA7quN6o28s6iCosRg9c3CCZB2+BkJU
         fYrw==
X-Forwarded-Encrypted: i=1; AKwUvBwfEZZCeHMB8Wyy0aitdGICYfqmdVBo7bl1n4r3q99hL8huQKYprOVlTR7vo0NglharL7fLzR7xrVOK@lists.infradead.org
X-Gm-Message-State: AFuF++mv4fM/phxrZSE4qHzmhTBsc7/VfqBzI35HwKkIJBOaZ7xL2YoK
	AZ2OfujV5BL2qrOPkHeqeA0+t1rCptLNn7ocea2TrJt3TTv6/gNyQgBp8xngaQ==
X-Gm-Gg: AYBFou3r/YuKFz6PBNvYW45fyhtYOq6+yBWFu6Rx+GkTq85ZefVU5NVBKAckz98O89P
	+TXvoOr5qjuvag7qcTEXlWXHpOuFuQvVv7CfQHAeefIBeo3U04Is7i+78itZZ0jLBpdBdTWSD0j
	kT8St68VuFzokL/Uf7EtfhhnF+Pa8Zw1beMUE5vVwWrkZcLCJhwZCHb1PCAWyj7lJxSqssOpnUg
	G23FI5IVrKN45/BFGZhFCIaYC8ookfv3UsCP7bRIafxjKfo9+/uoOro84Ctmcm+CtsFqXNlmWV+
	lMx5mGzyDm7O0Uhv6piU3sunVODwHWoRwrijo9OXM19aafVsPJhj9BV3mnuBq4oz7rD9LrzJMWQ
	8ADyhj5P8urqRZ7yosiBPCSUXikWeOPDSeQM+66dbWRzieVzarLSbauNu2l16k/Tmg7nSVJfoh7
	k3+BZis4MdlQ+jG2F1Z8RkgSnNcLf52dkwItrq6mbJAY8swD8koGt1oZzdsjKJ0PDm6/oON4mzn
	w2SgNfW9J0NJA0gjwXM4ingtcM=
X-Received: by 2002:a17:902:ec8d:b0:2dd:c100:424b with SMTP id d9443c01a7336-2df69de9aeemr24338955ad.47.1790171602285;
        Wed, 23 Sep 2026 06:53:22 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:f072:2258:ced5:5d8c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d738bsm11494825ad.47.2026.09.23.06.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:53:21 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/071: add a test for fcloop LS request use-after-free
Date: Wed, 23 Sep 2026 20:53:16 +0700
Message-ID: <20260923135316.13144-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arOLaz8NSnz6bqL2@shinmob>
References: <arOLaz8NSnz6bqL2@shinmob>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_065323_529364_41BB84E7 
X-CRM114-Status: GOOD (  12.69  )
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

Hi Shin'ichiro,

Thanks for testing and the review, v2 is sent:

  [PATCH blktests v2] nvme/071: add a test for fcloop LS request use-after-free
  Message-ID: <20260923134938.12673-1-ngocthang2710.1999@gmail.com>

- Noted the kernel fix's commit title in the file header, since it's not
  applied yet and has no hash.
- local -a ports, and use _get_fc_host_port() instead of reading
  ports_to_hosts directly.
- On the hang: I couldn't reproduce a real hang, but I think I found the
  cause. _nvme_connect_subsys() doesn't pass --ctrl-loss-tmo, so it
  defaults to NVMF_DEF_CTRL_LOSS_TMO (600s). After we pull the remote
  port the host has nothing to reconnect to, and the following
  _nvme_disconnect_subsys() has to wait on that reconnect state before
  it can remove the controller, up to 10 minutes if it lands there.
  v2 connects with --ctrl-loss-tmo 0 so the host gives up on the first
  failed reconnect instead. Let me know if you still see it hang with
  this.
- On the swept delay: I tried a fixed "sleep 0" here too and got the
  same KASAN UAF + list_debug BUG as with the sweep, so it wasn't
  earning its complexity. Dropped it in v2.

Thanks,
Thang

