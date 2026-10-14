Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E67CC6B2A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ore5pTjDZjqNZvaBmIBth3riUQaRpMdBJFRuQs+XS9I=; b=kRw2OSGYMDjP774edCCyv1H7EG
	p62PhxGOT5uwhgOEeL4n8Ph5LyeKz8d8H90iiJHookYBj1HbdTOJxKYQjFcKOzICal3o+RiLONVWH
	vAm73ut7DUsv4QUSAbDenTEhAGt+sFalbCufvcw59RntTPARrY4IJNa5KzMQIH7Rtwd+VGt6Cfele
	2gJk795wHE0EHfev8pvgh3sSpUFvl2H0Q3FqR/O/PA1CL3OV5HpZJvOfkbqZLahPu+AFOvE6OTZMW
	KFMHq85VU41WbrQcEMgZe/h252ibqA16zzB000yUJUfUbBxm9N/8vfvU01tDr+jPyzxBLEO0u73v+
	FgoX6giA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwjK-0000000FGZf-3VhB;
	Wed, 14 Oct 2026 11:01:06 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwjI-0000000FGXa-1aan
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:01:05 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so27769865e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975662; x=1792580462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ore5pTjDZjqNZvaBmIBth3riUQaRpMdBJFRuQs+XS9I=;
        b=q6iTIvH///f5n7aOVzyP9QBpSxyjba+59r2AquI7bVRl6i75b3xgqQiKy5zTZgBdbV
         QF/g2GR85GkQDPgdBSOiIlzfPpsEH6HefVw1x4o6fLpBI1QIdlAKMmnOmpBjAKNu3OJU
         eaEbQNdCLG/qIZvLABEtTcmqBr6txMoPG3I9bj5qPH1t5piXNNufY2q1RXGI7bqSdgdu
         meTODwON4M2eAByxviZ4yn24PGVpNKr8KbDkhE4uMG1Veer4hspGeXVwttYISqAJ/1dc
         U4oPSxh24fgjzeeUIMcr3MqLTYixqo8Zpz4+dlCwOcnBJr2bZhY5zCNYBeC2umis6XK2
         BW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975662; x=1792580462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ore5pTjDZjqNZvaBmIBth3riUQaRpMdBJFRuQs+XS9I=;
        b=EAkEHQHVuwYiwmJ/iA1EkvNXS7zz1KkioRs404I7qPbv7ajBhVgYky+9WQ4yt8zU6D
         OWuMZYYP2dlvhsKrnc/egLsAvVPR3SfDtsHAaF5/gMy8RDdlRUVZwksa69G+k9ovW/33
         bbTipmhlRP1CdajC0OdptuK+j/ZdE/Wr4xUMBOeoHkzxqX0puAGGa/sa74bs4FVbMM1D
         CnHlEdz6/wz4Q7P4qoRIsm/UljbBriKA+LcCBzcSJv4d35wBfERBBRjaFZ6dtqXAowHA
         mFho+iNk+ydD408koq9tTBktNIfZmhWN6K8wimEWqvpWRMmMFWOaXnuPV218NerKk4Uy
         WVpA==
X-Forwarded-Encrypted: i=1; AKwUvBwfBYD80wz9shvfS0fDBLrMwbkIzZ7h08OzckSPv8QZDi9chLdRgY96YeuTf4wwfMmA8BH1UDiLo0K0@lists.infradead.org
X-Gm-Message-State: AFq9FYIb7qEGs6bQ3ExN0OVJ5f4K+8uNSkgr+mNx2gPV1I7o1ucfSoIc
	xf8oFPnfyd1fmYcZ4iZ2mrz4AVRiCOuZWRrOx5nUQLmUqryAmAfa5TJE
X-Gm-Gg: AYBFou0ScHNmga9CYH0Nwih9byne1X2zr85fSrXBUZzYo28xbMOxdunpSODmxBWZXuj
	36Sn0ZnbtCbo6qEHcm40kNVn4Sbb2gEOGwIA7Sgtn6KvTLlmukft7MtT9mpTfOM89oXmspYnfmO
	/dm1jDtNbcgWYBXMhmXWJjgvPw3Cj6lnbEcuSEuG6Ar095sss7vETDVV4cYdOyPAb5jaAatrL7g
	n33XECg9eE4GuRMO/zWr0ueQyE3D5PlL/GAQIE7uPgibrur/M6IBkWnlOOnAMgxbPIP3bhZvABX
	eSnDzsPMlmpX05uuao74ZMs1hN5AZhKx4Sx6xOK9S7xtf7hfhR1yE/LlDoSZ51jroW9MrPDHHh/
	oGQcUYbQ1qOkJ8eqIrCqaFPTg5xga2nUBMGitretH1rQouSsA4BA4sSmhr3eJvRzql4pNi7CB8E
	nrqLk1yC5K2iXb8RDQIc98Bfk/cq3RKuNuI30JMsNb3aOjpkU1KOyJQXAVATRqnn5e4v8XkTvuK
	1cb/Ua1vToBr034KvMGwA4VE+d+tSWNtmW93t5fc6YWh3GN6FR+IpUu
X-Received: by 2002:a05:600c:8b83:b0:4a1:811c:8064 with SMTP id 5b1f17b1804b1-4a18e4d5512mr296251135e9.26.1791975662021;
        Wed, 14 Oct 2026 04:01:02 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm653036435e9.8.2026.10.14.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:01:01 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmet: zns: reject a NUMD whose byte count wraps
Date: Wed, 14 Oct 2026 13:00:52 +0200
Message-ID: <20261014110053.95249-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013142649.GD14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-4-parri.andrea@gmail.com> <20261013142649.GD14759@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_040104_425434_72A27884 
X-CRM114-Status: GOOD (  11.91  )
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

On Tue, Oct 13, 2026 at 04:26:49PM +0200, Christoph Hellwig wrote:
> > +	/* From U32_MAX / 4 up, the byte count wraps and no longer matches NUMD. */
> 
> Overly long line here.
> 
> > +	if (numd >= U32_MAX / 4 ||
> > +	    out_bufsize < sizeof(struct nvme_zone_report)) {
> 
> I guess to make various sanitizers happy we probably should only
> calculate out_bufsize after bounds checking numd?

Agreed.  For v2 I plan to move the check to the start of
nvmet_bdev_execute_zone_mgmt_recv(), before the handler or its work item
computes (numd + 1) << 2, and to make nvmet_io_cmd_transfer_len() return
0 for such a NUMD, so pci-epf doesn't compute it either.  I'll also keep
the comments within 80 columns.

Thanks,
Andrea

